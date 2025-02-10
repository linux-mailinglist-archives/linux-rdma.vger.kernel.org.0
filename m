Return-Path: <linux-rdma+bounces-7622-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D695A2E9C5
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 11:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9C5167B81
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 10:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365C91CAA82;
	Mon, 10 Feb 2025 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTTBviPy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C781C68A6;
	Mon, 10 Feb 2025 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739184104; cv=fail; b=LmgR9vG85reotl7fSqBpkoZZhV9FkTAL02RDPxTL5WewMyNe+YbSfRS1wuW5y8bL08qw+lOSq4eV1VhHdXos2l3uskG7UGUZ48SipGa2Mi0F+bClbwXd0KhS3nN05hYFy8rwFJ2gHVHlaeZnTMq/qnFaK8efLB7enuzGdcB5+zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739184104; c=relaxed/simple;
	bh=c2kLom/o1bMVQCm6bBZfTZxJuBBKgXqAa15ARrvWBoI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BV+ga0WzhUeR8JByAgaCm8JJZ3HHMWstzOlc0cVlo8Z/WXbb15uN0UDKxktrQMB4nWPvD0Tpxzq0x6HS9I8YdkW55ZNPAsaTOoIKCCpMdO8IJEoQD+ZSayy1GIg29Xxl792/4/fAgi1iNd39FvVcE3Zxbp9oMLTUuYKGAQqMUQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTTBviPy; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739184102; x=1770720102;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c2kLom/o1bMVQCm6bBZfTZxJuBBKgXqAa15ARrvWBoI=;
  b=aTTBviPywzXD/cYPwG7a6zvOGlig+zvgvw52I3sfbfsFy/9QYDqW/HJL
   64tcpElxj3kWLfBTn3NT1ii+o/fuYeupQ0+FJd4FS1VlkRO8Mv/OmUVIM
   OEONmJN5LhK6xJkEBiagB3wFmSexQ3ukclcRZjDWiQt+8m+s/YRGkE55N
   TpPOx6qN6nz2De3vKnEE4pBFnIs0LQvXnqBNNK7ObG+icRGWPkpaVSlTC
   j+ZoHv09LyyjbBU3JBHPsB+RGq1pj2N76kmov7kn8lTM2zjf6Aq+mPpFu
   1kBGsBMBc5Ws/h1PQk0T6tsmS0TEZkIobS5fJK4RQQSBUXM3V+uvsRtcT
   g==;
X-CSE-ConnectionGUID: PV8ZU/11TTWMCIPJe/Iutw==
X-CSE-MsgGUID: iN2TZGLjSL2M8pmwuOrKTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="27363642"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="27363642"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 02:41:41 -0800
X-CSE-ConnectionGUID: tzsrlsL1SGipy/5BbAF9ew==
X-CSE-MsgGUID: X0XeTXWMSSqJchTowtzAOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="117087528"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2025 02:41:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 02:41:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 02:41:39 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 02:41:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ytn2gWeNzMqcEj/668/1047z7CDyRTr0p887aGpIgNJqub1Is/chtrqJYjhJouhxLwAS44ACeTX+IXqIHhwqoxd210zDDG6NkaZi/yEzj6ees2rIuz+rz59NxemW8XgiMM3AHAviiy2RBm+pddS6Rg77EefHWOHrZ9awoocj5J/hQZmcCvv3z9ZsITEeMneUtENLq/WrOU7d7+U8zKnKPEHFoF/BI+RFXT7HuNDeXBFCxa5X9myaUKou3bjGr6/XFJYXVec9qV7P5GWb5CbwkpMLyHWqEApWD6R00Vnhq7xLiBcnFuEvHYifoEOmu4L38O+hp1UZZ4dr41Dig6HV+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ngGtoTJwd6GUrzCEy/xjNsPxXn4WN/Oiz3yKxueuao=;
 b=dFg/oVLB8ZXYhgOMSL2NxgnKqirMbyHaes8GNoPKKAVqLOpIYBh/UouBeMO/z04XPu7qa+DVLbFvTrUlTUyK4K1vTE+0xgjRmL1UVUofIooDMfCe+xWO3kmR1BsxQ0Grtcz/lH9PzTYAGOPe3zIDEHdhhmY4kV1P2pTWAhr//Qn28F96JBlq7PnUYFTXDfqjeyywWS6Ub0/x16YMU72sq8i5d5CsZBfiy1W/XAac4MkT6ljkWzKW1M23hujeUN1FxmX9I+lQU6MWNS3wJQfnBCE9UmbuYLkSI0IYeORrD1EqwzLiLTljrWEcyPSBJ8jmor8FmdqxIuRhCbuEup9NPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by IA0PR11MB8378.namprd11.prod.outlook.com (2603:10b6:208:48e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Mon, 10 Feb
 2025 10:41:36 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 10:41:36 +0000
