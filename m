Return-Path: <linux-rdma+bounces-4497-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547DB95C409
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 06:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F022856E0
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 04:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F683BBC2;
	Fri, 23 Aug 2024 04:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYqFsYFs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408E63B29D;
	Fri, 23 Aug 2024 04:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724386111; cv=fail; b=u57rU4BimH0FKOF696tKFKyaL6iTabCqHwsrkduY2HtywwZE0i7r5/7xY1NMjoA7O+Rg/wP78V37Y66Xn+YPBOwfZsxZedP+tzxCoTRkYoQfRj0ReWACSJUXjsvKQD2V4+jXl/2Wh3DLENScLy/24hZUCjZLN1cg04WD3FFxSUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724386111; c=relaxed/simple;
	bh=Gc95EHGjTJnXY4PsVVe/jwE9vni+HR0Sh6h0ZLu53Pw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aumF9FtZaf7nMS1u0HurUrT5Sy/eSCQwgEDOIKdf3F4/erUyNRN60YS3zGhdEyB2M2N7o1V2Sn81GEZRZEwYvJtu3W8FzXz4RvsH87V25Xuu5zA+lTWN+1RkuhUDz8Qlav3Ume91ESYcgEXCOXxZBVIS91UwVn6Zx/ATG6jD74I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYqFsYFs; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724386110; x=1755922110;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gc95EHGjTJnXY4PsVVe/jwE9vni+HR0Sh6h0ZLu53Pw=;
  b=aYqFsYFsFDCMs1mgpQOniltnAKM62UMmKaBxCFgEAS0x6CLiTcrE5Fv2
   spFuauNH4umXAtSE4Fp72zP3skbkRvQLbcWiFJIOqlzqzF0bZw8GSjoXN
   HHFlSV42lPxakuaj1AKCAl26zigFTUcupcHId3y2X1G0+8QLc68ZV/otx
   ebCakyzX4ti4N8arPYxErWVDJSFlTeuL1mVW+j2yZiAyK2InodrX4TWfa
   wfOqt0cW9P94FTnKwNmqSW2wHAD/VUDUeUEUxjix+WysiF91u+5B5mdSq
   4F0SdaxKWZvf5ov2fBBMSw8i9bUbZgubelcSPIg7kDaP836/ra773boGJ
   w==;
X-CSE-ConnectionGUID: GSI1lQIDTN+/LMMNwls6zQ==
X-CSE-MsgGUID: P09jlXoZQ1GQNH7e+O5H+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="34255820"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="34255820"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 21:08:29 -0700
X-CSE-ConnectionGUID: vVAln4tgTtOSfLlXj1gosw==
X-CSE-MsgGUID: CUtT+O0hQdKPWMB2UTdGWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="61377509"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 21:08:29 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 21:08:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 21:08:29 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 21:08:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekDdDtd0I7cEIS94I1djdB2fQT5BP1Dzj+fi7nCxqvX3ixKzkADLyXjcGrmKfjXOpJZ54hNWl9BBa0LWkoE1Q5OdYtvxlQ/3J2SMRJklTuqzkdVSh4T7jFflltgtRPZPu2tZaROt8aISWM5hsKzMmJy32VQ8OszXvawR0dkAm+CuEz6+pbAg0M2wEG0LmW4VeX+7q59K2UWF8tMywSbGByKiQnyskJKwIczzgFPTovtz/3r1R9FQOpVpw22eOSgojV7b4u0Twcg3IJbx6kMJvC4GUlRo4k1cYskr01MiehH7HNllfrrkVVTFZjv1VXtxYZnS8qSPsT1MGK45044FqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/pWB6eq44oiaJDGIDFMAS2WBJIPywxwD2t4F5DtnGo=;
 b=V97Ru8vfEbC33MqQ8LbzfNWh+GF6G8pxMxUb9PuKAL6gnv4zDqLST61mVyjPF3Qi/9d/jwVgdfxHF/v/wBDzXj9DfY4iFA3QbPSW6ipeezzWaD2qI2EYCPbot9OrEbbXV8P9QbX/nS3GZJD7RPIJjJU3X57GVmsJvZqADTUbTcY7n34aI/Euu8UebXSnePAjxUWFwE7mbLywl56Z5kun8z9PIAFVJQsBQC916R+ET764DUIlFqPD66oV34UJAEgm/D5dEJ7gJEZ7ERWhAQoAZKp5k+YGIxOSM3cOzRtZhtYE4ioOfFqO60obR4iDg4QHwdUe744DFSAku2DCs+eKBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by IA0PR11MB7379.namprd11.prod.outlook.com (2603:10b6:208:431::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 23 Aug
 2024 04:08:26 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3%7]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 04:08:26 +0000
