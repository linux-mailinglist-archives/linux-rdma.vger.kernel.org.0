Return-Path: <linux-rdma+bounces-9302-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4189A82BCF
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 18:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355D73B9BD7
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 15:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E0C26A0A9;
	Wed,  9 Apr 2025 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3QZdPOd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D862B265CB0;
	Wed,  9 Apr 2025 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213858; cv=fail; b=ner5GU26caqLwWPxkkDK4LZc/5UomOnhMW8rwXpkNIMrAgs3LJKz3hBhO2f+kbcjrOZqbNbPT3S/O2eL6WSKQfUpqdnHRF+2SEoYShLS9S+Mcm/8JgqhLsxm5wwMRbKYtqb4NsFUVcQBVM+8uW5jvyjtWbgMmUyzI3weyHD14HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213858; c=relaxed/simple;
	bh=j0g11ig63yWpsDzFqEFnLVe6vB4e5ARpempMz11zh/c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TYoYsdbroxzASq16LjRkhFFBHblZhoBzcOpEqPZ4DCmC/QF59xZJ/s2R/Env44dSar9L2o0XpLDf4Wmh+tjxIljF/z6W3xiKv6Z8pnXadZTZTSDDmswuWZCiVpHTIkmxBvsf8Ho9++0guI7gYLHE21zQGTbXdedHry+xCz8PIZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3QZdPOd; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744213858; x=1775749858;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=j0g11ig63yWpsDzFqEFnLVe6vB4e5ARpempMz11zh/c=;
  b=N3QZdPOd4jPlzV58adP3o6ci6Aj6sCv+14nsGQrwZHdMiwDUlqPs9BIy
   GaZiydCOhOsemQ1qlVf1v7jNUDFWbK3F9vWikyKOSjfqFOJDNJCKP6U1q
   6eLu/EBMcTHwcuN4zo/qsPryA1YXgre4a6xDtowwGM+2N7FvPZSi6tGrY
   nDJ7pIvdjnkTqK38zgwvdNMgx8OvIxkTHRD4mUrgh0/Cp+PSrtMtcPJC1
   Fe8gIHavQMejZuBBY/i4WQT7TlIQeuyVrFkrRFpeAEg1dEZJhRBFo4R60
   dsKgZ9q0lJqB3wUfZa6LCgujpehvnILqyxRW1z5bLxzDTQoGIWSic2EjL
   g==;
