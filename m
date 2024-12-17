Return-Path: <linux-rdma+bounces-6605-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D439F4EE1
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 16:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B788518884BF
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 15:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD791F63E1;
	Tue, 17 Dec 2024 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNOVnCl1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492B91EBFE3;
	Tue, 17 Dec 2024 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447864; cv=fail; b=I2dBOEP/B49jBE7/JuWyZv4T+DdK16HcI5m5Av6AyvP2glGz+u6Uy15jWkJxJyr3Vwvzn+ttBBTG3vlxV5GjoWKXC71bDPWtSqxyo72uIQocMc1TnGTcorL6fhf4xUcqfuF3HF9wYvTKXK11oivdaLrnHTNu5Z6IoKKw/VWKoH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447864; c=relaxed/simple;
	bh=npJKjlxdpVxITzq3Fz5gY6p25NWeW+Svt9+knTYZdkY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jVGbR/WDjfu7qhgk8+KVhx3E7QXfL++gxfUiCAs7thucAqwFl9o4qTwHb+6KJSpLv5VDptKWLR87CdFU9wKW3KMvPgx+Ia3cuhnA95aG098r1zCf763jEosGgWEgiTv9CC+1BlxarYCQOucOr8QJoy2OWVTslA8ISRQJ8sv+YGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNOVnCl1; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734447862; x=1765983862;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=npJKjlxdpVxITzq3Fz5gY6p25NWeW+Svt9+knTYZdkY=;
  b=dNOVnCl1I8BYCFG9E7hA/xJnRBDa1ktWYwfyAi+pfFYuHKMmmXqzlZ3R
   Z81NaqBYI3q6FcMt8eeh8JUb/WtwEEgFGDGsJD/agf2XlmdBHAFoAt+vC
   E6i4jEE0xaQziWix848eGDbJd/linXbsHzL5R/NZRllkgY/uRdauSfIBk
   YiN1tVdejvOTei8YEPGFJ6N40Kba4jIJTQ/piTBsABn8oseajcZN1jJcd
   wb/9ZLvozGMzkkuxDtWMbLunvErm8rLi6zkRq2RjCtBsBgq+ZQYNLKqEB
   DvuUEXJ2REmMX5TWiNV9EiDS5/Vqt4/VZfSGWnXflTNOlpArNkV12PMNj
   g==;
X-CSE-ConnectionGUID: vgdK/rz3RH2oVl1DF8HCjQ==
X-CSE-MsgGUID: Pref1BogRvatpfcwfZe7RQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34785745"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="34785745"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 07:04:21 -0800
X-CSE-ConnectionGUID: ajiyyLjNRDStZMDINBhaEQ==
X-CSE-MsgGUID: PPtGn8U1QR+em9tvDxh6wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97406507"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2024 07:04:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 17 Dec 2024 07:04:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 17 Dec 2024 07:04:20 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 17 Dec 2024 07:04:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDMpBEp/s5FLv4p9xFgn0k45C8Q+Z8dTp+TWl/UDUNq0BdkqosnKtDXnE6ELzzXn+FDiM7rqL4hH10ZAE9IkUWYiSbd8ZtR0XGwzgHjTp718zbG1G9NkLeN55kRca04W1rOydHjsDNER/UtZPvX1EjhezqaBHSTmy5pXZbf2l0LDS/4Q5vLNLEvSxCXHjsR37/LpsrzWJhQu/CSnGEqZrxM+gdvf4iBuA3h+U+iRhXNqFIN139pQ3qkRI1De2yEgqCNuRFmIzT0FOqyIZ2DG7pMEpPB4zzZJsCvMCxpeKqmF59NqyzB+UL4+Xh0f0M1QcMfpYABV8OSbYf1tHyddUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHCJlW9EltGP9TrXU3bkcwS3dnWgQM4oRqf1Ff+6Kys=;
 b=pjCe/E/2niQkqZvUS4crcd1xIbCJhCNk0gC0jxIvMYUpzptx2VCUdoZBN+rqMK9hUvA+uKSjgU0Bp4t5fUVBIO9WKuFycDS7xsACu0KfkQ8+agPZp+5oC0XCGNX63zwz5XkdCMvZ2nLlnsM43p/CK00rNT3joJySrIuOh6eApzEaZBpy2tLBFLRGl9DCTgXIB8sfhguERZVU4HV72nvp+rgKX/WZh87mcg342GMzjoxQ5oM2/9WpunTTZFo8BiooPHM4WtwY+WCukRzvhCIJU5JeWTAhAwGSxXxiUd/ae1zjNURwDwEdNLwCZQyxjgY2ZhxC4fg1xndaaY2P7LjTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB8381.namprd11.prod.outlook.com (2603:10b6:610:17b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Tue, 17 Dec
 2024 15:04:17 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 15:04:17 +0000
Message-ID: <4720f23a-b680-4968-a11c-989e9616aece@intel.com>
Date: Tue, 17 Dec 2024 16:03:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/12] net/mlx5: LAG, Refactor lag logic
To: Mark Bloch <mbloch@nvidia.com>
CC: rongwei liu <rongweil@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>
References: <20241211134223.389616-1-tariqt@nvidia.com>
 <20241211134223.389616-3-tariqt@nvidia.com>
 <93a38917-954c-48bb-a637-011533649ed1@intel.com>
 <981b2b0f-9c35-4968-a5e8-dd0d36ebec05@nvidia.com>
 <abfe7b20-61d7-4b5f-908c-170697429900@intel.com>
 <624f1c54-8bfe-4031-9614-79c4998a8d78@nvidia.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <624f1c54-8bfe-4031-9614-79c4998a8d78@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::26) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB8381:EE_
