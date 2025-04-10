Return-Path: <linux-rdma+bounces-9341-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BCEA84AFC
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 19:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025098A57F6
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 17:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353A8202C2A;
	Thu, 10 Apr 2025 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kqjk/bx4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDF120ED;
	Thu, 10 Apr 2025 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306118; cv=fail; b=ICKdo9aKTE8KZWcPP7aXqf25b0eyUH4sFkcIy/kit2XfLf/MHfq5oZesi9eMRHVTfmbsIsvF4XIOdZnZwYVgVVVaDqjOm775ph0bFamlNgkNIb9LmWOIAB71W5O9d1LeDWokfIMm7LuCO1PO0tQ3Z2HtpEOh66MHVm+u6Q9f+6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306118; c=relaxed/simple;
	bh=yA147KZZ+NECoK6JosauCtba/uzasMf5iMK3AE3t3Gw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eI8I0G8OI9J6smzo+4wU1lc1Vax35e+sq2QtZ3kCbtbsOxRPDJCr0aQb/n1LV5uXu98Es4Zp+ITUWDQzjHJOdAJU6dzIT2lMLfeQTaUFBALHREWeosmCxw/2TkiRs1JpewW5nGXsN1AuUHMadqVy0CwRDW9ldYyigH4b5YHWgvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kqjk/bx4; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744306116; x=1775842116;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yA147KZZ+NECoK6JosauCtba/uzasMf5iMK3AE3t3Gw=;
  b=kqjk/bx4j3R2VRZyP0TxkEvtGb/7DnI+y8Db9FxlZLwW2SMLq/IyLQVm
   AKVcpgsVtwAFMTfNCOm0fUzIuiWo1npAi2Gj74iFTAO1vdgGeDjOC1xwS
   piIwI9bwDXBCl5mTI5hlo4o4xng19c4LeC+wrIUc1J29wAeN+FzMm6PVc
   4xxDCuv7va5yddKe8YAYkwl77mFIlFXKn86MT4BMfQvMg2cUr261EVjuf
   cgtG5VdEjRYJVF8WCtIXHtc+9RHMwNUL9bciD4vpN1zmoe4iM0mVYZItH
   vH6+O1h8duP5/8wempiYQQVTvON6OFVmWrAydO15T1WVjmN+fPHUxlneB
   w==;
