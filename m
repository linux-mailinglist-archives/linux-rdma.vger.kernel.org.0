Return-Path: <linux-rdma+bounces-4432-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B24609583B6
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2024 12:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49D71C244EB
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2024 10:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9E118CC16;
	Tue, 20 Aug 2024 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMJMCvgy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D70118C937;
	Tue, 20 Aug 2024 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148590; cv=fail; b=CCLDXZutptMN39UvsVioV6q8t6AxU9RmO89riU+ncjj9UNHMrzcO0Y7NirAi18V5mqg0/lfaiWYAgROsreP2KeiyT1Ke2kB9wBNm/uSX9O8k3wWKweVhUPoFa/fgfwjjI574hFBi6HDGuuNxTTupxYq/6VjS1m5ACv+HOFMTGdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148590; c=relaxed/simple;
	bh=gixusVastk5FxJ2NPOwGe+uqPuZhcj80bvir8jZWcGQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tjd0cVwhzTjFfq/esOERQmeQ/caIEsaAGcp5lJ2tXO4z2sC63NOe+1s0oCN+914z/gVl04iklqAhKihwpfuGTE5qxT8mA9zeX+qR3Xw2kVjYEeuJ4KZc3olPbsD5YetaoY+fYCXdv2BLXe4Xt2eeJb74Y7D20wmoeGdvUqCIC6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMJMCvgy; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724148589; x=1755684589;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gixusVastk5FxJ2NPOwGe+uqPuZhcj80bvir8jZWcGQ=;
  b=XMJMCvgy/d9jHIdn1nFerLeN+oiddN7WnTBAix+lbKFlqZFotG7cjmJo
   LPgNer29eTuGSUShZ3nb23//bZua/c9PoiURaSxAcZwuCRjoNrsqsdnPJ
   QQXrlvzC2nU/+e8AD/g8Grlj4zROEJlHCzoIn7NB5QRXyQaLfDX21omeV
   Jl2Uq+IJH9tEh8g488J3YBOT9NIKdjBC6C3Pw2kX9LUiDZRhCTunDOcto
   UyNBOO8+BE9OrNCc+r60hDVdzaz6G5Ht0ZR8iSHRTAkHqDUEwJrY9XVea
   10mEPsQk7YoMvWk83Zp9G2oNz2j3+DA+becHtZuMjp3Dg4FoPiczMMIeq
   g==;
