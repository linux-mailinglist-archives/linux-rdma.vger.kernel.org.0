Return-Path: <linux-rdma+bounces-2709-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6742C8D5450
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 23:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0B31C24B99
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 21:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68919181315;
	Thu, 30 May 2024 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9v4WBS8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9FB65E20;
	Thu, 30 May 2024 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103347; cv=fail; b=IzPqQ1QiDCy100plcuN3MXkolJpx8+6PSBlWlO9VB0Kn0reKd/hk0ORzbnnP0IqwgxkZeUhtMPzDmGr++OyeDZ7S2DeLti2efPw7AWkhuOAW1RYI4b/+JmS7oglQZvhyRJraz5qLtdGAFt3kw2Uo4IaR8wiJPROFT7WNZ4Z0B1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103347; c=relaxed/simple;
	bh=8GXMJbNp82j02GAUVpFIVFN3qPSIQz6zezfBpO1KT00=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NAJJBUAERoJViYSZSGV98hfhX4wA205VyBgYp2x39LVCnQ5nsyVIOC5wF5lEv3QD9VWOH/BOCE10TZqRuLulsqO8oKJKMIXtMh+qMqWQ6cPFMyJysEf4ruwEtTrsacuZiS/GQR4Se+TkOWEak43TcJDCz+Et6/Wl69w/uj8wsik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9v4WBS8; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717103345; x=1748639345;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8GXMJbNp82j02GAUVpFIVFN3qPSIQz6zezfBpO1KT00=;
  b=K9v4WBS8DBI8EE4TVf2iq3d1hr7texI4pY9Bum8ZzFt6BNamQV8vrLSd
   b5/CGdnwqnNo2k8/7b+HAf6PWmnGUjZpI1PlVqsZxBZDgmHYxYb8TFUG8
   xnnQ1eL1WyDw3hbD+S/v285DoACewh7dzWYF1sonmLBqk+iP7+t0S5kVy
   iC/55E8jnp4DdnckSYkIIhhSLFDy7UHGacjCgUToisqEX/zZ6amd6Yo2P
   8kJzlK3w08Auf24HjP1xOxxMpUp9kfETeFEKsu15XF4gZVSJ7pX6QW/eB
   +t6liezs4wvJKV1qCSn3sbFEkwUbCrRcekPueE6D0AAoLQT1IGHUboGb8
   A==;
X-CSE-ConnectionGUID: UR/QJCHiSleBOfpF4V0XoA==
X-CSE-MsgGUID: ZP3oN+DSSfOJ1gOO1v0TIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13444738"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13444738"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 14:09:04 -0700
X-CSE-ConnectionGUID: nLQMz1tSQPegiteO07FjnQ==
X-CSE-MsgGUID: UFsUsdeiS46eyFuF+UxgoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36524445"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 14:09:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 14:09:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 14:09:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 14:09:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnqLe/LHOJ9cX2w7kOuj8pnpx4YsTogqrEB1wcb+W6whtgkSZwWrMeU8E2advd/BNW5bvjJznV2bhidEswVsmvMaIaG9/7AyjdhiCxtLBkcSqwVCBFlEkbjbBp/Mn7YcpBEZcJpq2fqFqfLA3DOq1r/778/2A8msnYmN43vTfNTUsnWXTp9uVL3kdoCq3z9aQuo/IRMOsghI0UgGzNe5H5v/v76jpz/m6NyJN+4IWahcbeGXWT29UTDC5INltex9G+XDsAngNn9pt/dMjstZKBnzfX73pGBgISPO9uTeBeg9diHrTDbwka7YC+g1g2wv4G3tsCJYj46lA/2DctPEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J25clJZUo6nzEj6d0+cOadVhfK4PLLMApfJqCrrmHyI=;
 b=UrPGBoFoDFSBW9CgLC7GN8GepCjsKsEoYxjlHUC3WkkVOVAOJDNOaYIojn/ayAT+6ebaOqhOOggxWkbFCLE3krwby11PsMjDmVlvS7FKK1kjEj83D6dyB8LnnNofkn62hYN+fww7t2fQdhvmIYdvmzkLbVsY65oI6A3cW5ce3alrYFG/nGUxulJWEGqnVucpbEHTtGVxVAoYv217ckhET7CyRFMDFAi/X6FVMyqPHXLqgwLEZI3SJLKJA4xhHatmKjWjVjf5bKoxGXTlbJ8kBv2nMbdjN94kZu22Z8uPc5xa3sm9mtgirQK3mmr2SuEx8IGtgpvmCXB00vxF/8d59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PR11MB8760.namprd11.prod.outlook.com (2603:10b6:0:4b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 21:09:00 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 21:09:00 +0000
Message-ID: <e1efc17f-e4a9-4952-9ad0-7671b72fd37c@intel.com>
Date: Thu, 30 May 2024 14:08:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/3] net/mlx4: Track RX allocation failures in
 a stat
