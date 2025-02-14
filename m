Return-Path: <linux-rdma+bounces-7774-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8754A36670
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 20:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4851676C6
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 19:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D04E1A8F63;
	Fri, 14 Feb 2025 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ERFiGPWp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B4718CC1C;
	Fri, 14 Feb 2025 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562502; cv=fail; b=FEoPPr0hPrau/WLOximEIb4f00FcpIRLBl7o6Oz68XMZ2QgEcdhkqZh8wos4/qw0G3aS5DcfFn9zu/tdfwnrEOKkhWdsWoAC4olK3aRdK51ssqzdYQeRNYRvLYDn/K2yZxcMFCbguQlccEG705n8p5GgQooaR5xc4O7+RDvMaI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562502; c=relaxed/simple;
	bh=Vn0Gw8/lqqrj+r8jLG/tPaDs/Y4Ls60p3Qk/hqqOnHY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LYYLZUDLgayavkTUqrJMBUY4awOActO91ADyQ8waf+24ZAG+F1iCfLGQEWLfVQjaA+xUgvNLxWrIfP9Jd2vHKZccctCiRPTujRR1wXIS5qrEmwDBbrpa4kEk7wqahSFjIimONqyQEId1kXfb3nVNNlLA5FP00HuOnFlwg9BUdkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ERFiGPWp; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739562500; x=1771098500;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vn0Gw8/lqqrj+r8jLG/tPaDs/Y4Ls60p3Qk/hqqOnHY=;
  b=ERFiGPWpkaaPeYxgdhWL9uv1ysunKg+hFKneboXzF4E+bEaJjFIVVCGY
   1Aqi+b6DsvGc9YARnsr76w9VGsZ01bwIy5U4RRn+6u7OrJCPtxnKlwy2i
   wH787k59nrFrWEFxHVhmxWdIY7rJZIUOnpvqqYIL229L4syvKlyDcNO/X
   h23yavi7fdvwDeFsHM2/Oj8CN4FGt0egs5bnvREeAKVXLVjrFOyiYHbtv
   uezpx8SGLQYuNyUWU5HC5ulL5/O+ubOl4Q6JLHgto4ebO1OtkcWHvPlHh
   7Vn8rVrKLyg1/WyRkJbZhHurh1CQAmMQYsIqkBwNKwTBMWy0ABZPCPv4C
   g==;
X-CSE-ConnectionGUID: qtwwEPc7TeGP0uWU+jui3w==
X-CSE-MsgGUID: 40jbPLo7TReYRd/WwZwVqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="50967719"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="50967719"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 11:47:44 -0800
X-CSE-ConnectionGUID: WnJmDk26TlSp6TdF2Qs00Q==
X-CSE-MsgGUID: RnV5YurIQPmytDy8J3Pm0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="113271800"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2025 11:47:44 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Feb 2025 11:47:43 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Feb 2025 11:47:43 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 11:47:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYblK972t+73P2EhAJYOvKWNuV5A2h0ctrrqSqShWkR4s68jH4VJ5zSbpmUvuK6BzYq1QB6An2GDrZ58jwIixmcFbWcKn59u2aOt0VRn8d4Ks29S6CpfXcx6GdqTcIgm2tYshYMcSWNDzSxnLXyibBFvt1cJFDIqfGwcayr2mcqWjZlwdTblczofQdbVrSGuA8nEXm1l6djDbUD32SncWNX7Klqo8ZqkhO3yaxvMoDFncBnLz8TbDHIE0Sp9cx8JB+oX2mm/+RR+Y3+JPimrG1Rrxh5+nBhxWkL5coIlpEnVtTmYLbc4572AQhiCZrQfJfUJoRDSKjodOoW5zfbalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hDf0NqG2hpGoT0+3ccoPx03tzYBcpm4XnFjTg9HMjo=;
 b=VYaXuNFFmtKArCJemnCNtyOLrsgMNzzxhyxaXwtsapE67nQmb0x892r8bIZpUZ5Asza/NspKhltf+h0BmHYXDwLdMk2XCn2C/5PDti590Jjq9WG11sMvptJmMbrahZkN2/zIZXDIgCDl55WqQ0FwWK/HyoX+H9e0RD+GE5FX4KmN7nztNohLnkhe84pc6P1NpmBCi4MZIQ6ixXECI87wHQiXto6nhjDzpIX63t3bsR0DAb9qsBZw2+i45eeovmi+qE0zoFAhdNWXlguxjMwuavu0tTou9ej34t1KEROQ19F0cMvGd/unKSfa/FZBjg8phUJ0CQ6lD8LLfpXI5lTFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by CY5PR11MB6234.namprd11.prod.outlook.com (2603:10b6:930:25::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 19:47:40 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%4]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 19:47:40 +0000