Message-ID: <7e12c97d-8733-44df-b80e-2956c0e59dae@intel.com>
Date: Mon, 10 Feb 2025 11:41:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-next,rdma v3 00/24] Add RDMA support for Intel IPU E2000
 (GEN3)
To: Tatyana Nikolova <tatyana.e.nikolova@intel.com>, <jgg@nvidia.com>,
	<leon@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "Eric
 Dumazet" <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
References: <20250207194931.1569-1-tatyana.e.nikolova@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250207194931.1569-1-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0049.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::38) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|IA0PR11MB8378:EE_
X-MS-Office365-Filtering-Correlation-Id: 9517fa45-9109-441c-52ef-08dd49bf7e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z05wMXFFczRxZHU3RE1EaXBXQnlMZUdPRVM5d2w0dnJLZ1IyNjFDK0dOd05J?=
 =?utf-8?B?bncxcWs2Z2hQUVNtUG5ZZ2gxU2Mwbk4wcEY2c2x5TE5ORmdjdUZ3RTF2SVdJ?=
 =?utf-8?B?TndoRk11ZiticVQ2SUx3aGF2THdWS3RIb0JNVXB3R0dob3JJZytRZVJhczYz?=
 =?utf-8?B?MVdqNk5Xdzl2Z3czeHcwQ3Q5cE1nWGFCYzZxSk00aUJSTHFCdEhURURzUUtN?=
 =?utf-8?B?VmNSTmw4MGJ5RWFRb3h5Mk8ycEc5OS9mdzhFWUh4WE5XUXB2ZFFzU2ZTc0lD?=
 =?utf-8?B?Znc5a25DbzQ0c0o3WHRPbHFvRFhkamh0QTR5d1NQdkV6dzNUc3VRcVhsRzhM?=
 =?utf-8?B?NXlDd3lXYmFSdzVZUDhlTmFvWjhoVWdjejlCSDVyTjl5dDYwS09Wem44V3NC?=
 =?utf-8?B?ZkxoRWl2aHBvVlVvQVB5RktaeGJiUG1laVdhcmlDazNrNHJlSDBCamoxKzVq?=
 =?utf-8?B?aVJMS04zZ2ZDRkxaWS9ISGxPQS83d3hWbmt5MEkrZUN1cEpGZG1ZSHZ0QjFL?=
 =?utf-8?B?bjNnUGZGb2tjZVRlWkhHTTl4elpCVmpwOXFkc2Yzek9Ya2FwQVZobkVoOUZV?=
 =?utf-8?B?c0RLNHVrVms5Yi9VUW0zRGRLdWloaEtGZ1p5K21abytCYURpNXN4ZUwzQmdm?=
 =?utf-8?B?SmQ0QjdjWjllZ3dXbXpSODlpTjBRVmorc1dCdVIreEtaMStpRmRiRHdCRFA3?=
 =?utf-8?B?QkxmblljT1I1UlpRSExtOURHK2dIcFp4ZjA1cWtXT25VbUdpSFNHT3dqR096?=
 =?utf-8?B?aS8rTloxN0xBbURWY21URTkrU04raDhGeGhLNnVvN2NlZGttNHVvM1FjejRL?=
 =?utf-8?B?T2tQa0FtRlRKc0lBSmdUZUd0aDlTNGtRL2pnQ0gvcmRTN0YxL1dTOFZBV2dQ?=
 =?utf-8?B?QzhZclBCS2tta2Z2SkY2VlpTZDdGVEpoaDBOR051WGhTYmlZNmpUdDRjVmht?=
 =?utf-8?B?VlBtNk5vZC9sYktITWc4aXBucXNqVHdXRXhwdGJib1gzKzVIY0RjUzY2MjFu?=
 =?utf-8?B?ays5OWxvN3NHK1NneGFOZWR5VVphSDJYekVtOHo2dWJJbFBPdEZKQ2NuRkJW?=
 =?utf-8?B?VnJpVWlqcXlMTVFmamJERkZ1MC8vc05oeVJpUE9WTmhTMDB6Mlg1L2sxdkdQ?=
 =?utf-8?B?NFdWTTFGNWJQYlNaRUREcjRIYjFXbFZ2WFBNbW1veHNnclg2MU1oR0NtZHJX?=
 =?utf-8?B?eWdwd0xieGdDbjlrczNudlVBNmVoTHl1bGtsSXVLMVFQTzFxc1NoZjRGbDB3?=
 =?utf-8?B?S0JpOUFoQWkzUVYwZzNrc2hzYjJWamJ4VHFFNWNsU0QxbmhPUDVia21KVVVE?=
 =?utf-8?B?ZHJ5ZmpXU0dxNGI3S3JuREhndGpsMVA0aGxKOGt4aGM4V3ZOeHlhb290Mmo4?=
 =?utf-8?B?OFM5ZFp3Sk9MSUR2NEZQMSsvL2RUNkNzNzQ3RHFneFpsN3E1SXRHRGV5Yitx?=
 =?utf-8?B?b09XY2hwVmZtbWhVUFZYNGJwZ3EySXE1RGRYN2Jwa0xZV1JWbzQzWFY4cnpP?=
 =?utf-8?B?N1ZUdnpjd3NGN2I1MzVKSzBrZWl0NEpPZWkwLzFDajV0b0RJdUxOL2luYUF4?=
 =?utf-8?B?NEtTMFVSc2hVTmN2SnhaVDdBS2dSYlQrNWt6U2xwZXZCKzVLRzlvM2loMnpp?=
 =?utf-8?B?ZjE4ZUZZVmFCY244Q3BnZXdmMTc3UWsyck1pQURLS1UrTXEvams2K2ZQcDF4?=
 =?utf-8?B?c3V3MjdxbGo1VXFFcW1SYk5vZW8vQVBmK3MrRllybExlalhYQURMd2VzM2cx?=
 =?utf-8?B?RHUzRXBhVFo5OGxVZGYycVYxWVB2blBaS2ZPRTJXZTRkVjMrUmlydXdncm1V?=
 =?utf-8?B?UEdmQ3RtQnAxNHJESWJNdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE9VckVWQW94dGE5emxwZzdiUjlSUzFXMW5pSmVBU0FocS8wZkJCRVNQM1FO?=
 =?utf-8?B?ckgvcW45c1NvWHpWblhZSXRlNVo4eWpnUlJ4VnQ3Uy9VRHRhc2NBaXpWMlFB?=
 =?utf-8?B?bzJRSGZSUHJ1Z2hibkk1R1BzMHpWMlYvMGJNbjJLVUoya3ZvU0tFVlFmVDFW?=
 =?utf-8?B?TWRSSEVvSFBjUHpSVVlwNEd1Mnc2VEhod0FDTmpJTzgyRmtWVmIvblVGbWly?=
 =?utf-8?B?d2FJb1FBUlZiOGtyNkN2ZjJsTHNjYkJET1dMem1IamdSTzRqZFRvSnQ2ZzV0?=
 =?utf-8?B?djExZm1DWFR4QzhmSzNEUDUveDFsK09sSkRSZjN4akxsU2hhNkRVS3VDZU5M?=
 =?utf-8?B?SWRFNVR1MllwM0NpeFBtV1J0Slgvd09NNFVWaGVMSGxZMm5KbWpEVWhPUnRx?=
 =?utf-8?B?TDhqU29qNlBFb3Mxa0gzc3hkL0RxSVA4M1ZISW45WnJVblZESDBEcUFqelJD?=
 =?utf-8?B?ZGtBUk9nNWxIRXFIc3huR0ZJSlNSSktsN0JCMHFmb2JZVTdxVFA0RmJVYUpq?=
 =?utf-8?B?NEVCZE1UcW52VXpoTzBYM3ZQSFJ0Mzl6T0pzSEpJcVlOczBUNHdhVWhzbmY0?=
 =?utf-8?B?MHlEd2FFL2p1MnZ0c1VacmVZQ2h6Z3B5a2lLUHgrUEQvUXhmeWsvTVhDYUVi?=
 =?utf-8?B?b1lPcVVVM1UyM1UxRlB4azZqc21MREZqeVdoakgwNlBJRGNWdjFUNnZydVVu?=
 =?utf-8?B?L0RjWFpCcmF3MnZqcGI5SlVjQ3hPK2VoR0hjeGFKTVBZZWpNaHpZdmZZYjRF?=
 =?utf-8?B?RFdtQm40RXhvZXpFWE8rSEQvc2dBWm5kTDFvVlROSVVzRlk0Z1RpSVVjdVBy?=
 =?utf-8?B?cmxjcEhYOTRDR09KTFRtSWhzYUNadHQ4YkFiakV1US9LTG9saFBZYWJvaU5j?=
 =?utf-8?B?RDRMcGtxTERIZUhaRVNmQXY4Mzg1UCs5NmdndVZ1Z1ZNZmpQZ1A2c0wxVWdl?=
 =?utf-8?B?TDVlQ0tsaVFndjZlMTBFUHpFVmE1SXFHaDd5K2pJa2NkWFczclgwREozMWxX?=
 =?utf-8?B?Y2NSWFhaRzNxUTZ5SXQ5UHZ0MS82MEkvQy9Dc0hvb1ZUWUpIcVV5R2wrTkc3?=
 =?utf-8?B?ekZyOXdoLzB4ZnR1RWRobDBaK0kyOTNwUXd6M0h3N0kweWJuMzJuT3hkS2g0?=
 =?utf-8?B?NHoydVNZaVZhKzc1cUNCbTkvU1R3bVRCVHdIeWtCS1ZLWllESmRjZzlWajZ1?=
 =?utf-8?B?NkdMMjZLWDVJT1RjUTlvU21xWHhKS0FTN0k4VDRSc1hxMjVrdnp6czJJVDdQ?=
 =?utf-8?B?VEV4ejV5Um5pbktONVYzNTExNDNlNTljUFo1NmZyMTRKamh4ZXVhUnVvOTdM?=
 =?utf-8?B?ZEozRkxnN2VMK203OVI0eXlaaUpHZkQ5djE5OFRqdWtlcGRqZDVmYWlMSjlh?=
 =?utf-8?B?bGV5RnRaYlQ4OTlhUTdDVm0xN21YcWErTHRCMUxIV0t1OTlUY1dhWnpoYTcz?=
 =?utf-8?B?OXhLSHZjWTBETjYrcFNvWXB3ZE1ZbkVrOUNTdngvVWFBVlZYZXI3TzVId1c5?=
 =?utf-8?B?bmFhcnVlQ290MEc4SXh1MjBBVjZaNXBMMDQrdWVhR0pLSE1CTjBneDhGV1FE?=
 =?utf-8?B?bXN2QlVpM0lSYzFqYU4vNlQvZ1VyOXB5dXYxUmFMWVFYc01mc3BMclZYenJp?=
 =?utf-8?B?dFV5b2diTU5DNW93SDFkdm80d2dZcEpONHF2MTI1bkdCWURwNEVBOGM5aXgr?=
 =?utf-8?B?SExVRlFjZThheWFWSU1teFFDbDFTNGpFUGVQckt1d0dRM2RldHdjL1FrUysw?=
 =?utf-8?B?MGRWbHRyNEduM3BUMVpmcGM4T2Y1S2ZoNkJPVVJ6YmNhaTNQY25HdXJqM3cr?=
 =?utf-8?B?Tkc1TEZZTG13T0I2cDU3S3VacjVuMjQ5VWNDM2JIZ3lra1cxb2xnd0xEWTN2?=
 =?utf-8?B?b1BGcmgvNXR4eHFFL2xtbC92YS9CS3ZkK1RtQitqQXZTbmZkQk9XUW9nWHlT?=
 =?utf-8?B?NkRCRGpvUnlhQm1wSXRBL2ZONFdYVS9uYzRLSk1uWFlMTjNxa2t3Mm4rZEpm?=
 =?utf-8?B?eWRKNkNhUnRuRGV1VXRpZlJXZGxNaTBva20zQndtRXAwaFBaOGNZUThvbEtF?=
 =?utf-8?B?OUY3ZW5md3F6N0MyR1FzWEhPRkQzU3ZkcUlRUXN6QjNna1B6czgyMlQ3c2x3?=
 =?utf-8?B?cVNvdHhBK2E1NGZUUEEvbW5saXpTbHlyaVdXMC9zaktncWZlL08wUVdsbzdV?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9517fa45-9109-441c-52ef-08dd49bf7e87
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 10:41:36.8760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBrMZnQUQJSLjrX0jsxQwRWqsNWRR22AxtGLYxI4qbthVlFl75zV045OQ8nuRTe8YA/8mEJBAyFnrSxpLKCDMyQDNZnKiYW+8BF7UEg7lWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8378
X-OriginatorOrg: intel.com

On 2/7/25 20:49, Tatyana Nikolova wrote:
> This patch series is based on 6.14-rc1 and includes both netdev and RDMA
> patches for ease of review. It can also be viewed here [1]. A shared pull
> request will be sent for patches 1-7 following review.
> 

[...]
TLDR of my mail: could be take 1st patch prior to the rest?

> V2 RFC series is at https://lwn.net/Articles/987141/.

code there was mostly the same, and noone commented, I bet due
to the sheer size of the series

>   58 files changed, 6693 insertions(+), 1137 deletions(-)


While it is very good to have a common cover letter and all the changes
available for inspection/cross reference, it is just too much for doing
a practical review.

I think it would be much easier to follow and split into multiple series
if we will apply the first patch, is that feasible now? (It was a no-no
back when there were no idpf at all, no it is not a theoretical case
anymore, and the patch makes code better anyway)?

The first patch:
Dave Ertman (1):
   iidc/ice/irdma: Update IDC to support multiple consumers

@Tatyana
The rest of the patches needs to go via our internal e1000 ML,
and get the Reviewed-by tag prior to being ready for wider review
(now the community would have to put substantial effor to get rid
of style distractions, etc, and, as we have seen, there was not
much eagerness to do that for your RFC v2).

