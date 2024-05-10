Return-Path: <linux-rdma+bounces-2401-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C10C8C2560
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 15:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4041C214F2
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 13:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2207E127E33;
	Fri, 10 May 2024 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyjDE9Fh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EB0127B46;
	Fri, 10 May 2024 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715346440; cv=fail; b=ruusqWCoekawM6DjV4JAyixRHLm+h4dPPwsngnKbESsqWI5ZY0cAQTjFFn/M6DHpw/FS1a5v0nWZlSO607YJBmuFqlQuXkkazFkMsQaluGnAijZSmqcjzaAjmtNjiqV+Ocb2SETY1C0DolIjYVaCc1YzNMr9AV9cK7bMJYTMSRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715346440; c=relaxed/simple;
	bh=rpoak6c2ka3ve5ti74JcnA8JubUeN1xROgHE0Hn5P3E=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gI/1ISCj/d2OOAj8ERG7G6ssSs7XE3SSvefs9QWKilzdS3/53agi88N0KXGVVh5+qII/V5qL1ewQem9zCJ97CtfF3oC/FUBWfN9hTSpmUYaAGQmQ4AcJo7dlp9k8sdqfbxPCR0tR05YmONkBL7y+6FE7aYQ65vQMxtmxGmhMES0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OyjDE9Fh; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715346439; x=1746882439;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rpoak6c2ka3ve5ti74JcnA8JubUeN1xROgHE0Hn5P3E=;
  b=OyjDE9Fh3Law1eCFT4eTCHfYr0jVQWy3IFEUOiiRD/+K/wJMCradLQHR
   5B0emsG/g8pc4+DwDTzZF3GPw0mkKhKlpT5/3v+uDwqT3HF81TdoXmYdb
   tYKvdpMZUrNaFeQ9R13N0drE92em2yeYgGhV21A0nHuDsxYzsDCAO3RzQ
   +10Io0V6cucD5nJRXpqXkuRuf/xTnVGTBwqJwnzl2ZfhmaY+KenBlQtwi
   I+TDuu+GabswGbJSYFgAwVf0YCkPjMOeSutPfm9dPRnb49kLwzMQj1dRT
   3XaCcaDP3/IdxLftYaJlBcyxVyib1qCZhRzKG2/z47uPtMuSZgtI22dSK
   w==;
X-CSE-ConnectionGUID: GWJ20CpRT6yeW8B19GWXiQ==
X-CSE-MsgGUID: PfOQ0G0QQLeUmdvC7K9AAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11537741"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11537741"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 06:07:18 -0700
X-CSE-ConnectionGUID: +KPmzkMxQ2SRlR41NUUKoA==
X-CSE-MsgGUID: qfk6lgJISg+tSDgE8lAZ3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="34149441"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 06:07:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 06:07:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 06:07:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 06:07:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNkxCLyI1ZpZcn1xC0+sQSY4TPM8Xt4b4OdG17VYz/CCicOWM1yOAABkuKTyeYZ0XwdjEybc3jN9pmXnnawwI/hfyz3yr8SM9w59cdR4AGcRYUTqlp+GbXCceoYaOXtERBrMFZEBYNWIhdieg0IaobqPcak/FDQMZz2eBCqzHeQ55UPmdUNvul6MenpqWHq5I939rOkyPAbo5HZfH2IuP3Izx6QSHFeJliEUFaqnfjSx2bplIpPt7aNqyIpeWYfCCLNm2GEmX2Ks+/Om0Xu4XhhTqappz+m3qtHZfQyljLVFfpGvAcnGWL6v5tdTR28BVEDwhuoOwr/DVy1CIqQhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4paGIdnxzWnDnvu8P+42JCPJYcxAqreRr8vy5ZGJwQ=;
 b=QWDCvajDzsibOvQ/x9CFBd0GpqQN6SNbdUrorMdOwOe43O9YoHghPkfU2sdrJLANEYqckuQI98ETe2lPLx0J2fvCmSQr0yvDWfUKnxdMYYLIaiJDm2Nv/yz28ATL+UBwlJ04XhMFe4pjKe8DqCFr8Uny3YzbZT12DXTyhURopvlmnK44ujQGWjRi6TjKRRohsSqFaWtAVh9d7Je9trS3/i+5/9U6rf/km6El9kd1xLeO99Ni5WLn8U+6Tzc0RIupydwF78KtcS4Mpingtsun6n9qakSZQJIvehNc/V7Wr3V6sGy2uYWbjlkRdj0wL4Q15xOw/gQRZIZ3Seze3Gu4Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA0PR11MB4624.namprd11.prod.outlook.com (2603:10b6:806:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 13:07:16 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb%3]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 13:07:15 +0000
