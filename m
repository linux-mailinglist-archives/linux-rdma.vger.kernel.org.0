Return-Path: <linux-rdma+bounces-21803-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +bLkMEvTIWrTPAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21803-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 21:34:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1ED642ED1
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 21:34:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="iGd/RYOs";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21803-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21803-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98BFE300CFDA
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 19:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362D83BFE3C;
	Thu,  4 Jun 2026 19:30:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12D13B6C00;
	Thu,  4 Jun 2026 19:30:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601445; cv=fail; b=sfyEOTwYebtPAQbPXhMGRPMNr4/mXONS8aDkErfoGea2g9D4fmRNPdr7X/5MkWoXvU1pmkR+7zGnYgw9jckWgUfd38gpDiiqMoSHVHjIuvSFbl7sSI/LJPRU7kngSy4Rded3/n6qx5T2Wx1tPGGKBLIhPU+Izxw7M6EoBqayll4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601445; c=relaxed/simple;
	bh=4km51Gc6OIHJjJ5ixIBQCuSNdCwMui2gyy/yu/3L5l8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZAtkhMhN5b5SfWmxZ+KIGOwM5msVte94eeL4jswuGi1J3wBedFebZm0NyhSNtErqSRRaNa19ZEr6yiEEOA3FR91/N/DWAdPDMf+KmocdsEMCfNJ+zBqcjn+x/1TnoSpwUg4ddPOz/4XsqZm9qxfZNGJYxoHA1Be3LrxyaoGZpyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGd/RYOs; arc=fail smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780601444; x=1812137444;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4km51Gc6OIHJjJ5ixIBQCuSNdCwMui2gyy/yu/3L5l8=;
  b=iGd/RYOs1+sPUql2E/4Dh+YvwzB/6nrgXZdMLvW8OkwOCOl/9KZxyedV
   c0Ehd6b9MdFeRjiwU4H5KrgzWWmK4XEZC40BqhK4CFnFtHLogdMbt2922
   4Cb2INkGDn1c0yMhszIQf4VaZDMrCSYZcs2fRMjrIxYlgKPk+uGIC5pJx
   8nYDiKQ1zaYbvXDGg6AmJF1BG8yog8uAvTcoFdNAx3CR/U73+fpy2FhLk
   EisLhhIfIY07qwwxK0h63XNJ6ynLA4rHcCh5iXHx134gTmaa/TNTOAcqN
   R57Zck3Yw9/5GLLq5gLO89S/devOBkKRrdDVWKWZWYUvPBawclWXx846W
   w==;
