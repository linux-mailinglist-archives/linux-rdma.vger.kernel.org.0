Return-Path: <linux-rdma+bounces-16795-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH6+GxBWjmnHBgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16795-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 23:37:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E212F131894
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 23:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D873304D1C6
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 22:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC5932FA2E;
	Thu, 12 Feb 2026 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHJGIhoF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770A261668;
	Thu, 12 Feb 2026 22:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770935816; cv=fail; b=bS0qp/ESkvlxSm2xJyiswHZgLmXq8TfxBfOvtgG4ns5fEIlH3yHAEG3UmtdjOqozka3pFFgaW0cqhl/lXr1H1hdTb1yeC+x6fDt3g0ZwvqNhw/hUsiVPnv9UhOAlunkPlpspoP55ZbUwQ9akbuhxPBZwizi03NlmNCH4/a1e3/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770935816; c=relaxed/simple;
	bh=5b3wuN32/VUr9iFXM6KrXFxavnpJoarMpfs9PzhH3xM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=os+bUttTCXrYsc0Nwe1mn4pSJsFla54b7hvp7wioT3ggE4/840lgDDmEqcZlUZowOL7cUqTUXGxmO3MEjDI/rAqWpdYHSOPs1M3DQQYVDPAJ9+TnhS1Cn7+SmRPyNHWqYRrtjrbkicaU45mwJ51/ZCWkwgC/bqiH6HoUhENN+dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHJGIhoF; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770935816; x=1802471816;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5b3wuN32/VUr9iFXM6KrXFxavnpJoarMpfs9PzhH3xM=;
  b=VHJGIhoFFXwlfF+O/z6zX+dNc7OThGBn/3LamalICl02MrjaqZ1n9DKv
   Uh3tGUhrMyg500/fXrydHLcoSEslFv4IInhF+Oo0rkb8t8sxn4aCiGLby
   DKYRwuMeWmgskELfHbkd0z09yvV1VGFJfYmb4QwweHDfJxQVx/DjbHFH/
   X9JHWcqSYQkZ1ofYXPk0w8BwWmQe2C6+qcjxvI6Jl9uVpqXyYget18gCq
   gf8QQXvw78dNapItoQMKwTKs3ExAizfH5+T2NJSkAQ74P5VTkM9Zj3GiW
   YxZF2An3I/uzFAHIxQmva3xBa7Qs+3LXUPSH2KVvGZa3FDEdwUDspKaut
   w==;
