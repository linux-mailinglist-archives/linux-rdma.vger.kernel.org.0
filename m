Return-Path: <linux-rdma+bounces-7567-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D38A2D180
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 00:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B566188E937
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 23:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E5E1CEAD3;
	Fri,  7 Feb 2025 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJIBCCsH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629F6187872;
	Fri,  7 Feb 2025 23:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738971130; cv=fail; b=PyDqSvgQOE7CBJu3Gh4uyIRINzzLTmJ3D+DGDxnQyCo3oQU0I3WHz/ZAC57ABm8ZYHeflsYwnAaz19gbxeP+5ldSZ/rS5sSx/bgtPtAW1M0aLqsr/0tVOyYRgY7Ikxqd+bty+uXE+kmmKJ/Zh/u5kQm056xkplDSGq4yt2CKRrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738971130; c=relaxed/simple;
	bh=Lx91zJeR5R/wAjiropcGGLhAgTPwiiAZ41Yir0CflkU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=exb+ATwUrvn9J7uHs4LdS4EELOB4EkoEa7pqJeJorfc/fMLzotFLxrVigUyqthzfujZO6llS+kGpzqiJ13QL7FpjQ/VyOVAOp+lzv7yFcNLiV1S+Is97+Ly64j6FeRdgfA2uqKx8HcfHX+QYLEtBvuyPc82D0Z0ojAjYwAieG28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJIBCCsH; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738971129; x=1770507129;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Lx91zJeR5R/wAjiropcGGLhAgTPwiiAZ41Yir0CflkU=;
  b=nJIBCCsHrFiKmtKBub/td+hpaj341ZtmRPnJ5WC1fAkuyjL8prwN4XTu
   4wKQD4cAaZExHOzDbh8T0R41q5hpkpTldZr1FV7LCV8cx5mqivSztNEF7
   LPB1UzzG0fZ1RlHECEjkJNuB0Vo1mkXW0UIg7Qnq5kzOsinTzDroXx/EB
   6AvlUCMf9Vtng8E3Qqfh9I3kOSrQnjfEaa1ullORE9m77u1ATcQYw7lmO
   6MBIALFCMXVPpcBG6MXozwhqvLhIDUttY3Fr0EVJUeRql7LpSCv6OfWRI
   q/OFNSpmqztQniZ1DSrs9g6jBik4GchgJ75ycfoPlUkPvHQRsJ31Std9I
   A==;