Message-ID: <abfa794a-e129-414a-bb5e-815eeb13131e@intel.com>
Date: Fri, 10 May 2024 15:07:09 +0200
User-Agent: Mozilla Thunderbird
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v3 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
To: Shay Drori <shayd@nvidia.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Parav Pandit <parav@nvidia.com>
References: <20240508040453.602230-1-shayd@nvidia.com>
 <20240508040453.602230-2-shayd@nvidia.com>
 <6da0b4eb-717b-4810-951c-b59edf32e422@intel.com>
 <fa46ce9f-75f8-49af-8fb7-37b1e698f349@nvidia.com>
Content-Language: en-US
In-Reply-To: <fa46ce9f-75f8-49af-8fb7-37b1e698f349@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::29) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA0PR11MB4624:EE_
X-MS-Office365-Filtering-Correlation-Id: 790f2032-d3e2-47ba-55a3-08dc70f21d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlNtdjJrLytyeGNOQThCemdtTEpJVmVwamE1QVo2VFczNDZtQlFhaHpSWmpv?=
 =?utf-8?B?WHpGekgwT2lCejYrbUhhUlFRZWg4THVmd1FPSGM0NnJmNTg1d0VqME8veGZz?=
 =?utf-8?B?Z0lSYXcxUzJQMy9HWnNEMFgwUUlZMUhvLzhRQVhXb25paDN1c01zYjY5c244?=
 =?utf-8?B?a0JEOTFZM2hVTmw0U1hFYVlPSnhqYzhLS0VCWUo3dW1FbHhkOXg5Y1FLNVpC?=
 =?utf-8?B?THY3WndOdEpRZTRhVzAxM2dZUThXbHNNdVlZTTFhVUY5cGlMRGJQYm1Xek40?=
 =?utf-8?B?d0M0N1lMM2xFSnFMdURybWxUOXRjbWtyWXJieEtQTXJSeGppdlVCajRUbm5Q?=
 =?utf-8?B?Q0dnNk4vbmJNS3VDY0w5cTlGOWlGN09qbkxLOEZtMVdVKzV4anpRd05sRytR?=
 =?utf-8?B?emszQWNieW9CRUMrZERKd3JnTHRpaFlJTzljRDZ1L29vUTdWUVR6WFgraU9V?=
 =?utf-8?B?cFRxZHdFN21BRWZCNXJRU2dpMHd2dDhGUHBoRGRLMWJxdGZ6eHVpOEx4empn?=
 =?utf-8?B?LzRCN0hOUERiZDJTWTJUeHRlbHo4bDF4VkhncWFUbTA0VVAzNmhxdXExN3c2?=
 =?utf-8?B?dU10cjROak1zVU1JSy9Dcnd6elM0dzdEeXlSNVpxVjVhbTNSbzI2eEJsQWMv?=
 =?utf-8?B?S2cxcFFwcXM4azQxYklyblorTkxmZ2FmSU90R3dvSzNOTkVlaVVEQjI0Q3hG?=
 =?utf-8?B?R3dyUmVBSm9FeTR3Vkx6RVdOUFpCMFkxTUdyclE0dVZrNkh1UzQyTStMM21h?=
 =?utf-8?B?T1JlcTFIZDhZcFplMkQwWERpKzZicGpDTDNQeVdHUVBOTThSWUxXZytwYU9Y?=
 =?utf-8?B?V0FWUlpMREt3aU00ZGdZdWJ3VzJoQTVkeDZRZVg5OEExL2FyMkh6UTljNmQx?=
 =?utf-8?B?VEswM1VKcGJ4eDVOK2lTYTI0T1BBM1loaWdEL1E4SHYyanhabkhaaklzblZG?=
 =?utf-8?B?QmpYK3hrcE5Jd3VOZjRvU3krQWJxUW4ybU4xWmVUK2lWSmdIc1U0MFpDZ0JN?=
 =?utf-8?B?R0xXNUlNcVROOThlR2ZiZ0M5MkE4djAzYUFEM3FmZEZJaUJDaHAzR1BDL05C?=
 =?utf-8?B?UGRWMTNram5vUnZsQzJ6VzZUamFWS3BZMHFuN0l1UmhKSkxuT3l5eGFNLzZ4?=
 =?utf-8?B?N3I2TWk0ZTJ6akR5bGZPTXdJWmFnb1dqb203N1NVdDRXYk14cEdDOUlaZVJy?=
 =?utf-8?B?SnMyVUFIMWdGNFk1LytHUDhPWnQwcWV6ZDA5NDNnUjlZU0hZencyQXY3Ykpr?=
 =?utf-8?B?eldVUm5OOWZDUTBra0d6NWNlUUUwYnBZSkRBcEU0c0ZXRXJEckZ1enRvdGJl?=
 =?utf-8?B?TW1BSExNK1VlM1FLb3dGTFdqOHgraitqWGZaOUUzZ3JXUVQ5TGVIS0ZsbWZz?=
 =?utf-8?B?VllmLzFZMXp0ZFNkVXBpZ2s0cDJZUm40UGZTcktsbXpqRXJtMmR5UU9naFNi?=
 =?utf-8?B?WHhXV1djTkRPTUYvdEFaOS9icWltY1lUeFRNNzdDYWMwK28xMk0xWlorS0Mx?=
 =?utf-8?B?SUlQUzdvekhUcDMxS1Fxd0NzWWgvUjBJY2xCQy80K1ZWSHJxSWZzUnN3djF0?=
 =?utf-8?B?bkJhQ0tuazVNeUs2K0tRSzlCMW1wMXl1RVZtc1hnNHNlbHhwS3VTVi9NczUz?=
 =?utf-8?B?NnFrWWp6ZGlhSUpFbjhRcnIxZzFWTHdSOXlzY2g0ckJKdG5OUUhzNWJKbzJi?=
 =?utf-8?B?d1VXMXU4blN0TEVjSHcvZlhuMXhxYVlJUEFmMDNjbDAxUjBBbTVONGRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0luZFV0cVZMc2xCanM2bU13UTBDZTZiVEcrY0RrdDViNkU2TnNFejYwNlNm?=
 =?utf-8?B?ZGdqWTBlTGk3SHY5SDZMWmh0dVR0SEFWYm9LMjMyQzhMNjMyMjFrdnd3Y3hq?=
 =?utf-8?B?MERFSzR3dzd5SFF0SGFSNkNZZks1V1IydDFpdmpkRDZTU3FTWUxvS0hTNzFM?=
 =?utf-8?B?clFBb0c0YVJIQ2N1OTY3cHVUaHRza2dTOTF1RFRWNll3czVmaHQzUk92NnpX?=
 =?utf-8?B?WktCZGorVU5qWDMrdUdtbmNrejcxd2J1dnBtd0VJMkErOFFHSDNiaEc0MHFu?=
 =?utf-8?B?MXVCYXEwbE42YnBlQ0RWblgyUzJNbFc5TXRrUUdFM0hkclZLQk5FUU5NVlM2?=
 =?utf-8?B?dzhJU0hNYWRvOWdZQ25tNVUvNWdDRlFtdUhNMEpnRkRmM0ZzTGJmUzdlL1VS?=
 =?utf-8?B?cjcvVkVqb3JITjdoY3pkQTB1Zyt3NHhrekdpTFQ3ZGFjZXE0bWNZZlc4cmRa?=
 =?utf-8?B?Q3NwWVFpZDZnVlhBRHBXSjl5NUI0OUtvdTRiWFpla2w1a1lURU03N1ZGUHVq?=
 =?utf-8?B?cmNzNVdvVGpVR0ZOSDZLTEJLN2pwU3Rnd0x0c0dHa3I3TERuRjJUeDJQdUpX?=
 =?utf-8?B?OGh5QjBWbWcyS1NOMUpzSm9tMFA4dlBTMW14NGNpdGZIOGtON3hQUTdMMExi?=
 =?utf-8?B?RDBVc3RlSUFqdlNPVlNvMVdPWGhmVGFxeExYTWJxeWgzK1pIb25ETUduRFFs?=
 =?utf-8?B?Rk9UL1cvV0RuU016SVRMWDJDbHZQeStOTTFvS2ZNUUhVSW91aTVnZnAyRm5q?=
 =?utf-8?B?SElZd05yLzIzeDZKeTJRdFZPWUxmZzhuZ1hpWmJORm5hNnRDUGxvR3JEZHEr?=
 =?utf-8?B?eVp4NExsN3FSYTR2eUl6dFNGL2pPdEtPMlBOUHZqMmZtQ0NwdzdyYXAxNWNw?=
 =?utf-8?B?ZFM0V3FiYi9aNEtKSnQ5NWFMeDhwSzRCUVZBeGhycEUrSGh3MTJxaytITmxD?=
 =?utf-8?B?b3JHSGZlVll5QkRiSWM3WHpGR1lCR0t5NWZGM1NlbHE0bG5JbnErWm5pV3l0?=
 =?utf-8?B?R2hib2wrdkZ6dVR2YzN2SUdZYksrbkdWdUdMN1ozaVBiSy92ZTA0UVRwWkNG?=
 =?utf-8?B?MXh5YjNRNWQ4YjQrQzZ6cnN0dWpNVldTT2VVaEUwOWhkcXRxdHBMcHRGcGRL?=
 =?utf-8?B?Y0FVZGV2dGx0TDd3SnFnM3RVeWhIUGl4RU44aUlMa0dVMER3RkxMTmdBWU1Z?=
 =?utf-8?B?TXBqdVRkSlBScDEzeW1oVHVZajBQdEpweW1ad0hTN3VPTkpGOFFxQlRqWGk0?=
 =?utf-8?B?K3phbnRPeTRNRlpqS0l2K1JCVVhRdmhsbEFqZzEwN3Z2MW5FYjVkV2JtamdH?=
 =?utf-8?B?K3Qya1hGYzFKNzVlaTVVME1qcnBHQ1ArT0JUNExTZEJEWk13VHZFWDJPT3dh?=
 =?utf-8?B?L0gvbFpmWWVNYTMzZFB5V0JzRnF1MnJ4WGtkQSt3NXNOSFFIWXhhYUlMY0ZJ?=
 =?utf-8?B?Z3NMWVRnSjJWZGhLc05VZHRkaCtRdUlidHJsbVJxUzFraGpHZGNMNXVIZGRX?=
 =?utf-8?B?NnI0bmhjdktqTXJabkJvTXpCMTNocWFkYlpEaHAxRVhNSGd1T2s3T2xuKzNk?=
 =?utf-8?B?dUJuRjlOZEVheUJ3LzlVM1pzM21BSFdEOXZoeXNyeUpaRnZYa3JXcGVkakVT?=
 =?utf-8?B?a0hrbWpIc2YwMEJ1eS9TYmpyS280clJQendHRjdZbkJ2ZzdCVkVpRExkVG1a?=
 =?utf-8?B?VXBJME13dVZGNnZhLzRnVGJ6VFBXZ2xsTFRZd1VLS0t2dXZSUWZCWFErVVdW?=
 =?utf-8?B?RGxrYkRxZmJwRmpSSHAxQ1BxOHhPQm1XOHJya3JJN3lZT1l1ZXBSU0VVNTFi?=
 =?utf-8?B?YTVLUGtqamFpdDA0UnlwaGZ6K3E4R0JjYnRjVDZ3S3l3eTlvVzEwNXFCRkhl?=
 =?utf-8?B?bmFsd244QTdVK3dxbERaT2VnRGxBd3V4cGg5NGdzQTc3ZVRpbTJKbkNhTHdv?=
 =?utf-8?B?V2lycVAyZm9NbkdKbFVyMmhqMHBVUlphdmFoTFM4b05WbkVHSHBpS09vbWZQ?=
 =?utf-8?B?b1Z2bnR6UzMrWVdMc0prT0NYcGg5RkU5ZlE3MlRJSGMrY1MvazI1Zm1CUFdp?=
 =?utf-8?B?Vi9qc3RLb2w1MGNDMkNkWStLd1YyUkRnNUYxT0hCTGRhMktRRXFYV3BkZXhs?=
 =?utf-8?B?R0hnV3c2WnBRVkQxclVjMXNOVUJOdDFJRlJlbHVJMUlDUXM3end6Zys3SlFY?=
 =?utf-8?Q?QNn/8U2iy1HtP/tsy5pn7ZA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 790f2032-d3e2-47ba-55a3-08dc70f21d44
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 13:07:15.6061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yh/H1nPY5+/W9NjHDztyy8IoSHP2GYctZXdOkm6AHN5f/w10kz5IPzb4Grfg5c/h3jOt8gCHqC6Myzx63FX2yWwTyABN2Fi/q8nJvCe8Fko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4624
X-OriginatorOrg: intel.com

