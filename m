Return-Path: <linux-rdma+bounces-9429-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04897A88CAE
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 22:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC68189B5E2
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 20:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4181DE2CB;
	Mon, 14 Apr 2025 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBrhxzTL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4FB1B0439;
	Mon, 14 Apr 2025 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660875; cv=fail; b=OkrS5Rwn87R0HzmsXHmQbUXNAts2fY7YBOjQh/orUIeb7/kvs19E1R9W6pM5bDC94LzJ8vnPGZ+wj0gxOLkb+ceW6bH/im8b8jrysxhCGZoA94nh/JyJ8/t+l5eymtnPwzOhyBBhGM6WJhPcBG/3LoBWBtJD2gMWnEofiNcQ5ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660875; c=relaxed/simple;
	bh=qlmJFm4NQxRdWOpCXL//nptG3qLFKbAavYgSIaQf/Eo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EY9+RJ9iCK2WqehwpdoyD7i4M/d4cgzPQaUKvgL+ttmkR3fP+3lyOnCo/dg+QnUN18CMWNE/n8Vfvyfcm8Y7igGtgmBd1EP4Mq78GRXuNOO/F15TBKhKGKnFjE9HXZLvq7jTwbPYWSOT5izeZ539By8XoSZEjBhuc/KZpVHxVYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBrhxzTL; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744660874; x=1776196874;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qlmJFm4NQxRdWOpCXL//nptG3qLFKbAavYgSIaQf/Eo=;
  b=RBrhxzTLfdY8H/8evsAmieR6lsmafe5g3WUV/MLwIxoazUMdHK2pNI1+
   3t9bOMjliA+dxLh+tS1U0UyFIjcwri1GYNdVv1Nib8s570kHyr0n0XWZ5
   Ic6ephYfKA4KuMI3M+JIbfDhf89hkDWHk/oa2k9ImNvXJ+QQhR6tJhlKi
   Dk7igIy2MObcvogaIaXbUnaKDMBZsWXCVcFRgLYOULv+x6GBPyK+XUUvb
   CK/rZPRkC903JDxZlxG2oEu39Gzq5LjXLS4310ZIuI9uytEul45i8VYg5
   bLfKRR0h833kAZRWn4Yv8+1BbMwDYDvBoHWUZO1uMBibQwGB6TDVkFLUa
   A==;