X-CSE-ConnectionGUID: Foa23LK8RV2Xm+h5yByUkQ==
X-CSE-MsgGUID: LIu4BmtbSGCXxLf+kaW+IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45711044"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="45711044"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:50:48 -0700
X-CSE-ConnectionGUID: L2fi86vITHSA1GTha7BuXA==
X-CSE-MsgGUID: J+8pXB4PTR6rsQ3HAz7xYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="129168501"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:50:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 08:50:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 08:50:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 08:50:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SV1FkOPC0muHMOq8TWKgTIhcP7xpyTH2QtP67LlVUH6TJubVe5aRkR3kMlHBJL+UQ/bTjdXwEHtOXNd8tGp+A+8XG8h/TF7aldPLh+gMHcOwJ0s7mluaT/gn5axGIQuliMYhQIyeVLzZJ+d+PRJF8mBcngxKItEqgeG7zE53AfbCKPjCr8Vzc/a1YUFNFzmQdGx5ce2wtPdeS/tr4OYMi27u4z4XHxjNo4LcMhqWyzKMHbq/D5r39q/mgACuLcTrpe5PPFAx+17uHApuuqSmp1szzfHPFCa0b10V9rSLpfnchh33SmyhtF3h37wy/1FxxgVzc7DnGU4/k2TOB5NG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oX5O8JEoGU5HrE+FD0lp9teMLwgWMoCHLSZOW21C9sM=;
 b=EZfn+t/SwFstRDbmZOeeyscK36IrNVUFNxIGpzSxOvJverGZrQWicg85Y4Rhv3+14aentKcU7kPBvSlMOXWp9ABcT8UdvaujtduETPxl5RWaptIFq1xgbEIqQRR4l8zUYGS+Z1sZ2gi/bE2JKsVs6+/JC2alfLi/on9/axVBG3anDhnj9dI/TftZR7DOT1kfNzwmUy4M9r1sJ9jUV2cRsw+3zD5FAUN5pkOmdNoxKqbVCVX6ZGwjV5FeIRNFtpRmFEdN6lr5y0dovFbmDWuftxvuxCp1WErYL6TYPFov6XBJNi8O+v4kBQrrT09KUIQXabqAZ7+vNHiUIzxx74nwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 IA1PR11MB8802.namprd11.prod.outlook.com (2603:10b6:208:598::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 15:50:42 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.021; Wed, 9 Apr 2025
 15:50:41 +0000
Date: Wed, 9 Apr 2025 17:50:29 +0200
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
Subject: Re: [PATCH net-next 02/12] net/mlx5: HWS, Remove unused element array
Message-ID: <Z/aXRZz38snRxyYw@localhost.localdomain>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
 <1744120856-341328-3-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1744120856-341328-3-git-send-email-tariqt@nvidia.com>
X-ClientProxiedBy: MI2P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::12) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|IA1PR11MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db1bcfd-76dc-4acd-8e1e-08dd777e4826
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cacoRydIkuv4fOl2mFKJkvnGzgNf4LqH4caglqzZNVHeBdQNbuYv37kb8O9F?=
 =?us-ascii?Q?cQnjJJyAtgX1QACXoK1jMSm725fJCqLtA5mkTb3CFLr7AfPZv5SKOKTLqxCD?=
 =?us-ascii?Q?f2Y0Mor32IUhq0VrEGtpSALV/HX1JABPeOJwhuPDiIz+dJSLrDSFXWSEf/t+?=
 =?us-ascii?Q?+oFs6y3EH0gRIIUlRHQKinFR9KOKmU2VpsZDFrR0ZO5xrdvPft5W1oBvb8lW?=
 =?us-ascii?Q?Uv8adOK5/ZqLuB5mgiE0/fWC1YC14dAm4BPjVaSjvNEZzc8QRpPPTQ3+sz6R?=
 =?us-ascii?Q?xFaLTaXxd+GrPSpvqztYV/2jA9YLE6bsTDOWn7JF0BfeKoY0/WlbY9htOexN?=
 =?us-ascii?Q?lPm+ExBSdItL0+Ux+l2PbxnDO/RLWstNGulQAWQoRe/LRF8gNURCDn6n0tUy?=
 =?us-ascii?Q?bbHM7ToagTFLaoOM4oP4SulZg1FYuwK4Tsnx6PNwdrEzdIXCdrLs18gx3nVl?=
 =?us-ascii?Q?aOmlf5a/FSBxGmJZkULOpuoTmZa7KFGX2QPJIKvFowdIGXuweVRf3agS7LfH?=
 =?us-ascii?Q?bI97FuSe9abuLzNqP9qdXag3x9ChzvTIa7Qsi1CxLiUZfYMKHuGod6dvc3+O?=
 =?us-ascii?Q?LDSoTBe00kS3MKiXKUz79cKdKHDQiYHHGnGe1DytQWGAWYJR+2Ujp+oHdB85?=
 =?us-ascii?Q?86Ex7qBsl8kYH3EUHcwip+EkV7/6NwWk1ENPhGEm+jvESWXAUt+amL0HYy/h?=
 =?us-ascii?Q?BNScf2iCcOjQpIs9jxA9dOJ/24GBgpeDDZYRMyMZ7ttmuzEnDAS4AHjUlRSb?=
 =?us-ascii?Q?amXf7/Is5bBXp0iKmlTaXhdgZK5U2xxJMf3HrXcSutmIyO0FD6PZllJkRox9?=
 =?us-ascii?Q?ca0RCcf2DENcEpXqLvVZYS53SBuOiwghcNpDWLwx2MlPQ1LTN/EdF88r5+yx?=
 =?us-ascii?Q?7ebe4caN8XvIaGp48aBW0/sPyj50NUHo9VVOwCThVC/agismyEcIOqU3m58k?=
 =?us-ascii?Q?BZlTLqEtCYlsMlk08ZzCjkEBVlrXoasbe+nDZGFSnfV2+GXInJC4ZoKnSH2U?=
 =?us-ascii?Q?lirZGzLd8dyuqTSaR1z8m+TsCprq9aLMgm0e+uYd34D0KZtWHLd/LK++aLH1?=
 =?us-ascii?Q?QYAFJy3i9ZuBlTKHeYLriiy6qYAVURGEtckjFDr6YLcKfdHM9dY7Ra3JCT+N?=
 =?us-ascii?Q?wtmdyvq6XvA4z+msmvk5pEIW2EMJ7EiO22eKBAlNwFRFKSxkgVE6eNs45T0M?=
 =?us-ascii?Q?1JsL06Jrlm7Wac1oI2D8TEh7LfDylTMue92R5VcbEx/4lIzH3RqdTSQ1eKum?=
 =?us-ascii?Q?DIKMt+0Fxajb1l37F6/ARU4udQJi8bn0Z7ouY/iEEmxnXbfy0XCXf15ER9Zg?=
 =?us-ascii?Q?d7xyVGoCjT5a7MbwX2YDD460eWTaBm+e59I1ekMCH1hH6HuMmxOm3ubfPMh7?=
 =?us-ascii?Q?lQdRcU5VsOM5pl0OLcdZtQboz08Ag0GQb0k+03VD6SbxapxXCEPIc/9wxtF3?=
 =?us-ascii?Q?U5p8Z5eH1pk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EbP6NvVBW3VbFRYlbsTrxerQbEnM4vcY5H8vPVT+D/vMH9LYGPk1Q+4kpSyC?=
 =?us-ascii?Q?856XCUgKzU23OdxewlZDEKn09wNPpbAbodDmiwhlFeCsixeowp+V/bnsefTs?=
 =?us-ascii?Q?eKjioj4bPFVZYTrx1dexR/H4qCwHwJPMabRc96HlHGQx4u29KzZ0sF0nILpK?=
 =?us-ascii?Q?BZeya1j8eoRQSFZFJ6afCNJZzku4os5xp1WKVKX4kTaqxCrNJwzoDeCx6LYJ?=
 =?us-ascii?Q?E8hNR6rfwUrYIspdfwh95z1VR1zezplUbsvEOVoF4/Mj9coswTH7GE7LdggL?=
 =?us-ascii?Q?Cuei4kQ0D8mOLmo1lo94OmS3h/FongRZRAz6wx69hf61i86blsmcT0KTGZMx?=
 =?us-ascii?Q?cC8y6mzAbQ9vMkcGwVxbXTCjwqzdPmji85vqkQbcitWi1aR0dV5frWdxCsm6?=
 =?us-ascii?Q?5gzA104DRRH/NQJrygKO+nK3uzbmgRsWIY4XuzFEM7H2JzWVSKSMkO1hLZXU?=
 =?us-ascii?Q?DeR/YbQhDXNWZ15dGS5DlKAWLub8e0XOPjxHYAAIrt3ZJkVgK0k6o+/s0RLe?=
 =?us-ascii?Q?/vgZHcANtNPzHoUaUfo/MA2KQ4n200go5VpFoWqt5nEmEEp3yN984easzwix?=
 =?us-ascii?Q?OfyVPdQKO29XK2W6JTKLuVWWeGNrTTRH7BmoxQNYMLSUBzj1r/IIwmEpTIoz?=
 =?us-ascii?Q?q3UW7TXXm68NS6tICRc0BmUCsM/v0J4QpGzrlo81Y1LRY5F/XsiE0YWZsePz?=
 =?us-ascii?Q?GQCt7sJKWUuldr+QWGADV/hO7ZfivvTLlbwi5olR4aWnYGqUwxvqdoowozWU?=
 =?us-ascii?Q?taZxjsi5bzvhdKxImSfjBLJch566Vpf1pFyNcNxm/oDnADS816pMR7O2rYY4?=
 =?us-ascii?Q?rGXx7q3qfaHinvzF6JgpZw3wWbzhU2UygQmKlVApzQLmGgl85bbOcomrmJRN?=
 =?us-ascii?Q?PfHU9r5Uy109rMR3NKlhJUjcj1ji3eJ6R19CK8TXhGa75kvwUKWTnMofHx1Q?=
 =?us-ascii?Q?phb07bwEpl/A6NMwpcRasDitc20OaQZS8cr5MeyYIf8RiTf4GDDvSIaAFSto?=
 =?us-ascii?Q?ncFxBmqdcDmBcEU9p7n/T18ztpgFHBcpdslWAO11T6fgDHevQVitY6wFY7eN?=
 =?us-ascii?Q?r60vrp2b3L1/aHZ7LQGDugJluBFDm8uI9HfQur+V4Rzl9btJFr4z6UB8ovSn?=
 =?us-ascii?Q?dVlUZlZNfcJp9J6MsKQ1o64X30HAoPX8FG52M3ANrHrXgmHxF83ye+YqMaGo?=
 =?us-ascii?Q?BsqyV9T8UT/K6LnhqrqrLOmA482WAeMUn8uG8uCoB8LT144u56X6ck4JneHJ?=
 =?us-ascii?Q?LJO0r3tUK2XLtSLB057qPegMOQEESTQmqGL9wBx2y4mQ/dDigpHdpEX7+9pi?=
 =?us-ascii?Q?0RuNMpZMq3fyu3HdOWezgd8YYcf1JbZUGox85bcno/HJrVJVjZegrwRzRZK/?=
 =?us-ascii?Q?xPx/21+WEJEna1XahpZcxND2fNyf6zi3Rnm5hh+9FMqwXfa3fSEX29HLvn+b?=
 =?us-ascii?Q?DtLmILWFBsJZReIZfiTOrxnsJfYKJFNuvbJdYpLryFZv6/vf1ayLdth6kL3w?=
 =?us-ascii?Q?nbt64mDjVRXY8kvFftlHwz0O5hRW9vmFPteeDKftURjT6HS8jSTB+HQKjcBE?=
 =?us-ascii?Q?MuL52sk6OobE0DbXD04MVCWwrkguhHpzB+vRu6BrESSW0sOV1oaf+fs7V0xa?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db1bcfd-76dc-4acd-8e1e-08dd777e4826
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 15:50:41.8296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0w/GGiU1YFJT0AUXuuurWPCSz14jRqNWjWitJZ3hyyc8WFZ9UanWHS59g4rUgd2eig0cUOLIMUm7iyxxYPpFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8802
X-OriginatorOrg: intel.com

On Tue, Apr 08, 2025 at 05:00:46PM +0300, Tariq Toukan wrote:
> From: Vlad Dogaru <vdogaru@nvidia.com>
> 
> Remove the array of elements wrapped in a struct because in reality only
> the first element was ever used.
> 
> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../mellanox/mlx5/core/steering/hws/pool.c    | 55 ++++++++-----------
>  .../mellanox/mlx5/core/steering/hws/pool.h    |  6 +-
>  2 files changed, 23 insertions(+), 38 deletions(-)
> 

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

