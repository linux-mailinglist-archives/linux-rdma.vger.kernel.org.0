Return-Path: <linux-rdma+bounces-2712-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8367C8D545F
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 23:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F2B1C2249A
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 21:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967C0194C6C;
	Thu, 30 May 2024 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1e636Hw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E5B1761B9;
	Thu, 30 May 2024 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103543; cv=fail; b=bFowLJyicdNDR8rYTPZdhtQMBXx1023v0AFskf/Rkvx4TcyqIqbJoHksTNF1gMGC1ZryDT8q8fYPwSjFLVcYINg5fbX/v1+L+KjJZBJI6XSuUKrxssl6wU4QMUNHj7jFrzekjjwUGCqZrP+GIIUlIDbE9gKdl1gm2dhQzaPk0JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103543; c=relaxed/simple;
	bh=ihiyFKznxXe9oo9tmfJUNnqFWrGlApeAUXBlKvJR1wc=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Av4qXpn+KacdqlgJrd3SUtEyPRSkwwr+goqXbcnoO2eKsUDwu8wTZEE/C4HcYFvwq9nmiZYGE2KVhguvQlXr9Y6NqyrUVXS7K6x2569hog877V8wFXgzBETH4XVcCSEXdAjt5h7wmL9dFovasyG4F0nuM64tRupd8Cd9Ijaj24k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O1e636Hw; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717103542; x=1748639542;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ihiyFKznxXe9oo9tmfJUNnqFWrGlApeAUXBlKvJR1wc=;
  b=O1e636HwGkd1heYHcNCmjsggNbYEyMsB0UhbdB9Jtfv5QlhYbyFsx+x5
   18QtTwz7wBSrl7Qj5UM5pAoyAEWC9HI7aIOmOuLmQTvDBBQT+wl3ECrQB
   7Ih/asLfIM/knsQOm+raVkT0QSaUBd1JNpQkuCiAJxpJ1qbHpKF2i1HxP
   /E3sNjM5RrNdIRXx72H3GDSZqIoM4sqspPlwAJYgyeKUkze5bqoyRVyGu
   frEj4A6cn57bSBkwK5uabPmz8eD3dd2lS34HeSHak+gwvjv26Swmmqvj8
   7QXQM+Zz8Q/zoFbt/eil74hbwCbqyDheK3oI6AC5K7bz7F5WSWTTyLkuw
   g==;
X-CSE-ConnectionGUID: p7py26fGSeyO9HHnMwO4TA==
X-CSE-MsgGUID: LJVdLYRoTNC00A3R7s6R0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13792681"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13792681"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 14:12:21 -0700
X-CSE-ConnectionGUID: yakmE6CGTbW9xic/QWL5rw==
X-CSE-MsgGUID: 7Pp+M0e3Qzm4g0AfOG0kLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="66812528"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 14:12:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 14:12:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 14:12:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 14:12:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcezDk5V5dzR/g/iAJSP4D5/8BE1U2UkALPmGyVraA58evcorPC8pV8tfn9ZidKHgvAf9O8BPfVyJTiSiDLqfbqs52Q/hv3DHxPG361JDZHPTm+h28ZYpmWj0H7VKbLMRDFW8T7a5BOaQtB9wCujo498fbFZ45be+o1HswiMQFCmejEkCvxk+WyHvCk9U0j/wGRJbMZZ4U1luvoYnJJ9WZUYI5RKaklG5xHECIX8S8/ocVGKHaRTG3VD3GiesR8SLd5QiWusqD6CnnWHIch51F3yfqtJXoWNosGpyMmeMghmYl377UddHglUsnPZWw7yGYBt5Uw2M3qYWU8YyP9sLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etGB+Io19CI8UFrY87zlLZq7NRZgZUMlkw7h7BkmYtw=;
 b=LVae/CdEQ5VrGqXGjpSPKJrNcXc3MKsuHB/7Wj6lc3a3j9RnSfTk4MillvVCCuLrprOOyG9WLCYBxsjqkNkOnd+INMIFk4xYGfXenJZH3ItMquWkxn9nap9ctiEkyBXvApNSIJtTXMCYycfwtJg/lgGhczrDFJTP5SugARrSjTNlxF6+cimXTk2uo6M+XcZqdK0I4WYI8YhN80jKV0qxo84ecDSlUNQ8kmoz1eCsdDnGRM0K+USjGdxmby+4Cc9fZ8uIeEEqYh9XsqzDwPW/cOk1mjYw/N95XwDUEaSO6bzCN1LLaIQ2a8pfOy+fTNmBATdEAYE+tWE8o7dxthJnmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PR11MB8760.namprd11.prod.outlook.com (2603:10b6:0:4b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 21:12:15 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 21:12:15 +0000
Message-ID: <6cf3a91b-7449-4aec-8995-15088e9e9346@intel.com>
Date: Thu, 30 May 2024 14:12:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/3] net/mlx4: Track RX allocation failures in
 a stat
