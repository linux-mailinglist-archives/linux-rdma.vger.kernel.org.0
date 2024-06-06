Return-Path: <linux-rdma+bounces-2966-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAB58FF78D
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 00:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275F51F2501D
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 22:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F203C13D2BB;
	Thu,  6 Jun 2024 22:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hy65TSEX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3124E1D6;
	Thu,  6 Jun 2024 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717711905; cv=fail; b=DYIGAqrDDc5uHbSnoBR5+uzgXLJHhxocpOwcMEREXMGIeS7GuFKUulcHQL0mNjCyDJEhBVvPUQnp0+i53+/BVXDI6R6lCG+TaoxvyY0prOrhc0PSbP8VZmBeIiz8k+Av6edi0cEJngUaa/k7bZLAOqfApinQWYTeFH17CqsgxZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717711905; c=relaxed/simple;
	bh=f/R6ktxDf4O1kUyaKOK4HeJPDSIULv50Io4ae1hfu9M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iXmT1oOtHb8LSKrp0vmLrBPn/rKTfxXtPtw0peHxyfaEN8zghzMEVZwT2o6VtXqHJGQdhPjU4y28DDUqfpuKFVKuGHaoHFxdbay8mTJNtS44kogwq9jIatPAKguFGbSJbgoCE1oyZGHy0JLEOSxaD2KxNJIoUrvtmw1ExsX5Soc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hy65TSEX; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717711904; x=1749247904;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=f/R6ktxDf4O1kUyaKOK4HeJPDSIULv50Io4ae1hfu9M=;
  b=hy65TSEX/jTN0UtHUUxxpVfAQfF1v5lkSKgQq2vS4zdU/nBv/OkTCDV/
   jmPHOpbSa7huRyaHOOKMcnRFHpVYytYAo6N3na9es7mspokdIfbGACout
   wt2wjKExXt3gOLfZBwK6LukOcvaEUoLKxbmVbi1s2z2ARy1DdRsFTM1VK
   22LjkJCw8xyLFSIlUWC048JxV8PekQfKpkH5Bl8KRD4+oLdBc29an7paU
   fIAbyji2ab1ZdosScVacseDvKmanar3XD65YCr5cO2vi0bAJCpRRMzW2m
   1sLAKm1n7C7T5rAeCXTdr420AecK0v9RRso/BTW9sD/IB5ic6eo3gna+W
   A==;