Message-ID: <d4c9bcb6-8440-43cf-85a9-ed46e087d769@intel.com>
Date: Fri, 14 Feb 2025 11:47:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] ice, irdma: fix an off by one in error handling code
To: Dan Carpenter <dan.carpenter@linaro.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
CC: Mustafa Ismail <mustafa.ismail@intel.com>, Tatyana Nikolova
	<tatyana.e.nikolova@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Leon
 Romanovsky" <leon@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
References: <47e9c9a0-c943-440c-aea7-75ff189c5f97@stanley.mountain>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <47e9c9a0-c943-440c-aea7-75ff189c5f97@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:a03:114::23) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|CY5PR11MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1eb65e-8b4b-43cb-54d7-08dd4d3070e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blBsR3JrU3hQV0NNb1BwOTB4VXpvZTF4blY3alFEOWFRcEVlZzlRaFJ5QzVr?=
 =?utf-8?B?K01xWERwaEU4eFo1dDNLQzlYRkFGaUQ0MEQ2UkQrWE9mUWU4RU95eVgwTUNq?=
 =?utf-8?B?d1VrWk43clpnMHdLaS94WWNqdzgrUjh2clNtaGhGdjNzRzRoSUVjeXArd2pq?=
 =?utf-8?B?RXZsdnhqVTg1SHYwWHZTREdhMXZUb1doRmREd0gyakp1TkY2UC9aNEptWWhy?=
 =?utf-8?B?TjQ3UmhGWEtVZXpQNFJhUnQrV0czb0loRzYxUDNzUFduSThROW1qTjN4ZG5F?=
 =?utf-8?B?YVNCSXZldkMwK0ZDUklZdjZjQjZDZkVCWG1jSWN3Ly9ZbW5zLzRDTU0rakpH?=
 =?utf-8?B?OHY3N3E2MVh4VFRPTzd6Wk5OSzZDR1dwd09VLytnZ2pFRnJacW5kaGJPMjFy?=
 =?utf-8?B?Tmo0QWQvRXZSbmdWRi9UdFZmNEJSTUxLUm5zMFNPNUVrYzJnalBDNUF3azZk?=
 =?utf-8?B?UWFhOW84MkszMnVYUXBvYnREVEtGSlA3YXZGbHNjK2cvdUQ5UlRDRHp3dE52?=
 =?utf-8?B?NEJkS0dkTDA0VUJzcHBNN1dxbFk3RUhSY0hxUjEwdy8vRW9Sb3FkMGNHUEpW?=
 =?utf-8?B?RmFFTk1zbTZhUDNGSlNpcTRMcjhaZWRCRlQrUkxqWFl2WU9ZZldtUmhPcUZ6?=
 =?utf-8?B?emdML2x1QUtndjh6UUliWU5naENvQnMxaEFBS2RsVEJIcys1KzJ3VFVpTW84?=
 =?utf-8?B?MUVpeDk3bnpDazU0azllUm50Y3NJanNaTUw2RW9BV3RTZTBTeHZHUXl3VkMv?=
 =?utf-8?B?dGlhZkVhYzBvZjdrYlNNWjlJYndtMW5uY3RxdXdyb2dLYXNjZjZCNWQ5NEsr?=
 =?utf-8?B?WlRlamxjbGU0a0h3bExmV2czM24yUlV4ekIzelE1TmxxcFBacEJZUzVDR2w4?=
 =?utf-8?B?YktPOG4remdHV2dMcDFWaDdodU9LSTdhL3p5eHg4bVJreE1UZzNMR21RTHln?=
 =?utf-8?B?UGJJNThIUDNzZEliNDltTmt3bndNT3pBMU80RWZvUEhlT0I5U1EzMWZEZVN3?=
 =?utf-8?B?RWdwTXdudTNFQ092R21FeERPeUFXb1h4MEdNZ2xuZ3FSSE5VdUUxcGFFYWM4?=
 =?utf-8?B?c1hObDJGREZRdGhobmRMWk10b243MGRsdDFUWDZJMHZwTzJETEpEWUNrMUNS?=
 =?utf-8?B?eWQvWDRkRzI4U2EwMEFaQitOS2diNnNUWXhvODJ0S0Z4RjljSzFGQ0w1bE9Z?=
 =?utf-8?B?OU5CcEJCdG1laWh4V3JRSlBsS3VEajdoTXRMcjhxUVM5TmxPVWtSK0h2Zi9T?=
 =?utf-8?B?ellZTzJMU2pEcHZjQ0s0a3dVWUdCMlNaaVZyL1NFcExOZlRHMmhPakpQV044?=
 =?utf-8?B?RXpSTytYUWJEWkNYVE54V0orMDVYMWpSdmxMREJEcG9nZjZLZEduc0o1Ty9s?=
 =?utf-8?B?MHlWeUZUZ0phVE5wWUhWWktiUUNGb24ya0tidVJHVU5nWVRWM2JPVmY0ZWFl?=
 =?utf-8?B?YmZpQ3ZQQkhDdFoyY3ZQWi9xd2QxeVBNN3VMcysyR2pKdmFsZlYyWjNnd3Vy?=
 =?utf-8?B?ekNJb3lrYW1pbHFTSE52WTkzVWdmcEg0ckw4WDhqWTFLdnlTeC9jUWcvZlRO?=
 =?utf-8?B?dGo4cUdpOWsyc3E4R2t3UDd2Sm1MMHUxMjNPTVp5ODBJYUd0NzlMY2xnZ1I4?=
 =?utf-8?B?QmRlU0hRRk9MenN2VlFVekwwSEI3OHp4aUljMCtmMWttcjNOY2R1aDROTHpv?=
 =?utf-8?B?bTREZEFUT1BOSTZZcXZLWU11RktIUnBaYXNubVJhWlhSS3kvRUJLcDd6UTEw?=
 =?utf-8?B?cDVya2l3RzVhZWFPWHpJaFpJSUpseTVMckFBRmQyUmt1cWdFcGVmenFlRGdi?=
 =?utf-8?B?N0N0RmdUaUkvNys4Rk95ZEhIUlRXbHVKa1lVR2VDN3R0NVI3OWdvZVlrTGRr?=
 =?utf-8?Q?Ig5oaBdB1SSWw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1psNGhVWTl5Vzdhc3JaejU0NnRQeWxTaVY0Sm05RjhaWkt4MFBaeml4dkFz?=
 =?utf-8?B?WTNjWjV5V1lGL0ZpSWFRVGJOUTZ6aW5JNWpTY210ZG81S09aY3ArMGl1QndV?=
 =?utf-8?B?RHRzSTNPRlNjSkhXQUNtQTh3TjJKeDlZTndSZXovdGFRWmNxeUdqQXlTTU8w?=
 =?utf-8?B?WlA2RkNTZVVlck1mS2lSQTBIZHMvWHVVZGNhZEUzQmJaWnZYcmJ1azhHVkk4?=
 =?utf-8?B?dklISHpzODgrRjFuNTg1NmV3Nk9DZ1ZNWmlKRU1ybENkdkxBR1lFVmNmN3RP?=
 =?utf-8?B?NDZWbUQyZ1FsSmRrck1PbkVlQXA4MmsvbmtwTERvVEYwYzZSOVVrekJsMEVG?=
 =?utf-8?B?ZytITUgrd0dwUE1tUXcvK0JaWk9Pa1ZzR0NCb09LM0JMOC9qVDFsVFJnbFJw?=
 =?utf-8?B?aURocVJnaHlrS0FwcDBLa3c5dS83UkF6OEpTb2UxY1Q0Zm9sSDNUdko5amVp?=
 =?utf-8?B?RTRNamlReVpWSmFmaFZsQ3p2emJXT09KcmE2eGU2M1NWYzFhT05hV2J1a3dL?=
 =?utf-8?B?MkJucEx5M3grMFMzTm1kUUpZQjViMkJGN3lidGRSNS9nYTJINnN1U0ZzOXd0?=
 =?utf-8?B?ZTR4L3RBVjF6cG93bDlHRFl1ZTNSRWlpeVBYaTdNeDZNazVlbms5QTVCSU5I?=
 =?utf-8?B?cXJORWpEWC9oKzdDc0NUOWFid3dIcEFXbzN6RDBPRVhkdDFFNi95WTc4SDJF?=
 =?utf-8?B?WStXVjhOTTAySThUMm9rU3U2V3RSQS9oL2RhSVp2NUZjYmZZSGhxc05pVjR5?=
 =?utf-8?B?SEVSRzUxb1Z6YVhCUTZHcThaSFN3Tkxqd2V0UXRwUXZDL3k3R1FUSDllMlBS?=
 =?utf-8?B?aEkvbkZxeGE2dUxGUHQxcDE4UzN2YTJGSWx6bjlWeThPSzRISDdKNGh6QVJS?=
 =?utf-8?B?aFdOTk9YWGRwSEZIaFNtcEdnUjRrait1VExRSjB1NFRZNWtvbm5ISWdZTkNj?=
 =?utf-8?B?ak5US25uaS9JUlR5THhNQi9yZGtjVlFjdjdnNExSamRmMjFqcW5VMm9ISHoy?=
 =?utf-8?B?U1ltVXdqc3RMcGhhcFZPNGJUakJoY3JlVjEwSFdkZ3dBeFkyYnRMaXFnSDFY?=
 =?utf-8?B?ai9BU0RkdjhoZ1A4NzVJT0VSVHlkZlJnMFpORjNTOTA2RzFUWkw4bFVnM3NZ?=
 =?utf-8?B?dmRTYStYZ01DTUpqV25NVU8rNGNaNHQraTM1UTdVaHhnL1FkcmZPVlhSQll2?=
 =?utf-8?B?TkVvUUFER1gyQno3RzNaV2hlK203NEQrVWdYaFVBWGpENkJXSS91NnVjRkRX?=
 =?utf-8?B?M2t1eUxGSDgwaFd6d3FvTjFkK0ViWWJGKzVQa2ZtYUE1cHRETEMvdmZUNWtQ?=
 =?utf-8?B?clFucHcvMWRSemVxZVFIWGw4SUNQcHZZejVwSFVzdGRTWGZKLzUvVUJndko2?=
 =?utf-8?B?eTZGNHAwcEhtTFI4U1dualVDWFh4amlNVUltTFppbjlTU0VNdXNyakJZZFo1?=
 =?utf-8?B?bDJTUy8yc2h4cGZPcHpTdStuazhoc0NOQmIxTDZtdXE1NlRmenU5TnpBMGhG?=
 =?utf-8?B?WkFEdEJiUXUwOU15cGRwTlFScHpQOUZoaVQ5blNYN0M3R0RlVU44NlJ3M0RZ?=
 =?utf-8?B?cWhibElJdU50dk0yNnBzSnhDcmVJUEE5czZDQWYwZUJ4K3BwZ1Jta0xhMG12?=
 =?utf-8?B?OSt6L3NjZy83SnJybzZOTFB0bEVUYUlDejJBU0hUN2lyVy85ZDJiaUduL1Bq?=
 =?utf-8?B?Ujd3dHMyUURiZXdNY3RHeDZSNWhTeWxKckcvekkxaE9udEViVFhnUjdWMTc5?=
 =?utf-8?B?M0pnVkFGSjc4ZmtkeXdiaVlZamovZEo0ZWJVMXlPOXNuUFROMndYbkFiR1hD?=
 =?utf-8?B?UFh1ZmRrditNM2tJOTRmZ0VOeGxKTi9xNjdNc01EcWF2dStKMVZNZjRHcTE0?=
 =?utf-8?B?VkZPT2pNUUZuazZkVkowNnNPYkNZU1YzQ0hUSW5jUUd3VW8rNjNKZEdiUkdn?=
 =?utf-8?B?elQraEpaM1d0U3F2ZVM5TjZVRExNbngvMGdrcDVyOXd0NmFXcDJLdUVNRlZj?=
 =?utf-8?B?aXpNRTE5YU1lckZyMFlkczFsSXJlQ3RnUStDRS9sV1JCbUU0V2JRcFliVGNk?=
 =?utf-8?B?SHZkY2p2NkltWkRDZmU4eHFDcVNTaXJ3aVFSTVhUUVdTV0ZRM3FBczd4RFl4?=
 =?utf-8?B?bTViSjFnUU9zN0xqbkx5cUh6SHEwVEhGdlRKd0NzRVhxNElXSEkzcjhKbSs0?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1eb65e-8b4b-43cb-54d7-08dd4d3070e6
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 19:47:40.6014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WRllbKu/+idU0rnp+6zGqx8drqN6x9Fohk4i/nY7AyhAj4EcNyBzpTnj51l1epspKWeQuOr6WeFjj8MSYj3XY9pmoDntwnCZKr8GF4X9kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6234
X-OriginatorOrg: intel.com



On 2/12/2025 7:25 AM, Dan Carpenter wrote:
> If we don't allocate the MIN number of IRQs then we need to free what
> we have and return -ENOMEM.  The problem is this loop is off by one
> so it frees an entry that wasn't allocated and it doesn't free the
> first entry where i == 0.
> 
> Fixes: 3e0d3cb3fbe0 ("ice, irdma: move interrupts code to irdma")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks for the patch Dan. I've applied this to iwl-next since it 
originated from there and I'd like to bundle this with the other fixes 
related to the series.

Thanks,
Tony

> ---
>   drivers/infiniband/hw/irdma/main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
> index 1ee8969595d3..5fc081ca8905 100644
> --- a/drivers/infiniband/hw/irdma/main.c
> +++ b/drivers/infiniband/hw/irdma/main.c
> @@ -221,7 +221,7 @@ static int irdma_init_interrupts(struct irdma_pci_f *rf, struct ice_pf *pf)
>   			break;
>   
>   	if (i < IRDMA_MIN_MSIX) {
> -		for (; i > 0; i--)
> +		while (--i >= 0)
>   			ice_free_rdma_qvector(pf, &rf->msix_entries[i]);
>   
>   		kfree(rf->msix_entries);


