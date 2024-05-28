Return-Path: <linux-rdma+bounces-2634-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B60D8D1F21
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 16:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE89E1C222FD
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 14:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188F617085C;
	Tue, 28 May 2024 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bDCJTKJs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DE1171E73;
	Tue, 28 May 2024 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907448; cv=fail; b=ME5KDlyTUZwDvF99V2hUoXZMM36ozwyTL86qTSbtgEkgonustwh1BCnDqvJXLXvHY8UtBdXhmor9eSCj4mMAj8rV4oeDsAiYWGf3mhxSO5+E4GbzpFgGfLIYKn60jnTCXJ1M4IJ04ZTMMFeHAxhL1NuLt3YhW+9yKP6lSnbYKcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907448; c=relaxed/simple;
	bh=1/6/H2Y8NvlbZ3gjXjNzj+Dg3yUk15DLZWKTobA+sDo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B4eLwkhwBmL2OvSdrTE08/d4P77wK8Coa5htD9b+oFAv/DZWA4F6LxZsqEyDM2YpKEwvTJhXgDUroyf38GYsMokkY8YSDpc1MRaSsHNpItZONC6h8hOAALyf7aIInOqbpvFtvV64FpH5Gpyy7041iWqbnADLu9VwuLLcLHgTTc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bDCJTKJs; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716907446; x=1748443446;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1/6/H2Y8NvlbZ3gjXjNzj+Dg3yUk15DLZWKTobA+sDo=;
  b=bDCJTKJsmu/ok3X4KLnYNFuwV4RaX09EN64uhW0f1iT5vMyeektJ8A1g
   ANpqzwP37sekgo0bysGU4XCFUWNM3awtg75JTsleN2l3HnutFB8k2xZis
   EoorS97lyXCLNVSN2eulLJTKiL8E8ohriVzA6+DGDnOKOt4MAVS8XQj+F
   C5KUdopbnFljmFGYC68ZUGgBy1ivXK+ZtFaqgO1Hnktq9rTo3+OmCJzV+
   16wVIVZmfc8gdtsMa3VYqFZI0dx2wkRg8OheN4oq4KHJmUoHAAW48zMsD
   yWOrbvwj368mvD4AmKRVG87EvF+yg7qDt8A6gxOpoo5NDpKnuIjP6QlRl
   g==;
