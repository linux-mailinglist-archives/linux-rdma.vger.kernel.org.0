Return-Path: <linux-rdma+bounces-6184-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 131039E17AE
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 10:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8C8162C30
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 09:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6551DF738;
	Tue,  3 Dec 2024 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S5OTNioU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3231DE4FD;
	Tue,  3 Dec 2024 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218356; cv=fail; b=XN9mTBIO7ltCPvRmjXda9dUfMqF9FwpjMULaTJu8odAFaz1kNaoG6Qsd7Sjl8eO5JxTpMhGED06+3oMoSpOAXpfR+KMICS79UhqtVquAskAUQA+tyPbR+XHaw/XouBwj1mebhrI+h3+uF+Ba7t117I2OR7QcAyk0E/ooTDwQymc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218356; c=relaxed/simple;
	bh=4fsyVtCYtGSJvDLMrXYS28SU+xnL+fqXQr12Q4HSxRE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nVT7GcVTI9LAiUpCNrcQKMEsjNrL3S/1VpveX6puPL6huLBO+fNws73P3gUK2lot4JQeypx2uVRSHEytghH3oXGDijwjGTrc6wt17uRPSkvRoj4p4PtMZoUp1ST6MowFxEAmnM3r+FAhAgm7XSx4i5ODtospsriZixAXgN5uxMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S5OTNioU; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733218355; x=1764754355;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4fsyVtCYtGSJvDLMrXYS28SU+xnL+fqXQr12Q4HSxRE=;
  b=S5OTNioUKvAsN96Mr3YI83Lxbq1Cdj/b+RpH/4gFyBAUw2Uzpw2BzbeY
   p5YHADg+O7PC9otXOHKRLS9bYJlR3zDz2rL0/s2zmerZmTIJWzk6NJTyn
   grB2ylixofFB9tMx7A8zbxv/3C3bk0s8y/MOjN8CJOR8qy5FeLwwKx+Y+
   2VtvhHkowdm3x3OCneAFokEhcBp6g4Lfqvc/1syu7X0gvPOsuQ5CxUxI9
   9qNMEvUGEmVjgf2B6munj3ktunxqsuT0sjrhlfbea4dkSnoQ+pzIQoZE+
   omKCvBzdT6baZB/CziHppgB8c+9TLpyTVI5A7v7vpyViYn//vPyyXNapc
   w==;