X-CSE-ConnectionGUID: JmZvJvyNQR+FxjGL0RVBag==
X-CSE-MsgGUID: +aPiSQ0vQxSuODTheOZi1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83217550"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="83217550"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 14:36:39 -0800
X-CSE-ConnectionGUID: XmFwc2hVQuCMGEARs4w/mw==
X-CSE-MsgGUID: 4CX2Fq6HRa6r70QRtCGSsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="216926681"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 14:36:36 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 14:36:36 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 14:36:36 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 14:36:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuweDBGXQKiQS3dAC+CO/NNutnuWIrSs2oWmC5b3xsagNiGZMo+XnSsryspicuDarUuhZ9gC8O4AyKyCkxKIgqxpHVkIYIg1P3N12V26v+We68BjskOPvzCNd8Rolf9FeKSCi2hv2fBaH/OQ+ofz8LPbb4HmbKLeZtgqY8jjdWV89vNRv8/szu8K60Q3k41ybf4+SdLE4EkIzkuojD3mYRfEM+pERCWBDf/9++3IU3aPdThxjiO7lvyKbiYRqgQ8dhDvmt3mVnkIAFxkbF1VYm7Q+Ns1LuVCa5C5uBhwoAFArnkSMwGFUr6U217O3yp7IxsjiWRYylrGXwDMIBL7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfyQlbBRtFKDN6+BZoVJPpIVMNAAG/r9nXngATmKcgo=;
 b=ISSeI1iOZ9YTZjuB9rk2jy8mlnLetInk/6aDiJd3DTgnnL5yV9kQDDj37CiTY1fde1F1wRgo8zf4b2zaY4ikZ9Lwhm50U59iKer05HGnpv/2TDpTnOJzibkgOntUjXkqjDbexCXKTeB1pYdH+XvD+tIKfXrD8FMzHNXDxAW7nRA9KFHkqBlV/C8lG2Wou9eggkWkgD59btEFmy8a7unSjTaAtx9+94VsmKMqfP3DccryxTfubOR54JuwJphJ9EOXDszUo6CfisdgvmGro9RgEaVhxfdy4CEYqY1TSczvi9zQZ8nuktLM+CeUjuzyTnDtlSTgmwvPKP4HU7lHEgAJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16)
 by DS0PR11MB9504.namprd11.prod.outlook.com (2603:10b6:8:28f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Thu, 12 Feb
 2026 22:36:34 +0000
Received: from PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3]) by PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3%5]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 22:36:34 +0000
Message-ID: <8d3b2da8-e13c-49f8-a8a6-3aa5b307dfe6@intel.com>
Date: Thu, 12 Feb 2026 14:36:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/6] net/mlx5: Fix misidentification of write
 combining CQE during poll loop
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>
References: <20260212103217.1752943-1-tariqt@nvidia.com>
 <20260212103217.1752943-3-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260212103217.1752943-3-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:303:2b::24) To PH0PR11MB7588.namprd11.prod.outlook.com
 (2603:10b6:510:28b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7588:EE_|DS0PR11MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: 235f6c80-14d7-4ee5-225e-08de6a872cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1hOeXVZRGVWeldJUllCaTBhS1hoaGM5S1VkdkZRRVJNVXJ6NHZoWVBjREZq?=
 =?utf-8?B?MTBHdXdoaVpaMnZPTWRDUlpuWFVoQXpYS2RMRGR1bVNvUnJ6ZGFKajhrQy9v?=
 =?utf-8?B?VHYyK0IxL3RreEdScWFzbjdvcVBkZ1g0WTllOEdQV0t3OFdHT1BmeWFWcmlx?=
 =?utf-8?B?OTM4bXJvZmZJNnV4aFgxbFZoTHpnRzdOOUE1U2F1VjQ3V3N5dTB4clpGVnFq?=
 =?utf-8?B?WUNCUDMrWDFQdGFkaDlnM2dxRVlpZUVPUjZhSkMvYWdDTWtaSWdjZnovd08y?=
 =?utf-8?B?L0trZlZtOUFrc1F0Z05FR2xkUURCVVpTYkVvbVl6WHJiKzB5WlMzM0IwdDNS?=
 =?utf-8?B?SUo2WVM3STZVSWdrZjEvVmR6NGlKdXhhY0VzSTJ6VGFjYlArOUFUY0YwelQ3?=
 =?utf-8?B?K1NZa3RNZDRyUmxnNHNjcVdJamdvaHl5VHZ6c1R0ckg5RS9DRnptb2NXMWFk?=
 =?utf-8?B?VzJqNGhBczV2R09QYjFKK2ROWlc5S3dqbUdhOTFoWG9WN0xsRDFsd2VUUno4?=
 =?utf-8?B?S1JndkJmdHN0NjNyNWVuSXRtVnh3YzNYcTNHdFJPclE0dFFpdUYxeGtaK213?=
 =?utf-8?B?d2JTMy8relNXajgwL054emMvZndwdVh2T05vamRweE5raWk2a0paRFk2dnVJ?=
 =?utf-8?B?RHBKWnNvNFNtQWhmYnVjMVdYVTdYa1ZQdlZpanN3Wi9jMGtLQ0kvWVFsNWZm?=
 =?utf-8?B?L0FmOHJaQThNQi9UbHF4MG1ZRlU1bFc2YmhpSUZZT0VIYTlMWktuQngwUEtW?=
 =?utf-8?B?Z1ZlaFJjNkMvY2pFVEErNlE3Y0JNemM2TEt4U2hvT1hLUzhBTmJpR2xrL3pw?=
 =?utf-8?B?VHZoM2hRd2d6QTBQOTlsN2lNWHcxN1ZWdTB2UnZVNjcyZEF0d0NKS0xGL2tC?=
 =?utf-8?B?UENzOUVTN3NTK2dZSXMrVHEwVDVDdVMxcGd0bStoVTlncG5ySldadGc4VE5h?=
 =?utf-8?B?TU9VeEEvS0oxS3JnczBsM05tVGFmMUFnLzBheVRiUE4wWkJXN09OaXV2MVFq?=
 =?utf-8?B?akwxZEprWkVTaEp1S01TbmpoT204d1B1RHEyVUx3dUNENTlFSmdqMVd5dmFq?=
 =?utf-8?B?bmRBYk53K2VodFptRXRQeWwwQzhFUldLZWM1am1XM2wxakxvR0h5RFcydjlU?=
 =?utf-8?B?REtTNCt6bHZGVm10RG44WStCNUNMc3J1bmpRUU1aZitwQkt4YlF0dHZ3Q3J5?=
 =?utf-8?B?UGdhOVdpZnZLcFdERHd6ek9VYmgrUS9RSFRVWSttT3RMWTFHbktXNVZNc1VO?=
 =?utf-8?B?MnFvZkF3Q2pJamQxbTNDTUlNc0JLU1dnU2tIejJkbXBMQ045b2xzbnQ4RFNZ?=
 =?utf-8?B?NGNWRUlVRnZpakRsZDc0azIzdXAzbS9XWGdicloxK3JqaCt2ZHdxMDF2U3hV?=
 =?utf-8?B?V1hJVFpHbXp3RmFmQklXQzFKcjV1OU8waGhNSmtEZERHajZGdW9nRjJ2L3NS?=
 =?utf-8?B?RlNHRlY2cVJyMk9WRnZud3U2SlcwNFlHdlJkMDNpSTdvNDFmdEtoSkxzOVp3?=
 =?utf-8?B?b0EzaVhlMUJYZFdUL0JBSTJPM2YyaTByYkpBUVU5MmZ5ZU5VeHJQODYxZDFO?=
 =?utf-8?B?QW4xOFhkd2QydlhtT3d1TWRqeWlUcGttcUtVZFExa2J3NW1KN2NOV25MbnVl?=
 =?utf-8?B?ekR4M3ZrZURqSTJpbW8ybmJKRlRGdWExR2N5VzJTRlpvRTNsV0h5T05tREFH?=
 =?utf-8?B?Qmd3UFFadHpWQzNPR3hVYnRLWXpsUEdUT1ZyYzJ1UE1GYXp3Z3FFdFp0YlRu?=
 =?utf-8?B?Y2JFRSt0VTVMbGVyVlo1QnVQRW1KM2FmeEJwaTl0YlNaSjIyL0p0ZThjdDFw?=
 =?utf-8?B?ekJGMXZaWng4aGM1cCtSTHlwaEt5MW8xNXR1Sm1CSUw0UVRJRGJVUGJ3MWJC?=
 =?utf-8?B?dHlsTUV0R0ZEZytoak5UNEJ0NndOYVVBcmpBd2dsR3Q1NVZkZ2hYb3pPaHhD?=
 =?utf-8?B?RlI2ZkVzNDVNclFmQUdJbmZuNnRlb2xFZWtQQkkwbVdnbFhiN1RMU09zL1Mz?=
 =?utf-8?B?SjQyVHVNUS9tRGhWbTlSTDdaOU5pcFBjZ2hWL1dtS2JzSEdqS2I5SkRRUTdC?=
 =?utf-8?B?MUNuczBXMXc2eXp3cmF3Y0NqRG83Y0FadkxoOUcwS3Z1VFNxUGRaRVZZL2pI?=
 =?utf-8?Q?81gQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7588.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3dqQzVuQmpleVUxTGd4VEFVT1NwRFU5RFI2RCthSkwxdURoUjNjR0Z0YzBC?=
 =?utf-8?B?Ymc1L29jZjVidC9TZCtWWFdybnE5bUc3ajVFOE9HUE1pVnhneGE2Z3B0eHNw?=
 =?utf-8?B?TGpleGt5MjUyNm9WK2sxR0VBbTMrMDh2MHRyd3FWNVk4OUVPcW8xQzU1YUIx?=
 =?utf-8?B?TnlQZEk3S0g5S0Z5eXVqc0Y4K1ZSMWZ2cVRNWXMwWG0xbXhyMGoxWHBqMFBj?=
 =?utf-8?B?aFJWc29nVEl1QnpwZzJUZnd2dGNWN2d4ZnkweTgyaU1TbE5aS0NSdEdZLzdD?=
 =?utf-8?B?VC9kaUR2L042ZGhiZjBVdGxYRzV1R1hDeWhlbVUvdDFLT2o1Z3Z5TUNCU1FV?=
 =?utf-8?B?ZDAvOWtNWlkvZytDNHEydk1QMEVqOGIrVlhheGN5Mmh0UWVhZHcxeTZXNmZZ?=
 =?utf-8?B?dS9lMG5EVkt6QVNUSEFSeHJEWGNYWnBqN1QrN1ZtMlFvVUkzSGJOUTJ0Um1Q?=
 =?utf-8?B?empoY2cwOTQwaHcvMUtqengxWlN3RHYweWcyQ2VDTVNtYng3RzRGN1ppNU9t?=
 =?utf-8?B?NHJmTU1ZZGVjajh1S21vZ2RibHVHSU1vNlo1cW5pdGlHdTY2WSsvbXlzL1Zr?=
 =?utf-8?B?TWhxQmxPWFB5Y3BXam5TRGZaL3l4NXdJMVR2a1lhSU5XUVZnNzA1Mk5nQm9o?=
 =?utf-8?B?WVcxelVrRjk5TlNEWEs1eHVPTHhzWHp5T2U5VjNEN1QxUlRYcGhqaW9PMzV2?=
 =?utf-8?B?UmRZc1kwN1lPUkJ5WXEweStrTE0vQnI0VlU5Sis5aGFkbWpOK2c2SUgrU202?=
 =?utf-8?B?NHhjZnByLzRrQ1lidGNHWnpaUmxvNHBsTUdVQ1BwSEd3eGFzTFVzSTV0Y1dp?=
 =?utf-8?B?VEpRWDJ1UG1EQ2tHQzNxbUNTbklkek8wUG5DUVpTN2NibzJOUGtjSkxsRk0z?=
 =?utf-8?B?TTFNWnkzUjJmUTZ1YW1Uamx1YVh4M1paMi9TR28rd0IrcHR0akhRS2NtUWxN?=
 =?utf-8?B?VTloWFo2Z0hzMjBqTGNhQmtoaUVjVUZZMTJhclRLb2haS3hMeTJTc3ZEMk1x?=
 =?utf-8?B?cHFhNzRSRzJkeGs1RWZzUkU4KzViN2lKbExFbHRxNWt1T1hGWkZ5QzNrdXM5?=
 =?utf-8?B?OW9Gem5ZK3R6eXJMRjFiT281QVhnUXFubEcxTmtWS1E4QU00VytHUE91T0Vm?=
 =?utf-8?B?ZjVGN2hySUZ6dy9vWHlsZXJXOVZpZXR3OEJxZWd1RnBDOVdLU2hIVGJtNE4r?=
 =?utf-8?B?KzBkNUFldkViaGRIZm9ZLzhvK0tEQXFiZzFiMTRUYWVaZkxyZzByM2dtWDFG?=
 =?utf-8?B?MnZaK1BWZlV3cThGU2ZaQStjWFMzYUZBeVJjRUdWNnRxSTBpa1pQZmhxN01K?=
 =?utf-8?B?OGJOQVhiRWRpV2MvcDE1UHNrY1pBZnlseDdBaC92cEF1QzAwTGFVektWZUpF?=
 =?utf-8?B?UVRUSmVzV0pvVXJPZ3g5V3Q2cStyT0FHdUN1RFlHODBOZXU4VXlSME5maFRO?=
 =?utf-8?B?UlpVQzg2c3A4NDJPdGoyNjhYTiszMmhiakZZSDhIVUtzYmJMdjhvdWxwVDRx?=
 =?utf-8?B?R1FhZmFlK0oyK0tNSFRYd3NUeVRCVXR1WWN4d2F6QUNEQVhLdmExeE9mRXIr?=
 =?utf-8?B?YmUxRDBpNXBEakJvUlQrL2FCUEVvbFlWcU8vQVVCcGdYK2ZQWFV0UXE3cWJ4?=
 =?utf-8?B?NmlFeDlUSElFMVROZmcrdkZCRXI1Qjk2WlY2YmVRRVBVczVmVkZpdGprNTdD?=
 =?utf-8?B?WHU1eTRqZFdOSWxvMFlpeGVDMDNtRmNmZEtOUmliRFRXaDg5ZWRwRUxFVDVv?=
 =?utf-8?B?dnB0a1F6aWNMQUpKc1RLK2UwM1dTdWJPRjVhdlpGVy9zcVJXc2JVU2VtdmNR?=
 =?utf-8?B?UThPWlJodk9Qc2RXMkFMZGI5RW4ycWZTVUdTMmdGcVR5VDhudnlHdG9nYlNI?=
 =?utf-8?B?MDl0OEt3TEwzOFJuQTlsU0wzL0tveWFBdWVSaTZRa0kxL2RodVZRQ21sd1ZP?=
 =?utf-8?B?Tkw4N0lmTVJJTExubExxZWIxVlNsNllBR2NGS3BkY2ZleXlYVkNscVE2QnF1?=
 =?utf-8?B?K1daUWZXZ0VlQUJaQ2NiR29ZUUIxeU9yVnAyY01SZkdwdGhXZEJwK2xQNGR0?=
 =?utf-8?B?NGNQV3dWVGdWOVVBUkpnVG5hbUlYZTNtTzlMeDJiTGtWOFFBUjhEKzhRcUpt?=
 =?utf-8?B?WURhY3pwNzZuQUxrYitIdmo0QUsveXpkTDJzK0k5aFNMM1pKUFJOSjNVcVBL?=
 =?utf-8?B?UHhuVzFGbzUrUVd3Z3J1aDRWR21reE5CY0J2OGp5dUF1aE8wYVBlMllQVzhz?=
 =?utf-8?B?VzVMbzFJcStKN1ZlMnM2aGtkNkx3K3E1S0ZPVGxsVWR3eldxbGpJZEZqcVpD?=
 =?utf-8?B?cWluWFhtSXBZd0MxdEVqWlhDNjlXWnc1dzVTOVVOVmJUQjBza2V2Y0xXSUg0?=
 =?utf-8?Q?fUQyk8oO8nw2WR6s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 235f6c80-14d7-4ee5-225e-08de6a872cd4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7588.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 22:36:34.0135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPQsO4ePvANnJcryPSZSGcVkEzE+4Zq6YUZYgZxHXhQPJJAwyQK6yE99RK7t68vE/w97ONBfvh6kHQnfemPr9928WIv1M58cbyCiQKBhhXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9504
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16795-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E212F131894
X-Rspamd-Action: no action



On 2/12/2026 2:32 AM, Tariq Toukan wrote:
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
> index 815a7c97d6b0..29db15c4b978 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
> @@ -390,12 +390,10 @@ static void mlx5_core_test_wc(struct mlx5_core_dev *mdev)
>   	mlx5_wc_post_nop(sq, &offset, true);
>   
>   	expires = jiffies + TEST_WC_POLLING_MAX_TIME_JIFFIES;
> -	do {
> -		err = mlx5_wc_poll_cq(sq);
> -		if (err)
> -			usleep_range(2, 10);
> -	} while (mdev->wc_state == MLX5_WC_STATE_UNINITIALIZED &&
> -		 time_is_after_jiffies(expires));
> +	while ((mlx5_wc_poll_cq(sq),
> +		mdev->wc_state == MLX5_WC_STATE_UNINITIALIZED) &&
> +	       time_is_after_jiffies(expires))
> +		usleep_range(2, 10);
>   

This could be written with poll_timeout_us(), but I don't know if it 
warrants holding up the fix.

Something line the following:

diff --git i/drivers/net/ethernet/mellanox/mlx5/core/wc.c 
w/drivers/net/ethernet/mellanox/mlx5/core/wc.c
index 29db15c4b978..6ec9c1a2da78 100644
--- i/drivers/net/ethernet/mellanox/mlx5/core/wc.c
+++ w/drivers/net/ethernet/mellanox/mlx5/core/wc.c
@@ -15,7 +15,7 @@
  #define TEST_WC_NUM_WQES 255
  #define TEST_WC_LOG_CQ_SZ (order_base_2(TEST_WC_NUM_WQES))
  #define TEST_WC_SQ_LOG_WQ_SZ TEST_WC_LOG_CQ_SZ
-#define TEST_WC_POLLING_MAX_TIME_JIFFIES msecs_to_jiffies(100)
+#define TEST_WC_POLLING_MAX_TIME_USEC (100 * USEC_PER_MSEC)

  struct mlx5_wc_cq {
         /* data path - accessed per cqe */
@@ -359,7 +359,6 @@ static int mlx5_wc_poll_cq(struct mlx5_wc_sq *sq)
  static void mlx5_core_test_wc(struct mlx5_core_dev *mdev)
  {
         unsigned int offset = 0;
-       unsigned long expires;
         struct mlx5_wc_sq *sq;
         int i, err;

@@ -389,11 +388,9 @@ static void mlx5_core_test_wc(struct mlx5_core_dev 
*mdev)

         mlx5_wc_post_nop(sq, &offset, true);

-       expires = jiffies + TEST_WC_POLLING_MAX_TIME_JIFFIES;
-       while ((mlx5_wc_poll_cq(sq),
-               mdev->wc_state == MLX5_WC_STATE_UNINITIALIZED) &&
-              time_is_after_jiffies(expires))
-               usleep_range(2, 10);
+       poll_timeout_us(mlx5_wc_poll_cq(sq),
+                       mdev->wc_state != MLX5_WC_STATE_UNINITIALIZED,
+                       10, TEST_WC_POLLING_MAX_TIME_USEC, false);

         mlx5_wc_destroy_sq(sq);

