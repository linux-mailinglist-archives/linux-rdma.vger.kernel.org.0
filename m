Return-Path: <linux-rdma+bounces-9115-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70ABA78CCE
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 13:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 385967A5859
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 11:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D01236420;
	Wed,  2 Apr 2025 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNARwDYg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A391E0E0C;
	Wed,  2 Apr 2025 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743591716; cv=fail; b=VZaw7XnlOkvbggpwFCLgRWagHeZS502qZW/oUEXE2kIx4ElxUJOZ4Yf53Tcg1LUu+pitqOIxlHqHmsAZI25KoJnKj7q8dO6cvpmoIoJvKdjYY2xJgAa2RcvBV43jcJK7bOQKBqi9R0HetPKHR3YMSvZ3x59stkSLpWPtDPxABcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743591716; c=relaxed/simple;
	bh=91X8FWhdnYNntPWWr/nq0KiAoOFdbPXz7IbGCygsV8k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i20SBkbNYhgnMzPu8NcoGGeBTys56UAGhR9wPgEgRTmPFUDqm8lZOq0+VPu2S0NSlzB6vwLe0dq7zpx5PGMLfACBDkfMD5GF9CvVS9QHDy4ggBxCVn/RKqw7ikmo8qH/dSPj5iEPi/UaWrQI/77ljDPze12J447rTd6D50CLQ1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNARwDYg; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743591715; x=1775127715;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=91X8FWhdnYNntPWWr/nq0KiAoOFdbPXz7IbGCygsV8k=;
  b=NNARwDYguyjkxYK+WpfJ1Peapzxwdzqx4EnI9bBypQuMb843mtNU9SD3
   xL01LXEQgJ1zsoEmtZktqN1rqTv29mS7m+udnwviHqYHy/Athx/ugMq/a
   x9TFAB1seUzSscBvu2EDHYRAY2+rNjVICjQqb/oOEtl24WHbF4EZwnHm3
   mAYUtIwTbKBqNWVBn77kphyFSIY6zrGPAEgzyFfSS5WrJU6jGtIfq6iPH
   21DXAf69v45xcB2LkarZNbGSDsKb0Ozgz74I599SHAnTXQU7DAVuzGTya
   zOt7BjBsdW2ayilkTyOEItn+nhcdARxiZZ0mSFfEgjoYDMjwVMguNYQ1O
   Q==;
X-CSE-ConnectionGUID: g3xaeBPXSdGZfXgw+ExVlw==
X-CSE-MsgGUID: kL+cJucUTbSxTC8Ol4DF/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="55941750"
X-IronPort-AV: E=Sophos;i="6.14,182,1736841600"; 
   d="scan'208";a="55941750"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 04:01:54 -0700
