Return-Path: <linux-rdma+bounces-2713-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733EF8D5478
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 23:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD662844AC
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 21:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFEC183067;
	Thu, 30 May 2024 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fyR1mv3H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D501B181D19;
	Thu, 30 May 2024 21:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103722; cv=fail; b=DpWilIneqJnGIog/WJ4Ysi2tRJ3s9dIZM8PzdMoDT9H3DDpThXFUS1mqMu0biTp1A8PuzTdO4UWDPgLqNychupd8uLsLvOZdQgl72DJzk2oyfp1CsfUwhzwklKFMkeiU2XuL+L58q3hhJSLq/J83/nQ/uhTsEJLYRNromAfemIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103722; c=relaxed/simple;
	bh=JSt16f6jRE2+4jW9jsF3FVdHbfjI8JRM0T4YGYoMkAs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rkKBIsIT3m9z8ETPF/uq84/wSMRGSuhgVj4aqpBA96nn9IpoAq+VjxpWyoWETj2XkZmEHMGH6Vm5fYNUofgc4ORji348VcOcnKnlQqdhho4KpIAyrzX7Q4z0LY8kryYpv6v4H217eX9BGJeXmzzxDwZ2OicDzL/AIqcfvAYMNX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fyR1mv3H; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717103721; x=1748639721;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JSt16f6jRE2+4jW9jsF3FVdHbfjI8JRM0T4YGYoMkAs=;
  b=fyR1mv3HIqROqgYebqm8T6WfajGuoFu0hUt8SJ9b3xmePdassF/4IIdo
   MlYQUS/rpmojy1RkCZwIgfqvTWlJa6CnotlrFwtpfxDFHbX9t3sT/5ysm
   /L+7BD62zMzm7wKUbBWiTR21T0oVLE1lS6UbuaBD3M9BiqAHAk51G4kIv
   RH0s++1f+hRJMlzQZHuzFFhMGLNxzSMePI0yK3lzygbESUq+OT0q6p9ev
   VG4eXhWk5nFLYzH57u+o4U/vXpbcCsso85rolv1lb9yLlPeXpqxGs1cVR
   uZcnXqmhxc+U60GdL+886bRNhW3vzW9pENBqGywneX7ZGrP96AnYdGXAq
   Q==;
X-CSE-ConnectionGUID: CpjOwiFiT72xbLe4aQ2AaQ==
X-CSE-MsgGUID: QsDnA4djQqm03c+ya0AQIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13793211"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13793211"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 14:15:20 -0700
X-CSE-ConnectionGUID: gZ/+2vyOQAOHQM6l7fhjSA==
X-CSE-MsgGUID: 74LgtqBGQwGrdwmuuY2ifg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="66813900"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 14:15:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 14:15:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 14:15:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 14:15:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmLfTQY7yEUulDwkPZiOh9VN6Bv9t2K5mJluL5yHxocTxIlAjTPFXmbhIfEgtkchUkU5zGLucpIu30hv/2rSMfpeGLB3yzT1NElldF0NmpEF/iGAZSw99/0YBnEqNGor6FckVkxwBpCc37wgkf6mV/NRHXaG4VP6gdSp1L1cJqIFhk5neFS1wCigkcWrgtlhz701wWWEVpneufD7vU3ND4jvlTGU1gjV35KMYkqQ3p4MI6rhYPsWI5rVDbp40Jjy7SShBVqlSPiUqmpCstsXL8mWgl42NtjuZupFJ/MjaheyOaCAKkoHGZZ5CpDeddM8YEXBEf0jLi6Hc1jZyiNQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUF745tViKYcOZ0gjVO8SQcCAlRDVHoLZkQMqEBL2gU=;
 b=cOB2fu/5A/I3cwsHfxnt2ozuljumR1WUG/s5ytgZfamVm18jPA6YrOEPHQ+lTxbNOFZ0A2jzAT8GKgROSiobTK9acgYSQ3sYL4IzbuAAhudXPuASwCnQyraPudJSL+7nvow8myHpifbKdHEmOyrlU3AvzICxX+6m0OlHfYglH03pYmQL1CLyr13uGp9FK8igdUVQlu0ppHmfi16dm2rUrs3XqcnscoyD5xz1nRLSwBUktrOKZmgi7V/Dm1xfwvXGK/zUZ5Uxs8666JxR2cQdmq9b+4ZV11+WWw/CllBC9qnJqq8DzM53iE559jAG3C8CVZ8t/5EAB9NgdnAMo13shg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PR11MB8760.namprd11.prod.outlook.com (2603:10b6:0:4b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 21:15:16 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 21:15:16 +0000
Message-ID: <1f30da7f-59fb-4d43-9ef9-89573402cf4d@intel.com>
Date: Thu, 30 May 2024 14:15:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v3 1/2] net/mlx5e: Add helpers to calculate txq and
 ch idx