X-CSE-ConnectionGUID: +ubqKl/iQP+VJSeYAazXRw==
X-CSE-MsgGUID: tSzKsT+1R5GNxSSRaBcLOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="44981335"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="44981335"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 10:28:34 -0700
X-CSE-ConnectionGUID: jG3ACUoZQGe/eUSfFIBdxw==
X-CSE-MsgGUID: gXjqwJMqTqqWk1EzF6Rh7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129808328"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 10:28:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 10:28:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 10:28:33 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 10:28:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qk3sZrEgYzDOBkWTBUwsxQXizpql5IJvxueyFGxXuVp3l04ZjHulvfIq5DfR6ZQT30q35f6mQdBjsthhF2qN+qgWpGvN5f1/0gdPx6krM8nAAf/80sd2YLqyowCB4OYQl6dblj3BdrNMWH7K+8UdaoW3xDAabi64Hxian1V35AQeAoKk0Sw1DES5/N0rln7GEYEr+WilHdUiGgAtL3plXbPLjPXmjIvygRrCJA2vMg1i5ivd/ugRhb6pKYdzXKcAjtcq+pXktiPUdstYhIIRTwQbACAp+XtLuEfA1/iwZsAwyTlrPsqw02XZs6fLfKDBdCwl+ArhjE3ln68L3dnNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njRNaK8b+wiDg1X1fUi3vBJShk+dDvuSFmtjTHH7/hU=;
 b=NjHjsADMhTFTV+r4MEpuenB1ZoUz2WVIAYEbIrprV4C2L0+MG6qcjqDIUGF1MS9mzgXGKs2ZZmwKpsm/SeQ57t067qMn3YDpaRmmbUrILd4u1tjmUm2Qs+8jsx1VXUfPwto4sRXnAChouP643oljvGqiEDQYi8UjPohYGqAS/MPKHh6qd3mS2uvCtGDyzI3mkzaLxrOj1XUmxSwc6YGothKV7mRVf7DVmpMgbWo0CwPlMA7NXje2XNWboZzTTo1eGBs7QPQLcAZazTuCIcEhXnYoEuSTvkssKL/10ZkoIvVNXhusmyuhsfc9KjGTCo5TMdbAiid8+6pQqAz54GMC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 SA2PR11MB4860.namprd11.prod.outlook.com (2603:10b6:806:11b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Thu, 10 Apr
 2025 17:28:30 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 17:28:30 +0000
Date: Thu, 10 Apr 2025 19:28:18 +0200
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
Subject: Re: [PATCH net-next 11/12] net/mlx5: HWS, Free unused action STE
 tables
Message-ID: <Z/f/ss3KqE+D0G9l@localhost.localdomain>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
 <1744120856-341328-12-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1744120856-341328-12-git-send-email-tariqt@nvidia.com>
X-ClientProxiedBy: DB8PR06CA0047.eurprd06.prod.outlook.com
 (2603:10a6:10:120::21) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|SA2PR11MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: e60265c4-06db-4676-623c-08dd78551c39
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lzdcAROYFKj7jF2Rpwh0GTkFMRfj55ldwaOwgJ9YDrm857lCnL879wqZ4Nee?=
 =?us-ascii?Q?ykqy2Y72La+d23gYU1WGc0LRWNs4En9kE3Uy4C/3b1biegpaxGwDxx/LO5sG?=
 =?us-ascii?Q?h6KZDT50TT6IfsW3zvGP4E56YWoiNINoekLdsDTkp5eopXe6sR1uyIcLkBgh?=
 =?us-ascii?Q?0vHd6SNGee26HddVN6yABM+b9eWbVDyR22p7WxYBGf+9JJjySrhK68r2jhZe?=
 =?us-ascii?Q?ai7F6gSvqb2oDENcWT2f5Fzo3KNbDcoHb7wgz7G3paICO+zr/KmOgI+SLO47?=
 =?us-ascii?Q?ceaGxdLYSrPTSITS+1M0aCiBIejx/mSuWUMM/UFlzppbtk3h/QOG8eAwl6IK?=
 =?us-ascii?Q?dOejK4lU33K22nLVQwPnN4A0wOrBu0MVI3XJeRAJjVqs8d2wc39Dz7IpLrM3?=
 =?us-ascii?Q?x/MIbcfSN7apj/Z8jTUcaNt2TKQg8fKrz7+Cngb7NC8HCRLdN1E+0IC7D4zA?=
 =?us-ascii?Q?wVDEzD2PfNebkgJ4jwrHV4i3DBvXjTVzOiFlUgL/l57ivUi/p0ER+WmbAOZK?=
 =?us-ascii?Q?+PqA87whUvHo/E1zwOwjW0l139EFaR5mI94diS84m+LMLy4+/dXWOmOM03t/?=
 =?us-ascii?Q?y9QGDcyBA3kzse3AWmzwvXd0W2OiWBtGUB2AR/0hEKXdUHNjfua3cmKo6aXk?=
 =?us-ascii?Q?ZVa0pNJ1Opqz97/wcfhygeAn3tqkr7ghKFDe/YCHNWJ5YQHmGnzco/sMqP07?=
 =?us-ascii?Q?b3IpsFEAaPUQ1GSzRU2k6nkASJNqSs2mRdcKKvND2/2MoIa4jsdvjG2I1vJX?=
 =?us-ascii?Q?qNtGO7ODiI02bXu75XN5dNxveS/RcY1FxAKmclm0kyKqupDXz5x7S/XnKDim?=
 =?us-ascii?Q?4TVn1NeUMjPxsU+PfT4AMjJiJc0lf0XLaAIAP93m6h2Vsf3Iu9qJEtisKka+?=
 =?us-ascii?Q?A4poL2R/h4M6i8I7K2fCJ5m/L1/jSKxnbPouDg7Of4LVjBqoaoBJwkIYeTbk?=
 =?us-ascii?Q?Z6J/Nvk6PSf54K0CHzdBn52GvcSKEL56XHKk0eADZ+GxY+U4QIK0/bLGcCjt?=
 =?us-ascii?Q?9qyN4hzoGlVtaAzKo+YCttb2z2Q09Ox4pAo6ywTM1EcYZAH8TosKcTe5rpug?=
 =?us-ascii?Q?QEr4F4y7cLd1XZsbOz78e/aH3RoQOM0M2f4mfF1aHGb3nLEJVqoFP3mRz0sT?=
 =?us-ascii?Q?njnGnYx4L0Xj87W7DWJ/pUt9kdZsAY2sRfIbjQjGdMdnMzsAu8nIDAHIypUQ?=
 =?us-ascii?Q?gmJixZ+Sj6DGORb5pL9XyDTz4zeQi/Rh3ModIcSam+96AVmLE61PZ9wAzMg3?=
 =?us-ascii?Q?V+96MNZ6vG9gvoi5eex/DL9M2CL9BUpJPqvdu/UrIXKiyffl+PZvnLaaa7/O?=
 =?us-ascii?Q?Ty0ZXU0OeNu/arSD9GJ2f8gu7kNd5uDZEZEVDqlX/2Cat18NEw+ScaP1SIm2?=
 =?us-ascii?Q?b4LbKZIOnXX0+KgK5nIIaD6BqwF0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KoSHk0Iv063kQkcwggEBgb5pS1TjQt5Mnd+UA+GUxcE8zDvZS02abmOYcspD?=
 =?us-ascii?Q?7fJXQreVkPVkq/ne/S8HUgPCUCMPMZP4LEuJAEld32zu3zKH0JjOLbFJ+u7E?=
 =?us-ascii?Q?A2qt2IAmyWtvXozG+88fzRBKthuvAoX2ztfN85solc0eXklwT3JJRK+31AD7?=
 =?us-ascii?Q?h7Fz+JMEx1YsuhiUJj/EL4GH6rWjtbB09uVAc/juqQ2skF+MoT7ydIxVk/v7?=
 =?us-ascii?Q?hmett9r2X6T+8O/6Av4XXY6PeIQ19xIsL9R84wwIV32IQ6WJ0AgA9OdLUrxn?=
 =?us-ascii?Q?X2txNsULw7ubSc3sm8MPXJ3RQELT/LFw68lZyQnLpkxmwBKAsK7tKTQQFgTY?=
 =?us-ascii?Q?52OJdBcEsFqR5sJPShuU1NleUAaBphMHAYsOxa0NEzDYKaoryV/Iy0KPgMD8?=
 =?us-ascii?Q?pEYltgOfciILOF46MXf4krJAh+AVAGxJoz8zBMjJtBtMW2G2volgBacgta0Y?=
 =?us-ascii?Q?v5NwRWiLT8HzAvQocOqWV3Cv6nJBAZcPR8r5k7kRWZzgdMBpCZs2z5J1HYsA?=
 =?us-ascii?Q?/XKv+PHyOlR5hcLExWTNbV/Va3NvgtGt4QKbg6jDcOVX6GitZUl6ue8fsjdl?=
 =?us-ascii?Q?Rui0T+PO6gQ2/LiHt66gZjRqeUNDl165G+wgT5hDvt0hndcyUG3gjW7ay6TJ?=
 =?us-ascii?Q?gMKUR7AuYd2/RFAo0UewLDiUbmqwsHz2m017gMjSEehZN0SkJk7weLWlaAXZ?=
 =?us-ascii?Q?LpbGeYIBCMiE6X/hmHcEeLGaIcmjJrhvFF1WhRxnepULveyNgqq5uhKQH/If?=
 =?us-ascii?Q?wx8/xR51XB+hlDAtUMR6gY7mQZ9yGd+E+gx8kq+t22XiBF1eFpg0/zDOsEVp?=
 =?us-ascii?Q?iIvwgjqdND1cWUMk9Cmo7V88+yFqvjMut9D738hsn7SlNAMFexc+dAq6mmHU?=
 =?us-ascii?Q?7dBdTcxOQ+vv5hvM6VsmyqiCUp3xQ0xwgL2ogE5/rUeCAncOakJJwZDUBEpL?=
 =?us-ascii?Q?MiHRK/GM/jVWVSwumsxH4DRsuk4MLcqFbyKohOUPYHr9ktZyFXw2HvUBRtHZ?=
 =?us-ascii?Q?zgI16OGr4MyfcoPehTadAKGI+tZXOOPxbXpW07VCHs2QTF5xrR8mHOzZQWOg?=
 =?us-ascii?Q?U0InP5zDOvqzXiaNuxCygqq0mwQ8IbEsvupCUB1XfLvHLDrhjcGOWczb9pV4?=
 =?us-ascii?Q?LgUXf9kr9uxex3FvWshMZxmZHw7JKX9u3gFY99Y2vtJNwqKAWh33hhB7Vy3N?=
 =?us-ascii?Q?UkjOeQydda38TOGGODVLa5SgYSvKa54ow9bswGphKgj7J+8IM8b3mPfil9Ws?=
 =?us-ascii?Q?I4mYJScZ+Xt9U4UsfaTrpakELDiT88ci0GMepGYOsDepryQ1dvh9C3kE42U6?=
 =?us-ascii?Q?5wL4WPowAg6EbJqyZXgDx1HdgSl2qSZ1Lh1jqPTVUeyk7R1VliDlqbiVB2aR?=
 =?us-ascii?Q?Akl2uTZHbLnuZcDWcLNiy/OAy7VYYrFby3gaMJYjnmDxzRMc5jB/478Xfk2m?=
 =?us-ascii?Q?MmEfztbBUXhLc/dH0EzXOHl84wM4HRHJ44YvSf/Yl+tIuGlHpEes4O0qKSPo?=
 =?us-ascii?Q?Ybr37BDgI2Cjcl7CiwuvYz0JudIK3cfYc21+jSWOCTgVm92Mf77Qxf5V1KbO?=
 =?us-ascii?Q?k1eJDFGZgZfY/c1KlRGgF/xsL3Ntc1YiL1ijnkIhm8Edqn+nKPz8HRBJcLxn?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e60265c4-06db-4676-623c-08dd78551c39
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 17:28:29.8779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDoXYfCNLkH1KA3I5KvL3DVSMHaGvl+SvRWGBHWLZJ4Kz2V+R3cmhVD7530lOkH6HTiFQRb5u7FUdt67w5/UrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4860
X-OriginatorOrg: intel.com

On Tue, Apr 08, 2025 at 05:00:55PM +0300, Tariq Toukan wrote:
> From: Vlad Dogaru <vdogaru@nvidia.com>
> 
> Periodically check for unused action STE tables and free their
> associated resources. In order to do this safely, add a per-queue lock
> to synchronize the garbage collect work with regular operations on
> steering rules.
> 
> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../mlx5/core/steering/hws/action_ste_pool.c  | 88 ++++++++++++++++++-
>  .../mlx5/core/steering/hws/action_ste_pool.h  | 11 +++
>  .../mellanox/mlx5/core/steering/hws/context.h |  1 +
>  3 files changed, 96 insertions(+), 4 deletions(-)

[...]

> +
> +static void hws_action_ste_pool_cleanup(struct work_struct *work)
> +{
> +	enum mlx5hws_pool_optimize opt;
> +	struct mlx5hws_context *ctx;
> +	LIST_HEAD(cleanup);
> +	int i;
> +
> +	ctx = container_of(work, struct mlx5hws_context,
> +			   action_ste_cleanup.work);
> +
> +	for (i = 0; i < ctx->queues; i++) {
> +		struct mlx5hws_action_ste_pool *p = &ctx->action_ste_pool[i];
> +
> +		mutex_lock(&p->lock);
> +		for (opt = MLX5HWS_POOL_OPTIMIZE_NONE;
> +		     opt < MLX5HWS_POOL_OPTIMIZE_MAX; opt++)
> +			hws_action_ste_pool_element_collect_stale(
> +				&p->elems[opt], &cleanup);
> +		mutex_unlock(&p->lock);
> +	}

As I understand, in the loop above all unused items are being collected
to remove them at the end of the function, using `hws_action_ste_table_cleanup_list()`.

I noticed that only the collecting of elements is protected with the mutex.
So I have a question: is it possible that in a very short period of time
(between `mutex_unlock()` and `hws_action_ste_table_cleanup_list()` calls),
the cleanup list can somehow be invalidated (by changing the STE state
in another thread)?

> +
> +	hws_action_ste_table_cleanup_list(&cleanup);
> +
> +	schedule_delayed_work(&ctx->action_ste_cleanup,
> +			      secs_to_jiffies(
> +				  MLX5HWS_ACTION_STE_POOL_CLEANUP_SECONDS));
> +}
> +

[...]

Thanks,
Michal