X-CSE-ConnectionGUID: Rfrkx9JSRya2L7qoBH4czw==
X-CSE-MsgGUID: 5DCzPDwMQKeUPEzG+pFTBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="98855115"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="98855115"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:30:43 -0700
X-CSE-ConnectionGUID: i0X+kGLNQuyI3elFVGHjlQ==
X-CSE-MsgGUID: gPbpIT0gQtGYc7TVLSN8UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="248566900"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:30:42 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 12:30:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 12:30:41 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.29) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 12:30:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cA0z2/AaKNxYXyRguJAK+8umuCa7SGRw+LF9zrLEvinDZKK0xnhx0eelU3iIm1RJ5AMdByTm87z7rorEcMyAxgLj/aD3gM7zAkALpdiS3fRrjgplExnXUIF1/9K2UOvvAQKKHO/ugoOEJG7vE+j+yfmJqdafePkLCchXLLIYWTPXmqMuxKkkdwzJFOX9Nr+QwWQ6v1GPQD0DD4t+N4osG/b0RhhK/dC3eAI4ehgMNOAzHgPaQ/tIwhagWtZGoMxOrxXzkeDJPXd1Q7YI2VVA5ywxxqBELlum8ipthu8sC49IkSfC53KWA4hq88kuBv4wy6SGtk1dxtQEZWlQWgAffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++BXL357pm95WfOWXJkTb3DbEfvDi548sdv40OD26oA=;
 b=Id52RbSIzLBiQPprdyhzDCsG+o+XuRKxZSS3RDzhJBjwLv9svnkF7IZYWG21KLVFhMr8VzXqpczd8vMtZc0HJYD95ufL1dSE5fdUFcC3ggxx4GMhRW6WY7dCUPj7NNX/ymRh4JptmIaynb+2+VIB1lMxm1X7pVZRa51nsWrk4TCIdOeRdCYYI8hM2j7mguY1bQpQMdC4TUJss0bG6YAs9JelG5y6wTXWk4bKDuvbIdv6M/RF2pjgr/xzxppAfHELHwn17gzGnW/z0MHh1mhlTWhDYrxiOUd9prYtvkeIOY8WCgWe98tI+c+OyHps0WXTgGPFI+VXJsm0Ca5jCOGx7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SN7PR11MB8067.namprd11.prod.outlook.com (2603:10b6:806:2e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 19:30:36 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 19:30:36 +0000
Message-ID: <ffb1c6a3-825f-403f-876f-8f138f29163c@intel.com>
Date: Thu, 4 Jun 2026 12:30:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] net/mlx5e: Fix publication race for
 priv->channel_stats[]
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, Eran Ben Elisha <eranbe@nvidia.com>, Feng Liu
	<feliu@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Simon Horman <horms@kernel.org>, Alexei Lazar
	<alazar@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Kees Cook <kees@kernel.org>, Lama Kayal
	<lkayal@nvidia.com>, Eran Ben Elisha <eranbe@mellanox.com>, Saeed Mahameed
	<saeedm@mellanox.com>, Haiyang Zhang <haiyangz@microsoft.com>, Joe Damato
	<joe@dama.to>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260604135041.455754-1-tariqt@nvidia.com>
 <20260604135041.455754-5-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260604135041.455754-5-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:303:b5::18) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SN7PR11MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d6b593-8899-411d-1a6e-08dec26fc071
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: pqM/O3ypesIm2JvxnwxhUcquAxGSGZnSXYKuxqqucBFH6bsPm6FzS1+3fPTJkHFFcj55b4hzdlaFBUBjSQv+nVj+CfKRS7MTRkqCKClMVrspI3NH/J5U7aqNEHiTPMQ4Mxnw+0pS+jlO0YkSgi5jmt7WtGJ8QnkwQv6c2I+pAcbcBdmXOF+9X54e7Zbm0312cN9MCgEZBSORzYW8TR8IX9u+zaJLs1dmxBjs3aH0ggE8Kz+B65MlYo5/FW2TAvErNWoa8AD03TCtZ9L/lkF1AYMTFp/3q+ZjOsEP5Gyb7j+EU0uIMrENiRMX85dit0SzBqZRChn9rYNiPceAKsI5pGD8e94R30qWtM8S/P0yLA1GIoqhHD8Nd1j6//D4z6phEyTNtJT8fEfCPWrCHThOsLT4cy0ENZoA6bO0LpL8W+TKxT1gPot7ciQUXzPdxVJqg1nTAU8mFVFmmcrh4Bot3L8Mnc6PQljIxMaangdukY9wPDsscHNsOPIBtFukNQ6g61EnFVC7eBy5KsgOos4GFw3Rk4d4bLIdj/wVFadgEKDxgC0cfEUndyIHVf0y7AUvEcbCRYjE/vXvu/m28aFAbHx3yTr5DVRBmKJIi/8VjV9J+dPlNBvHnNxTXkjy3k7qgYbX/mI2JWVnFXRMquSHmy+tzKx8MFcjLlU7wXSXmzUfZ1zFt87GbRINtOPEPPpf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlVXNFhLcTQxYzRmNHZaeEVRS3N5aGpEY0w1OXdUMklvWjljOG1GWjZHVHJm?=
 =?utf-8?B?Nkt5WTZIVUFYVDNrckdvWlF0UTJNMjYydWZSVDFRK0JsZU11Y0cvTzAxbVJM?=
 =?utf-8?B?RlBRQjhJeGdHc1pEb3VIRHB3ZEdLVVhTa0pIT014TERrSE1yaEV2YlI3MG1E?=
 =?utf-8?B?ZStWbEVTVmkva0FUM25sOHN0cld2OVBKSWJHYXV3eEo2ZEN5VXdDbGZ2Q2Ju?=
 =?utf-8?B?LzV6cjBXaTFnMzc4NlNhWTI4a20xTjFVWEVSUkJpcnRFVzBFcWh3NXZmQ2RT?=
 =?utf-8?B?ZlZkNkUxQ3I0dnUra2V2WVlyaHJKQVZ1L1N2QTVCWXUrenovTlNlQThnSTZU?=
 =?utf-8?B?UGk0dGJBWm5RRjg3bmE3N0Z0ZjJlWDdlTU9tNUlpaFpFcTRvMkhMS1JIWWNj?=
 =?utf-8?B?NEpTTzhqZVBXeHpDUlNmcUNXZWF4ODJ6MkJscThReCtCOGpmTitnTmlPRjJB?=
 =?utf-8?B?dHRLRitrSXZRcDRHSFpYbTI1SmVUZGM5cFlzYmZWQjRhYmlCK21BdFozQ3NN?=
 =?utf-8?B?QjhXVVZTSFlBY0tSTEwzTjRaQU4raS8rZnNYbGg5azFOOVpEZ2dFV29vZldV?=
 =?utf-8?B?TlcxYVlaZGNOS1FtT2lsa1psN2NSK29zOU5UL1MrTkxhM1dmK0FMRm1CZW1z?=
 =?utf-8?B?K2I0c3lxYUIyMWlBbWUzQXZUdTgxOHZ3aDM1UHNCU0F1OG1oQThRVlNrbFhR?=
 =?utf-8?B?NnNjTFpIT3h0b0tUMkQ5dkxRNmFRWURDQ21jUmxabXJSYlZFNkRSU0pJeUg0?=
 =?utf-8?B?TjdwRFAzeUpvekxINFIxYk5uOHprZVdOWkpUZVJzSHowZEYxYjROaytRYXV6?=
 =?utf-8?B?aGliQXJ3dWszUFdqa0JjMGFVc0l0VzZzaVlHUk1jOEkzcXY3RFJWdmVNa1hO?=
 =?utf-8?B?Umhidk5sYS9NMXAwaWM4eEFTWWZzNEgvU2JIL1lBdnROYnk5eEIrRG5xakd5?=
 =?utf-8?B?UDNveVAyNTBNUzhCVG8vei91Nk9qSWRCenhmdUk5M0xFcTJYR3EzZEI4NGUr?=
 =?utf-8?B?TmlRYjJjdkpYeUJKcVVLY3JwcjVBbHhmbkVuQi9za1U1Zitycm5DWlAva1pm?=
 =?utf-8?B?OE1QcGRybVRlbXFhYVZ6QWdyOUZUY2Q1ak9URy84ZVRXTkZqaHAya1ZBdXlw?=
 =?utf-8?B?SVpRSjBZbFY4Ym12MVhieGVQTlFURUZFNEJNU0tkUkg0UTdsSG5jdVlyVkZ6?=
 =?utf-8?B?TkRWeGQzYkFsc0JzbklUS1lpVFlxSC9YUG9ZVmZja0NkejYyYTRiQmUwVCt0?=
 =?utf-8?B?K1NaQ2FmT3piVUxNVyt4VE1xRis2cXN2MVVQeDRBSVQ5VytvRnVzREZNZlQ0?=
 =?utf-8?B?RitRNE41K0lnU0x3Ni96NGZzUDlkZXNPY0R4d2NScFlEb2ZjRk5TeFdZZUVy?=
 =?utf-8?B?NGdQeXpDUVlxdnRtUWxsaVJITDFnSG1RZ1RobEZvaEV6ZXN3OGozSzZZRnFZ?=
 =?utf-8?B?bzV1eHNqN1YreHRGVlVhbVFsLzBqMGcwTnlsMXFpN21yUDJsSk9ZYXREM0ts?=
 =?utf-8?B?em5NTmZZMzVqYmlSMXZqV3hHYWw1c2J3UWhHWC9EU0VKZS83dDB4UHdkWXZ4?=
 =?utf-8?B?ZkZVenZ4TnRlL0xDVGNlcHBnLzhPOWpuc0JkK2Vpb1hiV2ZUOEFQRXA1Uy83?=
 =?utf-8?B?djlDZThzZzJzUElmaHoyd2grRWNGRXVBRmhnTEJlVzY5WnBMMlNnRDVxRW5D?=
 =?utf-8?B?VUlBbnZrZHYxZHNnVVEwUmc1VXdKSmtuWUx4cVRWRFQrQTc3ZDlSTk5oRllo?=
 =?utf-8?B?K05VejlWMm1XcnhwWHBMMWY3Sjdzblg1VVNqUVdRa3JQa0tCUFovU3VzbWpR?=
 =?utf-8?B?ak5oNndNL0tZQUtQNE0vaE5FbTNMeVdPbjhwdmdodmZrdk9CV2JsZkxmbUhD?=
 =?utf-8?B?eHB6RXJRVTJpZlBvYkRUV3pnR3QzK05vYlRrSXZJeVVIbGVFN3Nnd0xqaUFq?=
 =?utf-8?B?Qld1Tkk4OWhLVExjcU16d2YvQWZxNC9kU2JlUTdIVitRQlNJaEpLVjZlSEV0?=
 =?utf-8?B?QjlsVXVvdHFlaWVZVWttRFFlK1FodE9XRk5nR3dRdldEdEZTK29MemNlZXNv?=
 =?utf-8?B?ZXFuN3FTQjI5djh5bjRUSEtySTA1VldaaWk0dTBzYktzaWxkOExGWnlOSVls?=
 =?utf-8?B?L0ZHM2dFTlA1VVBiVENkcG5uYXBWTVZXUVhMb0RxQWtrc3dnYUJ1bS92UlhU?=
 =?utf-8?B?WVFSRHFhMmxrRVJ6VFNPc1c0SThDR1lTSjBNVlJLTjg4MjR0Tk5GZVd0MElx?=
 =?utf-8?B?alg4dnNtS2FRNEJ3VXF0alVHRUtKSzFNMnJrMEw4bzNaVUdJdjVibVJMeHR3?=
 =?utf-8?B?U1hyTzJWMTlyL2xvaUhUWkpVUEU3Y3dHWm1oaEFCRDkvdzlITmpVSzZKM0tv?=
 =?utf-8?Q?5WtzCbXOJt5LGfSQ=3D?=