X-CSE-ConnectionGUID: l8aC9Z8+SSq+SlcaPhwsow==
X-CSE-MsgGUID: +oN9RrorQmuk11NSVqJfpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="36276316"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="36276316"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 01:32:34 -0800
X-CSE-ConnectionGUID: 7WyuHO0RQoKo9JmBuIzqNA==
X-CSE-MsgGUID: v13s9mRNRI6wVBC0kIwWlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="97819477"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 01:32:33 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 01:32:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 01:32:33 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 01:32:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yj9zbIfXbjaJ48GNJXmX028uYMslckboSPzR0tm2EAunCkCpbSvyZLPHeLSWVOnEORbPyW89LpxOXUqFdUlCa9/YdHg68dj40Zq7yqRV1Yd6Uo+49JQhStIV34LdsLrJo2LD3Sy0oqRi83WiZenisGM+ET4Pt3ZtFQMmDZdboc6/76j38lafowc+88vvREB/pNvufc7dcNj5gKZ95+aQ7xgkew8e4e+TjcWNQgUXK0iT9WYj7U09i0frZViXXElJf4Yi8eEg8MB18uYIvvNeo3SEYXJcq9lKOvrS7gcBhkiCzLnUNNzGSjI/MK5Tr4NJwdtOWImPHepnIiCoct7udA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wV9YzKoMk8az40gKN/Grs/NH2BFlm+I7NkXIn+IjC8k=;
 b=hVb1S/flk2QTsHW9G8Uhtr6iHmbNCy+n8Whumv5ccwHRl9nmUDuVRHt2x4hQafyLp1km5vBypNOl8mGmWJEOgt+DFoKHHnW9fGoHNI+dTVdI5eEs5ahcmKvUGFpSU0fDX5zkSJDGplpEkRlruaGZCyoBuRRMJ47T0lG3rplfBrtrpz417XaUpDydntx8/pCMz+2JxLDP0MI89bL27Vkcb7/L7+hFHIbF8cgc8ZqZ8u2coITFD1EP34CwB224DUtRZGBSYq8INYwqmQ3j6Ts5/1LCNDDGGMiInpY/tRIT52Qh/cCkQiLzgcFmitZXWvVqDWVYzwvm2+ojDTAJctm+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by SA2PR11MB5148.namprd11.prod.outlook.com (2603:10b6:806:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 09:32:20 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 09:32:19 +0000
Message-ID: <ad93dd90-671b-4c0e-8a96-9dab239a5d07@intel.com>
Date: Tue, 3 Dec 2024 10:32:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: DR, prevent potential error pointer
 dereference
To: Dan Carpenter <dan.carpenter@linaro.org>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Muhammad Sammar
	<muhammads@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
References: <aadb7736-c497-43db-a93a-4461d1426de4@stanley.mountain>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <aadb7736-c497-43db-a93a-4461d1426de4@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::10) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|SA2PR11MB5148:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5d5c21-8793-44e1-aebc-08dd137d6222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjlYaWFMdHRic04rcHpHME9FZTJpOTFGdXZsQkUrTTVCeFlvSmg0cDNzRDdE?=
 =?utf-8?B?d0hLNzNqSnkwTkp3TzBvbUJpcU5HRUhTbFdOQ0E3VjFnU0xybklVckxuckEz?=
 =?utf-8?B?cCsxTFNQOHlieUtwQmFjUjNBbUpPcjJyenZxcXUvd0IrVVExYUNnWm8zVjZo?=
 =?utf-8?B?TkljbmtQc1VGVFgrUmRjQzVvZ2hlN0tDV2FremVRUDlhT25ZL2hRWTZQYWhj?=
 =?utf-8?B?QzdHUTNST1VWdzhxVTNzTjc1c2JJd29xZTkzVitIVnBVWUdaZXVFOXRqYmFJ?=
 =?utf-8?B?WjZPdHpyQzRaWkpLSm81SFdvL1VkRU8wb2N0SG8wTGt4M25CYUlvRlV0T1pF?=
 =?utf-8?B?blZqWitBSEVvQWlxTkRRYmV3aVZDU0gyYUxUREJQcWxQbDZFNmxRdVBEakcz?=
 =?utf-8?B?SldZWUkrUDdmaW9uekZISzNMdDFhcjBuZ1A2amNlNzZOSmpvU3JyUEdTTVgw?=
 =?utf-8?B?NHd5clhTK3g3UEc5TVRkODRIM1kwU3RsZDRqWXByd3F4cFppc2dkdi82UDNZ?=
 =?utf-8?B?QzlSMUQwdUMyN1J0dGt3emtXNEx5ekVBZ3YvNUdIakRsbFV2aUdrcGdIME5F?=
 =?utf-8?B?blhJM05uVkRpNjJrbEE4ME9nYUNNT21XbE5xeDQydmN0bmQ0d3ZyNW42WWpT?=
 =?utf-8?B?UUhUMUdYeTZobVBiYklMakFwUXpWdDl4WmErRVNaY000dGE5VlZpLytjcjEw?=
 =?utf-8?B?Sis0SWlueGlBaU1JdXNLUysvaVlCZkJXTi9PZVc0QVhYVnVUdUxNZVRsUUhl?=
 =?utf-8?B?cXd1TjZ0dWViMk45aGhNWVVjNS95aW1TRU9oOTExY0RhY3Fhc3A5Q21WTUZP?=
 =?utf-8?B?czJZOXBhZkZMMU9LTGNwazl5RHZPdTkwRDVjUGJod2owaEFrSzJYT2VSQW1T?=
 =?utf-8?B?TFNUdU9uc1RNMTVNakFjSDJIUWZDd1hLTENNNzJadGFMRUhENnBpeEsrd1Zl?=
 =?utf-8?B?K2ZCV3FTMm14dnFLbWlqNDdMZEEzdmFLZnlERDdVYVpremhHbmw1TVZMb0Rz?=
 =?utf-8?B?d2lCaXZ3bzBTcE81UGI4R3FXZVlVWlNaNnhhbnZ6QnVBUFNjZkJXSXBNUHEy?=
 =?utf-8?B?UGFhajFMcFNDVElOVzdsWHBoKzEzN1JxdjlyR21qK0hSMGZwUDROQ0xIMEpi?=
 =?utf-8?B?SERsWDQ3UElQODhYVVJWZjNnWXd0S2hvM1EvMnlFZXlXdDh6eGxhc1l3Ukc1?=
 =?utf-8?B?bjdlYjZwUklrZDRQcmEzT0M1eFBHYk05TWRBRitpVDk2ZjVCL0FJKzJnNlk4?=
 =?utf-8?B?aC92dUlQR3prQnhJMTZmeHhCRHdteW9WQnB6OUd2Nkx0UnpqTEtmS2RJNG9W?=
 =?utf-8?B?RFgwS2loOXdxWFoxZ1lYNm9LYUFMUGowWWg3T3gwWlFvcDJYZTNQQnluNkln?=
 =?utf-8?B?dVhTeUhERVFIZ29IRzF0SnY4TGI5RG5TSWY4bC9zOTZWdFd1ZGhjMWVZYmli?=
 =?utf-8?B?U0FhTVlyVktmenJpZGlnS0hwcytoeDlEVlRqcmREU2MrcFM1Mzd6aGp0aTNa?=
 =?utf-8?B?ODhaa3VnaFNwbHRrNGhpTEs5RkdmZjlZYlZUYTVtQUhuRnI0SlpyT0loT3Z5?=
 =?utf-8?B?SWF2ZHdMbTVUQ0xFQjBlMC9DQWxBN3h4bUhvcnBQOGNTT2t5Z2EvTXJpSHFl?=
 =?utf-8?B?bWR3bk1qSHl0bUhHYnlQdHRKak9ka0Z4a3BhdWRaWWxrZHQ0WlQ5L3d5U1l3?=
 =?utf-8?B?cnB0KytLei9XdEI2WTNFd2F6WTRsMWE0ckdXNis0SzVVS0JDOGtmMHVvdi9W?=
 =?utf-8?B?dnRxSUkxR3lwSTVhUGN1SmNQRy8yVXc5UmcvMnlYayt1VzZ0cnViY0MvUW1J?=
 =?utf-8?B?RUJES2JIYXhrVndFWjFyZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekdkeWNVdVB4aXIxT1UvbThkalU5SXUrSHpPZ0NIN1JZb3cxSDNYb25maS85?=
 =?utf-8?B?U3luZG1PbGVNenA2dGgzZ1g1bWk1VFhHZ0V6ZkwxdFlDdFF3ckEvU2I4NzV4?=
 =?utf-8?B?dUR1SnRabVJ4WXlLUm9pc2tFV1pRTUdXZEl1MTVOdmpvaFQ0MTNhWS9FbUJi?=
 =?utf-8?B?LzM4MHZQU0ZaczlBZXdGL3FCZkpzbEZZZFpZRTZvUlFWYVdHTEg3aTJyMVlQ?=
 =?utf-8?B?WU9pbnBMRlk2a2kxNHlmYVVwaDZoVXZZR3kxMk80czE5ZTVQd2tqL1RUL3NF?=
 =?utf-8?B?MmNINks4czdnTkM3Tk1VcFY5TDRibmJyWHhCbVI0bFRVcWJ2YmJMenA4Vm1s?=
 =?utf-8?B?czUyNHRHTmg0elRwbGM3anY0clhGY3dLN1hmSVZoQitVR09GTzlZUzVDOGw2?=
 =?utf-8?B?amRJZ3NaaGcrR1hIbG1UWEtRVENpOUhrOG9ySGtyS0dacWx1UjJ4blhaV2hp?=
 =?utf-8?B?VGVMUVNBeHY5VFM3SmFSUVdxTWY1RzQ3RXlBL2hvOVluVk5iYUhMa1VzbGFz?=
 =?utf-8?B?WWdNQnE2SGZqaUMxUFpYazMrWVE3WGNHZFB6eGljcHZkbXd5RzhmRlNGcnNU?=
 =?utf-8?B?TE1rYnFkZGUvTnpDZjlkRXZVWHEyeko3UG5ldlJCc1dDM0lmRC8vS2JtUkJj?=
 =?utf-8?B?Q2pmdzJsY045Z2pZQkh3WFVBREh1blFpbGlmOE1oTERaRUlIR2wrUnF0RTlq?=
 =?utf-8?B?TXNyUHcwdEszTUFDNVUwYmMyYk81ckttNHYvTEdjTDk1WkhXMDNqbmxyTVVP?=
 =?utf-8?B?aEU4YWJZZzZKa0VvVGQ0Rjc1Vy8vVWwwTkFpZ3JhSjZuaDhOek5qZnRlVnZr?=
 =?utf-8?B?cVdwcFhZOXNOT1RYWmVQQ1ROZFluMFQzdFRqTlgxWDY5MEFjcTdEdkNyT0Na?=
 =?utf-8?B?Z0MrVFAyaWxHa0JzSCttSFE0MkNydU1tQ1ZtQ3UyVFF6WGNXMlBCVjNvaFlk?=
 =?utf-8?B?K3o5NStFdXA1Q09lbUZaZ0dwZUI0N3V1M05EN1FzOXhycUhoUjcra0ZUVnlk?=
 =?utf-8?B?cEN4N2pxakFTQVBXZnJOVFlsUHozbXY0bEoyK3ZMT2h6bFFUR2hETmpFV093?=
 =?utf-8?B?TkN5aUZGM1E0aTlUcnpmZ0xicVNZYjF3VGgyTXdUQVRtT2U0RGw1R3pqZTQw?=
 =?utf-8?B?akxqOGlQOWtBdHJFcGtQQmlYeEplakdOak1GQ1hYbHdDaHZoT21DS2ZMSnJO?=
 =?utf-8?B?MHZCYm9mdFZ0Z0pTUVFYVGZsa05oU2piMUU1VkhrMktEV0JSVFZwZk82RG5k?=
 =?utf-8?B?V25YNi9tc0RPM1NEd01uS3JjaTUxSXlEU3J4eE9HUlJhOFQ1Z0p0Q21MVmNy?=
 =?utf-8?B?VDcrbk1YNTJyY2xyUS9QcFk0cUZjaGR2ZksvL2phWlA1RVowRVNDR1pLSlAv?=
 =?utf-8?B?WmRKTFdkcHMxTWtCOGZRZ3d3ZEVZUVIvMlpxckRKdlRkdncrNmllN00yT2hy?=
 =?utf-8?B?cHhNNE81eW5Ga2ZSSHhudEVVT2FrVHZtemRQbnh1bEp2RllRcUFYaVhtNDRV?=
 =?utf-8?B?bk4wNnllclA1d0JRM3RDRHZQaTZnUUwvQzQvNjBsNWpTK0NLdGlVbTluZVZH?=
 =?utf-8?B?NWU2cG1TWXlQZUd0T2VJUlUzYW1ZaEJCcEhoS3JrTzFma1pjakFjZGlLejBS?=
 =?utf-8?B?NmMvRjVwQmFEWFp1L013Tko2ZVF1U25PTnRpaEFLOVVIYVM2WkVmeVB1T1lC?=
 =?utf-8?B?dHluVVhqZmdqSU0wMUhCdzRDNXM4TEhMc1ZRQ3djdERoendlVFZHVDR3ZUhS?=
 =?utf-8?B?ejdITHNSNlViTzhPVEdZMU91REtKN3J5ZDU0NjJMencrOVBhRldreUNGS29I?=
 =?utf-8?B?NExIaXdWdDlmdWlSS0VCMDJDV3NLK2VYZ0lvclFJLzc4TFNCQ1NlbVFwMHFv?=
 =?utf-8?B?cG02R3dUVlU3UjBSNDB4UDlQem5jMVUvaVpocVRNblcxUytSTGMrY2Z4Zm11?=
 =?utf-8?B?Zlp4Rm5RemVXL1R0dHVROHhndjU1UWxtbkVDS1VMNFVQLytNZ3lFNVMvUGQr?=
 =?utf-8?B?cDhUcjB0ZXhEQkJCRmhVV3FQc1RYVHAvVHJ1b1F6eFZEc0ZnZXI5WnVVSDdB?=
 =?utf-8?B?Slc1N0YwZ3IzUjhWekJLeGY3eTNhVDRWb25FcXllVkwxRFVzbnVpM2d0Y29i?=
 =?utf-8?B?NmJ6bXhIVFZING5qZE9aVmtOV1NEWkdrMkhQRmlaVlJJTXNQR2FVamlmZnVk?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5d5c21-8793-44e1-aebc-08dd137d6222
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 09:32:19.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyCcP0RWw7XwtQEjTd6iMFlQrtfpYvAZ12i2JZPNy6lhRjFpme81P2XXxF3gGUV/R0AFjldPm3yP3hMB4ZF9Xiqz+KFvgs0HhD0gh2T7sX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5148
X-OriginatorOrg: intel.com



On 11/30/2024 11:01 AM, Dan Carpenter wrote:
> The dr_domain_add_vport_cap() function genereally returns NULL on error

Typo. Should be "generally"

> but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
> retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM

Please remove unnecessary space.

> and if it's and -ENOMEM then the error pointer is propogated back and
> eventually dereferenced in dr_ste_v0_build_src_gvmi_qpn_tag().
> 
> Fixes: 11a45def2e19 ("net/mlx5: DR, Add support for SF vports")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   .../net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c    | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> index 3d74109f8230..a379e8358f82 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> @@ -297,6 +297,8 @@ dr_domain_add_vport_cap(struct mlx5dr_domain *dmn, u16 vport)
>   	if (ret) {
>   		mlx5dr_dbg(dmn, "Couldn't insert new vport into xarray (%d)\n", ret);
>   		kvfree(vport_caps);
> +		if (ret != -EBUSY)
> +			return NULL;
>   		return ERR_PTR(ret);
>   	}
>

When applied those comments please add my RB tag.

