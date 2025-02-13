Return-Path: <linux-rdma+bounces-7730-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF026A34957
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 17:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79C71638FE
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 16:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44403201100;
	Thu, 13 Feb 2025 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/NGFmHh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645CA1FF7B9;
	Thu, 13 Feb 2025 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463226; cv=fail; b=LhFQXLnVNyenex8X0MoHOwQzStTw6JH7/jErNLxQ3iozLcMYKrIm6RGhsn/rydvJqtEJoM1zXOSLOdHEsdlZh55F6E8i+lUuY94FgLv+fxmdSYnKdgoU5CHz3aXGTWVuMxiBk1wRnPfm6dIdNiBefTGEPeii6DbCOdR/R2VcUw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463226; c=relaxed/simple;
	bh=VQhcIjOLtn+MKxBMfN2pYthv8eF3qqrJyFMxPRsl9+Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S8tnhSmEWXNtRSBftES43DhTIB51KWIqkJDqSadpj+Ra8VnA5fYtx9x0bGnaZu2UPQUXY0dQ1WrJyVGucX5zmp4qXTR5nN1U/Bcf2PCaV+uK8cT1nCPvYWEiNVX8FIF246g6yCRSrfX6Ze3M24B7BE8TU1RbgoCmUZu7+NK6uZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/NGFmHh; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739463224; x=1770999224;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VQhcIjOLtn+MKxBMfN2pYthv8eF3qqrJyFMxPRsl9+Y=;
  b=Y/NGFmHhkNRJUL5PIosqR37XYynFJroUygU1FQRgTe2xAzM0hsmDemYH
   Ks/1GoWfPgX8pgAW4hutR2n92MHMwc0Dpy538ZMNzyaPBNgyeZB/lb/TT
   NmX88uK62yl3PqYNhg7S81bmLQbOvuBVTkRJaR/YkSMvbegh/s646HtPq
   l5i27LmzrTb1ksm2mmFZIc2vw/dJGpSTr3Zkc1S0ni3C4bDleC92pIP95
   8R4qJhcRhHDddAU0FpCVvXZqWXul84gJTUvbZvmAHDwzKAYlmFV8lu8YN
   vv0W/J2bbPalhe70g69Np8OirSVH3rBID1ZPQGHMmWu5eBDXT1Wi9o3Om
   Q==;
X-CSE-ConnectionGUID: 5U+dMPfFTvWuLkv9a8ofEA==
X-CSE-MsgGUID: Xt/cxFGUQG25pRUt5ua9ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="39359243"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="39359243"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 08:13:39 -0800
X-CSE-ConnectionGUID: TvGZmZZ/TaWxn7ns/IINkw==
X-CSE-MsgGUID: Ct0lB1PWTXSA0VJa9N2fMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118119423"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 08:13:38 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 08:13:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Feb 2025 08:13:38 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 08:13:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFaxsXH+weedhqpp2myI56KvAG9O+xX9g5NeAHcoRvp1ltkTYjYZG3VFGpwQ+HLts7L2OnxCoK8fcNCXD/pHjYmbTu4lqjgGZgHCUJVF6J2sFKjJQCC1o0yNxjTJpJaZqjvGNVhYtNnk9YWUacPmAuIBzRCeFqSDB4JUqdn1hMSQ4zWxNZe0IV1Kp+VmKtXuf/IRB3/ODns/iu+3FZY4ujc2v41dvaSA1GAbWxkWtDtpBDO4Uvaw3L2roA6DXmZApOOBjaS1MVMYy+D6oYIIhsXp5iGT89ITptul5nvqXxl0u1jFM/rpc5Pfp0tc0TZZlKJJPzGlaSJ4aK05CD6lZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwM5qFHYiqxBPzRbUX1HBo/5AJwVVBVYbxna5P9EXCg=;
 b=HbCcHtHFwO+50FE90uYKMuS5neSshGlIq8PDZNft4xYIkSHaK/HkQMdBEm+o+VYEJBJ0ubY2GuVJ9Bf/swIVgjjMXSaTGF+IgmAS2K5rd64ZCBs7of2gXODI4pN1KjK9EKZ57hfhl8vxUiy5otjV8ol/kL0zgZjWy2b416/EbrjlCnm61H3/M06fKQktIn2JZ0Y7ZzklPDMudW0su9I2JgtNR65cvu19Nh80NCB3SWXebWr49bN+UywZIOlsKIrTDnXKoCT6pGZBJkh1wTixMagC90NexJLSXvI2Bb2//NyiPFWk1MVyYhvzVxAFLe4u+HFzd2ribQdJNtEtIDkUWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB8570.namprd11.prod.outlook.com (2603:10b6:510:2ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 16:12:53 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 16:12:53 +0000