To: Joe Damato <jdamato@fastly.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <nalramli@fastly.com>, <mkarsten@uwaterloo.ca>, Tariq Toukan
	<tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "open list:MELLANOX MLX4 core VPI driver"
	<linux-rdma@vger.kernel.org>
References: <20240528181139.515070-1-jdamato@fastly.com>
 <20240528181139.515070-2-jdamato@fastly.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240528181139.515070-2-jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:303:86::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PR11MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 95804aca-6b6a-4327-627a-08dc80ecba34
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnVYM3BvdmpHK2ZBM1J1NFZLWWo2T3dDd1VMeU1CL0J4NTN1cEJsVDFYQ3VM?=
 =?utf-8?B?aHZ5S01ORTBiNUN1YmJNUW5Yd3NrQUtuanpJMHBRdmM3NWJVUkFnMzFEZmZ6?=
 =?utf-8?B?SjF1ZUlDeHZjRE9mMjBGS0YvZXBqeWlQdEJPNTVneHIyVHM1Z0JjRDdhb1h5?=
 =?utf-8?B?SXRaZUJEby9TcnJaMmErRWFIdTZMT0Ird2RDODFRbktnazM1SndaZkhMUTlG?=
 =?utf-8?B?ZWtmZE0rcXJ3ako5am9Vakdzd0FFbUE0OTRiSjJCN1NnRGF4ZVBXUmNRaDNt?=
 =?utf-8?B?VTY4d0czRGp3OFdUd2N6R1FDQm9nQmt3MThBYXBHK3A1U0MwaGxWSFl0UFNS?=
 =?utf-8?B?Mm40S1h1Nlkyc1JGY0s2Z2JESk9aYVpWYnZlVmxqeUpOdGdzdTU4VllsMkgw?=
 =?utf-8?B?a0pDWHNKeDRUWDFFMnBORDlmRGxpZCtFdXQwWmtrY2o5UCtNL1FITmlrZVZG?=
 =?utf-8?B?Z1hRUzhuZWg0L1N4TVVqc1NZeUhjZlJjQjVNK3B4ZWJ2QkNRTnNDa1NQS1NS?=
 =?utf-8?B?RCtVM3NESE44UVFSN3cvcklkQUZKSUNZWk8xM0Q0UTEyMEpKUFlsVzdTQUQ4?=
 =?utf-8?B?ZVFhY2ZSK3JubUk0cThDVXIvYVNBeHlYaHFhS0U5Rk1BZE9HRmFnY0h1b2J6?=
 =?utf-8?B?bjlSdUlMRmdzei8rb09GOXN2NG4yeUVMZW03QmxyRzhJQUVrdTJkWTVMNjNr?=
 =?utf-8?B?UGRSRU1FVG9QM05XaFUyV1FER0d0OW5pa0FHdHdrZ3M1eTBkdy9XTUJ0aDFl?=
 =?utf-8?B?YjdYZDFUVElTb25PaDlIdmc2a0w5MUVwemxVSnNad3lidmdBT0VCUFM2QTFC?=
 =?utf-8?B?S3JJYmpoeVdGejRiMFNJZUFET0o5ZjEvZVF1d1FkRnp3QkxkV05CRzVvdWRh?=
 =?utf-8?B?WklPWEh5YU9hUnlYTmRkNVFZZ052WSt1cHo1bmlKMks2SFFKWksxWjh1dGpy?=
 =?utf-8?B?aWIvMEluT2V1UkVDZEpLTDRBbXY1VUh0ZlhrRUVQL3BJcGFsQkpQdnl0WXdn?=
 =?utf-8?B?V2gzeWN0REs5KzJ5NEpvdHRxbnB3RVg0T1paQi83WGNQa29Dazk1eS84cVFy?=
 =?utf-8?B?Yi9iY0VUbm9ldE1NTDg1R1B4azl6RGZ5Wmd0ZWVSS0xVZ3J0THpYcVQ3K2Rl?=
 =?utf-8?B?RUhnY0dOVXpZT0FxM04vM2ZWTWpQM1RDRkRSeEVIZkgzV1R4L3U5TEFtVHFW?=
 =?utf-8?B?WUcwcVhtTVJHbmFYVEwzMDYvQmZpaUNabUYrSHFHQzExUm04YmozaGNqL2pJ?=
 =?utf-8?B?Um9vaHI3YmNvU0JyZldmd3J4d2ZRYnFqNXJuRTd6amJlenNQd1ZodnEvUnAx?=
 =?utf-8?B?cG8zVUFCNGovaE9hajFoZS82c2ZlY2tTOGRSMUl4RGdIeFRKbkNpQnJrM3dS?=
 =?utf-8?B?a2xhSnNtNk1XMmY3b1BQWGNNQXJKTVZ5Q0dDb3o5cm44RzZwdFZBNnE4RFVq?=
 =?utf-8?B?NXZ4YmJTWXF2SjBEWVUrY0daa2hNOTdaRXpTMGR0Ny9nMDZUeDcyZWNnSjlp?=
 =?utf-8?B?enhrOUo5SmwzeHhhMjgyK0dBZWxRck5HL2MreVBzSWpvRnRSVVVFSFdZMWU3?=
 =?utf-8?B?SEF5eDY2T0ZOQ2NMaUYyY29XKzFsNU1zVnhTZno2eVQwZkxPcEdiNUhmZE9o?=
 =?utf-8?B?TkN5bHlxTloveENzTTgvRGZoQnc1L21XNHRYZVJnaFEzMXh5ZnNvS2E5Skk3?=
 =?utf-8?B?YVR1MlVTeG15NVlFQ3Q3SWVLa2pHZDJyR0NkSW4rTnF2d0tiMWdxdkd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0M0OGQ1UzhOY2ZrbDZ5ZWRSTFZHSDI0TEFtS1p1dkJyeXdQUmoyaEM5dDQ2?=
 =?utf-8?B?MXhaZ0dBVFNrZlliYS9TQUY5QVlrYXk1dFExS2NMVGo1VVQxN3ZNVXNiWmF5?=
 =?utf-8?B?ZGZlSXpYK2FDMWZnWjFlWHlqdUxRM0d6ODA2QW5UWTV5a0x0elJUT1dVVGlY?=
 =?utf-8?B?WVV6cWZUdXRBVlBydWc3RVQ1QlNkK0RNSDI2L2dXWVBBVTdkSURUTU4wMFFI?=
 =?utf-8?B?RytDRE14cnRSZTRGa25mWDFjaWQweXU4Q3I1eWIzMG1hNXI0SHBaQmFHYXEy?=
 =?utf-8?B?alg3ZTV5OVdkREZsMGVlTnFnaXZKMVFuSzF2YkJJQ0JpK1Jxc1MyQ3V3TURo?=
 =?utf-8?B?elo0ekJPZ2JRNHVLeGhZZWd1dXN1SnF0VjM3RHNYSllDb2xvbHVrN1RCN2ZK?=
 =?utf-8?B?SGJvQm4xZU5Dc3JTVEdyODNIVWpMNHJYd2dQUWFLS0gya3J3dDNiSFJOUUJD?=
 =?utf-8?B?Ty9RUWx0STJQeG9HWkdRRUQ4czZyVERvTyt6SnI4WllkZ1RwWHlwMkpHOTJR?=
 =?utf-8?B?dGZBZEp0ZnFtNjdCZ2VPN3BjN2NEOFpwMFRjRzFYMGlQQjEzdWZlT3hjTTdQ?=
 =?utf-8?B?WTFBUThrOFBGQXQ5bVlsN0N4SWZseDhDcVdSdVRnTVpyS3ozSUNqY2ovOVBq?=
 =?utf-8?B?anBVaWdBYWQvNExmSDNhRkZ2bDBWM29EUnJGSko1VGd6WVVwdko1MUZoZjBh?=
 =?utf-8?B?N1pFb3FPaXFhS0xaMC9UdUpYSEt3RzNOcFV5VDJRaXZta2d5YWNOa3FFLzl5?=
 =?utf-8?B?NFdrdzF3bWY0QnVyRDI0SDNGNVAyTmNxbjI1OVpleXAxMTN0ZHd6WVQwWVc0?=
 =?utf-8?B?QnJlMnBaZElBc094NHFKLytiV3J5VnBrb1dHK1o1SGh6WThHTzU1d0JPY0VE?=
 =?utf-8?B?S0FuZnRNampVRWFidlB3aXJNNVdQRTZYYTRWbVppU3dVbFNUcEZZQ0xyNHRK?=
 =?utf-8?B?c0hZOXh5cTBnZDlsWE5FWENRSkNaQUNFNEIrWmRDWFJSUUhxWUFIaVdQaVZz?=
 =?utf-8?B?Vy9EaEhCbHVnbWRSWGtXdGtnbU95T1gvSG45Rzg3ZGJqMEx2TE1aT1djR2I5?=
 =?utf-8?B?dGtLZ1YybHBEamNCR3EvSkN4L1V0RGVnMEJFcm10dTJXNWdtV1lPa2hlejEy?=
 =?utf-8?B?dWl0Y3RubEwvSzdmNVNLeitLQ0pJcUdXdjJkYjRiYWF6YVMxNzNjUGozeFh0?=
 =?utf-8?B?VW9waFE4M2xHZFZheEthRjBoYk5OSTZwd3hIWVFhL2RjNkRuaERjYnNyOW16?=
 =?utf-8?B?dG5GbTcwTWFxVDgwOGpITjUvdWVXZFA3MDEySFpFUzVhZWF3bVh3RTRZUmJP?=
 =?utf-8?B?b0JwNTY0ZWJsTXA1Yk9WTEVldWkzVFdGQTZYKzZqek56MDNHR3F2NXZkL0ho?=
 =?utf-8?B?WERGd1BoSDk1NDdtZmFoY3JhclRlZ2NtcGZCSlJxVjZtVkJQZ2JnL2tNNEt0?=
 =?utf-8?B?QjB4YW9TTFU3RUpGdlpqMUtYWlE4UWRXVk14UFR4RnlIeC9GMkNrTzNaejEv?=
 =?utf-8?B?UHpEampRVy9MZWF5QkJaN0c5cjJWU1RZL3BXcVpLWkdaK3J0cnRyVlQ2Skh5?=
 =?utf-8?B?djdOZGlpWHF5OGRydmQ2QVdod2RQK0pXa2d5SzIyQnBRbFpZUTI0NkhNVnoz?=
 =?utf-8?B?Z2x5ZGsxbXdKRWVNV2N1QkRUaFpMM005VE1ONjU0VDJKRVBMbkJkUlRMVFg5?=
 =?utf-8?B?M2xBMGg5SkNjVnIvSncyQWg1eXBFSUFNRldZVldnelllbnh6K0xKZzVrVjJi?=
 =?utf-8?B?VGNlYkY2WStUcFpiZis3M2xKcEplQmFKRGErZDNuVFNtV3YyYlVuay9iOFRD?=
 =?utf-8?B?SlNzYmwzSFpERzVOYjFhYS9LeVhXZVhYd2ZXa1ZZV1BuTGhZUDF6N1NzMjhp?=
 =?utf-8?B?K25aU2RLS3JoZ1E1YngwOXZEZnMyak9DTEUvMEl0NlpmRlZYSW5uNUhmdFI1?=
 =?utf-8?B?OEhCd1JBUXVMUlUyK3hHa1NLTVV1UVVaUG43Rml6bDRTOSt5OFFIaldMNndN?=
 =?utf-8?B?QWdFNnNYQU1vTHpXQ2RIcjBESVc2UjRqOE9TRGFZcjlpc2dxZThEeVhEcXdO?=
 =?utf-8?B?WUJMRitOcy9nMzhKNHdGc2JPN2FaQ3VYZWZjcHpCN0dFTWRkN1Zua1ltSkZm?=
 =?utf-8?B?Wk9kUTBjZDArNkQ2bWF5bGxhbTFwQkVKVk52R0QyeEs3T2pPaklCL0h6WXFM?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95804aca-6b6a-4327-627a-08dc80ecba34
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 21:09:00.5658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lViZkB+hXDxPgPiQ6GAvwRIRzl2GWrEof03CHwT0JeOU5zKOt/KKJylk6ZYqNlMftd+MEWieIthqM5/EjYla8e+5dWWVyYK2YjQbmoYRHkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8760
X-OriginatorOrg: intel.com