X-CSE-ConnectionGUID: RXwOImIcRJKL+u5bLS3TJw==
X-CSE-MsgGUID: gjMcNrLYQKeKmqNJmN3yMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,182,1736841600"; 
   d="scan'208";a="127153202"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 04:01:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 2 Apr 2025 04:01:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 04:01:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 04:01:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/hAZYJxL7bq4+fcoKNc1iYM2kwLjJXV10rrgQRgxUgyU/oBRt6GEHP+it7Ap05auzLYrw3eL6NTn2MGxRl1PklH38kqRBgPpWVgI+peXWarxY0UrmKRjjmJTsPTuLGt8wrvsNqa44P0fky0UMmnJ7Nu+DyaieWuzxYI73BzrDmPPOHCyVRvzBafGAaXW8/wHRCg6ZGzgwJZ8aL+FhDNImEiBjOFZg/JPYn7NQtzOPo79yGvmrPxRHnZn6KeS4Pz/3Kz2W3f90ZA2x4DOxOfDeK490YrBAe7hAumg8Z+nVjiZzSSM/o3noMBxSILm9WirqvLCXwGssScMnP0L/p01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5aXKiaQ/BDVaik0pOS6wkENAXQQEgV+DAAWc4ALPv4=;
 b=pmW5p/T9pUwSWOJYoCQmf93P7DRhHRnFrkizhSjSLUjD+KuPRL6/fxkG7bphWJGLUbeDy1HZBFvnwRBw7rJ4Hgp5Nahv8aD4hd4Q1BOLTap1nJObjwRXSGrXHgXXdHAMKNHmV/GEOMRsRBHDcV+VKskEjwjTlwMB5O85xcWd6z0ko0z+RkKDYnogiNGfmG6XIftxqXI91OwtVA/OCzxVQrXAepIdJdOPl/baUvJBWHadxEfFqypyrgeA7Ky1d4SqSqBFs+RxPNbMz+8vkN3F5uz6cCH1KioDDiPlpqZx2j2+XtgqONPcsiQfX5DWrNzICS247TYJTS8qpgQpQT3iOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB8703.namprd11.prod.outlook.com (2603:10b6:610:1cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.48; Wed, 2 Apr
 2025 11:01:50 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 11:01:50 +0000
Message-ID: <c5fa5565-72fd-4333-bd8c-4437571d709d@intel.com>
Date: Wed, 2 Apr 2025 13:01:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix potential null dereference when enable
 shared FDB
To: Charles Han <hanchunchao@inspur.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<tariqt@nvidia.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<markzhang@nvidia.com>, <mbloch@nvidia.com>
References: <20250402094342.3559-1-hanchunchao@inspur.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250402094342.3559-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::25) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: 96759bb5-f471-427f-eaec-08dd71d5c4c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGVpNXZnTTBvcTN4ZzRhTmgyZGtDU1NHaHhHUUhaOXJEa09ReGxVbnNYb09S?=
 =?utf-8?B?MU9zUFI4UlYySm9TZkRJREdwWVcxUHFjR2pySUxtM0FWQmZnYTVuZnk0dDBT?=
 =?utf-8?B?MmtYUVRiQzNEaTArVkhoOFhaakpad1FVRWhpWHhaZVFYNEF1NFQrNXNEeW9U?=
 =?utf-8?B?Qlg3NzBMQWdaT2l2ZmNRUXUzMFAvTFVBVmZ6YmR2YURMUjkrTzB4ajlGekNv?=
 =?utf-8?B?VStDQ1A0Njh1eldtMFdNK1RHVTFkSysxRE1CdCtsa09zOGtwcXVkK05SemVS?=
 =?utf-8?B?ZzFnamdYRlMzMzJPMVU3TmUyUXFRS2ZhQ3BrYzB3Vk1YVW15R2JoZ1FoWmpx?=
 =?utf-8?B?YndEa2IxeFJBdWorWmt0MlFDTUN1emZwZzY0YSt1Tnlsa1BUZytnc3hqVkZ3?=
 =?utf-8?B?cjJSVFJCcVoraGROWWhRc0JDb3RxamREL1dVenNKUm1PMGtkYTJLQ3lWUm5U?=
 =?utf-8?B?aE1xSTZxUmpqRWxqeEFLYnhyUDdaL3N1R3NzWW1qbFJqcEFtUWJIay9IVzAr?=
 =?utf-8?B?SXBjOCtoTi9Na21jb2dkSkd1M3pRbzhhTk95OFdpdko1SWtsZW5mR09rMFgy?=
 =?utf-8?B?NmYzYktyMnc2bTlRY3RjNGJGNUMzUDV5ZXlBbnlpekswbXZ5Tlpua2xPbFpW?=
 =?utf-8?B?VVB1WXJRb1M1QzQ2ZlYxSCtLRXFqakFnZTk3RjQ1UTl5OXdpQnVLbER2bXYv?=
 =?utf-8?B?NTZTaFNVY0poc2pndU01cnJPeDFnUjJuSnNPWGhwb01EM3pBSXRneFdlMkxD?=
 =?utf-8?B?MEJPNTYrYTJ3aUFKWDdXTi92WUkreVJYVHB2MWM5OEp4dU8zVG1MTnAvZ205?=
 =?utf-8?B?a1I4bjJhaDM1V09nUlhxQjlFUUQwV3F6OHYvOCszMTZwalE4SWZWQy96RlNk?=
 =?utf-8?B?ajJ4TUxvcGpkVlFkMi9paXQ5eHZSRFpJRm9QbzdmcGw0SFNEUzRjcUZLdmcw?=
 =?utf-8?B?bWpac3NGZU5iZzJ2bmEvZE9jOGFxQmlOWHhxN2FiL1lOdzZjZFRjNktSbzJs?=
 =?utf-8?B?YVF1YUljYW1jd3FmQk5SZHFDMC9DRUJrWVFMbzJvdnFJREtPcXp1MFNDRHpK?=
 =?utf-8?B?M3l1cEVuZ1hXZHFTdHB4OC9TSU1SNE80dytsUEhqRStMWjQ4VlNuTW5GTnpZ?=
 =?utf-8?B?dkpRUmoydjdSeDl0SWxUSjIvNy95WXNhNW8yNkZzc2dvc0RBWURmaytnS25E?=
 =?utf-8?B?ZXFtNC9VY1RaS1ExNENIWHI2L0g3QlRiUUY0RVZZbW9lUUVTQXJkSkVlNVRs?=
 =?utf-8?B?U2hhenA3dkJOVXBiSE9adHpoZWlNN1hCRjd5LzBuazV0U2t6Y3kxd1ZtOUsv?=
 =?utf-8?B?eEMybjBHZUxmVkYzdFE5QVZqNXBvZEdzUWdvMzQyVzFTcC93eWwwMjBoOVBO?=
 =?utf-8?B?RXYrL0txMGN1Z2JkUFMxblJHMWMxVkh2Nm9RKzltS2ZKL0R0c3FmeFp5UXJO?=
 =?utf-8?B?Nmd1L2J2R2cwMGE2anIvSWhlNHpTaHJmQjNlRXpGdTJjTk9TN3Y2OFdlaUh0?=
 =?utf-8?B?eXcvRGRnMlpkQytSMytDQnB6K1RtRFYrVnlEb2VtZkc5S01BMmJIdTU1cTBt?=
 =?utf-8?B?TzNGWGZZNThib1lrOEhKb0VRM1ErQjNOb2JPVVovN3FyU1NFR1BqaXNWKzZh?=
 =?utf-8?B?NWhvRkQ5VGJPa0g0b3N1R0l2WklrRVhoeUNybXpLNEMxRWhFdHFJRUdpdkZ4?=
 =?utf-8?B?YXk4NGUwRVZHamFtOXhlME9JcVhkMHBBRTIxNEpidWdZNFZlaWxZZU1ObXg4?=
 =?utf-8?B?bHlOMjYzWHYxQXdid3dncVJidm94eDZRN3BTc25RUTN2bkFDQVpUZzdybjR0?=
 =?utf-8?B?OTVQZ2dlRUNnRWphOE53UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmlFck9IN2pHK1NGQWZSalZYQjVKSHlpOGJvTFVTMFlPWVJwM2Via3hwN3h5?=
 =?utf-8?B?bkVxNFlIQkdBM2dSbk5obDRaTUxNY2Z4SmJPdGNDV1IramU3UG1wU2NRUm8r?=
 =?utf-8?B?RVlOQVhoWVhxbVpxaXNtYkx6bTZ2RDFSaGRBVWxYLzBEaDZ1QlhENFBHUkRY?=
 =?utf-8?B?L2hrM0tDMFpNZEN6UERWVTBZbkN0V0U1UHBPNkhaMVQ3b0g5dEppWFo1TkZT?=
 =?utf-8?B?WldXeVVYdTBnc2dQRk5EeWs1YXNSMjN6TjNwMUF0S3dQdW1WcnAzYTFsT25u?=
 =?utf-8?B?bmhTeC8wY3BmWUIyVGJDWFd5QktaQmhmclQ2MklvZ1RZeFVwSDJqME9Mc0h4?=
 =?utf-8?B?WVVDckhoaEVlVDNaRzA1aHBsdWJxUkNnRVc0U3IzOWg4alBUSmZZODdJM0Vn?=
 =?utf-8?B?S2VZK2VTazl3cndIc0RwdzVzNlU2RVR0aUlhUHJZZEZVL1FPM1dkb3Z0MXMx?=
 =?utf-8?B?dktWSlhXNWdPNHBWREhkTTNyMjlIYXgxMGMxQlJxSGZ0U1FJZ250WUFkMTRO?=
 =?utf-8?B?L2I3RTBwdmQyMEhIemlTeTdRMDZVU2tBRDA4ak9nbmRvY0dJa1plK1ZiNEtC?=
 =?utf-8?B?eTZaUTU4TkMwalljTFhNMm00dzFNRlRHeVlrSHdTMVZVY09HQjd2d1gxUVMy?=
 =?utf-8?B?ZEZvamRPTWhTZ1N3ZGhEZU5Xd0J6UUg3NW9VK1VnUFJnemlQN1IvbDlXZ1lC?=
 =?utf-8?B?dDNoN1JWRU5oUE8yV1l3Z2EvMTJqa0xDUzNIeUVNZzFyZDAwMm9QckluQTRq?=
 =?utf-8?B?UU8zYkFlL1k1MFFEamhLdW1UTzYxdWpnWTVlMHBBTWg1SUY0dkx6ZlR3STBO?=
 =?utf-8?B?ZS9NYnBYYUZkdHNtSUZzZU5FK2RNTWJEK3hDRDVSVXQ2VU1qRVI1VW1TYjU0?=
 =?utf-8?B?QTlMWVJCVTdjcWVCYVF2K0d6M280c1RHTlNNY2U0WmptQTI5aXBHYU9JRFh3?=
 =?utf-8?B?T0xVTlF2N3ZBRDJYYjcrRmpPbWMrNkp3R3ZBZ0wwaUs2RVpLRWM0TlRaQ0lJ?=
 =?utf-8?B?TVVmQWM3TkFVbUlXRDYzbjhIZTR1ZVFMUFVoaWZYclUzRFVEUjFxZURJZWtP?=
 =?utf-8?B?aFBZWmlVbS9FbWowdGRrNjJuUmRMdytHKzg5Z2lTODdwSGlqQ0ZPV2lqTmNO?=
 =?utf-8?B?RkNSSFJPMHYrQWlldTR3aTRBZ08vRXl4S0p3NWp5dFNFdTFRSFVjblZ3alhC?=
 =?utf-8?B?aEVKdVdMblRkUUxYT1NhQ1dNZmw2TTBBalYzeHNiQ0lOWGN4Zk1WT3BjUWNm?=
 =?utf-8?B?T2k0QmlwSVBDQkVaWGlIdHJrQkJZRTlPWjYwazN1RXJWd2dQV3hJTi8zK0F5?=
 =?utf-8?B?S0o0QTYzU1RXcUlTT2pLcWZtMjhoT202bnl6M0ZZcHh5bWlIRkFucCswZm1B?=
 =?utf-8?B?YUdOUE0vVlB2M0xLUFA1djJsbU1mSTRVL1lwZS9ZMzM5VEtMOWdJMms4bVc2?=
 =?utf-8?B?eVNRZ0xhL0VPelExc2dJKzZCeTEwUzJCT1cyWnRiZm9PRlZvUEVzSUF2L2pW?=
 =?utf-8?B?RGxZOE90YXliNVNSODFVSzdZSHdxOVRJTGxZajJseDNsZDFVcW5kSDZ5N21O?=
 =?utf-8?B?NkxsTmJCMXArZmZlaXgxNzlWaW4yWTEyS0xYdkZSdDE1U1N1WTdmWlZzM240?=
 =?utf-8?B?T2wvWW54Uit2VXN5NzVEMW9PZFdoaUc1NU5FN3JYSVY4TjhQTTlmVjQrUTNL?=
 =?utf-8?B?bnJ6cStpa0RJTlZDbmtxU3l1S0tRVm1BR1R2aEZRQ3Y0MWFjZURncWVtbG5C?=
 =?utf-8?B?NFQwcDBiNGlUMmNLQ2hLbDYxZnY2ZCtHMTRXanlObWxIQll3RU8xdHlqWVNH?=
 =?utf-8?B?VXJFTnJPMEV4L1VDdVJFbVlFc29JdHY5MWhyOFFpbnpscVk0TGxicS9oSVFJ?=
 =?utf-8?B?TUdaYVhhd2JUQWU4WFpIN1ZjdXJaVDRzbHpiaFdOa21PNTRSZUJJTlJLdkQx?=
 =?utf-8?B?RnNSZTkweVJkTXhEN2xWTDcrSUNyRmNNZjdxRUdQNXdnTmhKekxqb045czE4?=
 =?utf-8?B?NFBrL3ZGU3Izc0RyUm14ZWdZKzBUaFhpenRteldyOVpIbVNRQVdrRzN1aWNF?=
 =?utf-8?B?RDljaU0yQWd3ZFFOUSsrdEhzRVlmWHk5b1MzSFlPYWg2SFVaRTdhZEVUU0FU?=
 =?utf-8?B?TjFSWEw2K0ZSZzFzQ2Z0WDVGTG1mZWQ3WCt3WS85MHE0amFUd3hVa0l5SnlL?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96759bb5-f471-427f-eaec-08dd71d5c4c9
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 11:01:50.0967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfOhxDbo5v4rXJhZYuOvEI/J4ccuIwP6t7yKOSai8n2VsVI9ElsPp+No3hZe+6tmlWxA7pcrRTrD/7o56lkdw9mgr4otCfnna6FU/0WpquA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8703
X-OriginatorOrg: intel.com