X-CSE-ConnectionGUID: r9gw4QRQQEyF185GUfHXTQ==
X-CSE-MsgGUID: dkmAVkR5TzqZgK03F7/91A==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="57530654"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="57530654"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 13:01:12 -0700
X-CSE-ConnectionGUID: CMevl54iR/qozTQdKYcIZQ==
X-CSE-MsgGUID: /C6+W57JTNW2B2DeVfN1bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="134684431"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 13:01:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Apr 2025 13:01:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 14 Apr 2025 13:01:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 14 Apr 2025 13:01:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydUjRhejvvN4/Oeq7cdhLcQYKV6K/wBTm/P6TdunBpt/dzeVsesrtGO0D0vu+k2oZzmM0Bv+NCW2tOq7aaCAKjvXzMDzU+DeUOMGrek5Mk/Jmrs+60cpugVYz7W+TIpuEt30hrhVkghGf3RWcOYLE9I8pR8cE5cHjrxBRmR3rDzSetnR2Nc6TzQaeIXxW4P6B/tFONYPyadsNCBySoJ+pONOBK659zgW44yDThrC47oULi5Xs+ElYoC5booYHacueRCsnCBp49+VZ2QOTpyEOvohw1c5TdP0QDzfJZlmeMOygsrT3ADf25Z3mrJv9UDDCtSzBHr8CyijqYDzp/ZHYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDsQtllDC8ALugdGUIGH/1ltrOsLNFYJb8jbZxgs+ek=;
 b=vw15wrFLxDbjRY9/DfKqgkEmiEsXhwUVRAeRtGofcxOPykROlXQnR6wNUdEUaCanX9CVaC66kvyqoLUzD98p/o4UkuvRa1pINHH3/5wrZCekV7XCKqGnn+HHJOb6yXUeEOHDsctgkuJsO9L+Y6eG28J+ZKWMS2jWHNpP6l64tiMPUh3zQHQ68P6hkCdql0bUzB59pBJMb/vef/E97xXkJoMKM2hXhxLUzKE2ue2vV7Y9ZOBKUZcfQr0BOkeMRv4FJkEAM2t2kCYBwy0DNvB+iZV+IzjlpAKHcckyFhBmp+qjrpMeIc6dHDMQ45SpTrzyKYehOvyKdWQyXjJiOxoolQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8466.namprd11.prod.outlook.com (2603:10b6:610:1ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 20:00:22 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 20:00:22 +0000
Message-ID: <53674f44-abee-4208-bc32-cb0eacf33a2d@intel.com>
Date: Mon, 14 Apr 2025 13:00:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: ptp: introduce .supported_extts_flags
 to ptp_clock_info
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, "Bryan Whitehead" <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Paul Barker <paul.barker.ct@bp.renesas.com>,
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Richard
 Cochran <richardcochran@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Andrei Botila
	<andrei.botila@oss.nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-rdma@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>
References: <20250408-jk-supported-perout-flags-v1-0-d2f8e3df64f3@intel.com>
 <20250408-jk-supported-perout-flags-v1-1-d2f8e3df64f3@intel.com>
 <20250411182044.0ee40963@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250411182044.0ee40963@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0180.namprd04.prod.outlook.com
 (2603:10b6:303:85::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd9c2b1-8e7b-4358-2104-08dd7b8efd6b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnJQcmRkclBNMjZmc25SQzBUM3pmNS93aWNoOGRCanRzT3FqSklnOUQrNnNJ?=
 =?utf-8?B?VUFSb2pKclZXK2E1Tnh4UEJiYUFVc0lpYitiaHlRdzJqblJ3OVVsajYxK1dz?=
 =?utf-8?B?TGxydS9zMG9HUC9NR0pHVVNWUEtrZld2UGRsRVEweGJuMXBmZUVHUjhGMW93?=
 =?utf-8?B?NVRsV0pmZnVwQXltc2k4UDFLKzM4Qk5hakJWS24rRUxSekZnUFQrdHl1d3Bi?=
 =?utf-8?B?c0cwNVc4N0o1WWk1MlRwUUo1c0x1ejNXUXFBeDBkTG5CWGsrZ2duL0lDeFd2?=
 =?utf-8?B?eHVzTHdhdTBEUzBzaS94OW1UTVA4N3lNaHF2Ym5KWVlvVEtNWk9Va2tTTkVl?=
 =?utf-8?B?K1JRenZwenV1NnVNNXhBdW5FWEtlNFplZ2ZWYndkWE1aNmxMTm1NbkhpU2g3?=
 =?utf-8?B?NGRsOERVV09kN0EzNkpNa0ZNdlhRUDNpZzliRkovdG11S29scXV5K0JuNHUz?=
 =?utf-8?B?alMzVVdtV1VhSERnS1ljc1Y1ZjNFSjlERllsZ3dLSEpUSnZueld1Ry9jMkx3?=
 =?utf-8?B?VUF1WVJESTByVWVvdUI2eFRxRGlhODZZYnh4Q1NWNWxpK016TFZ5Z043VWVu?=
 =?utf-8?B?c3pzazFxRG1Od2Q0cFhSVDJTUlhaY3N2bVMwTjc1Vk9DMkpTUjhEMktvWVhT?=
 =?utf-8?B?d3Fqdkl1ZWllUktGNGFOSWxnR3UzU0VMVkFSZEsvZGdtYnJrT3JaN3hEaUhT?=
 =?utf-8?B?dmFDc2NzQnRVSDRYSlJWK2oraVY4NE1CRktPcUtOWFBDRlU2ZjJHVEJPK2dy?=
 =?utf-8?B?N1I1d0J3dkRLZWVwYU9pbmdSYVhFTzNtTlh4anF6RHN6d0lWZVRoTkYvaE93?=
 =?utf-8?B?ZEFrR0w3UytGS2xhVXkvTFNrczlBbURyc2VvaHZ0T29QUk9IUFVIaHRzNi9E?=
 =?utf-8?B?b09iMUdqTWdtRmdMTFl1UkVzTFpVUVd1V09HdXVnU3JNdUswR1JyRm1uU0xl?=
 =?utf-8?B?ZUlYVS95bnltUmtFVzlpMTFiWWtVSXMwaWpVMWhGdDdvbldLdnFtcHkyUUR5?=
 =?utf-8?B?Tmk0dHRhbS9zenEyRGRRWW1pcVdlZXVGR1FVNEowYlBwcElER2JWQTR1WTND?=
 =?utf-8?B?TWlnSGtFZ09aZzZLb05nbWhDWkZ2ZHViT245TmxJR0VMTzhuM0NINytUV2pY?=
 =?utf-8?B?WW1OR0ZBZjFDSGsrd1RhU0pRbUZGb3NtWVJ0WkNnSnFFSWZJUHlKSjEvRHJl?=
 =?utf-8?B?N0QvSHR2WFA3U1Jyb2wvbXlrYkxvck44UHdFd21KYlhmQmtSYnh4NWpyK0hW?=
 =?utf-8?B?TkIxbEs3VG1yT3BQVDFIT01WbkNjTkdjS3QrVEgwcjJKQkpKOEZxaWNMUE1S?=
 =?utf-8?B?RVlMblpROStVa1NBRFBHbmNVOVpDWklFeTVDNWk4eXUxUStDR3hyeWNLcDRD?=
 =?utf-8?B?ZU1sZyt1M2E0LzREN3BDdUZ0QW1WSnZmUmt5WjFpMXIzcFlQSVNKc3NadmNz?=
 =?utf-8?B?aHh2ZXZ6TXdYL3lEUVlyU1NoUVFlQmdHOFEra0QzSE81MDlKMWlQL1o1VTBa?=
 =?utf-8?B?RkdicHFTVlUzcURMQjJyVHZmQWI2NzN2ZitMaFUrRm9USlFOQlFtT3FlUDQ5?=
 =?utf-8?B?WjRibkRSVDV3aG5qYWk1WTBlNXBidUc5c1V5MWxOTWMzVjhwSU1jYWV6RjRV?=
 =?utf-8?B?eDBQNmttbWFxcG9wc3o0VmFROG5iaVJNak80cTk5S3NROG5xdkRTQ2FsZ0Mz?=
 =?utf-8?B?VjFWRFpsMVVWczJ5NTh1dXhnSWd2bTd2MW01QTUrbjA3ZjYrblJNYUNybndq?=
 =?utf-8?B?SnZSZThMSkZZbDhsMHlHQ0FDenBHZ2NSNE5OQmdnaXpwTHk1S29lK3B4enRS?=
 =?utf-8?B?ajRhb3JDZDE0OTVMeDJsbmpFWGlzcGlSSk9UVzdrYjJxVXFvWnhTOTA0eTlP?=
 =?utf-8?B?NlBybmoxc0NiNUhIRlUyV2NhSmJYaDYzYWM2aStUL1hIVm5MYjBtVFp5aHYv?=
 =?utf-8?Q?k1YFWO5Sr78=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzJUQ1hZNWVXWnRvUUxkRkszSW9ZUHVoRm1Zd09weC8zMEo0TXQ3NVpVaVk2?=
 =?utf-8?B?azJFWElmaEVMVjBTNVg5Q2luNVVhQldGNlZNTkg4RjFUbDR1aWhjSXBpZDQz?=
 =?utf-8?B?YkxmSEdSVHF2WXlhUUFTNlhTeUtTL3NBQ28yWVpTNHBFd0owWFRwYUVRNHhu?=
 =?utf-8?B?cnJMVGtyUXBUUkVtaGF2cXlNSmcyWlBKNDRFL3I4MUNaMVJ3V3NHVzZWUzlN?=
 =?utf-8?B?VTFtK3Z4eXEwNWQwYUN3TUpscG5XdTVWM1ZQOWdNaEpKNTRSY3RkV281M2c2?=
 =?utf-8?B?Z2grL05UdFBweDV3c1NrS1JGaDJOUlo0WnVweVFWalNkbTNodFNjNFcrMUcw?=
 =?utf-8?B?c1RuNFc5U0hleDJ5SngrZGlhVzNmanRPbUJ6WHpBZTJEeEVHZUZrRVhuQ0FX?=
 =?utf-8?B?cFpzYUdpNVBiUnlNSjFNOHRhc2JCVDBCQ3FsakFXejhmVk1WWVlHV0xaUldY?=
 =?utf-8?B?RFp2SFVXMXY4QlU2QTJYd21pc3dTTnMrZjMyb29YTVJvN0laZTh3TkZDUkJW?=
 =?utf-8?B?UXNsUGg2MXRVTW15ZmxjemdxV3pZNmtqeDE4T3UyMm1qOW1XazAydTYvNEFI?=
 =?utf-8?B?MmJPbHlHaGRUSWdnUnlPdzAydUhNOVVEVURPcnhNcGtSS3I2SjhVNTArcy81?=
 =?utf-8?B?d0tLTEhtNjNSWUc4UDVTSUc3bmJ2b0NtbXV5VjJNZm5SNEVEQ0VrandMSTVL?=
 =?utf-8?B?SzVEQTNhQlc0SG9KdXZwcmY2RFBVZGJjL2FJVWxaZVF0eW9LQ0gwODQ4UTVo?=
 =?utf-8?B?ZFc4TkxvVG1rZ0dUc255eWsvWEVHQjljbTR3UDJNZW1lc1lVelRNUThNek03?=
 =?utf-8?B?bHhPUkhZaVErT0ttVERsMUhyWGRVY3NQck5MRll3YkwzMlF2aUxPUVRKd2NC?=
 =?utf-8?B?bldndHNkZXZuSVhzVm5iNHF0Q2xmRGg4bE8zMTNkS3JSZDNTODJmQ2w4TFl6?=
 =?utf-8?B?WUVKcnFITjRRZW9ueUROZDRtTDZKWFRIOWJxU0dmd3R6WEREYVRYZmVhb2kw?=
 =?utf-8?B?WHhEeWdEZ3RVclBBdWVIbHoyR2dzK1lBSUZDRVhhMlM4UkYxdHJ0Z0lkNm4v?=
 =?utf-8?B?NURsVlVtTGIwTGVIVGFjaDdlTGJIcEROelhTKzY5WkxMWHhIUGM0cU1wazNT?=
 =?utf-8?B?OUViZGFCaDFWb3U4Z1RKM1ZzUENzVmwxNW9Ka3VXdzZ2QTY2dkNSbWZ6SkFl?=
 =?utf-8?B?MEM4ZEpWYUtwL2wvNUREWFlKSUhEdnZGeWhRSVU1enM1RGxNai9FQW1BdUxE?=
 =?utf-8?B?Q2VLVzhTRWpqRlJZUjl5VDc1S0NpSGlUYTFRbWgwd0NuSVA5Z2dLbm9mQk9m?=
 =?utf-8?B?aEtMMm9sK3hVKy9kVm1QdG5od1hvZ0w4U3BsTDFoQmUwU1BjR3VLWkVXRzhu?=
 =?utf-8?B?T09xVFJzVzFBdFlWTVVpRUNVdHNEdkZyWXhLUWJLcDUzK1lFQnhEeWNQTmpQ?=
 =?utf-8?B?eVRpcjR3VnRubEFOQ3BrcGFTcWxmTFZPTGYveVlzZjVvNTVhSlZpV04yMVdy?=
 =?utf-8?B?WGJnT2lKS002bGRXcDBYcVRGSnFjZFZyMHNDRHdDMW1aSkRPb2dGU1RmUjVs?=
 =?utf-8?B?ZFNiSzZnVVBlU2pac3pKT2l4RStobG5IUWI2djF6R3dVS2xTOHlqZjVKb3VF?=
 =?utf-8?B?b2tMVC9PMW8zbUJmdEFibWxmYjRNeDNraDlDSmJORSt5V2VoU2JHRmpJZXhz?=
 =?utf-8?B?MGE5aVJxemc5bzBhL3JGdFZRSVp3ZmZ6Sk5jM2hxenJaOTF2ekIzbDZzdFdH?=
 =?utf-8?B?azYzczJtZXNVajRTMnlqOFo1ckJFZVlrTVpIUUVHd0g4cEpmZ3RwTHNYazV4?=
 =?utf-8?B?akcxaHlwUzZsNFpVbk9QV2dxdHdXZVpnRjFoM0FsS2t2RVVGbGh3MWpBMzdU?=
 =?utf-8?B?NEFDYkNURXorRWwwUzNOLzZNTjZrU3ZKOU5UZDJkN0VKU0hiSVIwaGQ1MEJl?=
 =?utf-8?B?a1dkYWFTbHpYd1QvdWJIMTVvcElFamgyRlZjcmxXUjhCb0lUQkRodEk0aC9X?=
 =?utf-8?B?TGxHNDUxeGhsVWczMm1EanQrVVF5Qy9iNy9UL2lIZ3BhUkNQcmlMbnFtS1R1?=
 =?utf-8?B?L04xdzFtY3FBS29GLy9Xd0pFWDcxMitrNHFnanVRL0lLMXZacXI3bVg4WDJi?=
 =?utf-8?B?clhYY2E4ZGZkT0Y2cXlHMjRMejRDd2lxTXhzamtpUFE3R2hyY2ZLYWx4TkVX?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd9c2b1-8e7b-4358-2104-08dd7b8efd6b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 20:00:22.5669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIanVW/2qpMR14BDtjbKdyUyMXxhp4X9Wl2FcZPHj1lRYveAqJl6izVQQVLdPuzNH0JGFxYIaIb4JVamTsfXHGD5ko1e64ULwlca6Kxdx0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8466
X-OriginatorOrg: intel.com



On 4/11/2025 6:20 PM, Jakub Kicinski wrote:
> Sorry for the late nit but the conversion is pretty inconsistent..
> 
> On Tue, 08 Apr 2025 13:55:14 -0700 Jacob Keller wrote:

8<--

>> @@ -1378,6 +1368,8 @@ void igb_ptp_init(struct igb_adapter *adapter)
>>  		adapter->ptp_caps.n_ext_ts = IGB_N_EXTTS;
>>  		adapter->ptp_caps.n_per_out = IGB_N_PEROUT;
>>  		adapter->ptp_caps.n_pins = IGB_N_SDP;
>> +		adapter->ptp_caps.supported_extts_flags = PTP_EXTTS_EDGES |
>> +							  PTP_STRICT_FLAGS;
> 
> sometimes you both drop the enabled and combine the edges 
> 
>>  		adapter->ptp_caps.pps = 1;
>>  		adapter->ptp_caps.pin_config = adapter->sdp_config;
>>  		adapter->ptp_caps.adjfine = igb_ptp_adjfine_82580;
> 
> No preference which version you pick but shouldn't we go with one?
> Or is this on purpose to show we have no preference?

It wasn't on purpose. Honestly not sure how they ended up different. I
think the right thing is:

a) drop the ENABLE since we always accept that regardless of whether its
in supported_extts_flags

b) don't use PTP_EXTTS_EDGES in the supported flags, since its easier to
see which specific flags are supported if you aren't having to remember
that the macro means multiple flags.

I'll update in a v2 to be consistent.

Thanks,
Jake