X-CSE-ConnectionGUID: 4Zek2EdJQXCPvhrl9Uhz/Q==
X-CSE-MsgGUID: 2+aG6ce7Q4OgaSMNciiaiw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="18265080"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="18265080"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 15:11:43 -0700
X-CSE-ConnectionGUID: Yd5GuwDnQj+LPZVMstND4g==
X-CSE-MsgGUID: mfvA2KGlTNOS5OU3JVd8Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="42687222"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jun 2024 15:11:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 15:11:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 6 Jun 2024 15:11:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 15:11:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXrHSsp+TQEcr6UpystjAyN4zoUGA/DyE5IUlcj/lrXT0sY1sFy2cnX+CWKFO5VnD5zoh7x2Z7fuEu6y2mbECqoVNUPI0CXP0xg1rGSMQABKAbVRsyy69qFb5PFkxHZ8VImdQnA+Nn21eXpMYz/qB9gk8bY2jUYuEqtK8iP9/zSwN/k84igzR+0lJ36Eeg9iHZhB6ve2ZfwqSShWOvkeEdZCuCD030bMW4f12vMBwUrDVWzOP0TIlCa/9bMrZk/5y7bp8HdPKmHmCtNiddbLwvOobMSM+2x0ewB4yRMz+mM9IFpaJ603fxa32BOV9Ngo2m1domJzSuQKek8zPaBepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K83AhfsrI9SBcWZ+ZgAhqWDMU9ehEMpLlfvd8J90JEo=;
 b=boo3XQNZCtrH4jlfA0GAdbYNBCu6PkiTjY0YrWvTTD4eO0zXvOM6v4nX3z1k0CwD1BHkTvuB1K1YOmR6ePaQisjyeBGV8fUd6/Li6Cpcn1o+xnqr9epIDKlIgwar8Q/e2fxa9MhOqlLo5PZiNffVILbdLBvk/TzgtinuJQrrRLpqHnLVOtqlB5wX+KPxEp590/rdSG33IMSWJ9cBfl42MkekcGzL6oCWsLQSB+27MZJ7BoCVIGcMMNYJ2CINHpOwqsIqiGnTeIpFhqGebPRfRhao97siH3MXtp/UrxVePboaK59KWorSxL7IDOCDWL54NAX0bplUP4hZq1IIaRSPqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6115.namprd11.prod.outlook.com (2603:10b6:930:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Thu, 6 Jun
 2024 22:11:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 22:11:25 +0000
Date: Thu, 6 Jun 2024 15:11:21 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Leon Romanovsky <leon@kernel.org>, Dan Williams <dan.j.williams@intel.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David
 Ahern" <dsahern@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Itay Avraham
	<itayavr@nvidia.com>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, "Aron
 Silverton" <aron.silverton@oracle.com>, Christoph Hellwig
	<hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
	<lbloch@nvidia.com>, <linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <66623409b2653_2177294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
 <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240605135911.GT19897@nvidia.com>
 <6661416ed4334_2d412294a1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240606085033.GC13732@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240606085033.GC13732@unreal>
X-ClientProxiedBy: MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b112d3f-1f14-430b-aae5-08dc86759afc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZnBjr9hs922iG7SPjuhV9aoNn5H34Wj/FBJ/NN5QmERIIye9ismRyM78uda4?=
 =?us-ascii?Q?dVYT1aXsHbvX0epx3r1BZhv8I1VwxykWJtF8r4HI6bGRTVk0+VxM10Y/TwyJ?=
 =?us-ascii?Q?XVeR50I4tKKHK64xm0NDAoCwb2nnj+yWHertj7TKUi8VM1AacWQm3ZDoM8RW?=
 =?us-ascii?Q?uLeIhsE36Oog04xh6buLjD+8+XjE0SVeoFleXcoMb9Do+Cuarz1yi1sF6BuR?=
 =?us-ascii?Q?RouwxvxcO/76WUT3FKwpmauIiangdyTlsT1/r4MeCmER75by9djDSPBeFS5n?=
 =?us-ascii?Q?b+ahDu0kf9kyF8L2ZwHlDjsiRKRsz9/WBQkSoFQtL1jGftraa0NxpCO3dwq1?=
 =?us-ascii?Q?nE2h3hPyfZ3nHqBRxmX9Mz80Tp94n1KdXqSkQvdvyeQNPm4H7BUhjLR2rWBn?=
 =?us-ascii?Q?SptGxvukthJoy0qbDb5WppPPjDQ5Rx3FSEeq38jSG37iUUJz51cofNH2TEI+?=
 =?us-ascii?Q?/WKuOXJQAlU4EBst42iw28iiEt9ywMyv3ddScTub20CAxBh9fL/7jYzMdryo?=
 =?us-ascii?Q?mR2SJ3S8Jex26T9h7aj1+OHYQSJ3prnWg9VbnJpZZkb0W8Pqeq1xQ8PoqNSq?=
 =?us-ascii?Q?7uv3axznTLYG4PW104USuYCIqtGqEXeSY1hvHkOYQB8KGXd7exmairqRTCxt?=
 =?us-ascii?Q?7Livc8o95bQu5zuXVaXScutbjR0Kemgh5z9+eF0Gb5nZWcAeITgTzqREmTRw?=
 =?us-ascii?Q?r1jlI1aHbgaHz4iIk1L/tpyRgHfop9nWz38DrC81Bvo8PXJH/niPc48ralcS?=
 =?us-ascii?Q?ha6iitexUVXuc40B7ExR6eFKbdpUz6P++58UdJzKu2e7u3JzeO34UTsKml7v?=
 =?us-ascii?Q?Fb7rNzrHZqM+smRblSE8F0X4zK6QJz6+h7A490uElmFi6HkSZoKVlTv6eIxZ?=
 =?us-ascii?Q?vy8dueCuqL6UKknuIQQcqmW8BhgT4Nefz4u09FqG71P02ry4M3UUno5KuAYw?=
 =?us-ascii?Q?376a9kHj0OJ9wz2EOa2XUX4Tw5iwHT33yC3nc6r57v/shM0QygwTfZluf+pp?=
 =?us-ascii?Q?VYhtkiGsO4gS3nNmUlHb9C7lottsoqR472eirITQxXT0v5H/4XAmjpFD9eYh?=
 =?us-ascii?Q?Zny4YcJFGihOPe9+E3eHGoWOrXPAGI/dk3o9ndc5vWwWeCqrnwzneukMGrov?=
 =?us-ascii?Q?HV/gU2aR3sucFncFqO7nAeqeep9OCBV8DoO/SdvGgNiD6Prxq0tgxOKNOSYW?=
 =?us-ascii?Q?jytFxE4Xqah1qRCvoGBsaqHg2TLp9UOs4JPsIM9JXMpgVfEkXxMsYRPikt0m?=
 =?us-ascii?Q?T/xaDfKavTSNukXkNLXOpz+F6mmJk2aI72Ftv1XNzs5bQU/xwMfXHGWY33Cr?=
 =?us-ascii?Q?Erq0C7/ny1LCVI3g6SN/f7J/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wGUPg2+Z9VFa8XCZvpYU2MBNLxnSsI5lM1OxDcMV3uVy2sgGIU6Ic0/WKXSK?=
 =?us-ascii?Q?6VsI8/vWx3BLw30tqZXSN1RqyiNs8azF6TtcnSvnf4Kjs6a2y20lAS6gmIQf?=
 =?us-ascii?Q?HcitlYVUw2uR2vTq9jj5IeMC3jsCHTbKSaKms/FSvGjZtzD7topcfNGUhBJ1?=
 =?us-ascii?Q?8vZc7eBESOJqd02cSLUkHRhanIuAPWffMdqUq9P1vN49+b4aAUH5eaEV4Ipa?=
 =?us-ascii?Q?HVbPMay67XEQVnACDbwI7oyaZqitDHc5whUcOo26mIf5h9ovZoKqSbQJ506m?=
 =?us-ascii?Q?0ehX0EiWHMDIQyj45x8ZreS4Htkd3kPFOuPmddmuQnlHTnco9Sm4bhJE7DGR?=
 =?us-ascii?Q?nj+wqci/VXyoJWTdL3+Y2N+b5UFMz/yxoihEdlZlzGJbKaFXDb8d6hfDZV6P?=
 =?us-ascii?Q?hgXYcrkLuXh+YzXxjIxEROtItKNsm2AB4WSCEQfZ7u6Qm6Xn/CyiyfcboLNN?=
 =?us-ascii?Q?MIdgG0dM1uJruP/9olVjoasmM7rfpkHtBbDbYHFO0vvQuyg43oKsOSJoZqf5?=
 =?us-ascii?Q?/14BZr8lDl3x+QeeMvqJQjce9LD2P2KfXErBy/mXpA9XC7WJvNLOO6iINBDJ?=
 =?us-ascii?Q?BlZ3r+cW5uzKPYspngilTQbFJXXqL4FNk00VBNA67eQANIWCLGhQfP+5zu+q?=
 =?us-ascii?Q?6X/CbuRMXGBE+Ry1Ei12F9GKN5TV6M+LLBAlGiwrYi6gKyCd8FCUAtzSdhWs?=
 =?us-ascii?Q?WQjJylEE0TuoAnItPKFZTl5vsV1sNYheXiIHb73mnBKRixc5rH3yVfcSv6dM?=
 =?us-ascii?Q?JzFvEj3+oi6ijtIFyEl8ikssYVGo3KblNDL0xh3mednwE2WFR2tinnowofap?=
 =?us-ascii?Q?6EKQFiByP2yxgXmc1+2Ghr8hhjKoU6taYjdLy5zcmZ3xk9dRiol7va0ni+SL?=
 =?us-ascii?Q?TH/2Mulc3gNMa3ynf1evHvnfK8hlCoao/cwehcT43wsXSgNChDN8+j0asMJp?=
 =?us-ascii?Q?6kJCe9GrMov+R3r92QNhB6LQDC+WCv7vtXoWBgwdk0KxYN/bUTLy9v+SSSeo?=
 =?us-ascii?Q?AMGLEXLDeOKZ+4jBW6NKdBh4JTB2RhLim6ulQjo/d/Kfu/yQFkNEB5ekOq8n?=
 =?us-ascii?Q?v82hW1mYS8IPsbejjrYAZCKY/3mx9O2wq/O46lVcDExsbDECE+PKpW5aqNki?=
 =?us-ascii?Q?2RA6Z7vcDXsG+IF72LNPsmM9/jKBXVn32su3KYBSg5KY5xzbQ4IGtQD3fOHm?=
 =?us-ascii?Q?cxqH/ja8/t9Ccbza1O1aZcY54lVju7CzDz/1gREmMXvdY/pmyHRVz6Qzp5Fx?=
 =?us-ascii?Q?ZgpVlmA1KFgNIbeme3ckDYKu3cehDEh20fVsgiZWgWwaLPe5reeEDGYKqmHh?=
 =?us-ascii?Q?bNkQHHfULmW2IWBfhRRUd+PQw95F7cXsPVsWzw2G0I9hnp+0ygRnv2WbuKN6?=
 =?us-ascii?Q?+YdZv75IX46RP1vOD/qHVaL3GF1UvSmaM1P59Et7JFLoI9zXWbi3M39xYlLw?=
 =?us-ascii?Q?38+BawwmPYRbi++1wXnTWbYVjMemBBRd3OQpNpGgNEysSbpFDs86cTdIuEQf?=
 =?us-ascii?Q?lKsjd14x0Y6GUNF6tPZG6PvziTTG1PLl1DXwPS3AU94Dy0FcJBoPC5dS1lNm?=
 =?us-ascii?Q?7BH3Ty776ZOrlUM+oIqZqEwj14hjW6fmjH5CKepHas4r16ZmWPp4s6jJBwsV?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b112d3f-1f14-430b-aae5-08dc86759afc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 22:11:25.0793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Kp+163u78EC2hbxEEdIHM7t5siYRlyv/9vorf3IQ6Gmy6m/VNrViTvTo1rIMhuOsZPDqZ4RbQirIIoqPcmBjuxBgxG/FoY3LcGEm6zLbYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6115
X-OriginatorOrg: intel.com

Leon Romanovsky wrote:
> On Wed, Jun 05, 2024 at 09:56:14PM -0700, Dan Williams wrote:
> > Jason Gunthorpe wrote:
> 
> <...>
> 
> > So my questions to try to understand the specific sticking points more
> > are:
> > 
> > 1/ Can you think of a Command Effect that the device could enumerate to
> > address the specific shenanigan's that netdev is worried about? In other
> > words if every command a device enables has the stated effect of
> > "Configuration Change after Reset" does that cut out a significant
> > portion of the concern? 
> 
> It will prevent SR-IOV devices (or more accurate their VFs)
> to be configured through the fwctl, as they are destroyed in HW
> during reboot.

Right, but between zero configurability and losing live SR-IOV
configurabilitiy is there still value? Note, this is just a thought
experiment on what if any Command Effects Linux can comfortably tolerate
vs those that start to be more spicy and dip into removing stimulus /
focus on the commons, or otherwise injuring collaboration.