X-MS-Office365-Filtering-Correlation-Id: ae16751e-0480-4804-ab17-08dd1eac13cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlpDQ3dUc3FFeDZSTHJGeSsyREJGbEdIZ29wMUZUL2hIdWtQMG00OTUzMVMr?=
 =?utf-8?B?bzllRmdTcGhlc0I1bE9GdGRTRU5od3M3NnBKeDBlMWtkZ2NYTFhWcU54NzNQ?=
 =?utf-8?B?eXh5aHc5RzhDUUsxVVBOY1E3Y2hEQ2pzSG42a0pydFZ1ZjJQU0d2aTBwRyt3?=
 =?utf-8?B?WEkzRkNkaGh5RFU2Z3BHd2dOQ3J0NkVRckxESzFIdGpTL3ZxMG16YU1aUnli?=
 =?utf-8?B?UFRXTUl5ckhzekJlMTNxQnFJRXp3MGV6MEYxYk91U1BrMTUzZU9KMGE2cS9T?=
 =?utf-8?B?Tm9BY3V3Sy9JSktncVdEb0dRNjgzbjZ4dTNWSTRXdmgxanhydXZReVlPOWF0?=
 =?utf-8?B?dEZEQmxNK010Z2xwcy9oZnN0VHozSEZGdGFKNDRFQld3TmNIWUoxcnlRZjlQ?=
 =?utf-8?B?aG5raHdFYXJpRmx5b0J6emNOTnlWeFRNZzVISzljVURlNDZjazlKWGdiNVdF?=
 =?utf-8?B?eG13Y2UrY2lPeisxbmF6S3dIV29kMklNNkpueForaTZSVHp0ZEViTVk2MUlJ?=
 =?utf-8?B?Y3orcys2SFNhMEdJZldCVFY4OWw5S0JKU2NIWFJhTjhmOUlRQ3NvKzJUTE5P?=
 =?utf-8?B?KzJ4RWNWMitGTFNKWG5BZitEUE94N2d0YlBtSFdZREgrWTZZWTU3WEJkNDZq?=
 =?utf-8?B?anFJbXdKK1hRazVyazRHNTZ2QnEzOVpmTjRSWnFmU01jZGRKeVA4UnB1SVV3?=
 =?utf-8?B?d000ZHF5bDJqRS84bHU3d1Y0T0ZBY2VnRDV0QkJPdDAyVGhJVDc0NkhlNU5I?=
 =?utf-8?B?R296bVA3OERacGwwaFZEQk5ia3ptUGlKcHdmcFpTd003MTlSRGlxbnEvVk1H?=
 =?utf-8?B?c3ZhS2tZWTdGbVJ6MFQxRzdTMkRLanhIa1dFK2xtcEd5SVk2SVZpMnpJbGhi?=
 =?utf-8?B?M2lzdlJNa2xTU2cydUV4M01heEFNaEVOOTRlSTRyWTUzeUdEeGFxNTR3eklF?=
 =?utf-8?B?QW93dFpYRExkcHJFMUJlZDlycFhFM3FmNkhlL0N4alE5dUlNZHZDcFBJV3Bl?=
 =?utf-8?B?RHViV0paSnlhSXcyd1JQVXV0aDFyY3lUSlRESERvWEtzZE9MNE5ERDNWamFv?=
 =?utf-8?B?WkNFblRGM0VnNmF0SXZ0bXRaVzgveFdHL1B3akZIekxoZlJ5K0ZwaFZMMHNT?=
 =?utf-8?B?Y29tclFHN2dxaUZuTTV2TU5TR3E5cnFjUG5KWWhnNnppbks3RWVvZGdhWmpJ?=
 =?utf-8?B?NEdHVXQ1dHhRWHBjWFVlc09rckZla3pieEhNTnFmemdOZ1BCM0lDQ2VoczJo?=
 =?utf-8?B?RHN2dGVCdnNvTDV1VjVjbzVzSE5rZTVqZ0UxTlI4aTR4WG5pVGg2K3htNzdK?=
 =?utf-8?B?dGc0WWNjZnpOdElEN1J0M0lUWVhVMnF5bHRqSHhEUXpINDlnc0VVK1FrNmN1?=
 =?utf-8?B?ZGhxMEwwdjVKTDhtVjVxeG8yMUtrTDB6Vlp3OVNGUHlmZEcvOUVUdXJNK3Vq?=
 =?utf-8?B?cFRweVV2WHZQQjNZaUZNZFRrQXNXRitNOFdqSnk4U2Z2N2JOREZML3VLNWVU?=
 =?utf-8?B?WWZhWWZjOGF4VEF6dlh4SCtrU08wSWNkWE5WaUROUjkxK056S0ZXL2NmNDcv?=
 =?utf-8?B?K1hRZ2tGMUZqVXlMTm8vYnlRcFRXUGFmMjB5djdxazVMWGl1elpzanpWdXZE?=
 =?utf-8?B?aVBoYUZxY0dkRmVBZGRZWXg5cFhoaUhoUmpCZVRKWjAzem5ZUkppSlJGamw0?=
 =?utf-8?B?WmltcmljYVFUUVhGOWVlTnBZdnRxZE1aWEVGZTRURmsvUGNYUjRxc1lLSnBI?=
 =?utf-8?B?OTVkdkhQNGRBd0JEUmUzbVVhZGY1YXR4bjZaanZUOGJXTTNCTHRTY0tMeStB?=
 =?utf-8?B?ZUovcXhpYmtaZ2paMnlUYnpHRmlrWk1BWmw3RVJUN3VvWlovM0ZucjR1L2tp?=
 =?utf-8?Q?qqDV6U1BT7OCo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVEvbzBoWE5mcFlGeUZuN3hRa0xXdk41Q3RpbFNvT28xSmtBRDVBMFo1VGdQ?=
 =?utf-8?B?MmJZSEJEUmhmUXhqQjM1RExDV1p2a1ltWS95SFVndTM1UktsekJ5Nm55ZXJ4?=
 =?utf-8?B?b1M0WjdtQk1LUGtoMHFkQnJtN3Jpb3oyUi9ENDVtN1BHeERZWVNvbDZiYlV3?=
 =?utf-8?B?Ymo5aXh6VXFBcUtCaUNFQ3FhZ2FDZFBvUDF0T0h5SExabVRTUU5BU3lqNmFh?=
 =?utf-8?B?NDBpSG96dFRFK1Ryd25MQzVCaURZU3FwamIyYjhMcm1nY1h2dnh2OGU5YTg5?=
 =?utf-8?B?dWdSSjRKcHdQQkQrbUxsU0laVi9yaW1sZEJCbi9QMG9FZGszTFJybzBtYVZI?=
 =?utf-8?B?c01qU3B1WE8zREpncDY4U3NSc2FMV3dTTGxTU0RoYnFTMU5KY0I2a3doWHZu?=
 =?utf-8?B?RlZ0VXBQZXhEUHQ2bFdQTC9LRklQaVFHMi8vWkFiN1lWOGFhN0h3Skt2RnJF?=
 =?utf-8?B?SlZWcFlsTlRmeEVVc3Mzcm0zN3dLeUlHQjlOa3ZORnUzb0dsMkhqUEhKMWtw?=
 =?utf-8?B?M3hjTDV0Uy9UTFMzTXZnTHN3ZE1SZld6L3NiWjFweHM0S2JjaGpzZ25JaVcy?=
 =?utf-8?B?OUtUMzZtVEpESndwUEE4NldBZVlTVWRSM1VQNlFZZDZGakRaKzhlSjhOQkNi?=
 =?utf-8?B?c2d5ZlExTWFzb3FaSjRwenB2QUI1YXhBM0F1UU1Jc2hYb2k0VnY1WmptQjdx?=
 =?utf-8?B?TjFodWY4K2Nsb0l3U1Jib2Z4TmlBdkY0bHZBbFlJbEFEcUp6YmtFRVFuWmgv?=
 =?utf-8?B?TEpyb3kvL3B5YUdJTGVoMzU5SHBkZjEvTklYS21aNnljMVVxWWJCbXZScVp1?=
 =?utf-8?B?d2J3TXRTYmUxRzEwUXovSGNRL2txSmEzYTdTTVBHWGpsSnBTSzRUQmNHWXJR?=
 =?utf-8?B?c25JWjJVQkpMbXJJRmJoRFhLMis1ZkMwekF3Rm9iRUJQeWlyMUU0ZlBHaWw1?=
 =?utf-8?B?NkdtR0FpSWRSOXE1SWZvUzdGbE1nSXVENkZPRTRRUEljQXBaNVY4bGVmVHBX?=
 =?utf-8?B?eG92OE5oYVJHZ3Zta294d0dydXdDZHF4OFc3YVh4d3F3M3c1a1FGb2tnMmNq?=
 =?utf-8?B?cjJwQzk5SXV6SXVIN21mYlR5QUlpd0dVMjBjTXVIdVFhYllhZE5kaDlXM0lQ?=
 =?utf-8?B?MldQb3lZeUxOZW1zVkZndCtna0RSaUgzbjNjRm9LaWZuNzAwN09QaFdPU2Nj?=
 =?utf-8?B?eWFJM0JaOTdvNGVuWUl6Mk5RK1J4WmhQZE1LcUcyL2NyWGJMRFJ5QWR6L3g1?=
 =?utf-8?B?TG1MMUdHYlV2TzlZeFVDTElWV3R1U1J1V1cwM1AweTc5MHBOdjFROUlVNndL?=
 =?utf-8?B?ejl1bGZHUXcvM2x5dHpzejNsamxmUVZIek5zY0FOSXZ4VDdXcE5ERzB2dlJY?=
 =?utf-8?B?d01LTE9CS1krWmJGenRHcXgvcW5ZUEk5N2xpNWltTFB4OFNTTGZEQWs0Y29B?=
 =?utf-8?B?L2piblFwYmZJSDhpQTAxK05qUk9aWmV6V1czRW9XMWdDM3VYZVNPUjFaSW1V?=
 =?utf-8?B?OVhvdERyYUJOMXRvZVBhUnViSlhFUGY5Q0RNTUo0di9mYy9IbHBGeS92MUJm?=
 =?utf-8?B?T2hEWmcrZThxdFZVYm5tUE1ibjFRRGFNZUZZVnVVbkpDc0FlcUFkTUIxL0xT?=
 =?utf-8?B?NHE2RUFSTitHVEFEWFFBY0szVWVrTWcvc3JjZGJhVytlM0dHdlB1b3lXK1Uz?=
 =?utf-8?B?MnBnKzcvZ0dyKzlrdDYzbVpCZ0xmV085RXBsb0FNcHlxblpCdGN0Z3BXVnpE?=
 =?utf-8?B?Uk8zUG9MZkYvaW5MRUxSQUVzU3BqYUxjdk9xUU1ZQTRxeXhXUHF5czJETGFM?=
 =?utf-8?B?WmRLS3BnVlZSR2dLRW9tVUJ0M1pJZjEydTU5ZkswZXBweXRhcktsZGVZV3pU?=
 =?utf-8?B?cTRmZ3NWanBWU2l0ZHA4V2VFQ2Z3RGZ5akIwUi9wZzFJY3VCN3N0Mi84SEFy?=
 =?utf-8?B?Q0NmejgybmdlelRUcDB3UTVyZjV4K045M09ueVUzWnE5NFY5TFdpcFlJNFZW?=
 =?utf-8?B?Z3hSdk5EVmFUcGY1WE9KU0h6WHVnRFpodzdZdzh3VXhkZmRScjA3Nkozd3A4?=
 =?utf-8?B?Mk84MWw1ajdoWDc3RG9qOERUR1B2TDRpU1B5S2RybmNSaHZXVStwMEUwSHJq?=
 =?utf-8?B?RzJyVUgwWXBKM0NzaHQ3eE13V3VKRlJWYW9qWC9obEJOeVpkQTQ0bHdKMzBs?=
 =?utf-8?Q?OTS0YK/cpPUIU+wQZMUYCkQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae16751e-0480-4804-ab17-08dd1eac13cf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 15:04:17.3573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7b/XHOqEKT+T1VafPr4ELFcuBDUSU1o4XTjEayxjVDY1YahTnN2532o0wroMgEmjNgnBKX20OZ1qe93MUc90VwLue0X+vrApYrzVNoD3AXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8381