From: Jacob Keller <jacob.e.keller@intel.com>
To: Joe Damato <jdamato@fastly.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <nalramli@fastly.com>, <mkarsten@uwaterloo.ca>, Tariq Toukan
	<tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "open list:MELLANOX MLX4 core VPI driver"
	<linux-rdma@vger.kernel.org>
References: <20240528181139.515070-1-jdamato@fastly.com>
 <20240528181139.515070-2-jdamato@fastly.com>
 <e1efc17f-e4a9-4952-9ad0-7671b72fd37c@intel.com>
Content-Language: en-US
In-Reply-To: <e1efc17f-e4a9-4952-9ad0-7671b72fd37c@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0366.namprd04.prod.outlook.com
 (2603:10b6:303:81::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PR11MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a6e22f-2260-449f-7e9a-08dc80ed2e30
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXVocXFkNW5Ra1lsME51WlhScUh3dVVrQWZvRUI2cVZ6Wjd3WEgyOEplTzlI?=
 =?utf-8?B?eGJidGsxMXpvSUVIYnEwanUvSUg1VTlYcnhFUWNpUEdIaWplcTJUalZZa1N6?=
 =?utf-8?B?MTZyS3ZacnltVjVEaEU1QXROMVVBK0VHS1Mva0ZBSjBQK0gzUW1CSUYzSS9F?=
 =?utf-8?B?bjlUN2xFQjFlQ2g1SWI0aU9aWEdLU2lnK1haVENUUWx2OXJVb2VPNitsMGYy?=
 =?utf-8?B?RWduZlQ5dEdLNUZWVU55TDRKU2hlUkQ2MlVDNkQ5RktKZC8xdDN3b0dSL0hy?=
 =?utf-8?B?ME5MdE9mMm54WmlnUGNqQUttN0ovTmU2VEtIVnluNXRpN0tMZXNDTTc1R2Qw?=
 =?utf-8?B?QWFZMkV3ZE1RNElmWC9XWXFtWjVRT0VTbFYybWlVSUYxOWVKNm1wVk1YN0FY?=
 =?utf-8?B?K0NhdmlJUTZWbG5oZDFhYUtQRE9IWHhCTlVvRUFCSDAzSDJFYTgrZFNoMjZy?=
 =?utf-8?B?MnliSHJTWnl3NDdIV2w2R1pJVUhic1lzREpTNUUxcUpOMm1DZVZ0Q1YxNkc3?=
 =?utf-8?B?eEVyd2IwSGRBcUE2UFpxVGRaVVVIcVQwQytDZk5DSjdsbGNBc2JNSnVPK0Ur?=
 =?utf-8?B?YmpZcWIxY0toNnVLTWpBNEJWa1dHcmY4c1hPdGJCUFRoMVZ1ZGJaZHVSTVFv?=
 =?utf-8?B?ZTdDUCt3Q0ZpSy9tQ1ozemhkS1czTlQ1ZlpqWENSNk9IQk14UERxMnN6dkhu?=
 =?utf-8?B?ZmtWcFd6WHNnNlFZWDdhVDUwazVPQkdzcEFlWkRIcGZXQ08xTkFPaCt4ZU1k?=
 =?utf-8?B?V3pEWGJxcU1QWFdRTDhUd3RvdHlCOThTbkg1TVY0eCt6OWJWMy96LzhzV2Yx?=
 =?utf-8?B?dDJLMFg0UktsYitXS0pvejlWOUN3ZkRTUnBMTFluMUZCWjdSUi9mL2pneXZS?=
 =?utf-8?B?eENDWWJodW43cEI5T05OLzNEU2NaeU5jTkY2aXg1K1NITm9uTXBrSldySExH?=
 =?utf-8?B?M010NHdDcHJrdlVNME1TRTA1YUl1em5Nc01LeTcyMGRTV1AzUXFKc1JKd0ls?=
 =?utf-8?B?a1VvbWZhVHlKRCtiVzNPTVI2dnBVMkpoR2kyOEJnVUdOTDZaQk9IUTk5Wk9R?=
 =?utf-8?B?cjRQdzlqNW92Rm5xYWNLdXA4cWpKeGZSSGc2dzh6dzJZNHdyaWFTSlBXQVp4?=
 =?utf-8?B?c3lQTVlyUlNtaFpySVZJTTU0QjNrZG5mVUZqWnhtQ3I5RTBWVnhwMUdXUE10?=
 =?utf-8?B?Zlo4elA3TytVNklteEZLM3JUMUlHVm9nTUduaTFyNkFNeWc2UFVtTHlYK0FF?=
 =?utf-8?B?R0tJazdZWWc2TmNJc1Nwak1PVytnUDlZNXIvVnM2dUk3Z0I5c3FTOHVxa2w1?=
 =?utf-8?B?Y3VDbkZtTFhwa1hUeHA2Q3JaWWVIdTRzaWlxWGlmUzhBQ3hkcTNUZUUxWW9y?=
 =?utf-8?B?U0NaUUNXTzV1clUzMzMrU0JveFZmd3VGSm1rREtTTFF3ZTh2d2p6M3J6ZWw4?=
 =?utf-8?B?ZzFTN2ZzL1cyb0ZPSmhaNSsra21lZjM2cHZ4ZzZ6NjlreUlGd1R3M0dDczJF?=
 =?utf-8?B?cUxsOUh5bU5SNFVzZ3BSNXpxQytseUdSU3BJa1VEdDdkQWhrVkxWQTIyYkN4?=
 =?utf-8?B?Si9SMWpGdW5XUVlxci9tNXI0WFlYYjhxalNsZnQrNXovTUpjTU1nS3FLeVV4?=
 =?utf-8?B?cUlyK3Qzb0RlTEM4V1YydDYrL3VrOFVPL2JLODNOYmRZWVp1QUhIeS9oNEl2?=
 =?utf-8?B?RHp6VVJidmI4d3Vqd1ZDeEQ4NEJmbmVHM2lzQ1lYcXF0NGd5RmpjdS9BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enp3SU5Pb1VCMWJiU1NIcEdybExpVWRqVVFpM016aFhSaHVFODR4cjQvNlJa?=
 =?utf-8?B?M1FCWkpzaG5TVVU4QUl2NFBsa0xLeE9aT2g0QWtxZjhUR2ljUXJtalVqTGRU?=
 =?utf-8?B?T1RRYk5CVHg1UDZzZjk0K1pqWXY2SU5zT1hQNEtEOFNvbVc2NjN5LzdyTjk1?=
 =?utf-8?B?NzdmSS9HcHRrMDc1MkhIVnhzVU96S0tqem9jQm5kakNmbWF2b3l0TWtTNUhH?=
 =?utf-8?B?RnN0YXJhRVBmODZ4a3VaL3FkTkdtbXhtL3lrbGJLQ1Z4aUF5MDJJSFdISGJl?=
 =?utf-8?B?ZnFZcjR3YTQ4UWY3SWh4YldyV0tJanpYcTl6cG4vY1hKMklWY25KZnpET256?=
 =?utf-8?B?czE1SHM4NCtzYTh5ZUNrdjVYeG1FZmxqZmlKaUh3WlJ5NWtTbklvWTlhMFh5?=
 =?utf-8?B?ODI4cUdNYnRrdm5xbDZpZ1lteXh0WTZWcnEycVVSSWlIWnk1UXVONUhqbDdQ?=
 =?utf-8?B?VWtGVTJyOWxaQmJXRUxPRURuNU5maG9jTDh3WUZaOWVEbjU4WUlFS3owR2Nu?=
 =?utf-8?B?bGxVTEhNNVhoL01Tb2dlUlh1M0FIY3Nab0FtbHdoelZOYVgrZ2F2dlM1UGhR?=
 =?utf-8?B?WFFwN2pRNGhQbkM5ek0zeW0wU1hpak1vVjJickNFVjY0L1c2cVBsaEk2cUx3?=
 =?utf-8?B?MW9lSnJMeWEwYlltcEZzY0R1M1pkY0pvNHBza3gva1V4Nm5mN21hcG55Vjg0?=
 =?utf-8?B?NURLZGdFc1dXdW8wZmRxWUFhVDdEc1ZEaEliTGxXRUgyZWVkbGYxQXp5TnE5?=
 =?utf-8?B?WVVBL0xZenF5dGVOZDlQU0t0ZzM0Sjhrd0RxT2tGOG43MFFzMC9qRDRNS1R2?=
 =?utf-8?B?WXZvTXNpZktlaWU0SGNXNDVTcUlJSDVOT3p2WFdzc3UvZ3NpN2RGTkQ5cVNB?=
 =?utf-8?B?dFFMUldJSklvNkpkem1hQ3VFeTQycmhJb2gvc2hIV3czWXVLdzVEdGc3RWgw?=
 =?utf-8?B?QW5wMWovSjdNeUh2MitPUCswTVRyRXBmUlB1eUNsMXhtVm1LMy95cWhrUDVj?=
 =?utf-8?B?Mm5hT2E4MnU5anI0KzhvNjZQR3dCWEtTYm5weVB4c2lRWTVzNkVmZGl3OXpq?=
 =?utf-8?B?VUIwL2tSdTArWHZ0Y3JoTlFkLzJ2cGZmdUtGYmw5blFrd0JaUEZ1d3g5SnUz?=
 =?utf-8?B?dFZtSy9LS0NubzZWWUE3YU9Dbnh6dGwwZVR4djI2dnNpSkxUS1AvQ3VVdXd0?=
 =?utf-8?B?NHVlalY4ZlEvV3o3MnlBVEFCZ0VaeHBuZGx6dDhzamJZTUtLU3ZzN3dkNGlZ?=
 =?utf-8?B?cURBeHlaMm12WkNrN25aRGk0eHdHYWdmSElpcVRUbWtXRktkVHNkVGJ2SmpG?=
 =?utf-8?B?aHhkOEhHNlErSHM2TmEvdmt0SEhFRFJVaG9wKytrLy9Vc3RWcVVRSVlQN1Z2?=
 =?utf-8?B?c2h6bXZocGlVRWlINStMSmluKzcvb0dvNW53TWtZMks3K1VmQkoxYWxpNStV?=
 =?utf-8?B?K1Evc3YzRDRXT2hUNjJKOTd6YnU2UFB5Z2JiZTFHUCs5VnA0WE1EdlQzd29Z?=
 =?utf-8?B?Uy8ydjlQTEhtT3NaSmFZUzg2cy9IOGJFUG1Tejc5TnJHL1dJK0pSdS9UcTM2?=
 =?utf-8?B?Tm8wVk40TFNqd0RucVVEZUdta05ZdFRudmp2SzVGc0xRY1ZBd0dBanlXMHVZ?=
 =?utf-8?B?am0xckF1eFAzN3o4em1tWXJmYVZWNWRvTll6M3M4MHZ2aGhva0NNSUlnWUdH?=
 =?utf-8?B?amxiWEtwRTZEcHFTdjNRVk8yeVN2YUo0d3BnUG05bktUU1BZSlBNVDdGMVVW?=
 =?utf-8?B?TnV3WDFZUlhZVUdpUmgxTHNBVmsxWW9kdHBZTDB0aG53Mkg4RUsvc1ErNFpJ?=
 =?utf-8?B?TnZNeFFZb2dOM1FFVnJqdUZ6KzJoOWE2Wk9HWis3ejcrVU5VODhjb3RrQjRm?=
 =?utf-8?B?aU51ZWdJcEV5OVJNTGtKY2ZidTB2KzdXeVpEaERjQkpQYmpEQlR0YTVTKy9Y?=
 =?utf-8?B?bVdPNS82N2pGT3h1VzlEa0FST2dZeEhYV1RXL0lVZEJuV0RzQlcwU1EvbFJI?=
 =?utf-8?B?YkxPS1hVZmFST3JUamJvTWZhQkt0SlhaRFVKZ1hkS014eXoxQWtUTzRnY0lK?=
 =?utf-8?B?WTA3MDRMRmlhcUdzOGQwRk1xcmZzRGtEQ3N3VVEweTYrNmxVWXNGWGpZQUhB?=
 =?utf-8?B?czYvSVRoVGd6dTRIRG1tMEdQRkhOZEZORnN5eDRzSXFGM3pEazV2QnlLaGp4?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a6e22f-2260-449f-7e9a-08dc80ed2e30
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 21:12:15.1063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxeGvnnWLFW+UxRDbB+65jW6h9wfyAt6GAVwGpke5L9/Zg6qRsDAQcIlveEnTDmr4gQGBCGzUy3qMtgmcpRBYNpc0qpjoZ1jKSCnB+A7zCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8760
X-OriginatorOrg: intel.com



On 5/30/2024 2:08 PM, Jacob Keller wrote:
> 
> 
> On 5/28/2024 11:11 AM, Joe Damato wrote:
>> mlx4_en_alloc_frags currently returns -ENOMEM when mlx4_alloc_page
>> fails but does not increment a stat field when this occurs.
>>
>> A new field called alloc_fail has been added to struct mlx4_en_rx_ring
>> which is now incremented in mlx4_en_rx_ring when -ENOMEM occurs.
>>
>> Signed-off-by: Joe Damato <jdamato@fastly.com>
>> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
>> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>  drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 1 +
>>  drivers/net/ethernet/mellanox/mlx4/en_rx.c     | 4 +++-
>>  drivers/net/ethernet/mellanox/mlx4/mlx4_en.h   | 1 +
>>  3 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
>> index 4c089cfa027a..4d2f8c458346 100644
>> --- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
>> +++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
>> @@ -2073,6 +2073,7 @@ static void mlx4_en_clear_stats(struct net_device *dev)
>>  		priv->rx_ring[i]->csum_ok = 0;
>>  		priv->rx_ring[i]->csum_none = 0;
>>  		priv->rx_ring[i]->csum_complete = 0;
>> +		priv->rx_ring[i]->alloc_fail = 0;
>>  	}
>>  }
>>  
>> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
>> index 8328df8645d5..15c57e9517e9 100644
>> --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
>> +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
>> @@ -82,8 +82,10 @@ static int mlx4_en_alloc_frags(struct mlx4_en_priv *priv,
>>  
>>  	for (i = 0; i < priv->num_frags; i++, frags++) {
>>  		if (!frags->page) {
>> -			if (mlx4_alloc_page(priv, frags, gfp))
>> +			if (mlx4_alloc_page(priv, frags, gfp)) {
>> +				ring->alloc_fail++;
>>  				return -ENOMEM;
>> +			}
>>  			ring->rx_alloc_pages++;
>>  		}
>>  		rx_desc->data[i].addr = cpu_to_be64(frags->dma +
>> diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
>> index efe3f97b874f..cd70df22724b 100644
>> --- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
>> +++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
>> @@ -355,6 +355,7 @@ struct mlx4_en_rx_ring {
>>  	unsigned long xdp_tx;
>>  	unsigned long xdp_tx_full;
>>  	unsigned long dropped;
>> +	unsigned long alloc_fail;
>>  	int hwtstamp_rx_filter;
>>  	cpumask_var_t affinity_mask;
>>  	struct xdp_rxq_info xdp_rxq;
> 
> This patch does not appear to extend either a netdev, ethtool, devlink,
> or any other interface to report this new counter.
> 
> How is a user supposed to obtain this information from the driver?

Ah. Its used in the 3rd patch.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

