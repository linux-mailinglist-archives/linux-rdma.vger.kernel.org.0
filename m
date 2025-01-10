Return-Path: <linux-rdma+bounces-6945-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D689A084AB
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 02:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36260167E2B
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 01:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB6A2BAE3;
	Fri, 10 Jan 2025 01:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="POas+Mjz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927322C9D;
	Fri, 10 Jan 2025 01:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736471865; cv=fail; b=ahf+GnIGf5ouvZSKPSOUpZkh0I6z4Dc7C0HPWJ9/dyu64NZ9OHa3Xuq5CxmKd+zSDg8zM4FNCPAkKVa3w/2LBbAAx37pCwXnB0CnJ7mllwp6cNNPU1DR+j+Xab7yaAWMUv5zfoC8d5FGSL9k9mKpY174gOSLNEeLHFjaVpOMnII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736471865; c=relaxed/simple;
	bh=m2Mwr5EQGdAY/Z8dJ1AL4YnUu4lCZudhD1B02NJ8ccc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qYLBBOzGkl7kgWAfpZVZCn6XlEprcz5SmCG1rJWKPOZYr/uhodR7JtkUcdpzF11q2YYO4ChSxp9mzIzLTciPlsY6AuLkuoZXkmHFWEnV4GJvTttze1pIn9lANns1E6i4WqAQFymD2FH2H5PPxY4whCB7GlxueyIyRnjShynPIj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=POas+Mjz; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736471863; x=1768007863;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m2Mwr5EQGdAY/Z8dJ1AL4YnUu4lCZudhD1B02NJ8ccc=;
  b=POas+Mjz/MNegOSmzH3amhlDgH9a06Dwd/o+E9gps0UobZyGhn6pFFWu
   /y6QQVuSxzovaWQasyjeHFwu+FaSZo/Dl+aVusrU0/bwfZHK5XdjekzH8
   RWTg70o1+Hj+CCNYzf7B8BD8B4C4CDrK1MZLipLfxvvw9pEa0ErNr67ll
   XHj7JLSFpAkDRIliCRl0YTvNRgQpLKD41KvCIkAsyXEeOaRtUQjq1qRG+
   wrDgDo1EPAgQ+ihWp508DvZeufamFPG8TzaNCuRUylulHanrjfKHDKwA2
   I/BNdF30HYgPzOou/kQ1Cfj7VdMlaKx+0sk2x1pyx4kIna7pv/ywiltPZ
   Q==;
X-CSE-ConnectionGUID: kA6Mp+rjSGeKHUzd7EYMkQ==
X-CSE-MsgGUID: Y6TT6GKpQ2SVh6yGEd5toQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36781925"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36781925"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 17:17:43 -0800
X-CSE-ConnectionGUID: 2+Afxc6aTbazF6qSz3FyVw==
X-CSE-MsgGUID: +/NPHXBYTtSKW/Fv6uBgyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="103542296"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 17:17:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 17:17:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 17:17:42 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 17:17:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkrZtFcTF4ybDZnSuqPSwfcBbFYINAzZB+ixXIB8MPutLLBCy5sm0c9cZwh5szxnCAg0ycd/PvbP+9o+msoM9XVv+U5jEDjdAzIaFACig0y8VT6pjaULOaaMJAtcJKyqDWY/Q/q2JDxo8P6AB4vWhIt0zd6VadDwAPN3gQDNvqSfYvjM6iX8jjw1ZYNioK+Wj/LwSqRzaYfnE4nfZgGpqgpo9s5Cbk29+CS8megyBlF2ZWpiheslCa+eJ7EcCft5l0Z7Y6FIvvOTQYaPBaNTW9ZJaEEIA+1Kq1C90OQjbRfF3hXe/5vAi6OVCbLWkAbcabdESCZ3b3tW/HDO6KdIXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qp1bI0Gqks6UJZ8r4dXe25KEqK4SWEukzdqL8PwKwQ4=;
 b=HwbyiD3zeH5o18xhTOT7CHGFgvJnPaAYcFSGhLYgBSeuIjdPUZ84qHi9YyC3E5B1WEOgdElrDKV3yKtJqWr9GxElmRPaMgKIMuJ6YmUc3IEvgKK20FrodIdubCFHOSxTwI57v6tpPLjwu2HiXMIn7AxSOIhB8iRtM/oP7po6SoZV2fAHdMjVZL73WEa4X3zZyV42afjt79hxrxXZ8d6X9GkplWdcVTh9aOWciqEoBvDBrukSvOA0ppCzv54Xu0qMmfUw5tQEZdCb1YOKrZMBb/h+TAsP/62+31Vqy3OJ53iR5sa4LF5rS1ib2DdyZ/rjtV+nj1CGR4vvD2QVdtRk0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB5269.namprd11.prod.outlook.com (2603:10b6:208:310::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 01:17:10 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 01:17:10 +0000
Message-ID: <927f46e5-eed9-486e-8505-5a9270bae068@intel.com>
Date: Thu, 9 Jan 2025 17:17:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mlx5-next 2/4] net/mlx5: Add support for MRTCQ register
To: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"Leon Romanovsky" <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Gal Pressman <gal@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20250109204231.1809851-1-tariqt@nvidia.com>
 <20250109204231.1809851-3-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250109204231.1809851-3-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL1PR11MB5269:EE_