To: Joe Damato <jdamato@fastly.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <nalramli@fastly.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "open list:MELLANOX MLX5
 core VPI driver" <linux-rdma@vger.kernel.org>
References: <20240529031628.324117-1-jdamato@fastly.com>
 <20240529031628.324117-2-jdamato@fastly.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240529031628.324117-2-jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0232.namprd04.prod.outlook.com
 (2603:10b6:303:87::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PR11MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 276602f1-1e35-4eff-3e9a-08dc80ed9a76
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXQ0bE9IekhCQnNzK0gyM3hvQ3VtNXVUeUNkbDlXMTBLbEtWT3RBaUJIMVk1?=
 =?utf-8?B?cHBKeEVUTy96YUtVcC94Qmk4c0VBM3RJT3hGSTdyckhMejd3QlZzNFVjMjJH?=
 =?utf-8?B?L2RGYkVkTEc4VHZkc2l3V2MrQ3JjVEF2bXRmejlWUHFBZ081bWphKzc3TXo2?=
 =?utf-8?B?dUpZV1NFM3lNT1hjckZUdlREdW1ENGF0cWY2M2VQYVltVVRVOE5nQ1RRNksz?=
 =?utf-8?B?S1pXR0x6Z1RqbUNyd3NIcjhTQTJBazN1Q0FWaUF1V0pDdHdLbTJnTEFNcFl1?=
 =?utf-8?B?bDJNQnRnQWdXZC9Jb1NOZlU1UFZQM1RYeVNXa0xjRExvaGxaem1OTXF1dDhK?=
 =?utf-8?B?OG5wN3hVSmJodmVUL3o2eE5TaWlRU2c0S1pEamwrZXZDZ3ZQMElwMmxkUWNV?=
 =?utf-8?B?VFNkWkl5Z2JsZ3pyN2RrdWR5cWtrUEN2bHdZK3ZRRjVyWGFlbVViRmNxZTJR?=
 =?utf-8?B?NEpmWkpic1hFbEdadEdPM3ZKNW5uU2hjTXpQR24wMTFSVU1kRzlESjczWXlC?=
 =?utf-8?B?cHhHY01ET3ltQ3NRUGV0c01LeGtydWM4NXB6dWJGWkVkQmxRVHEvV2dTSS9v?=
 =?utf-8?B?d0U4MmdEdkZwN21haWRTVytUZlFIQld3THFJRnVCR01CNStYcVNSQ1k2K0d6?=
 =?utf-8?B?UDdYZjhVcXBXdm9qOWd2T0JmNENoWklFN1RMUGZEVTdYMEtKWjAxeC8vekNp?=
 =?utf-8?B?YzJVdGRScG81WXBycUFrK2hpcVc1UjV0YitmbjlQQUd5Q1Z0c1YzY3cwb1RX?=
 =?utf-8?B?ZjVDaEFlYTdYUHlKSGhiVVZ3TkNhNFRvNWZxUTViWU1BWEFjNVlFSll5Q0hH?=
 =?utf-8?B?OVRRa1J3bGovU3ZxT2tySEY5RjlpeHk3allJVDZrQ0xwN084TDQ3NWZVT3di?=
 =?utf-8?B?S0FRbGt5ZFBxT05DRkFDRk1BSklSbnJsYVh6MDF5OVRvNWU1S0Y3eGRSemdx?=
 =?utf-8?B?RG0wa0svYjhFK3VyS2hjYnBheDU4VXlxamQwWmRaejd2N0k4T242eWZjdld6?=
 =?utf-8?B?aGxieFI2ejVYditHc1lsY0RCMXJrWFQ0SjdqNno0YW9uTkphOVRtdTFwT21W?=
 =?utf-8?B?aUpsVnZid2RzRU5BcGg1bUw0WFNkTkgxMTF5MnJMK2x1RFFKV1V4cVZiSVFO?=
 =?utf-8?B?TzlUZmdJMFI4eU05cGYrdm01TmZIcklZWWZLYVU4K3gwejQ2QUhMVWo2b00z?=
 =?utf-8?B?RmZXUDJONHVFYjB3cWZGa3lSbGZrN3RxeEVTbmo4ZWg0UjdtcFdHOHFlekNN?=
 =?utf-8?B?QVlVbldFaEh6VEk5aGRBc2JYdjdqZWJ6Vi9LZmRwOXZHc0kvemZsSmUyZmRx?=
 =?utf-8?B?djgyaVYvd0lONll1Y2Q4VGZrYVc3R2YxQVQvL09tWXRwWm5XVm0wZkovWlRj?=
 =?utf-8?B?eDk4QWNrcEtaSEdGazRyYVRtNSt2aWh5K2pFZlBObGdFdmluNWo3SW1qN3A1?=
 =?utf-8?B?UjFRZVVza2xnM1BNWHZpNmhFd0JSbTFhc0RSdXd5b0tURU92bUhUcE9oYjJC?=
 =?utf-8?B?Qm5rZlBJcEZSYzBhNWwvMVJrTjdFaXhmUzVlOXJ3NHVPYWkzQys2dEI4UTJ6?=
 =?utf-8?B?cEZNYU1VWjlpZU15RkVzeEpzQnd5TUdwN1lhUGhCS0dNUzdJYVUrTE5GK1Y2?=
 =?utf-8?B?OUp1c3F3WXAyTlhCMGdLWm9KSnJhblhIMEVsMkVXcHhDTTZudFVsMkdGdG52?=
 =?utf-8?B?U3dGL01KZmNLY200UFA2SVdPa0J0NGRUekJxczBybXA4Umh3Z2lGdWd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1FjaGdDVUY2MGZuWkRsY1UwWGJZTDUzZXVYS1NRT3BKdzkraDROOGlwWjVn?=
 =?utf-8?B?cFVBYmZONWpHRWoxVlcwdmJ5QzR0WjY4L3M5ZnFINlExNUZqbjF0ODZla2h4?=
 =?utf-8?B?ak9Vdnd1WUJ6MVptVmdBZWV6cDJRS2JSZndOTVorcFh1cERoM2liMTBrUmJ3?=
 =?utf-8?B?UjZIY0xhaDJvdUZaWHFaT3FxSTBaaU1MaVY5UzVUcW1KeklTRms3UUhtQVRB?=
 =?utf-8?B?Tk41dU1oZk82ZFJQQlAya21FUDVINkl1OWtKaEpjbThWMGZUTGNsbDd3cDFL?=
 =?utf-8?B?YmhsZ0JOY3FCL3I0ZUx6cDlpNlRJTGM4ZVphZ2VNVDJCZnYxdmFjazhLTjFE?=
 =?utf-8?B?TDJLYitWbTMxY0tKbmRJSW5TM0hYOXdiR0FVVGdmLzdMRkRnUDZJOFlaelJL?=
 =?utf-8?B?M1MzY3VHNzF4WDArRktvVjFVblQwK3ZFZk5GTFBNYnlYSkN5T2lqc1V6RTVN?=
 =?utf-8?B?UzE0elpleHhXbVF3d01wRTY2L05MamlENkpLRndjdDB0MmVOczAwbUxUbmRV?=
 =?utf-8?B?dlFJK0x6VjRNbFZGREdGY2RGV3dPRnl1WEllcXIxTU9wZWZTdUxhM25RcnZH?=
 =?utf-8?B?NzZ4T0xKNXhiRWdpSC96V3JDVEQrV04yMWVQU2xkZ3RMdGNxYnl3U1VhemNi?=
 =?utf-8?B?S3dBbDljS21sdmJHd0Rqc3F3U2d6WjlrLzFoZG9TNHVDZllCMEpyNG42STd1?=
 =?utf-8?B?VldnYkd4VlhkQ2lVdDhURGxlT0ZDRjRudjdDS3M5Um42Vzl2dldSckZ1Ung1?=
 =?utf-8?B?aXQzdHRGWHc1MDZUSGR4cGFISnpLbytjUDA4VE0reXFwZzlPNXVBT1VTQnBp?=
 =?utf-8?B?UTBKanhFbnpuOXlvcFdSd0pyT0FUbGcyenZYbDJSZ3kzbTFsc0RXTU0yMnh2?=
 =?utf-8?B?OFJFRVdjSGJhUEtzY3A3dkE0Zk1GMFlpL0dkOWpWelA3UFU5Ylp5N2hFZUZ2?=
 =?utf-8?B?eWRQdmJxeVk3RElRazVaQlg3WlRETllieDVURHZHNkFKWnR6UzhSRWhMRWQw?=
 =?utf-8?B?NE05QUErM3BBRHkwdW83Wi9SRzZYTURpajQzdGtveUNFRzQ2K3NKL1ljVkM4?=
 =?utf-8?B?THNLVnFoQ2dGTlFmSXJiSEY0YzljOFplRGxURGV0L2dlbDBPZTVvT2h4ZnpL?=
 =?utf-8?B?bFgxalB0VktzOGNNR2ZQSlVSVHdGSjAycWhSZ1J0Mk5PeWlWWHFTaTNDMm80?=
 =?utf-8?B?VmRxaEk3MHpubGFSbHp0QkhsYW80ODBJdTkvTkhQNjJMeDA2K1hYZHFaN2dI?=
 =?utf-8?B?ejJhdTh3ZWQxKzVCUGI2YkVYaE1wRGYrOGdXNHJ2SXlJc2t1RmtoN01URi91?=
 =?utf-8?B?UTV2aDZ0RGVjV091OW5md25Sd3hlU3lkd2J6OFIwWlhQUmR0VFZQS0gwaDFG?=
 =?utf-8?B?Y05VWWxPOEtUY2d6NmFBYlB6TzA0aG1RZ3ZnVzZ0UjNUTkt1L2VxeGVycmJF?=
 =?utf-8?B?MURYY1R5Q1NEUCtUOU5OMGdwM2hmQnN6NURkUUdnVFpESFNOTHc1SG5oSXFx?=
 =?utf-8?B?TjFoNlVoTTJSNWMvbXFraDB1TitxazE3YUpoUEZiNHFja2dXVkppTWVYaEln?=
 =?utf-8?B?QjRRVkxxSzl5RjYwVzY5SUlQSTRBTzFTK29SWEJvNjRvWFk1U0pJUDNjWk5k?=
 =?utf-8?B?Z2FZK2RtcHNmbVRQUFRmb0x6Y0N3NXhaMndBVzV2SzRFdkdWdVBFNHBSOTF2?=
 =?utf-8?B?UXp4S1hoQVF6MTM2TnRjZ0NSUFIybzRhaGZ3WEJ4WEk2S1lRMk5INHprUGk3?=
 =?utf-8?B?VUEwaXg1dGh0eUpqUHA1dTFhbkM1Q1pEai9oaVl6NUdXREl5dmh3Q1JicFN6?=
 =?utf-8?B?VUlPQVUvQUNCRDNQWDhiL0thSXMybkpQY3FjSkpiVlhIN3Y1MEZGVDhZUTVi?=
 =?utf-8?B?MGh6M2dmc0JhMEMrbURDUFg0TEJGa2x6Vkp3M2JhUzFWTGQ4V3lyUitiV3ky?=
 =?utf-8?B?aGdidmxtOGR3cE1TdUwxdlJpb2dPZkd0b1NmTjkyRjl4K0hrMGFaSGZUaXVJ?=
 =?utf-8?B?NDRXbTlSTXFiMUZ3WW8yTzN3UHZ5TmdYVDdyNEVIeW5xMkg3OUdWUlFRRnEr?=
 =?utf-8?B?MGRMMmwyZGFRT0NlNG9wTUNkWnJKRjdYZnRNQVFZZkh0MEFvRS9pN3kzSEpM?=
 =?utf-8?B?VlpSSldlZ0NOQThFbU1DYklwUXJialFPMHpSZWlvVjNJaTViTURPcnhodHNp?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 276602f1-1e35-4eff-3e9a-08dc80ed9a76
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 21:15:16.7690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qgIbykkiOyXsDd0Wv/f23jQs3hzJClrl6E3OPpRG28Xf8VrdMGS75J6gaCa5APoy313A6Ye8lI8p03fJOZLt6OWx6b+38LbBVi5QQ56Gstw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8760
X-OriginatorOrg: intel.com



On 5/28/2024 8:16 PM, Joe Damato wrote:
> Add two helpers to:
> 
> 1. Compute the txq_ix given a channel and a tc offset (tc_to_txq_ix).
> 2. Compute the channel index and tc offset given a txq_ix
>    (txq_ix_to_chtc_ix).
> 
> The first helper, tc_to_txq_ix, is used in place of the mathematical
> expressionin mlx5e_open_sqs when txq_ix values are computed.
> 
> The second helper, txq_ix_to_chtc_ix, will be used in a following patch.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