X-OriginatorOrg: intel.com

From: Mark Bloch <mbloch@nvidia.com>
Date: Tue, 17 Dec 2024 14:52:55 +0200

> 
> 
> On 17/12/2024 13:32, Alexander Lobakin wrote:
>> From: Rongwei Liu <rongweil@nvidia.com>
>> Date: Tue, 17 Dec 2024 13:44:07 +0800
>>
>>>
>>>
>>> On 2024/12/17 01:55, Alexander Lobakin wrote:
>>>> From: Tariq Toukan <tariqt@nvidia.com>
>>>> Date: Wed, 11 Dec 2024 15:42:13 +0200
>>>>
>>>>> From: Rongwei Liu <rongweil@nvidia.com>
>>>>>
>>>>> Wrap the lag pf access into two new macros:
>>>>> 1. ldev_for_each()
>>>>> 2. ldev_for_each_reverse()
>>>>> The maximum number of lag ports and the index to `natvie_port_num`
>>>>> mapping will be handled by the two new macros.
>>>>> Users shouldn't use the for loop anymore.
>>>>
>>>> [...]
>>>>
>>>>> @@ -1417,6 +1398,26 @@ void mlx5_lag_add_netdev(struct mlx5_core_dev *dev,
>>>>>  	mlx5_queue_bond_work(ldev, 0);
>>>>>  }
>>>>>  
>>>>> +int get_pre_ldev_func(struct mlx5_lag *ldev, int start_idx, int end_idx)
>>>>> +{
>>>>> +	int i;
>>>>> +
>>>>> +	for (i = start_idx; i >= end_idx; i--)
>>>>> +		if (ldev->pf[i].dev)
>>>>> +			return i;
>>>>> +	return -1;
>>>>> +}
>>>>> +
>>>>> +int get_next_ldev_func(struct mlx5_lag *ldev, int start_idx)
>>>>> +{
>>>>> +	int i;
>>>>> +
>>>>> +	for (i = start_idx; i < MLX5_MAX_PORTS; i++)
>>>>> +		if (ldev->pf[i].dev)
>>>>> +			return i;
>>>>> +	return MLX5_MAX_PORTS;
>>>>> +}
>>>>
>>>> Why aren't these two prefixed with mlx5?
>>>> We can have. No mlx5 prefix aligns with "ldev_for_each/ldev_for_each_reverse()", simple, short and meaningful.
>>
>> All drivers must have its symbols prefixed, otherwise there might be
>> name conflicts at anytime and also it's not clear where a definition
>> comes from if it's not prefixed.
>>
> 
> However, those aren't exported symbols, they are used exclusively by the mlx5 lag code.
> I don't see any added value in prefixing internal functions with mlx5 unless it adds
> context to the logic.
> Here it's very clear we are going over the members that are stored inside the ldev struct.

Tomorrow someone will add a function with the same name to the core
kernel code and get a compilation failure. OTOH nobody would add a
generic symbol prefixed with mlx5_ to the kernel. That's the value.

(+ what Jakub wrote)

> 
> Mark

Thanks,
Olek