please not that v4+ is already being discussed

On 5/8/24 13:33, Shay Drori wrote:
> On 08/05/2024 12:34, Przemek Kitszel wrote:

// ...

>>> +
>>> +/* Auxiliary devices can share IRQs. Expose to user whether the 
>>> provided IRQ is
>>> + * shared or exclusive.
>>> + */
>>> +static ssize_t auxiliary_irq_mode_show(struct device *dev,
>>> +                                    struct device_attribute *attr, 
>>> char *buf)
>>> +{
>>> +     struct auxiliary_irq_info *info =
>>> +             container_of(attr, struct auxiliary_irq_info, sysfs_attr);
>>> +
>>> +     if (refcount_read(xa_load(&irqs, info->irq)) > 1)
>>
>> I didn't checked if it is possible with current implementation, but
>> please imagine a scenario where user open()'s sysfs file, then triggers
>> operation to remove irq (to call auxiliary_irq_destroy()), and only then
>> read()'s sysfs contents, what results in nullptr dereference (xa_load()
>> returning NULL). Splitting the code into two if statements would resolve
>> this issue.
> 
> the first function in auxiliary_irq_destroy() is removing the sysfs.
> I don't see how after that user can read() the sysfs...

Let me illustrate, but with my running kernel instead of your series:
# strace cat /sys/class/net/enp0s31f6/duplex 2>&1 | grep -e open -e read
yields (among others):
openat(AT_FDCWD, "/sys/class/net/enp0s31f6/duplex", O_RDONLY) = 3
read(3, "full\n", 131072)               = 5