On 4/2/25 11:43, Charles Han wrote:
> mlx5_get_flow_namespace() may return a NULL pointer, dereferencing it
> without NULL check may lead to NULL dereference.
> Add a NULL check for ns.
> 
> Fixes: db202995f503 ("net/mlx5: E-Switch, add logic to enable shared FDB")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 10 ++++++++++
>   drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c       |  5 +++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> index a6a8eea5980c..dc58e4c2d786 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> @@ -2667,6 +2667,11 @@ static int esw_set_slave_root_fdb(struct mlx5_core_dev *master,
>   	if (master) {
>   		ns = mlx5_get_flow_namespace(master,
>   					     MLX5_FLOW_NAMESPACE_FDB);
> +		if (!ns) {
> +			mlx5_core_warn(master, "Failed to get flow namespace\n");
> +			return -EOPNOTSUPP;

I would return -ENXIO in such cases, you were searching and not found
that.

IOW it is obvious that dereferencing a null ptr is not supported.

If you agree, please apply the same comment for your other patch:
https://lore.kernel.org/netdev/20250402093221.3253-1-hanchunchao@inspur.com/T/#u

> +		}
> +
>   		root = find_root(&ns->node);
>   		mutex_lock(&root->chain_lock);
>   		MLX5_SET(set_flow_table_root_in, in,
> @@ -2679,6 +2684,11 @@ static int esw_set_slave_root_fdb(struct mlx5_core_dev *master,
>   	} else {
>   		ns = mlx5_get_flow_namespace(slave,
>   					     MLX5_FLOW_NAMESPACE_FDB);
> +		if (!ns) {
> +			mlx5_core_warn(slave, "Failed to get flow namespace\n");
> +			return -EOPNOTSUPP;
> +		}
> +
>   		root = find_root(&ns->node);
>   		mutex_lock(&root->chain_lock);
>   		MLX5_SET(set_flow_table_root_in, in, table_id,
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
> index a47c29571f64..18e59f6a0f2d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
> @@ -186,6 +186,11 @@ static int mlx5_cmd_set_slave_root_fdb(struct mlx5_core_dev *master,
>   	} else {
>   		ns = mlx5_get_flow_namespace(slave,
>   					     MLX5_FLOW_NAMESPACE_FDB);
> +		if (!ns) {
> +			mlx5_core_warn(slave, "Failed to get flow namespace\n");
> +			return -EOPNOTSUPP;
> +		}
> +
>   		root = find_root(&ns->node);
>   		MLX5_SET(set_flow_table_root_in, in, table_id,
>   			 root->root_ft->id);