X-CSE-ConnectionGUID: DtANTiOqSwqtZP5Vqdl5eQ==
X-CSE-MsgGUID: 8Lw/99X5SlSFFb3j0AIhlg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24672117"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="24672117"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 07:44:04 -0700
X-CSE-ConnectionGUID: ZGzF9qqoSg2SBL3TN76Z6g==
X-CSE-MsgGUID: BSTk36rkQFanHE8U6tSHwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39537177"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 07:43:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 07:43:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 07:43:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 07:43:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 07:43:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Su35ligsrLtIwmXFW/demGZfZ/29rGA/hLUAlDQ2+5x1G9lEyRbPdXWSyRu0TJfHTOn026UcZZxy/mEynYeijuykLbxJc1sgEncGYh3fnXIzRDUDXDAEsYssLHbcU3Qaq/YgcQwYK5vdWML1d3UCUhVoj1WKLkvKec6TBfP0L+XKInvsOhw1GSrUrbGIh85gp+19i3iiU4wuNv0FUIsy7Efbf/qYJC1fnizKtaQrNGwOB+Ld4VvAvsOvVoZCSIQlHFytELBNJp96oEwMEB9ddddQazTXtP3obnZW/F5F0IlZ8mZQQs/GAMkrMQTuvrihoYJiW4BlnzTd5h6i7wuJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmJhD0Vnf6P5mdCiBlTZkPYEIys04zuzDejl5EbLPVM=;
 b=UGq7s9/ZA16XdbHHaOuyiu6SW+ojYYLneaZiykMH8Kjl49GPsVmJHm8GvqdC4oIwBq5l1sScVj2UY5zMO68n6nrGpGpnGUAKm48nzpPr5vvm+zJOSn+2XeVmNmdMgE3UePNlIdQE16xF2euGbHj3MHtWKgNTA36UUsZBChJsmNinmzWjIrE2nUSVQW6O1TC3xS/KWzbyyWUQcb5qNpWz1mlywD8w1yVvzCdkXMuvGr1hVxM4DFvcLVHngObOP8Ek1IAtXQQ3KHwPKs79uZd8NIU4/8sAPEh1E7ULavMtkY3GoV+nNgFRY9AtIhYw7i4f+Ss6xBMXj2B96bTyB/X0Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA0PR11MB4717.namprd11.prod.outlook.com (2603:10b6:806:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.31; Tue, 28 May
 2024 14:43:44 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 14:43:44 +0000
Message-ID: <8b8a42af-afe4-4b53-b946-f60e10affc2f@intel.com>
Date: Tue, 28 May 2024 16:43:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
To: Shay Drory <shayd@nvidia.com>, <gregkh@linuxfoundation.org>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <edumazet@google.com>,
	<kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <david.m.ertman@intel.com>,
	<linux-rdma@vger.kernel.org>, <leon@kernel.org>, <tariqt@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>
References: <20240528091144.112829-1-shayd@nvidia.com>
 <20240528091144.112829-2-shayd@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240528091144.112829-2-shayd@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::29) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA0PR11MB4717:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d96933-e702-4107-9499-08dc7f24934b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z25xMVk4S3Y1bWU1OE9lNnYzYWc1N1hkYXphQTBMYmdGelFnM0xzd3lPNHVr?=
 =?utf-8?B?K05FZmZaSVZDYXBpY2NhaWkrNkxZb0orcklvSEhZaHF1d0VvTVR5T0dsaHJs?=
 =?utf-8?B?eEFGVXVDd0NjSEl1SFdDdmh5Tlllem9DcnV6b0tSR0hiUERoNlYvZGY1OWJN?=
 =?utf-8?B?cnhUcTJyUCtFSnIzWEp1VlYwdVZEcElscytXZlZDL0tuamlyNnZYMDVJK2wx?=
 =?utf-8?B?T1NyQWlDeUVjQ2hFcTBXTTYzZjZaMzZNNUc3Unh0YzFHbGlrMlcvUWs0VEUx?=
 =?utf-8?B?LzlQaVBGMTd4bDFBbS9yYm92TkJWSzQ4ZmpaZ1h0WUI1OVJkTnhCMk44NFV3?=
 =?utf-8?B?VHNXMjhNMlhLOFdRenFsVjdjT1ZvVzNxb05wM2FLREhhRHUrM05ldE5aOUhr?=
 =?utf-8?B?ZHJMNVVvMzVFTWtBMEJINjFFS2F6aEZZZ01USUo3Njg1RTNKZkR2UFQ5a0hy?=
 =?utf-8?B?MEVlM3haU2hWeTlmSVlrK2F0TktPL05hNWF1SFhlSGxHU2NRYUlrYnJXenpQ?=
 =?utf-8?B?QXVXeWk5ZWxvN1NPSjAwcjdvZmU2aDhWTHBud2Y2YVhTaUpIZ1dlQzZ6R3da?=
 =?utf-8?B?UGR3ZHlQUStnSjlySzNIcS8vRWhpcGdNYnFhbVlVUmM2ZkFrdE1JZ3l4YXQ2?=
 =?utf-8?B?L05GMTE2UTF1blAyMjY2Q1UrK0IrZHByOEUwYjFrWEdic1pUVTNpZDdUTm1V?=
 =?utf-8?B?RytnMWxyWlM2WllCc1E0dW9RRHltSWE1eWtTN0NtV0VtTDNNWW51V1YweHNY?=
 =?utf-8?B?Sms0Wkg0bDN0NzgwMnk3ZGxvWDZkY2pHbVNuaFpacFpiSUE0VkUxWWtZT1Fv?=
 =?utf-8?B?MmZ5NS9lL28rcXFYTGJ3Sy9qUndyODhFWmhYRnpiTFlaWUZEazk1WVZ0ZjEx?=
 =?utf-8?B?TStRclVuOEw1WFBidWlVS0cxeFJPWmo1OHpzbnN2L1dYUkhWZzhrYjk4Rlhm?=
 =?utf-8?B?TnF5dmE1KzJnV1AweXU4LzFDaFdLY3EvVkZNTGJPaGVyTHpuWTRwNUZGMEJQ?=
 =?utf-8?B?cW5UNStuelZ3SENoa3BwMFVjUmtTOVVzQmhFdEdsUm10bi9ZM2QxUUlmVFBr?=
 =?utf-8?B?bEdoMGo5TDRqWWgvMEVJUlV3NHhSYWFEaGw4OW9tZzQxay9heTBySktNTHc0?=
 =?utf-8?B?S2VZNVVXZHdLZDNWdnBoVlo1VDRVK0xick9qb1JXUGhFS0V6cHY4b01lbVo4?=
 =?utf-8?B?RDgvdXdDNFRVNlhlcDUra1hhUVVvUnN4L0tEcTZhdU9RVmhTTlRqbFZSLzhX?=
 =?utf-8?B?S3A4MHA5akNNUUtXRGdiOWlLSjEzUTB5WXY2SnpwZDZZYnpLSlN6dVk5SEw5?=
 =?utf-8?B?VDB6QzdzZitaSXhndngwdTg3QlJ0MmU0eUpwUFNrMEhEQUZkMGRObnowYnY5?=
 =?utf-8?B?RWFTU0lnWmx0dTRUVmp1UGpWNXBmTXBGSkIxUVNmY2x4cWlPT3MrK1llR01E?=
 =?utf-8?B?dHZmL0txcWFudmcvMXlBTE1MMnFVc3Exd0JJc0hXb2R5c1hMMGxtMW9DOGg2?=
 =?utf-8?B?Zktpdm94TUZkWE9PdkliN2JuS1pOMlZOWUhlNHhCRHM1WnF2NGFlQzBybkZL?=
 =?utf-8?B?N29IMzB3L1QrT2lVK1gyVHFQZG9GeEFMYU03d3hmem1SZXJGL21LMER5ZUFq?=
 =?utf-8?B?cDlpUnNzUi9Wb3lkMnA4TUxRemRjR29WenM3UEh4VW41Y2pISU5iMW5KeFIw?=
 =?utf-8?B?MVFjenkxdklSb00yTDlDcWxGakpWRFlMcHA1REp1bWFHaUFFZUJpUmR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXBZTVpSbUZXSmtBRmFkbkhhWVNhdHVBM1pmbnlvazBXQ1JrbzJTWUx5WEFk?=
 =?utf-8?B?NjF0Tmt4V0ZDMWVVT1Q0NEsyaXVMZjJGMWVvRGpPNHltWlduOEN1L3RSN05I?=
 =?utf-8?B?dWxnSEVaMk5ETUZDamFCak04cERCVGxlTFJVK3p0U09ORjl0WFVIYXpVY1VI?=
 =?utf-8?B?Z3dncERicExVRlFOeG5sTzlnWTM3WjM4RG8ybVhFT0dJQmVyQ2U0bUprRllr?=
 =?utf-8?B?eXBmNjFrQU5wdzVrSm55UTBpYy9iYTdGRC9mODJPOHZLTWM1MzlVR3N6ZDNW?=
 =?utf-8?B?OGhxcVZOcXVyZ2tZemJqcEw5Q3VDYURMUndQaDNidCtDd25yRUxRNTM1b0JB?=
 =?utf-8?B?UzRmSkZHYkE1RG5GYmQ4aXdPNkR2c2VSWC9PZWNBRFZwQlRqUElaYmhNV1Ar?=
 =?utf-8?B?bEFlVk1Hblg3WHBZRENOWWZZYWxnV0RWbHFVd0dEZzRZYlk4dDFkdUZpQVdl?=
 =?utf-8?B?YWVzTCtZdWEyVWJ3cWcwLyt0dWxFTVY0R0hLS3hxT3ltVk1xejZEMFhPbkov?=
 =?utf-8?B?NlE1enora2YrcURFWmlUNVRqVTU3RXUvQURSRlc5UkZwbVVIZnNiaDdnSlMy?=
 =?utf-8?B?WnJDRG4wWVdMUkhsT0JRZ2lVamdXVkF4bWVkSjRYRFZZTndHQUk5NXd6V295?=
 =?utf-8?B?L2NlSmhBNThieWdrbjllNVhxakpsTmtzOS93ak9TVU8zbkFKaElnNUx3TGgv?=
 =?utf-8?B?ZUNWdVBQTVBFOGpwblRrbCtYdExPdmNRNWxTSjRYYTRtTjJNVDdNeDR2U3Iw?=
 =?utf-8?B?QmJTeWN1b21EWWxPWFR2MGFlcVVObTdDTkFiakx5b0pHQ1BCaU45enNjSkEw?=
 =?utf-8?B?KyswY1R6SVZybnJZcklaTGdIT1M3cVcyTlVxRnhTdkVObjJaYWtzZTBwemNO?=
 =?utf-8?B?UHlDbUZjcVZ1dEZZT2s4NHhsY2ZJa29OTDVCd0p4emxoaFFUYnFSejQ1R1dp?=
 =?utf-8?B?SDByZGRreDllOFcwbU9TMjFVU0lYcjdNNHhlTmR2QlNRQkZQRDVGdjZnU05O?=
 =?utf-8?B?R1VwdWpOVTRvc3ZBeTBiNTM5cVM3OS9OUXNQeVUrTXFlV0pxUXBSR2dTK1p5?=
 =?utf-8?B?WGFUOVdkd3h5dmwveVZMOEFhS1FBTytUbzkwL29nSEdTSVJUWkZMWk5XZ0tu?=
 =?utf-8?B?ZURyNS82YVNOS1FZL2t2eDRYZUZaWWVVTlV6QWVlLzNDMzVmcDNwa0M4YUxP?=
 =?utf-8?B?Q1d6d3RoYlNDUEJJdmtQM3RkaDhaUklFdGpLSzdUSkJUbkVLNW5LdVBCN09i?=
 =?utf-8?B?T2dLQmRjWE1uaGlWMFZJd1NlWGE3emQ1LzVjK1F4a3FwaXdQaEtnR0xuTjdY?=
 =?utf-8?B?bHNRQzAzamF5eEVBd1ZueEtGY0RKUWZoUmp4WmxkZ1Y2WTBRaWowL3JvaXA2?=
 =?utf-8?B?NG9HcG92UGN4aHV1UGpWRWlxMVUwTEQ3OEoyczQ3VTR0MGtocGxMTGg1M2VN?=
 =?utf-8?B?c2YwY3NyL3BEWjYzQlg4ZHJZbjI3WXpLMEljRDlFQVozd2pxODJVRkdycnJ3?=
 =?utf-8?B?cnhQOC94S1kvOHphSUlDa3MrUGh0NDRLNi9hbXo2TjRFTWJRTUVRUXVzRnVj?=
 =?utf-8?B?QzIvOWk1ZE1PUGh1RkExKzhxUUtrRk90YzJoVnhMSVgwbHpzeE9uRFB2S3Fu?=
 =?utf-8?B?akpVaHB3UFRTWTA5ZVBPbkRJWjgyTHBJSVlJZHMyR1ZSTnZPRm9ReFVRS0xh?=
 =?utf-8?B?K0hoU1lXU0UrY29lT1l5V2JWeEcvVUV0OERwSmRROTVwRXJ2Y3k2WjNldUNu?=
 =?utf-8?B?THBKVlpiRVR3aTFyUmdxL2hmOXFvejV4ZFUrclVtbzQ5SWptVjVsTEhmTU5U?=
 =?utf-8?B?eWFIQUpwUS9yTlJncmtvRlZvanh5VDgxL0FCVTBNNU1IUHc2UXpSb2g2K0cr?=
 =?utf-8?B?VVkxbXBNTys0eTMzcUlZRnd2ejFDT2xnb0NYY1lDdXlDZndLaUZvS1I3MTY4?=
 =?utf-8?B?VE5xR2J1aHFvU1JYeWUvenowaUFSSjNraFdnQzZPMktEYjQrb3JJN3RHNlJ6?=
 =?utf-8?B?d1N4b0RIWEVaVjBxbkV6V0xTaXFsNUxMbFpWZW5QSUhHUTBEQk81QXlCVHkz?=
 =?utf-8?B?MUJpSVZqWDQ2ZEQwRlZ3b1VMZXQrN1lNbW5zbkxDUENHaWp2WjFhS1JNNCtr?=
 =?utf-8?B?eENVTUNKdjlyS0lmMjZrMmpIOFNjZEFqd3ZxNHhRdUF6dXA3NnYyT3pDS2RR?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d96933-e702-4107-9499-08dc7f24934b
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:43:44.7411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lR85eiEUyTgT/Xrsk/5xpALogCOyBEnZHSP7LEMxhKuyJ2P/LlYWuLEm8LI3WZW0N2IucW0dEp0C1/vq/YrheMxTIAxgsLXBPrVxzTIxClo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4717
X-OriginatorOrg: intel.com