Message-ID: <1d9d555f-33b7-4d95-8fbd-87709386583c@intel.com>
Date: Fri, 23 Aug 2024 06:08:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Added cond_resched() to crdump collection
To: Mohamed Khalfella <mkhalfella@purestorage.com>, Moshe Shemesh
	<moshe@nvidia.com>
CC: Yuanyuan Zhong <yzhong@purestorage.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Shay Drori <shayd@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240819214259.38259-1-mkhalfella@purestorage.com>
 <ea1c88ea-7583-4cfe-b0ef-a224806c96b1@intel.com>
 <ZsUYRRaKLmM5S5K9@apollo.purestorage.com>
 <ea86913b-8fbd-4134-9ee1-c8754aac0218@nvidia.com>
 <Zsdwe0lAl9xldLHK@apollo.purestorage.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <Zsdwe0lAl9xldLHK@apollo.purestorage.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::10) To CH0PR11MB8086.namprd11.prod.outlook.com
 (2603:10b6:610:190::8)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|IA0PR11MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: 450a756c-ebf6-4465-e40e-08dcc3293cd6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3laK1J1TENSdkNTK0RMZGsrSHlEVjJVbUVJbHFQZmliMFZJNUdFZU4wUXN6?=
 =?utf-8?B?WC9ZR2IzYS9QWTBPbURsOENSeDdNUkZid0ptaFh4NHM0RDBSdEtXL3hQRldw?=
 =?utf-8?B?QllQWHpLZUpySHBsQnQ3OE02elM2UVNyZm9NYlRTKzgra04zVExBK2NqUm5j?=
 =?utf-8?B?Q1BDTkEzVjQyNTFUTlIvTlhZYTJRNlRGRTlhYkdsUmpnNHFLMFV3cGV2bUty?=
 =?utf-8?B?MndpZ0h2UGJLYkRUSFIzUjh4NjZONEpTZlMxU3dDZDJIR3lSSUQ1WTZzVmlh?=
 =?utf-8?B?ZldSQjhadkUvNTVMblFxYyswaG5VMzBSN1N3dzV4dVk3T0RWWlQ2UjBVazRX?=
 =?utf-8?B?VHhjeFh1Nm5GR0ZGUXVEVDBWM293NU9QVVpWVG1rNDd4aVFRZ0tBUDgrdDZE?=
 =?utf-8?B?V015OHZnV0NLV1RjN0hNdHd4SlRwMmVpVFQ1ZCtTOEJFcTdZT1NPbk9FUFd6?=
 =?utf-8?B?MUUyL0ZnakxTdDlubmRCY1kxenlzWTBNaHA1MDB2WTZYWndMZjdTaGd0aFJ3?=
 =?utf-8?B?RFA2Z0NhTGhvanluVjJJT09JcmpPbStGSjRGNTgyTFNDMGx3U0pIR3dpZjJK?=
 =?utf-8?B?eHU3VUtvUU5BRlovcVVWVEFPUDlWRG5XY254OExqSi8wUFVyOUdNOXZmemY1?=
 =?utf-8?B?UjdiUmlxc1hOdXMrZ2tPdXpnSWR2Njlrbm42T29JMldMeXRnbDllbHR1OGRp?=
 =?utf-8?B?Mmg3TGFUdVNCcHlubWppUnFMRzJwTFQ2YVRxenNlVmVnWDRDTUtSdUlGcHNH?=
 =?utf-8?B?NVlYQzE1UzdPdHFUenVEWll4TnFZcFZucnduL2ZCK0svMzNlL3MwNFpkU1B5?=
 =?utf-8?B?R21MblpobUxzdXdzUk5QQTNaVkFYL1MvWlJmNnBueCtKa3NqSWhJeG54dHl0?=
 =?utf-8?B?cWxWeVl5bzk3Z2g2V2crenVsY3JuemZoRHYyRDNYUmtReC9ibHJha0oxUkxn?=
 =?utf-8?B?Ym9CaGh6eUo3d3JuMGJLUE1MSDloYmxxMkhRY05xVURpSE1lbHR6WCthbmht?=
 =?utf-8?B?ZXorQmxPa1RXdHQwQnFCZjRMVzIzQjJZdnB4bm9ZZmg3UFJGdVdxcGp4c0dt?=
 =?utf-8?B?QTFFN2p6QmRoMmJhc1d2cTM1REsvblVuZmhhaWxPa3p1VXN3cStEUUtBYUh3?=
 =?utf-8?B?QXdialJSOWxYbVYwNk1zbVNzQmVYRzBSclA2OXkwMDRsM01CS2pZL3Q2TndV?=
 =?utf-8?B?R0MrSTV5Rmg1Zk1yWTJRWVFQZDFzRm85YUp0ZzBhcmZhbEc0dTNjeFUvOW9Y?=
 =?utf-8?B?Zk1ZbUJYOHRHN3JlU1pldU1Jbi9sRnVkdWUrREJjY3ZSMlJDL0dVRUdLMmMz?=
 =?utf-8?B?am5iMldab2VnSHN4MDI1U2h3eThudExWNCtPY3dhUTJFQUliZnFXNi8xenQ3?=
 =?utf-8?B?SGllS3Z2M09VVjZxa2FnK1ltbkpmWFcxUXVXK2w4QlNvZE5Rd3ZzRmlveTNy?=
 =?utf-8?B?bWplMWRnMlV4OEpTUVJHZDRvR1I5SGpyaDBySkR0Q1pmT2JPL05XK1V2MTM0?=
 =?utf-8?B?WWROSU5jVXZpRmVSTGRLayt3T2pxK3cvZk5wNytWN2REc1VxYzFiYnQ3VVJY?=
 =?utf-8?B?WFpmWVBLY3VQWjVzKzk1QjNoWEQ2MC9LS3Z6VFpvN1pyQ2JlRGR3YktNblRj?=
 =?utf-8?B?L0VHZ0lyVEVIaDMzVC96Qy9jMkYweWhzWkhKMVZNS2JNcXFVTE1TQXFPR0x0?=
 =?utf-8?B?bDBRWU5EcFR3blRqbEdtOHhDNFZUR04wdlRqQ0k2akVmTXJuWDVTYmVZV0c3?=
 =?utf-8?B?OTBVcE9EMVhMMzB0YlhBbXJKM0VPRGFXRUdUdGlqTG9FbWg2eW9kU21Ga1FP?=
 =?utf-8?B?SWpVZWxncGhrc1hwb3cwUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlBxY1diOU41K2w2QW5nbHpDeDFlOTN2ZDlxUXhsY0tvU05jQWVJSm52NnFP?=
 =?utf-8?B?WjgybVViYXJoN2UzZUJHa3JXZUFqUjlod2Fub3hnRWV1M3RFZFVrU0cxelVB?=
 =?utf-8?B?d3A3OWd5eWV3RFFIcFJVeVFLNVVmYmx3V2QrOFVJTmV6WjB3bWgxVGh3MmUv?=
 =?utf-8?B?Z2xBUEJ0SWxERG9WWGs3ZmF0YUsxMlJzWEhGd0ZEckFvWFhRZjE3cnM1THF3?=
 =?utf-8?B?QnkwOGtySDhSTnNvMk02b0RMa21Hc3JpU1FaQ1Qzd051RlRyU3l1VGV1MGZ5?=
 =?utf-8?B?U09DUXNLTWdTbkZTSEk2V0JBNVRKU0RGYU9nem00VTRaSTFpY2hNWnRtNVlp?=
 =?utf-8?B?clIwWnlCc1loNDNLWGt2cy9QeVpwWFRUcWxpaE1PWFkxWWh2cFFHNXFFNHU2?=
 =?utf-8?B?RGxja3NZaGRJV0xlWmxQOUk1YTlGOThlWkhIdnlLR2RzZ2daR3pnT29xZHNT?=
 =?utf-8?B?TG00b3ZmcXlBc1duY1kwQ1ZnWWU3VjN5bEwyODJTdFRwUVcvQ2w5aEJGbWdB?=
 =?utf-8?B?TFlnYUMrSkJScjRBbTltMmI5Q2IwRktKUnNZZnZHMlp5aEI3SjhZMkV4Y0FU?=
 =?utf-8?B?MndvUXJWWDUrWGRFdlA1MTZoWGUrd0YvQUd4TEFPa2twbGpmb2pZNXJ4b3c5?=
 =?utf-8?B?cEluQVJ5Wm1FbVFzUnN0Y0ppSzVPeTg1blJwZERpQkk0QkxPWHFPbk5PWDJW?=
 =?utf-8?B?RXhCekwrUkJxdG50S1NCWHFKeUJrRHM1TXVrazB6VkJhTUFvMVdGSUVaNEM3?=
 =?utf-8?B?Q3pMK0hITE1OaURkbmI2anh3WnUxYkF3RHpOY3U0eEorUTBOUG1DTldXeUlT?=
 =?utf-8?B?SExGL0tlRVhCbzVFa1ovdklxOTkxWWJVTXBGaGtsQmN5RFVXNmlBVUxKTElP?=
 =?utf-8?B?bE5UcjdsY0NTb0UwQXpZWEw0Nm5pdFZlZWRubzV2em96QllaT2RhbGhYSjhL?=
 =?utf-8?B?b28yd3hKbmZtRzBDUmlqc05UeHFLRS90TjlkM1Y1RzY5REFoY2JraU5OTlBn?=
 =?utf-8?B?dlhkbnJWalVjYzBYcThOZ21pejgxWEFZRFQyRHkrenRuYWlsK0E1RnNBSEN3?=
 =?utf-8?B?bFcyVGZaNE1ZMU56OW0rVkNqM3puQlBYeTk1dXVpWE9VMjJmOVBEQzlOVjE5?=
 =?utf-8?B?Rk1jQUxLRjlISGVHY3piRVVIOVNDWllQdURpd3pxRlNoVWxWOHZIM20rWkh0?=
 =?utf-8?B?R0NXbWdtNFZ4aXppZUFqYnlIeEh5NTJTeHFYR1Q1Q0I1VisyemhaQzQwUWRZ?=
 =?utf-8?B?YkZNVU4rWk5EZm5ic2tLNWNUNzUrRGJ3cVNhanE3QmhZeXJub3J6N1RMRFF0?=
 =?utf-8?B?Y0lOQkZwQTJmLzk0NVRQUFBqakNaeDNoYUFYRTVxOUljMzB0ZVo4RGpLYVM5?=
 =?utf-8?B?WHkxSWtObTh1NEE5NktoZjFtMzFJMllsU0dxUTJ3dTBCd090aXFpbHhFd3ZT?=
 =?utf-8?B?Rk9OVzlzS2UwSUc4VFBqWWVKb0xtTUFzV0tyM016UnN3WGdqU0hpdnJ5ZnhC?=
 =?utf-8?B?MEZMQzQ1SDMvWXhmaXYveFgvVTBheURwOUlLRGlwV2hSV1V5V3JUUWdONGlS?=
 =?utf-8?B?UENXNUZSTW53eVdSSkVpQUlXV0ErQk8xdW5DclNRTW5kbTd3cEcxMEt2MUdC?=
 =?utf-8?B?QXZPMERTRnF6U2R5OHhIenc3eGdzc3IrV1A0ZWtzMUI5UXhoK0Qzb0lBNEJI?=
 =?utf-8?B?N0RrRzlEOVprNVhHdE04bGdyd0pGaEZybjFrb0xvZzROVU1va2txVnVKZjk2?=
 =?utf-8?B?V1RWUG4xNWw0UWN3OXJ0NmM1d1V4Y016Y2RJYXBYNmxHWjdPc0QyeTBTRzh2?=
 =?utf-8?B?Z0o0QlJjZDRCMnhSdFpMcldJQ2RVVnI4b3ZzSnErMGlXbHdwMkcrL3lJbjVQ?=
 =?utf-8?B?VDdYczc3d1cyc25MaVZ6QllzajZLYnorVVZzeEZhbk1kSDk1TXNZbzZxZnh6?=
 =?utf-8?B?d1h4aUxKVmFpeS91N2FRNnVhdjBHZVBYU0RzMS9mYml0U05hazdZR1U0Umxj?=
 =?utf-8?B?ZnBuckFPZzFZTFpoZ0gxdGpmOUdCZTZSVTZWY1NvcTF2c2QyUWQwaVdoRzZu?=
 =?utf-8?B?YW1ZL1FWbnNYUUl6am1OaC9BUVRWTnlSRnFubE12clkwdDN0Q0d0WE9RK0Ft?=
 =?utf-8?B?MG0zQ29oeFFsVHRXNHhCQW1OdWhreXQxZ1BRTnFSN3QzdXBMYm1ma0ZpKzg2?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 450a756c-ebf6-4465-e40e-08dcc3293cd6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 04:08:26.2455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9p2g8eTn1cU7JqPhy1FLaxKT2czRTvVUv0YBpqbGEBTXojUjpsp0qi9l+Vu1K3Ew0ZBbhX3O38xP9jB4To0b3/qCm2wPvF6xP9yUmjVL3MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7379