X-CSE-ConnectionGUID: G0xir2KKT4a57wAKr758SA==
X-CSE-MsgGUID: TMgKB/lRTE6VX/YyiLCvpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22567194"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22567194"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:09:48 -0700
X-CSE-ConnectionGUID: w0JmSWWpTOam39ad40mW3A==
X-CSE-MsgGUID: 3cSFfV/CT8iIECxXH9h+rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="65039522"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 03:09:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 03:09:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 03:09:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 03:09:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8OUqYh1wvRtMZPbPh1goB8dOuh2MW+LrgtK7wuseAojaAYPFJp5ed2GkXkFJep1Ejck3imba4Lor55QdaJ1em+uBW4w2mMEMtwEFAQJDqom5YmyU+bGTbFvqP75+i1QZXMj+srCcbphzp2vJclzU6X3hIb6gxs74K8Y9ozRP8Wqm1QC8UjxPNI8i7B8RxLpdq0H5nsMC9mPi2ury+CiZx3LrqPmxxs8SJF38sBK4JvES8CLC62wf92OoVQa2nwHk3mQxVQPegFb/c7fQc9LiXUmk5SFLpjX+bevdV9vsVeEtDVLDNknyUlq4iL2G8QVcwmBFaXwMzHP+RTBNssV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZLVlabUyNENaminP8aDRXeE/YXnBMMhMubSgmBkxw8=;
 b=gB3rYzsiw0FHxt9SVuqVy3JnJlvl9k1zwrpzDzQz8f+TsXKxZV0H4b517Wg8CXQsvq6ZassR2qREiVaH2y1+t38HnZSyZiEMJaarWBp1PR+no0wVNPVLi+OX+Za/RPMOCLTweiProo3lJRJOp+RtRv3bi4oOJ10GVsP6QCRs09K3e0F0ojhJAVzU8p2r4vrqbM6OyBhxGBPbZBnLObMwdUt+IjwOxgT7IEuZlktsqAqK8FypPUuhJ2BrJwLq8HmNDuASe5rZeeapDAEj+RP4pYL4zIxee5+GbIUqd6hR6KoYIsPDNqW0I7HQ5If7nUWmg9ppH7e6pGZ5wX8to3Nv5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA2PR11MB5178.namprd11.prod.outlook.com (2603:10b6:806:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 10:09:44 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 10:09:44 +0000
Message-ID: <ea1c88ea-7583-4cfe-b0ef-a224806c96b1@intel.com>
Date: Tue, 20 Aug 2024 12:09:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Added cond_resched() to crdump collection
To: Mohamed Khalfella <mkhalfella@purestorage.com>
CC: Yuanyuan Zhong <yzhong@purestorage.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Shay Drori <shayd@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240819214259.38259-1-mkhalfella@purestorage.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240819214259.38259-1-mkhalfella@purestorage.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::6) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA2PR11MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb59931-1dd0-4ee9-9131-08dcc10036df
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2RCVUNZb2RQMTFmRkZHSndDcFVSaHJpZ2FTbmhYVGdjaXd3TVkvcEl2bFBv?=
 =?utf-8?B?YWNobDJOOVdFb2xVNlJFWms1eUJkbXg5d2RaTG9UY3dwVXlUQjNHQldNR0Fm?=
 =?utf-8?B?Mk5xZVJaMm5ZbWtuMDFGbEdxbkt0Ti91ZzBHcDJtNEgreW8rN2o3R2dFbE81?=
 =?utf-8?B?R3J5RFRGa3Vqbi9QL1YxUjNqeW5DTENyKyt6ZDZ6Rjh0SzFwNE82OWJPK0VX?=
 =?utf-8?B?aFNsT09CTFZrSjhDM3Y1NmZCcjBiN2g1NWRhd1RNZ3BSR2xJdG11Zng4WlRw?=
 =?utf-8?B?aFhsa09RbzVTS2I2bGFsM1F0NHJ6RVpUSGV5MUJ0ZlVhWVY3MVlRZURSTEJi?=
 =?utf-8?B?am5kN09tSCsvZWg5d3JzZGUzWlJNeHVWR0VDMmU5WEZFZzE5VXVzTGZsdUlp?=
 =?utf-8?B?cS80aW1tSEpRNmhjNEpBTTFpOGJkQmFVemlod2xRSTBHMVg2NFRPeFJTekJu?=
 =?utf-8?B?R01yRkh0WGVkRTJ1YWFVazR1NXV6WUcrMkhtMWVQbEY3MjhYeHhpdnBPZ2ZX?=
 =?utf-8?B?cnRqQ3ZnSHFSTVJDOXcydXlsczh1RnFkMzNZei96T2xCaTRVaUxrNElEYTR2?=
 =?utf-8?B?S2REOGY2UFNVOWF4VWY3cW9mSEpCOEQwczF0Tmh2OVExeDNoSHZZM2lxbnl1?=
 =?utf-8?B?eDA3aksrVmdZN2Q2aVRKQlpSSS9zb1ZWVmNEeWh0L25DbGxyNlRYL3ZVWEFs?=
 =?utf-8?B?QVhGUlUwNi9oM2pLTTRTRFJnNndKdHl3NHh2WEFBNnRhSUNtbm9rOWlhTUht?=
 =?utf-8?B?NmNEai8xc0ZPWHEraFpTbG85MFcya2V6RXFUL2lUeHU2RnV2c3dkanc1ekly?=
 =?utf-8?B?WXZSbWtqN2Z0SmozanJ5VE9BN3VpZjF2ZThhQVVrT2NvdmxIZkRwSDVvOXYr?=
 =?utf-8?B?QlppVTJqQjc0aGR6RzgrMFA0cUpjaUEvaGs2UGdNY1RFYThUZnV1c1BNbzV1?=
 =?utf-8?B?WWR4MTBoTDJUTnVvTTY0LytVVmtKbTkwQlVoZkx0L05ZSG16Z3BVc3B4MWxx?=
 =?utf-8?B?OHhMVXkwMjNkZXA4VCtLaHl2N0lQZnRQSjI2UGdUUCtUTkVBcXR6M21jbTE3?=
 =?utf-8?B?WWhwamJUUi9PbXB2d1JVVW1RaVpMRVlzSlhzSHRkTUNTTHJjTURHMWxzb04y?=
 =?utf-8?B?bVJoVnlKdnNqMnhDR0MrY080cWV3R0xuQ3EzYlZpREkrbGxrWVdEWkRKeWMy?=
 =?utf-8?B?cGJ0cnNZc2g0MW5SdGtmWWxrbmlwb1RjcVB0cEdvaXVEVEdldmZ2ZEl6UzlR?=
 =?utf-8?B?RVp6S2JrQWxvSGo5WmI0YWh5dnAyOVh2ZlJhL2dLU1JxS2FkU3p4RVByMTF5?=
 =?utf-8?B?dE1UREsveHkrRnFLR3lva2NmMDlWdno3OHVKOHlBWWlBZ2lhNkxnak5QVld3?=
 =?utf-8?B?OUFnOFQvcmZySTRUaE9xeGQ2WndReUx1M1NFMUp4RjQrRVhtY3kvT0k5MDJM?=
 =?utf-8?B?WXd2R21tZlNQckRKZ2IwU0FpdG1pNjZpTlljWXdYS0QwbElYdGVtNCs4RHhZ?=
 =?utf-8?B?d3Zta3VaL3c4L3ZWMFBKdEF4bGRvNk0xNzNQU1FBMWJXRUlpSktxYWk0b0JC?=
 =?utf-8?B?enFmNVdtaDhUYkZnWmUxWVY3REF6cXZZbmxNV1h5d3BLTUhrNGFXeFphVnE4?=
 =?utf-8?B?RnNsWnFCOWpVRFRGaC9wMTFvajlGNmdsUk1PN3VhcFhnaFl3azVSS1RBbUN2?=
 =?utf-8?B?VG1FdThaS2l4NlFmaVNnYzQ0R1RrbHNLTFVNZzVxRVJ0RTVoMTVzMStPZStH?=
 =?utf-8?B?U0JnYzlPTWUrZUJYWS9QbUNjOWxRVEZXVmVTS1FhOUlBYTJkUUdOdy82UzRu?=
 =?utf-8?B?K3paekVDQlJuWThOcWQxQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3BVeXAxY0doQUxPSGZZQVpmREk5V1RUTDBGOXhKWXgyWVNJVHJHb2lRS29u?=
 =?utf-8?B?K3dCaTJRTHFpMzAxcWRTN2ZtdGlyakVXbm5KMU8wL1g2THJkYU1qcDVhVU5B?=
 =?utf-8?B?TlBmQ0JyVUp1NTNqbTFMQlhBL21zeDJQOTRobWZnZXFRbUNkYVNTWTRxOFlE?=
 =?utf-8?B?TXBnaDZVUFplNEdzaTZUMFFVd1BKZXE4WTdZR0tLUDVkTW1QQ2taY1dVa2g4?=
 =?utf-8?B?eEpBVk9nbmpTeWllQTZ0ZXJkNDZsNysxYTErbGpnMjdzdmRubjJ2alkxcTFD?=
 =?utf-8?B?R0hWdHViM0dpSk5DNmsxQlpySmg1ZU9uaWhaSGllS3ovTHBaNjNEQnV6ZzhR?=
 =?utf-8?B?cVdsc1g3eHZYUDI0R2liMTRIOUxoVko1UndQOWdETzBCamZDQ1ZhL0pQbDVa?=
 =?utf-8?B?azUzVDJoWTVxd0JWUXJ1c3JzbkRvVDJFWmV5bVBMR01FTmU5dGNDdE5BNnNq?=
 =?utf-8?B?MjJ5d0xHeml4QmFLRDlwazVEd3EwZ0d0dEo3L3dpcDUwc3pEV1pzeGVCMy9S?=
 =?utf-8?B?bFJNN1RWcUt2VVRqd3B5c0ZjQXhHWHliR0lrZyt0SnRUUHZpUnMrVzI5R3BQ?=
 =?utf-8?B?V0toNU5NT2FYekJYa1MyK3FNZm5qc2JpSllMY0ppblMzQnRzZ3JNM2c0V0o3?=
 =?utf-8?B?VHpCSEZLR3NhSlJmNUFuWFNaaE9OY1I4c0hwcXJBcDQyekVUdWtHbDVnaUZI?=
 =?utf-8?B?NDRBbjBGSVBsd2l1NjJRVHVEbDNhNXNlQ1JRY2ZzWXMxRS9YSG5ZYThNSmF3?=
 =?utf-8?B?QldweW9QN2NwV2lReCt0Tmppdi9CVVRyMlRQSjFNd1NOenpRNko5NW83NEZC?=
 =?utf-8?B?VEhIMnR1VCs5VVBxekZjREYvckxrT2J0aUdibmdxazhyYzVTZVJlN29kZUdR?=
 =?utf-8?B?VU1WM25KRVhRNXlxb3ZTMm05TTVvREt2NDM3RXBPcFhJWE5hQ1ZlbnMwQXZK?=
 =?utf-8?B?ZDQ1cnlvMm1PRTY3eENaM1E5Zk04Tmx1SDd2bUgzRDdYeE0rSTF3elAzVDdL?=
 =?utf-8?B?dHZvZ1NhZWFWVE9VSFcrT2d5YkRqK1pLcHhCTVczK0kvMmR4WjRwVDIwWTMz?=
 =?utf-8?B?TExMNUNGV3JKb014NitZV0RRL1ZjK3poSHJkZ0cvMW9xWHJHU0JzUE1lbTJo?=
 =?utf-8?B?QXVtd29nMWRRK2dJdnpzdDMwTWxtZEdUczc1MiszMkNPT2dQLzAxeVU3QytL?=
 =?utf-8?B?bEdVV0RBUFlWMitVM05qRXZ0SXN3VW1HSEJ6MmtIVytEUlBKamdGYndxMFh3?=
 =?utf-8?B?UVhWM1djTDZRdG1uODNqQTlEL3JoRmhucTR6M2pySHNYTCtBVWFMTHd4MnE1?=
 =?utf-8?B?ZVVCQlV4ak0reU5HMDVqeUJKNUZpRkYxN3FSNFB5OXFRVkRzSmU0eWNNTTQw?=
 =?utf-8?B?N21FM2dxVU9mT0tsV3gweVhSZDZ1NHh2TTJkb1ljSktJS1pCSmYydW9vWUZK?=
 =?utf-8?B?L3RlT2ZCWC8vMzV4MndteHJGQVlPZDJyVjJTQmRMUjhZSWMwcm5kdnp2R0h2?=
 =?utf-8?B?bXp2bTMxRHRqRkR6SFQ4czRDNUx1enhMT2w3L2Nibkc3ZkVFZkZxeXlMNEhV?=
 =?utf-8?B?YnFOVC80dEZLSG5GRGZSeHQwNGkvN0MrTE1aMkE5dVU1N29qaXpHcnZDeXY0?=
 =?utf-8?B?V0UwWCtjN3h4bHptTmhjWHhka3ZqRERVc2ozUVNpbnMybWx3VDRQaXBQc1ha?=
 =?utf-8?B?N2hOMDlTNDQwYVdLa2RQa2Njb1NWMFpEUUdlUzZwVDJxMCs5UTh0eWdmRjJH?=
 =?utf-8?B?bWJPSExOVWRmRExYL3p2YWtxeWJTSnhEazUrTEVlRTZwRmpaYmpkclFhbk84?=
 =?utf-8?B?TjQ5QVZyWVVtRndLRGJNQ0d3Yi82ZW51VEl4THdvcGtoWVpVMXBrdUt0ZE5P?=
 =?utf-8?B?NjNYaDRxbTFxVC9ERDNld2pFdnhObTlERlZzOFZIS21aWHFXaittR1FJeTBK?=
 =?utf-8?B?dzRmZnZBUVRhWUp5aTFCbjcrUkswSWc4SkhRZGc3cExkVzNNZ2NXbEwwbWxa?=
 =?utf-8?B?M3cyUHc3Q1NLc2xGM2VIUDFYbFRHdjd0cUZTZXloVXNQcWdVRG5KQ1BDdmlO?=
 =?utf-8?B?dEhpMzY2Ymoyc1RhR0ttMUtZSjN2UE13THVWYklhZm9PeDczSWdPSTFNV2NB?=
 =?utf-8?B?c0tXV3pzQnpTbTM2a0N1c29OWk10WVU2SnFRZ1BRanB3Q3AxeG9HSGptUXh3?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb59931-1dd0-4ee9-9131-08dcc10036df
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 10:09:44.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoqTo4jfw3SkQVLXgiYYtnnA0KyscRLZ6FHDJZGDJ0TzfCgL0Huu2VuqJ4EhutdD2DXLyshqUn1UyfyD6BYbi/7QYzBrxyZ0JjXHQYcDuB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5178
X-OriginatorOrg: intel.com