On 5/28/24 11:11, Shay Drory wrote:
> Some PCI subfunctions (SF) are anchored on the auxiliary bus. PCI
> physical and virtual functions are anchored on the PCI bus. The irq
> information of each such function is visible to users via sysfs
> directory "msi_irqs" containing file for each irq entry. However, for
> PCI SFs such information is unavailable. Due to this users have no
> visibility on IRQs used by the SFs.
> Secondly, an SF can be multi function device supporting rdma, netdevice
> and more. Without irq information at the bus level, the user is unable
> to view or use the affinity of the SF IRQs.
> 
> Hence to match to the equivalent PCI PFs and VFs, add "irqs" directory,
> for supporting auxiliary devices, containing file for each irq entry.
> 
> Additionally, the PCI SFs sometimes share the IRQs with peer SFs. This
> information is also not available to the users. To overcome this
> limitation, each irq sysfs entry shows if irq is exclusive or shared.
> 
> For example:
> $ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
> 50  51  52  53  54  55  56  57  58
> $ cat /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/52
> exclusive
> 
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> 
> ---
> v4-v5:
> - restore global mutex and replace refcount_t with simple integer (Greg)
> v3->4:
> - remove global mutex (Przemek)
> v2->v3:
> - fix function declaration in case SYSFS isn't defined
> v1->v2:
> - move #ifdefs from drivers/base/auxiliary.c to
>    include/linux/auxiliary_bus.h (Greg)
> - use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL (Greg)
> - Fix kzalloc(ref) to kzalloc(*ref) (Simon)
> - Add return description in auxiliary_device_sysfs_irq_add() kdoc (Simon)
> - Fix auxiliary_irq_mode_show doc (kernel test boot)
> ---
>   Documentation/ABI/testing/sysfs-bus-auxiliary |  14 ++
>   drivers/base/auxiliary.c                      | 165 +++++++++++++++++-
>   include/linux/auxiliary_bus.h                 |  24 ++-
>   3 files changed, 200 insertions(+), 3 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-auxiliary b/Documentation/ABI/testing/sysfs-bus-auxiliary
> new file mode 100644
> index 000000000000..3b8299d49d9e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-auxiliary
> @@ -0,0 +1,14 @@
> +What:		/sys/bus/auxiliary/devices/.../irqs/
> +Date:		April, 2024
> +Contact:	Shay Drory <shayd@nvidia.com>
> +Description:
> +		The /sys/devices/.../irqs directory contains a variable set of
> +		files, with each file is named as irq number similar to PCI PF
> +		or VF's irq number located in msi_irqs directory.
> +
> +What:		/sys/bus/auxiliary/devices/.../irqs/<N>
> +Date:		April, 2024
> +Contact:	Shay Drory <shayd@nvidia.com>
> +Description:
> +		auxiliary devices can share IRQs. This attribute indicates if
> +		the irq is shared with other SFs or exclusively used by the SF.
> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> index d3a2c40c2f12..579d755dcbee 100644
> --- a/drivers/base/auxiliary.c
> +++ b/drivers/base/auxiliary.c
> @@ -158,6 +158,163 @@
>    *	};
>    */
>   
> +#ifdef CONFIG_SYSFS
> +/* Xarray of irqs to determine if irq is exclusive or shared. */
> +static DEFINE_XARRAY(irqs);
> +/* Protects insertions into the irqs xarray. */
> +static DEFINE_MUTEX(irqs_lock);
> +
> +struct auxiliary_irq_info {
> +	struct device_attribute sysfs_attr;
> +	int irq;
> +};
> +
> +static struct attribute *auxiliary_irq_attrs[] = {
> +	NULL
> +};
> +
> +static const struct attribute_group auxiliary_irqs_group = {
> +	.name = "irqs",
> +	.attrs = auxiliary_irq_attrs,
> +};
> +
> +static const struct attribute_group *auxiliary_irqs_groups[] = {
> +	&auxiliary_irqs_group,
> +	NULL
> +};
> +
> +/* Auxiliary devices can share IRQs. Expose to user whether the provided IRQ is
> + * shared or exclusive.
> + */
> +static ssize_t auxiliary_irq_mode_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct auxiliary_irq_info *info =
> +		container_of(attr, struct auxiliary_irq_info, sysfs_attr);
> +	int ref = xa_to_value(xa_load(&irqs, info->irq));