X-Exchange-RoutingPolicyChecked: CZ7uLMSowj10glc5md39UTk+K/JQe10l+A0/E+zg0COFr2dZMkr3I8XNbrpgQ4zJ0W3rfJd/8davNjLkAbaPEyeXLR65ZhWWxa7yPCGCfgdkfkEuTYkre1P3EUN5O+2+dgXqy1vmi8RJfwAoy8udrcZYkiEQdeZSK92ey/YmGSFDora8E9PnoCeJN6l1kmCWtGqvTUpe4O1V2BoLDzSDt0qZsJ78A1iXcK/Xq0fukqFXUFEEuLxz2xKz4IZ5ymhnlVw4ghp0XplFRAKOhUyK0wus8gTMx/+Ek0l2e5jMXFS7oZtupL80mbJFIq4I3lessfdJe5jPYq21Y4X6GEZK2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d6b593-8899-411d-1a6e-08dec26fc071
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 19:30:36.1218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iG5LKvkHVxX2Jh8so/1YXRDgNEPIkbBja7OpPT0rSpjWEvRebxjrQlBzDna/B6EEPI53F+Xka74LNjs3ouZ5kDmAkrQaxginoFjQwSrBv8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8067
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-21803-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:eranbe@nvidia.com,m:feliu@nvidia.com,m:cratiu@nvidia.com,m:gal@nvidia.com,m:horms@kernel.org,m:alazar@nvidia.com,m:noren@nvidia.com,m:cjubran@nvidia.com,m:kees@kernel.org,m:lkayal@nvidia.com,m:eranbe@mellanox.com,m:saeedm@mellanox.com,m:haiyangz@microsoft.com,m:joe@dama.to,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D1ED642ED1