X-OriginatorOrg: intel.com

On 8/22/24 19:08, Mohamed Khalfella wrote:
> On 2024-08-22 09:40:21 +0300, Moshe Shemesh wrote:
>>
>>
>> On 8/21/2024 1:27 AM, Mohamed Khalfella wrote:
>>>
>>> On 2024-08-20 12:09:37 +0200, Przemek Kitszel wrote:
>>>> On 8/19/24 23:42, Mohamed Khalfella wrote:


>>>
>>> Putting a cond_resched() every 16 register reads, similar to
>>> mlx5_vsc_wait_on_flag(), should be okay. With the numbers above, this
>>> will result in cond_resched() every ~0.56ms, which is okay IMO.
>>
>> Sorry for the late response, I just got back from vacation.
>> All your measures looks right.
>> crdump is the devlink health dump of mlx5 FW fatal health reporter.
>> In the common case since auto-dump and auto-recover are default for this
>> health reporter, the crdump will be collected on fatal error of the mlx5
>> device and the recovery flow waits for it and run right after crdump
>> finished.
>> I agree with adding cond_resched(), but I would reduce the frequency,
>> like once in 1024 iterations of register read.
>> mlx5_vsc_wait_on_flag() is a bit different case as the usleep there is
>> after 16 retries waiting for the value to change.
>> Thanks.
> 
> Thanks for taking a look. Once in every 1024 iterations approximately
> translates to 35284.4ns * 1024 ~= 36.1ms, which is relatively long time
> IMO. How about any power-of-two <= 128 (~4.51ms)?

Such tune-up would matter for interactive use of the machine with very
little cores, is that the case? Otherwise I see no point [to make it
overall a little slower, as that is the tradeoff].