just a note that you forgot to take the global lock here

> +
> +	if (!ref)
> +		return -ENOENT;
> +	if (ref > 1)
> +		return sysfs_emit(buf, "%s\n", "shared");
> +	else
> +		return sysfs_emit(buf, "%s\n", "exclusive");
> +}
> +
> +static void auxiliary_irq_destroy(int irq)
> +{
> +	int ref;
> +
> +	mutex_lock(&irqs_lock);
> +	ref = xa_to_value(xa_load(&irqs, irq));
> +	if (!(--ref))
> +		xa_erase(&irqs, irq);

Global lock makes it indeed simpler to support xa_erase()-on-zero.
There are simple solutions without erasing zero elements (you could
have non-allocating store), but let's say we are leaving "the simplest"
room then :)

> +	else
> +		xa_store(&irqs, irq, xa_mk_value(ref), GFP_KERNEL);
> +	mutex_unlock(&irqs_lock);
> +}
> +
> +static int auxiliary_irq_create(int irq)
> +{
> +	int ret = 0;
> +	int ref;
> +
> +	mutex_lock(&irqs_lock);
> +	ref = xa_to_value(xa_load(&irqs, irq));
> +	if (ref) {
> +		ref++;
> +		xa_store(&irqs, irq, xa_mk_value(ref), GFP_KERNEL);
> +		goto out;
> +	}
> +
> +	ret = xa_insert(&irqs, irq, xa_mk_value(1), GFP_KERNEL);

make code simpler by one common variant of ref++ & store

> +
> +out:
> +	mutex_unlock(&irqs_lock);
> +	return ret;
> +}
> +
> +/**
> + * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
> + * @auxdev: auxiliary bus device to add the sysfs entry.
> + * @irq: The associated Linux interrupt number.
> + *
> + * This function should be called after auxiliary device have successfully
> + * received the irq.
> + *
> + * Return: zero on success or an error code on failure.
> + */
> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
> +{
> +	struct device *dev = &auxdev->dev;
> +	struct auxiliary_irq_info *info;
> +	int ret;
> +
> +	ret = auxiliary_irq_create(irq);
> +	if (ret)
> +		return ret;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info) {
> +		ret = -ENOMEM;
> +		goto info_err;
> +	}
> +
> +	sysfs_attr_init(&info->sysfs_attr.attr);
> +	info->sysfs_attr.attr.name = kasprintf(GFP_KERNEL, "%d", irq);
> +	if (!info->sysfs_attr.attr.name) {
> +		ret = -ENOMEM;
> +		goto name_err;
> +	}
> +	info->irq = irq;
> +	info->sysfs_attr.attr.mode = 0444;
> +	info->sysfs_attr.show = auxiliary_irq_mode_show;
> +
> +	ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);
> +	if (ret)
> +		goto auxdev_xa_err;
> +
> +	ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
> +				      auxiliary_irqs_group.name);
> +	if (ret)
> +		goto sysfs_add_err;
> +
> +	return 0;
> +
> +sysfs_add_err:
> +	xa_erase(&auxdev->irqs, irq);
> +auxdev_xa_err:
> +	kfree(info->sysfs_attr.attr.name);
> +name_err:
> +	kfree(info);
> +info_err:
> +	auxiliary_irq_destroy(irq);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_add);
> +
> +/**
> + * auxiliary_device_sysfs_irq_remove - remove a sysfs entry for the given IRQ
> + * @auxdev: auxiliary bus device to add the sysfs entry.
> + * @irq: the IRQ to remove.
> + *
> + * This function should be called to remove an IRQ sysfs entry.
> + */
> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq)
> +{
> +	struct auxiliary_irq_info *info = xa_load(&auxdev->irqs, irq);
> +	struct device *dev = &auxdev->dev;
> +
> +	sysfs_remove_file_from_group(&dev->kobj, &info->sysfs_attr.attr,
> +				     auxiliary_irqs_group.name);
> +	xa_erase(&auxdev->irqs, irq);
> +	kfree(info->sysfs_attr.attr.name);
> +	kfree(info);
> +	auxiliary_irq_destroy(irq);
> +}
> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_remove);
> +#endif
> +
>   static const struct auxiliary_device_id *auxiliary_match_id(const struct auxiliary_device_id *id,
>   							    const struct auxiliary_device *auxdev)
>   {
> @@ -295,6 +452,7 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
>    * __auxiliary_device_add - add an auxiliary bus device
>    * @auxdev: auxiliary bus device to add to the bus
>    * @modname: name of the parent device's driver module
> + * @irqs_sysfs_enable: whether to enable IRQs sysfs
>    *
>    * This is the third step in the three-step process to register an
>    * auxiliary_device.
> @@ -310,7 +468,8 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
>    * parameter.  Only if a user requires a custom name would this version be
>    * called directly.
>    */
> -int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
> +int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname,
> +			   bool irqs_sysfs_enable)
>   {
>   	struct device *dev = &auxdev->dev;
>   	int ret;
> @@ -325,6 +484,10 @@ int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
>   		dev_err(dev, "auxiliary device dev_set_name failed: %d\n", ret);
>   		return ret;
>   	}
> +	if (irqs_sysfs_enable) {
> +		dev->groups = auxiliary_irqs_groups;
> +		xa_init(&auxdev->irqs);
> +	}
>   
>   	ret = device_add(dev);
>   	if (ret)
> diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
> index de21d9d24a95..760fadb26620 100644
> --- a/include/linux/auxiliary_bus.h
> +++ b/include/linux/auxiliary_bus.h
> @@ -58,6 +58,7 @@
>    *       in
>    * @name: Match name found by the auxiliary device driver,
>    * @id: unique identitier if multiple devices of the same name are exported,
> + * @irqs: irqs xarray contains irq indices which are used by the device,
>    *
>    * An auxiliary_device represents a part of its parent device's functionality.
>    * It is given a name that, combined with the registering drivers
> @@ -138,6 +139,7 @@
>   struct auxiliary_device {
>   	struct device dev;
>   	const char *name;
> +	struct xarray irqs;
>   	u32 id;
>   };
>   
> @@ -209,8 +211,26 @@ static inline struct auxiliary_driver *to_auxiliary_drv(struct device_driver *dr
>   }
>   
>   int auxiliary_device_init(struct auxiliary_device *auxdev);
> -int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname);
> -#define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, KBUILD_MODNAME)
> +int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname,
> +			   bool irqs_sysfs_enable);
> +#define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, KBUILD_MODNAME, false)
> +#define auxiliary_device_add_with_irqs(auxdev) \
> +	__auxiliary_device_add(auxdev, KBUILD_MODNAME, true)
> +
> +#ifdef CONFIG_SYSFS
> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq);
> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev,
> +				       int irq);
> +#else /* CONFIG_SYSFS */
> +static inline int
> +auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
> +{
> +	return 0;
> +}
> +
> +static inline void
> +auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq) {}
> +#endif
>   
>   static inline void auxiliary_device_uninit(struct auxiliary_device *auxdev)
>   {