On 8/19/24 23:42, Mohamed Khalfella wrote:
> Collecting crdump involves dumping vsc registers from pci config space
> of mlx device. The code can run for long time starving other threads
> want to run on the cpu. Added conditional reschedule between register
> reads and while waiting for register value to release the cpu more
> often.
> 
> Reviewed-by: Yuanyuan Zhong <yzhong@purestorage.com>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> index d0b595ba6110..377cc39643b4 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> @@ -191,6 +191,7 @@ static int mlx5_vsc_wait_on_flag(struct mlx5_core_dev *dev, u8 expected_val)
>   		if ((retries & 0xf) == 0)
>   			usleep_range(1000, 2000);
>   
> +		cond_resched();

the sleeping logic above (including what is out of git diff context) is
a bit weird (tight loop with a sleep after each 16 attempts, with an
upper bound of 2k attempts!)

My understanding of usleep_range() is that it puts process to sleep
(and even leads to sched() call).
So cond_resched() looks redundant here.

>   	} while (flag != expected_val);
>   
>   	return 0;
> @@ -280,6 +281,7 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
>   			return read_addr;
>   
>   		read_addr = next_read_addr;
> +		cond_resched();

Would be great to see how many registers there are/how long it takes to
dump them in commit message.
My guess is that a single mlx5_vsc_gw_read_fast() call is very short and
there are many. With that cond_resched() should be rather under some
if (iterator % XXX == 0) condition.

>   	}
>   	return length;
>   }