X-CSE-ConnectionGUID: Y5D4sWw3TPGvKe/F5fYuSg==
X-CSE-MsgGUID: i5RHoNB/Qd20YsE/pZLhIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="43387516"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="43387516"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 15:32:08 -0800
X-CSE-ConnectionGUID: IVdqelYiQCiKGR8ScJNvSA==
X-CSE-MsgGUID: IGK6ceFARciLfl6QA0TeVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115741534"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 15:32:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 15:32:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 15:32:06 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 15:32:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jm/0/ih6d9/4o93rVBZjFPsFMJRvabZGWGhLGHAqA4YBUTcPo1X2ddje3QxqTHifxvLAutlNWK8yolrK37TGUqxoaxvevDQNYVi2FINM5FNxLDVnOjeXcI5EFn6cUWx7WVK6Qqz6ySnRXPWxBwEp+mEXCjQ3wH57dtxdLoQPGaui94i303kXS+XOSkVnJPWJ9XrHywktQfFuGnv6Ajr+JC8UhQAOVwZqc7x4myVKKHw6CojThy1USGAJk2W8oDst0WFdvaStHoPi3R4xu9axa0dmXXje1Zj6v1sh+6PXqLrmEZu7LqOpAZsRCi12Z1zK1+g1G32NgzjXOPvUjI9suw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9XO2dPV/vMLls92uREiYlYQh+uqzKpLffqYdOTXL8s=;
 b=GcMgGVaBaLwsbMMUnuzB3rb59DSB3IvE9Cfppq9+rsfcu9LatkTFRyb/jALMbib8FrZnZl/06odgXCO6/t83pVjB1nTLNzo84X7qWGSz8H6qwLp2S7mdh7Cj/twT1ZuULy0fk/yvEuypf9rf0JuF4YH7pxTm3pKsRoWcfkfiIoDrQttrTjljjmF3w8WLHcgu+GsrwQZw5kU1Dzd56KdBWRITONp+YibR6a+aop0115OufAxdcZnaYdvKi9o+e+3X9gWA0LEnx+TBNQshJjmveo5mh/mkn4LqAaMdg2kpmVJeF9JHT/w/OB6FQVvGAOgCTvYlfZBMp4Rft3D2qwCDPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7380.namprd11.prod.outlook.com (2603:10b6:208:430::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 23:32:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 23:32:03 +0000
Date: Fri, 7 Feb 2025 15:32:00 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton
	<aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, "Daniel
 Vetter" <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, "David
 Ahern" <dsahern@kernel.org>, Andy Gospodarek <gospo@broadcom.com>, "Christoph
 Hellwig" <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>, Leon
 Romanovsky <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, "Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v4 01/10] fwctl: Add basic structure for a class
 subsystem with a cdev
Message-ID: <67a697f02bc0b_2d1e2948a@dwillia2-xfh.jf.intel.com.notmuch>
References: <1-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0069.namprd04.prod.outlook.com
 (2603:10b6:303:6b::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 2edb02a1-11fd-4855-35c4-08dd47cfa064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QaAgo1gVXbCJRgc2+RScgr4papbaGz4ja5vNO4vZeFnh2KTuv3XVd6YUhhlo?=
 =?us-ascii?Q?txnnxe9bhTdvlRIjMyL7DYLhSe6h4s+2la+g/gdblUXAjMpIyTyqxB8cbB9I?=
 =?us-ascii?Q?eVM9Ad0+l/49QPKEZDoVSjh+fz/CvaQ8zIzUMwCeNDsbxOaRy5IMXPX4PF5s?=
 =?us-ascii?Q?O/Bm30BkpSwwqI90n+AyfCTHZjuSsntsEdjuRIrwqvYDdB8ljAhV/9hBPu1X?=
 =?us-ascii?Q?en0zSytwQkujd17SQtyxdiX1WfGfLWaRL37gUlUWydJLq4q89MWdYwy7QcgT?=
 =?us-ascii?Q?qDNC+k2AQh+nZDSJ5ozzw+KG5XFll/BC0/VaHdq1YdvwDyqBsgVr5of/1B1z?=
 =?us-ascii?Q?4qqI9b5hmkrVsPe9IVubSOD8v8WkB4Wc7XOOa9oco9PN1ThAVBt1EoZs63AV?=
 =?us-ascii?Q?Wop6eBBMsaSpBBSzGK33bEd/+VJSt9m0LcOUmr11uMBjE4U+UH29vfIwrquc?=
 =?us-ascii?Q?E5wK2jIJhTOv9VmXFIUQOltpHAB+KeLi6b1c8JjsRrBOulXn42jL6I+zaahw?=
 =?us-ascii?Q?bTOWz6gIcSlxm7goG805kiINshIp9C3g7pp6JlwxOw2TPIOekGgfzM58onYg?=
 =?us-ascii?Q?oYW0VVmi2r3npzlTo6HEUKnbrs0o6UgTnK4Up0WgypyuoWQxcEVJ1v2GuSIp?=
 =?us-ascii?Q?BC7DOXR5mWZWmulwVXz9avHvnMvJFt6WEanB9CG8Jgpi8QUoisY6/s+WqNJF?=
 =?us-ascii?Q?rA581wdae2buTeE36nX2/bRJvEV7eUH1XLtDr2Wu4WGhHF8uJuPHNYGKf7ND?=
 =?us-ascii?Q?mfaY2zdH9qTPM48853alyjIiyGURYdvtH0roChB9A/fjet+LEtFzBQnFQMyp?=
 =?us-ascii?Q?uTZG8SMO09nvr36nrOk6xQ74pmSoF8XReJr6Ufc5P10cOUHEplWnxk8my+hJ?=
 =?us-ascii?Q?Ex/1f1+3vTdmSBQZnvmAaCOXEw7yQepzT1qWRyeVVNJt65W8xEnqK8nqgqIb?=
 =?us-ascii?Q?Ev08dWBcKFp+LSSwKMRZUOeEKZ3UnkjkRlVo/LuuzYtyyPxd69kwtQt3g3qJ?=
 =?us-ascii?Q?DnIhI+Pvg5E5Z78s32DSq0APde4Wf97UQ85Jc5u7VI8mXWqoVLC8nQua0OLq?=
 =?us-ascii?Q?bLVX+9+MJbaQj6hg/H2zBgnIGI5DjkSN4xJ2EOVssHEQKR3P22y0jxA0y9Xz?=
 =?us-ascii?Q?QZIepPE+YlJLHd386EbSpwjih46NZLLIha+lQHASmWheoztK2EeDbIbuopp3?=
 =?us-ascii?Q?bYEh0VK1vBsApnffFraRsQoG855H/3Ak6vwuGh38+EycopR58TIQB5s244BT?=
 =?us-ascii?Q?0rHPodaDY5iz61miUZv1/JQnWUQPOohY40HpiGMBVRejzlqIVenCrNd0git8?=
 =?us-ascii?Q?2qpQIAcvNux+aIQHk97khOJxUWwsiH2agIaSInwHCPNj0yr5WweCE1LFjNqI?=
 =?us-ascii?Q?iY+ys+bV094dZxF/Xu4WU5XO+ymL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nVwX5xiE1JIfkyv2UEvT1SpXuscyHq050y3Rth/dsVhBgqBkbOxylsBpEKFs?=
 =?us-ascii?Q?dy0VwXT1OEoQMXcEG8Y1sWfVL5CsqzH5XZrhzQKHaDLLH3iFFWGXQbgc29hV?=
 =?us-ascii?Q?6wBauCCX3k4UXIuJfPN+QlM0B1ZLLk5T1xtOvkAYbF8buhou6RnJfEZmc6QV?=
 =?us-ascii?Q?absKXoopp4D3bEI+7RGdc3faUXOjxp++pLSVpV8xaZTCC73ICdTRndEsO8S2?=
 =?us-ascii?Q?25PbNDBO/EXZTnLyNV2mtHOujOhxeIEE9rb4bfShbjEV0mf8t9ufzSODvWNy?=
 =?us-ascii?Q?tHGI0UltTjkKYyUsJNeilCGSTveEl5B03F5Xrv52b8/XuTNJBwesc8nnpfSa?=
 =?us-ascii?Q?fS/a3YxI1b0+3oxs6Mgz6OT06e/UwBeNzAqOV8QvnKeAcxoraLVz7eAmmSro?=
 =?us-ascii?Q?p6fD9DA8tUpjxgwLxVGiWM03fmo914FQJVju8MDkZ2/fmNrfd4MNB02dwaFl?=
 =?us-ascii?Q?SHXrp15mAJ9CkYLBcaXFBI3Wpku0g7lt8bfPKRL2hh4oNnOOM3XQlpVrIArL?=
 =?us-ascii?Q?Zk7dBl6C64Q7EbC1szfVvYelm/ezvApSVYPXsBSbVZJ9pTo0QGDeB32ETE3A?=
 =?us-ascii?Q?DfK+gTM1NovyTctCdbxCoEpQDrkRhCJreuerju++IGm6FjcCki50mzoTMVje?=
 =?us-ascii?Q?CLOtNwZrUa/TKPrne//YRiR20szQ0PRmBEUS+mO56tBif+oDpNFv6KatCx4Y?=
 =?us-ascii?Q?/v8yYXWnMd1stsw4QjsY2978/k0x8o1/dHz+cTzqIaRGMVU47ZBizrJEEmoM?=
 =?us-ascii?Q?jFJUbcKssoZdh2gkkeWnJFU3peIJGllr5T7f4pmwzSSBt/F9Gv7Mq/7rmiPa?=
 =?us-ascii?Q?7BKJCB7K/1O6vPEJfyDaUq1TUF3V52gFo9qKqoMZxVygXXhzAJKaNWdmF5xU?=
 =?us-ascii?Q?rHNun9zntTnhdmkao3QMFistwuND9LQFImIDTP//VUHUr/JKZYevwPdMMUds?=
 =?us-ascii?Q?VlnlBk9RLM+tOamndnuIHzCtRJxtIlH6yXsE2B2OuHOwU9B9I4f94qS+TawB?=
 =?us-ascii?Q?UV9osmirrYXvcM99Y8UPEDA5vpUi2vJ/b/GqaB2Krc47qX5pjJoXoau0qi4x?=
 =?us-ascii?Q?A5D8pwM1nFohG57bih1c86MpKPIu17SPs4ruMArkb5+soto2X4drUnSRNGJY?=
 =?us-ascii?Q?LrUu79DOrurlRFF5NB/kBsGaGj9nI/7lJUlDnkQpiE7c2Jk8YnLxRwa1jpaj?=
 =?us-ascii?Q?20RuTgdkQvvNUcBJvtBwbHtU4WYKXS0WPcsGTxYFR8s9TAE4VmQf8ItiyMFc?=
 =?us-ascii?Q?0B2DmpsrRuEzBafxoRu5P3OajbtEsbTI2aydRIn37Bs/Sj0ey4hzq6vrCSJR?=
 =?us-ascii?Q?IIdqLKXfzWb+KkaxLQJbkUsLvXuWgpPlYQd5bx+6/WeP9DaOvMWFZ+VJa1tU?=
 =?us-ascii?Q?DpW3CCsbsMo/jZjEzaLkc4TZqeor6RVItiIPTO1wd1BHAT1DCvqHG35rA90x?=
 =?us-ascii?Q?OkBIYf+QA+QzSlffgEtmFgjlkU+x/9DLRQC8JBO7blasEDP1/1rHrP1mBaP3?=
 =?us-ascii?Q?3yXyySrWgDXADznYFBJ7DGvFR5UKEKhbaW1BW9dWjGHzKnlniPqQhB1GFopS?=
 =?us-ascii?Q?O0hBuzHIh6ie2b/j6RwIm5ULIsQatgfAI71gjMyASga/2styEgsQ5XG9CtLs?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edb02a1-11fd-4855-35c4-08dd47cfa064
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 23:32:03.3282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Krw6ya7hKUDKOizUjAviigyjJRQCSJ/Bw2N/KJHV+X7ipMIMmKk/psjJObBKXmelo6MuQlSlLNpUBpRJPh0ry2cFwTkQRGRNSoyQgeiRbcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7380
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> Create the class, character device and functions for a fwctl driver to
> un/register to the subsystem.
> 
> A typical fwctl driver has a sysfs presence like:
> 
> $ ls -l /dev/fwctl/fwctl0
> crw------- 1 root root 250, 0 Apr 25 19:16 /dev/fwctl/fwctl0
> 
> $ ls /sys/class/fwctl/fwctl0
> dev  device  power  subsystem  uevent
> 
> $ ls /sys/class/fwctl/fwctl0/device/infiniband/
> ibp0s10f0
> 
> $ ls /sys/class/infiniband/ibp0s10f0/device/fwctl/
> fwctl0/
> 
> $ ls /sys/devices/pci0000:00/0000:00:0a.0/fwctl/fwctl0
> dev  device  power  subsystem  uevent
> 
> Which allows userspace to link all the multi-subsystem driver components
> together and learn the subsystem specific names for the device's
> components.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
[..]
> +struct fwctl_device *_fwctl_alloc_device(struct device *parent,
> +					 const struct fwctl_ops *ops,
> +					 size_t size);
> +/**
> + * fwctl_alloc_device - Allocate a fwctl
> + * @parent: Physical device that provides the FW interface
> + * @ops: Driver ops to register
> + * @drv_struct: 'struct driver_fwctl' that holds the struct fwctl_device
> + * @member: Name of the struct fwctl_device in @drv_struct
> + *
> + * This allocates and initializes the fwctl_device embedded in the drv_struct.
> + * Upon success the pointer must be freed via fwctl_put(). Returns a 'drv_struct
> + * \*' on success, NULL on error.
> + */
> +#define fwctl_alloc_device(parent, ops, drv_struct, member)               \
> +	({                                                                \
> +		static_assert(__same_type(struct fwctl_device,            \
> +					  ((drv_struct *)NULL)->member)); \
> +		static_assert(offsetof(drv_struct, member) == 0);         \
> +		(drv_struct *)_fwctl_alloc_device(parent, ops,            \
> +						  sizeof(drv_struct));    \
> +	})

I have already suggested someone else copy this approach to context
allocation. What do you think of generalizing this in
include/linux/container_of.h as:

#define container_alloc(core_struct, drv_struct, member, alloc_fn, ...)    \
       ({                                                                 \
               static_assert(__same_type(core_struct,                     \
                                         ((drv_struct *)NULL)->member));  \
               static_assert(offsetof(drv_struct, member) == 0);          \
               (drv_struct *)(alloc_fn)(sizeof(drv_struct), __VA_ARGS__); \
       })

...and then fwctl_alloc_device becomes:

#define fwctl_alloc_device(parent, ops, drv_struct, member) \
	container_alloc(struct fwctl_device, drv_struct, member, \
			_fwctl_alloc_device, parent, ops);

Either way, you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