X-MS-Office365-Filtering-Correlation-Id: 174bb0aa-ab57-4fe7-1e74-08dd311481bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHNsNDJGYy9hZzhMVU5uWnZyeVRqRlloRTZjUVNhbGdUczJvc0tHUU44ZnBo?=
 =?utf-8?B?ZWRMWVBXZEQ5dkQ3RHdZbXdZREZMczl0cHN2RkxpOGFTNUtseGlYc2ZadDNz?=
 =?utf-8?B?bGxDZHRCbEZXb2hQQURXbEdzK2VSZHZ4NlQ0TTJIajVaZG9LRFA2VENpdFpk?=
 =?utf-8?B?UTQ0dHZMZVBNUGVUZDk0R0NpS2oxclhlZWJnT1Z1YjNNYXdJcGM2VXR2SGxh?=
 =?utf-8?B?cjVsZUhpa2pweXdtUEtPK1JwVjY5NGdLaFZ3WFpyd0w0UXlQcVB5eVVuQWMr?=
 =?utf-8?B?ZWh3WlJjV3RqOG9LMTFJczVBdjQ2cmkzL1Y1LzR3YWtPZVB0VHRmYWxrWVJU?=
 =?utf-8?B?bko4c0VYbm1DSVR5QktycDhRM1UzcHRRSnJiYnN4cTNuTjZ5N0lCTnJ6cjgr?=
 =?utf-8?B?T0VOaXJCWlNuV2RwWWNQaUpzTXluMDBSTFRrY042K3dWZFZEaU5NbVFPSlVy?=
 =?utf-8?B?cFhUUnFQNHI4RkgreWVVQ1BieHNNVnJFMmxBY2VRd3N4US8zN3RTbEJiY3Zy?=
 =?utf-8?B?R2F2b3VVM3RjSFZhZE93OTl5aEVra2pKc0RmTHlTdEVEaEk3TTliZXdMaWlC?=
 =?utf-8?B?bGNvSVNpdXhrWFA3bjhyZytVUTNMM0xaRGljNlpadXJCNHpKYmIxYVlna2R3?=
 =?utf-8?B?RzlQZzY2M3ZrZi8rbjN2RW9sMVBKVDN4YXBoT2F2bVVUVkV1RitpZEEwQWJ6?=
 =?utf-8?B?d2VKZzVhRnpKRGdldTIxN0RrVUFXQ1BvQ1hTN2hmTGVmK3BBQlVTQ1czeFZi?=
 =?utf-8?B?L1BQWGJqWXFJQ0phbEhQTWNDSVltY3ROVUN4UE11WWp4YVM5WGx0UEJ4bVIw?=
 =?utf-8?B?c0ZJbjJkS0JjUDdwbXB2dUUzaTNYZThWU0F1SGlMVG9vMlRzL2kwdFdtM05D?=
 =?utf-8?B?YnBVU2FiNEQwNHc2NHdCdXY4aDhaN09lVGxyNndFcWlRN3h1VEtzY3krR1VS?=
 =?utf-8?B?Uzd0RC9qL1djclROK3J4RkFDa1RDTlFsbE1zM2g1Q1ltN0dsbDI5QU5DalQz?=
 =?utf-8?B?UllJejdtS1lxWUwvNXBvUlpKNGNVLzdxWlJlMzZZSElvZk5KR1lPTGdTd0tv?=
 =?utf-8?B?Q3hLOGROckZPdjlLc1JSN0p0Y1pxaVlWRThXSUo4NnI5VTJEdlcxd0dnWVlt?=
 =?utf-8?B?S2xmc1Y2OTFUakYzVjUyOHpqTzFCOVNqWHFzSWJaUjNSNDUzMUNna2lLTW9Y?=
 =?utf-8?B?NWlFWFl0a2NkLzVrdWs0N0E2ZC9LVUp2TGhjRXFtQzBrUmxNNVU4OFEwN2xq?=
 =?utf-8?B?akhZbjBSVGdnZUFnUmU5NjlGdC9LNk91d09NR2xCeFkxWldiY3k5YmxPUDVL?=
 =?utf-8?B?WThGY3c0MVRBMVNqZ0FFaEhXNDN1MThNT2xBNjFpQTRvUHlBVWRvOGZYRng2?=
 =?utf-8?B?UVJ6OUNJUHZ6MVlXcGVjME8rQkYyRkVMN2RhQ3h6aG9zTytoa2daK0pVUU53?=
 =?utf-8?B?T1J4aUFIVjJXV2tvT1ZiQnVMMFB1Z3FVYVc2M2k2MWZVREp5U2FxbG44WU02?=
 =?utf-8?B?ZkttNFJZTnEyNHlLS0JiTEQwNjZNbnRtL0t5bytrNnV3Y1hxWXVzNDdzdUFs?=
 =?utf-8?B?M3pGRTVWc0ZQVlZWQm44bzk4OHpmRHRaNnVUTDhWNEQ3VTVSMHVWWEtFL3c1?=
 =?utf-8?B?WUNtano4bHNSQSt1V1VkVE52Q0VLS0pyMjlzdkw2N3lXVXphaERGUFZqRnJF?=
 =?utf-8?B?eXNLZ29ZdFdGRlVSeS9qZG9GamUzZE0vZGt5d2MzUStJL1dsODJGdUhzNVR6?=
 =?utf-8?B?QmNBWVllZFNvTTIrbHI3UnVtamYxTGN3cEswcmt5QmJ2bzUwckxKcnR4N1JD?=
 =?utf-8?B?U2VZOWgrTXNyS0VXYUs4Y0c4R1RiUEtkU0VmdHhSVVBpc0xQbmFWb1J6RjNW?=
 =?utf-8?Q?elay7HPvEUOFJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlJLVm5ia2FyM0QraWZ2TWhKa3BvRXA3RTNSUllCOUY0MW9OcUFxKzBKbTZ4?=
 =?utf-8?B?MDFOejlFK2pUV2VhSnFXUitLanNvTmFqc3JsZnZZQVJOcG43dHdWeE9BNWpq?=
 =?utf-8?B?U0dvOEMxZGVNWDA5UXBHTVNocm5MS0IvN0lvN3F2b3AyNXJQZ2FzUnJZN1Fi?=
 =?utf-8?B?Y2Q2SzVnOFBBVDhFNFd1MHJSSFhkK0o4T2hGN3Q2VVJBMEVwQzUrUC9nWWVU?=
 =?utf-8?B?NDZvWmdqazlDT1RIZFJwdWVPdE1uQkNxU1k5ZnBYZDRTUG14MGhJK2dST2or?=
 =?utf-8?B?eVIrUHRpbHdJOXZkdU1kdWhkbUx6bjNaVUYycmJuWVBLYkU1T1hXcGlGUTh2?=
 =?utf-8?B?TXhCb0RTSTkzMWRmNnNudGx3RnFUK3pkUEE2R0MrYlhQZm1ISzkrc3FaT1k4?=
 =?utf-8?B?aVZqaG5lSVlIV0ZhSFFiWEtmbVBzLzhyY2x5eEdkNGhZSGZReWFYdVJ1cFdI?=
 =?utf-8?B?a0w4QTBBL0VqNFJjb28weHAvdHdQUU8wYlhORTVUUVlJU2Yvbk1ML1JwVVVX?=
 =?utf-8?B?UnJFaGRPckZxaHREd2FCb2xRVzd2NVJya1VXb01OdDFtTmhDSnlyQ2pYdzdT?=
 =?utf-8?B?dkZ0K1R6NVFGcyswblFoNnYxZUV1a2Q3ekVKenVEUXl4SGlVSUIxQjBzOEZC?=
 =?utf-8?B?aHJYNmgxdU9RSy9ERUVJVTBzOU1ZTlhlTW9xTDU0RjErQjFNcDhxdVdBdXB5?=
 =?utf-8?B?V0hSNzhWUU9HRkl6VG1CbW1HMjlucXNvTldyVFI3U2hiN05tbkNhTldMMDJN?=
 =?utf-8?B?MXNMSWlyZ1Ntc2RRZlNFZ1E5NnY0bzBMRWdYMGt6ZDdDVWlhanJJRmVndmFC?=
 =?utf-8?B?Y1QzanVVRGtibjBUaXJZVDBQQmhpK3BZOXNkK0Z5YURrREFZY3VjRFVPeFY2?=
 =?utf-8?B?MnNpNnJsc2Z1U2ptbzU5NU01QVM1SUs2TVMrcnVHQU40ZEhkMGVjNEJyM2tH?=
 =?utf-8?B?MTdzQWlnSWJSQiszdStreEFPdjRrNEdrY0wxOFY0eVRyKzYrejZGVlhEdjA4?=
 =?utf-8?B?S1ZLRVVacWZ2SmxCVEpyNHVFSExkd1VxYzJuQXBWVENUUzJ4N09WNzZvWUNK?=
 =?utf-8?B?UHV1Q2xtVXVTVElrM0ZMNXlxL3BwUlhvek5yWHZ5YVFEdzJIaDZoOUZlL0VO?=
 =?utf-8?B?UmlFTzZ4U0tCU2xITG5NWm00Rjl0ekdoQ3Z3dlgxKzhrUVl0NUFJQmUycU5K?=
 =?utf-8?B?WjVHd2N1djdVWXRZczFqL2o5ZEZsZk1PUVZ1TEpsUFpIRVRBTklRYXZaMHAw?=
 =?utf-8?B?OWtOU3dOSStzTDF1WStRZTB4THlCYVhENEwxSWg0aUNTOHdVNXpjSmFjUU5Y?=
 =?utf-8?B?MXo3WTJOcHZ5dTBOamtGZFNXLzRqNmUvRFhPZXUyMGp6SldsVjdveE1va3R3?=
 =?utf-8?B?SHpDYklpTjMvT3RLRThmVHoxNkp5V09PQmdoUzBUYks1b0NEd3pITUdCUmNs?=
 =?utf-8?B?Wk5RYlBxNkM5MnNnQ0FsN2cybEV1UHUzYlI5bE03RWNDWC9LN1Q3SWtuMFV1?=
 =?utf-8?B?dGNabUM1eHJkQ2pLQSttS2VXb1NHbXAwUmREM0kzdCs0bTVSRjNkeTA1MHd3?=
 =?utf-8?B?VlRzQmcwN0FYZFhiK1Q2YnJXeDloTDg1VzJZalJHeDIxcExPOVNnblA4Q2Zj?=
 =?utf-8?B?R3l3Qm5RZjNBMG55Q0ZvYmlpVmhacnYvMENRQkc0Yi9hL0VqR1ZLL0VrdUs4?=
 =?utf-8?B?QTNjcWN0RzNJWmhGUVdxQjgzbyt6VEIvOTNBNHpUT0RqUXpJRmtXazFPOVNH?=
 =?utf-8?B?eGFSZURtVFA2ZzA1SW4rNmZwYXplWkRJeHlHSUhzSDBrWjZpOTNrVEg3UC9r?=
 =?utf-8?B?TmNlUGg3U2VuN0syeDFnamFBSGs1SFNUQ3pONWZOSjd5RzhaSmNnNjMwUEZR?=
 =?utf-8?B?eTlHL2daSDZjU3cvay96dDFFUnlKNWFtSldZa3lJZTdEK1kra3dNMjRtczlD?=
 =?utf-8?B?OUtqaExPUjEwUkhPM2RIVExwVDNpbFhBcUt5dVZaZWFoeCtGN1dLWk5MMC9m?=
 =?utf-8?B?NUdPaHZmbEh1NHJ2ODdSMzc0ekxMclROdVpCMEl0ZURvNDU3R1VhdmpmWXYr?=
 =?utf-8?B?RzNEbEtiSjBoMC9FQ0FkMGM2NVZYQ2swYzBEdmdDa1kzcE4zaEJua0J3cDc2?=
 =?utf-8?Q?ZCUpK5RazxOdEU6vmYqLVpKR9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 174bb0aa-ab57-4fe7-1e74-08dd311481bd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 01:17:10.3951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Am1gFPDyUshNopKKv5oYMF7ptuTCMyGOwAEDix7As2yYU5JrS5n4QOR/VXzdk0iPo61QXKODaa0a8UZFO0fJkYWvJUJIruyIIvA9Wsjx1iA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5269
X-OriginatorOrg: intel.com



On 1/9/2025 12:42 PM, Tariq Toukan wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> Management Real Time Clock Query (MRTCQ) register is used to query
> hardware clock identity.
> 
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