And now imagine that other, concurrent user app or any HW event triggers
this IRQ removal (resulting with xarray entry removed (!), likely sysfs
attr refcount dropped to 0 [A], so new open()s will be declined, but
that is irrelevant).
My assumption is that, until close()d, user is free to call read() on
fd received from openat(), but it's possible that xa_load() would return
NULL (because of [A] above).

> 
>>
>>> +             return sysfs_emit(buf, "%s\n", "shared");
>>> +     else
>>> +             return sysfs_emit(buf, "%s\n", "exclusive");
>>> +}
>>> +
>>> +static void auxiliary_irq_destroy(int irq)
>>> +{
>>> +     refcount_t *ref;
>>> +
>>> +     xa_lock(&irqs);
>>> +     ref = xa_load(&irqs, irq);
>>> +     if (refcount_dec_and_test(ref)) {
>>> +             __xa_erase(&irqs, irq);
>>> +             kfree(ref);
>>> +     }
>>> +     xa_unlock(&irqs);
>>> +}
>>> +
>>> +static int auxiliary_irq_create(int irq)
>>> +{
>>> +     refcount_t *ref;
>>> +     int ret = 0;
>>> +
>>> +     mutex_lock(&irqs_lock);
>>
>> [1] xa_lock() instead ...
>>
>>> +     ref = xa_load(&irqs, irq);
>>> +     if (ref && refcount_inc_not_zero(ref))
>>> +             goto out;
>>
>> `&& refcount_inc_not_zero()` here means: leak memory and wreak havoc on
>> saturation, instead the logic should be:
>>         if (ref) {
>>                 refcount_inc(ref);
>>                 goto out;
>>         }
>>


<digression>

>> anyway allocating under a lock taken is not the best idea in general,
>> although xarray API somehow encourages this - 
> 
>> alternative is to
>> preallocate and free when not used, or some lock dance that will be easy
>> to get wrong - and that's the raison d'etre of xa_reserve() :)
> 
> I don't understand what you picture here?

Here I was digressing, sorry for not marking it clearly as that.
IMO xarray API need an extension to make this and similar use case
easier to code right. I will CC you ofc.
</digression>

> xa_reserve() can drop the lock while allocating the xa_entry, so how it 
> will help?
> 
>>
>>> +
>>> +     ref = kzalloc(sizeof(*ref), GFP_KERNEL);
>>> +     if (!ref) {
>>> +             ret = -ENOMEM;
>>> +             goto out;
>>> +     }
>>> +
>>> +     refcount_set(ref, 1);
>>> +     ret = xa_insert(&irqs, irq, ref, GFP_KERNEL);
>>
>> [2] ... then __xa_insert() here
> 
> __xa_insert() can drop the lock as well...

Thank you for pointing it to me.

Let's move future discussion on this series to your newer submissions.

// ...