On 6/4/2026 6:50 AM, Tariq Toukan wrote:
> From: Feng Liu <feliu@nvidia.com>
> 
> mlx5e_channel_stats_alloc() publishes a new entry to
> priv->channel_stats[] and then increments priv->stats_nch as a
> publication token, but neither store carries any memory barrier:
> 
> 	priv->channel_stats[ix] = kvzalloc_node(...);
> 	if (!priv->channel_stats[ix])
> 		return -ENOMEM;
> 	priv->stats_nch++;
> 
> Concurrent readers compute the loop bound from priv->stats_nch and
> then dereference priv->channel_stats[i] using plain accesses, e.g.
> 
> 	for (i = 0; i < priv->stats_nch; i++) {
> 		struct mlx5e_channel_stats *cs = priv->channel_stats[i];
> 		... cs->rq.packets ...
> 	}
> 
> On weakly-ordered architectures (ARM, PowerPC, RISC-V) the writes to
> channel_stats[ix] and stats_nch may become visible to other CPUs out
> of program order. A reader can observe stats_nch == N while still
> seeing channel_stats[N-1] == NULL, leading to a NULL pointer
> dereference in the channel_stats loop.
> 
> This has been observed in production on BlueField-3 DPUs (arm64),
> where ovs-vswitchd queries netdev statistics over netlink during NIC
> bringup, racing mlx5e_open_channel() -> mlx5e_channel_stats_alloc()
> on another CPU:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 0x840
>   Hardware name: BlueField-3 DPU
>   pc : mlx5e_fold_sw_stats64+0x30/0x180 [mlx5_core]
>   Call trace:
>    mlx5e_fold_sw_stats64+0x30/0x180 [mlx5_core]
>    dev_get_stats+0x50/0xc0
>    ovs_vport_get_stats+0x38/0xac [openvswitch]
>    ovs_vport_cmd_fill_info+0x194/0x290 [openvswitch]
>    ovs_vport_cmd_get+0xbc/0x10c [openvswitch]
>    genl_family_rcv_msg_doit+0xd0/0x160
>    genl_rcv_msg+0xec/0x1f0
>    netlink_rcv_skb+0x64/0x130
>    genl_rcv+0x40/0x60
>    netlink_unicast+0x2fc/0x370
>    netlink_sendmsg+0x1dc/0x454
>    ...
>    __arm64_sys_sendmsg+0x2c/0x40
> 
> Order the stats_nch increment through smp_store_release() in the
> writer, paired with smp_load_acquire() of stats_nch in every reader.
> The release/acquire pair establishes the contract:
> 
>   stats_nch == N  =>  channel_stats[0..N-1] are visible and non-NULL.
> 
> Update all readers of priv->stats_nch in mlx5e RX/TX queue stats,
> mlx5e_get_base_stats(), ethtool channels stats, IPoIB stats, the
> sw_stats fold and the HV VHCA stats agent to use smp_load_acquire().
> mlx5e_channel_stats_alloc() (the writer, serialized by state_lock)
> and mlx5e_priv_cleanup() (single-owner teardown) are intentionally
> not modified.
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