On 5/28/2024 11:11 AM, Joe Damato wrote:
> mlx4_en_alloc_frags currently returns -ENOMEM when mlx4_alloc_page
> fails but does not increment a stat field when this occurs.
> 
> A new field called alloc_fail has been added to struct mlx4_en_rx_ring
> which is now incremented in mlx4_en_rx_ring when -ENOMEM occurs.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 1 +
>  drivers/net/ethernet/mellanox/mlx4/en_rx.c     | 4 +++-
>  drivers/net/ethernet/mellanox/mlx4/mlx4_en.h   | 1 +
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> index 4c089cfa027a..4d2f8c458346 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> @@ -2073,6 +2073,7 @@ static void mlx4_en_clear_stats(struct net_device *dev)
>  		priv->rx_ring[i]->csum_ok = 0;
>  		priv->rx_ring[i]->csum_none = 0;
>  		priv->rx_ring[i]->csum_complete = 0;
> +		priv->rx_ring[i]->alloc_fail = 0;
>  	}
>  }
>  
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> index 8328df8645d5..15c57e9517e9 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> @@ -82,8 +82,10 @@ static int mlx4_en_alloc_frags(struct mlx4_en_priv *priv,
>  
>  	for (i = 0; i < priv->num_frags; i++, frags++) {
>  		if (!frags->page) {
> -			if (mlx4_alloc_page(priv, frags, gfp))
> +			if (mlx4_alloc_page(priv, frags, gfp)) {
> +				ring->alloc_fail++;
>  				return -ENOMEM;
> +			}
>  			ring->rx_alloc_pages++;
>  		}
>  		rx_desc->data[i].addr = cpu_to_be64(frags->dma +
> diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> index efe3f97b874f..cd70df22724b 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> +++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> @@ -355,6 +355,7 @@ struct mlx4_en_rx_ring {
>  	unsigned long xdp_tx;
>  	unsigned long xdp_tx_full;
>  	unsigned long dropped;
> +	unsigned long alloc_fail;
>  	int hwtstamp_rx_filter;
>  	cpumask_var_t affinity_mask;
>  	struct xdp_rxq_info xdp_rxq;

This patch does not appear to extend either a netdev, ethtool, devlink,
or any other interface to report this new counter.

How is a user supposed to obtain this information from the driver?