Message-ID: <f253c4b6-e4ee-44a3-953d-44f20ac5e79d@intel.com>
Date: Thu, 13 Feb 2025 17:12:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-next,rdma v3 00/24] Add RDMA support for Intel IPU E2000
 (GEN3)
To: Leon Romanovsky <leon@kernel.org>
CC: Tatyana Nikolova <tatyana.e.nikolova@intel.com>, <jgg@nvidia.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "Eric
 Dumazet" <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
References: <20250207194931.1569-1-tatyana.e.nikolova@intel.com>
 <7e12c97d-8733-44df-b80e-2956c0e59dae@intel.com>
 <20250210110935.GE17863@unreal>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250210110935.GE17863@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0116.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::13) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 693944ed-8595-44d0-181b-08dd4c4944d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2VUa29xUFpxR0VaTEZabFNldEhOcWhiaERBWk9VNEJ2YmgzVXMvZ2F6K3M5?=
 =?utf-8?B?b0I4RWRDV3ZpWXNMWnpvcTRPMXhnOXhxOUVNTFVmMkpMNGw3OEpUajNiSDIv?=
 =?utf-8?B?RmJsNEVJWTVxN1psazJkZ3A0ZzZUdWNrbFNNV1N2ZzNYTi9JbDliUjBXREsx?=
 =?utf-8?B?bkQ1emhtYVN0SkJ6SURpWU94Sk1LeXZmZktNWHlMcmxCRS84TDhvM3NLS0hz?=
 =?utf-8?B?VTBHWEpTZjdnWW9UcExZSmNqbExIMGI2M1hTUjlXN2NkMm1yWElMYzhlby85?=
 =?utf-8?B?UnVZMklqMmdzRFI1b0JuaHVWWEhYb0xDZTRFaS9UYTlWWU9ncDNWVmRETUtU?=
 =?utf-8?B?WEJTbzN5cktCYkNHNEFvVWovekQweXRBQmN5RHJYeTVRM1hsMFY3WFpITTVx?=
 =?utf-8?B?eDhwUmxtZHp5SUNwQjRJNFZWYzNkRjhtVTdmRDRWNzB3emo4dEFqYjd3MFd3?=
 =?utf-8?B?b2NaelhVV1g2UnU1N0VrT2FOR3E2WUdJMWs0dEZ0ZWx5eG1icUxEcDFTYXJ5?=
 =?utf-8?B?cGd6aTN6UWV5OUNEZXJwTk1UY082K2JvSE1ET1QxVCtkNy9tbnJydjNjeEdh?=
 =?utf-8?B?SU1wRDA2aDhocm1uVjQyUUZPenVQUitwekM0bTlYd01qbllES3oyRkhGZUxh?=
 =?utf-8?B?aWswUUpsQnJLUllRcmovQlhzUS9Eam5sbmYvOXZDMFNqVjVUdEpWMGE4TjU1?=
 =?utf-8?B?WlEzRTdKNTNGZHNxODQ5d1h2Y1pmZ0hDazVsUGZQZHIzNU5lSHhFVkVib1Jm?=
 =?utf-8?B?aGUreUJ5bTV5NXh1SDlnWFdOUUtmSnh2Zmx4WWEvY01BcDEyY200VUhWNDlj?=
 =?utf-8?B?dFRwc1o4K2tXN0YzSVIxdzRDK1lhcjE5WWhNelpZbUl5WUtwajB5RmF1dHJk?=
 =?utf-8?B?S0xtbFZoS2lXZ1Bnd3R4NW15TGJySGVNK1dYaUUyZmRVbDQ0em1Vc3o5cVlL?=
 =?utf-8?B?bXlRaklHZ0ZqaWRocElpbmN5ckpqb0U1OG5QZnpWQ2tQMGc2MzBzeVdtVlNW?=
 =?utf-8?B?YWYxNG13NkxDSzY2aGY0QmNvK2JVWlUrUFFXczFWLzZUQ29mWDZiUXIvbXRK?=
 =?utf-8?B?cTBuMzBKTDBZdEtvZUJicW05ZUFlb3pCRjRYM2lacUJpRjFkRmwyNTIyaklB?=
 =?utf-8?B?RmZpVEdFZHdzYnY1NmRaRnBwUlNWV1FnM2pkMWlLcDJCVGhWVTdVQXpzd21M?=
 =?utf-8?B?WXZQV2M5VUlYdEduWkZ5VHc2MFlobmJva0pEbTRXbXZsTVkyMkpLdDg3QnFq?=
 =?utf-8?B?aHJrNzUvOVVhdS9RbVRIaHd5V2MwQ2Vyd1UvbXB5LzA1TnpSdm51dlNaNThq?=
 =?utf-8?B?VTdod1VLc0VYeExKVGI1c3EzWEo4OGF6dm43clVUZ2t3ZVBRUStMR3VzN0tl?=
 =?utf-8?B?aW9CdnUwWHZITXYvODdUUURGVVROTWd2ZDM4L2lNU0trVUQySnBYbjhYREJq?=
 =?utf-8?B?K21EdVhtVzR0MU5ZTHlnYm1yTGRlMkF6YlBpaWlXOER0M2FGajVvUUpPd0Qz?=
 =?utf-8?B?Tm83bEcyWW50SUExYTFjZ3hMdzNnOUIveXcwdHdDKzVES0lWUHo1RkVMbzZH?=
 =?utf-8?B?RlJOWUxYTEg5YzlKVE9yZ0tua2JoRG1aK1NGNXdoTFNMNFFobTE1aDNNRkhD?=
 =?utf-8?B?Rk1lcUg3ZjM2a2NxSm9peXg4bzRHeUhCbm1SRTBlYmlwNS9hRlRSRUd4WkNl?=
 =?utf-8?B?UU84eFp6T0RCVFJVL0F3V1RBMktidUl4NG1VWHlJejhSOVRINlpZYU0wVm42?=
 =?utf-8?B?dlZES0V5T1FGeHpaMWJiYVNoV1UzdDhlWEZaUXhLM3NGZ2JLbXNyOEpLRzRi?=
 =?utf-8?B?d1RXc1RpUGIwd0dpVGQ4QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW1CYzhNdEhtWWZxUldDdVdVUklTTEpGNjdiMExydG5JWHZMMnlXN0M3ZlAw?=
 =?utf-8?B?OG5pTmlBeVh6VS9SVWZjVUdBVDByWDhuUHh0VlQ3eHpuaE1jTElPV01WOHJU?=
 =?utf-8?B?Z2lyVkUxWG1sU3MweEQwb2VjdFkrZEJrMTRzNThXWlg5cjF1Y1B2ejdpVVUy?=
 =?utf-8?B?dlpVWWtPanAyWFFocElNM2Nxd1ZoSHRPWWMrd0g1ajhlUnA2SXVXZG9wRWJK?=
 =?utf-8?B?NG8vYU1zbVJ2SUI3VWVwYkZhQk5nS1FObG1sUFcyNXhJTlBPcEVwd3ZlSnZz?=
 =?utf-8?B?R2tXRkIrczhHZ2pmWHg3L0ZZMDRoNVd5ckEzb3lJQ01jOGdFT3pySm51S0Zi?=
 =?utf-8?B?YlBMdkpUbnhlQXNlUnFyTnZmUnVtOHFRTzI1RGFRejNYRzVKV3RxQmErSE5z?=
 =?utf-8?B?TjRBajBUWFZYVFdNYVJKQkkxVy85R1BqTjMyd0Z4aXpaNXo1NTdselhIUkEz?=
 =?utf-8?B?cXBEYjNjbERJc01jUnQyaWM2SVlvYVY0L2tJYWk3T1ZveUdvbGlheWFMTmRC?=
 =?utf-8?B?QVN3Z2tZMk14bTN6VGpUMExFR3hseHEzMEVlWVVHUkVvbkEzeCtZRHZYZXcv?=
 =?utf-8?B?VjZndUNiVWxqcGdoME52ajRzZ0Q0VXJpZlZ1SUxqNGFJNjRCK1NpZjRSNmhn?=
 =?utf-8?B?QkVjUE16Z3JZVUZITUlmd3kxbnk5RHN0RGJiVXJ0dHdSWTdQVzBHNWhrMjZ2?=
 =?utf-8?B?S3ZacXVYcFIyTU8wblQyR2JzTDRLOFJsTFVCcnIvZStjMVpjMm11cnVHeUZC?=
 =?utf-8?B?R1U3N3hsMTZLbWhVKy90OUdEMEpnL2VDSVBPYXYyd0NhKzdjM3Q5YUtkSmVa?=
 =?utf-8?B?OGRlNHNvTTFlSWd5RGtuNUdnL2dkdDlVaXdMMzBCZVVRUWR0dXlBV2M2bExF?=
 =?utf-8?B?RlV2ajNYRysyMzBzR2pFcVl1bmdNNVFTSGlDWXFHVkdmY3FoSTVCMDlQY3Ju?=
 =?utf-8?B?cUtTNGg3R1FZU1FzWE1oY21tcUNPTEVEdm5OOGprNVdCYVVhZmlrdG1tV0Rl?=
 =?utf-8?B?d1ZJQjZlZzdrMmVwQUZDY1hQVHNlNWlvT2Z5NGQyV25DcWhTRVVWUmhueHA4?=
 =?utf-8?B?dWpmd2VOejVhZHdsQmVGdFg5TEtKcG5GYUYvcTNmUkk2UFdkaDRaaHZjazMv?=
 =?utf-8?B?TUhFUi9RVlZsOTVRa1dZa2pVVHhqRmVISklHem5OTHk0QlNEUGNOdHRTVUNs?=
 =?utf-8?B?MS9uQ0lwK3lRcmZIekZueTRqclNhV1V1ZDlVMXZMU0JzYzdLQzhGMW1MYlQ5?=
 =?utf-8?B?RDhSbWExVWhRRnlYWTlMRFZKMUJmcm52VWJDMmZnWkRmRmxrWFM0a1hldXBl?=
 =?utf-8?B?NXV3SmcrTENhUFBZcUpvK2V5b3FHam5RdmJobHlwbytFcWM1OFZsc05DUUFw?=
 =?utf-8?B?YkhiMHBlWEQxN1VJclJLSUN6UnNCMTBHS0p4MHpvb3hUNmlQTFRUMEFZSEZw?=
 =?utf-8?B?VHZ2WWlEa2xZenVBbmRFMWtLczQxY2s1ZnVxRitidnhSMnowemFUTHRHbjFD?=
 =?utf-8?B?eURkTUp5OEFVM3ZxSkN1WGc3ZWM3UTFVODRHblhvR1pTZlJrMHN5RndZMzFV?=
 =?utf-8?B?cFd4UXBxVjBJOGtBSWdMRWt3ZUdNUDNqdnlWUzJQL0pXTmhodGltZ0NyVkxy?=
 =?utf-8?B?bHJIMDVBSk44SUR3ZDlXTVVxVVYzTGhOajl2SG82TXBMNXhDdDhtTWhNWUN1?=
 =?utf-8?B?OC9ad3ZMTmtTMVZKYU1YaHFDYy9mMDRyYktFYXZIWlp1dUhQbktoNkJpanhk?=
 =?utf-8?B?cHhOdDJiWEE3bEdNWWRFV2tWTmQwbVRhWFAyeitrQ09oWE00MUx6RUZISEUy?=
 =?utf-8?B?dC9CalMralcvTElxaHJjSHFLREdvMEwzTklyNmRTNkNrcG5hdCtHT1FqbGhx?=
 =?utf-8?B?QVFicmlkR0ZHZHRXNnp6OUsweDRMc2dnNUNmakFqNFJkVDhNTWhGa2prY3VW?=
 =?utf-8?B?bk9YWWFMZkZaMkp4Z0JoaVE0eVpFNUM4amVPRitwN3loZ0lrNGlEMkJOR1Fm?=
 =?utf-8?B?QUxld1FhTWt3N2tvTkwvdm5Lem1zTDlscHVyOTk3TXo2Qyt4L1JRQUtEczRp?=
 =?utf-8?B?a2FxZjBJTHd6bGI0MDIvOEc3eFFhc3dDOEhmTGlXanU5UHExcG9XUTJQM2xr?=
 =?utf-8?B?YVJybkpDb3ZyMXBUWHpvMnhrSHplWjNuZmlsS3hRQWZ4alNRUUN0YWtFNW1w?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 693944ed-8595-44d0-181b-08dd4c4944d8
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:12:53.0605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hrub7UHFDDWsHs6nOjaeNdlF6QufDE2JvYGMqpZ83MlKqhQwdMPTA+ya8o5NOMNvbQN2Y6qh4nMxu2W8LF5j44yI5pH7Qv3YecX2gJ2q8Cc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8570
X-OriginatorOrg: intel.com

On 2/10/25 12:09, Leon Romanovsky wrote:
> On Mon, Feb 10, 2025 at 11:41:31AM +0100, Przemek Kitszel wrote:
>> On 2/7/25 20:49, Tatyana Nikolova wrote:
>>> This patch series is based on 6.14-rc1 and includes both netdev and RDMA
>>> patches for ease of review. It can also be viewed here [1]. A shared pull
>>> request will be sent for patches 1-7 following review.
>>>
>>
>> [...]
>> TLDR of my mail: could be take 1st patch prior to the rest?
>>
>>> V2 RFC series is at https://lwn.net/Articles/987141/.
>>
>> code there was mostly the same, and noone commented, I bet due
>> to the sheer size of the series
> 
> It was very optimistic to expect for a review during holiday season
> and merge window, especially series of 25 patches which are marked
> as RFC.

that's true

so, given most of the patches will go via your tree, how do you want
to split us the existing ones into series?

a) 1st, idpf, rdma
b) 1st, rest
c) all together

In any case I will do a review too of course

> 
> Thanks


