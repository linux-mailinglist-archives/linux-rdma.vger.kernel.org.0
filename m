Return-Path: <linux-rdma+bounces-2448-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D76098C3D57
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 10:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C670B20AFE
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 08:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C71F147C88;
	Mon, 13 May 2024 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ymr7Ee5V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59400147C7A;
	Mon, 13 May 2024 08:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715589215; cv=fail; b=hGie1T3rXWR8UcplHEBB3oZC+oTJoOHvLBJX+x3SQpAQARPQhyp3yBtBoF3gOORcQPzyNXBIklrzh3tCe13UDD0FVULmPf9lHa80zAFPTA3kIYykghBQBJ+9SxMTewxFUXc5aTG9AR7LMboGGNAF9DqMbqkFZRZBncl3V0s/jRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715589215; c=relaxed/simple;
	bh=prJP4SE2bHrll+PUvgOdNZuvAEULOPTwxMuhHV6xlK4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=spMHQc0qoYn6Z4HuW3TXa6+r0YRBk5RRlZfzspd5RoCS5DF4lUt+5v4POTplc2LM3xC+4/KtvfnAUNf5h9XJgR3bxhsZYZjfZaJwO4QSrUCe/n+R7AN1RmjdIEMiZAZCw/Q1QOrXUek0fylarE0UdkgRpLrkJjnNo6/+vInLcqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ymr7Ee5V; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715589214; x=1747125214;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=prJP4SE2bHrll+PUvgOdNZuvAEULOPTwxMuhHV6xlK4=;
  b=Ymr7Ee5V0wedvmZy7G2jY1iAx61LDfad8ssiYyTFQXWeN/dgRHnBOjWI
   MZCT4Yynk6DoueM10oXQFB8FWjveSdsOVLKczlRvgjSipK5eitp9T83tA
   DMMv7xrSGFx16g3ZIEwfoABJxjAk05ClU+Eq7lFgtRwh2K3M7QcFax3wO
   /BWvShn47lKVS5KQi0iOWd56vGYhvqgWSqEgy8YA7r0UOkWnTH6RevByq
   AyQFuXXXFNaCweu/I3uTZHkUlNbOJub9EhPRzKVNGyk5oP3uo+V1OhNPW
   Nnynx1Sxh9y0y0Qtw05qYUdwpGWCnRxlrJ/g25AKcbEslA2vtmBW07p4w
   w==;
X-CSE-ConnectionGUID: o8/xZi5ZSrW7zoT/OlyMUQ==
X-CSE-MsgGUID: GN7CSjcwTmOHVPEnk/mZAA==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="29001846"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="29001846"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 01:33:34 -0700
X-CSE-ConnectionGUID: 9WlUvpisQkCfL/MR1YZBEA==
X-CSE-MsgGUID: jKpjludRRiqgrf51gtfd4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="34689590"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 May 2024 01:33:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 May 2024 01:33:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 May 2024 01:33:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 13 May 2024 01:33:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 13 May 2024 01:33:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMOSrQTfkAvF/Lo0FygQVFmYvEgMEUfsVvENMpsjekdSbgV45Bz25oreKE4sC/NBbkZiGI1p+qh7kmXI7mjKOp5qKKgl+oaKy0jc0lPhs0BgXtV96omDkIKV74KTYAI9mVh0RWWDfnYE1zV1UYDp3T2hccWTYlxcNkiINzNKIcvvz7ptVEi6cXh2XgQekX/L2YXBdK5OlNzGum/K9I+BOF469+AVHqU5a/bTW6/jx6eoucC5YE+YZRiD5u76fikVUxum3rVaz1E6o9ajiAIO6CCvQssEuJW7rqvMV4UoVqklmCbCQAVbcFZcdyvZmOdMVQLSZRy9sBUj2rZd7ITJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ta7SXMNj9tkcWAgcbXe4xCHaoD2WSuJrIfdelw3BfK4=;
 b=FZW9LNcT6GRRLfDp4w56nAeZ1EbKYoOAVP03zf528lIhVcuI2cTrSxSk/l0IN9IZKN+PS6B5gcM7XC/cGv0aNUeLHAgdYmyP/k4RgpUH6ufX6isdNP14N72dwA96MGhOVnsIWIBoa0b7+KyJHDiQikDr9rre8ieIo5QQx979Djw/aP9pxw5mOY6rpzVI2IvHkWiqjJHuPNqEar3OwtRjnp4mMJ6wMqQhFhIEfvO8T8c8RkqblnSiZsCWh2vUPvEnPGNDiQvQMjQQTlauM8HquvvIyNazwFQA2oCy87ZB5g1jvTX4JYTFfmdrGs143JtnRpYoR8GMCl5gYYLOmCUyzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM6PR11MB4595.namprd11.prod.outlook.com (2603:10b6:5:2ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 08:33:29 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb%3]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 08:33:29 +0000
Message-ID: <5a3520fa-590f-48be-8594-de44ae4eb750@intel.com>
Date: Mon, 13 May 2024 10:33:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Greg KH <gregkh@linuxfoundation.org>, Shay Drory <shayd@nvidia.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <david.m.ertman@intel.com>,
	<rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Parav Pandit <parav@nvidia.com>
References: <20240509091411.627775-1-shayd@nvidia.com>
 <20240509091411.627775-2-shayd@nvidia.com>
 <2024051056-encrypt-divided-30d2@gregkh>
 <22533dbb-3be9-4ff2-9b59-b3d6a650f7b3@intel.com> <ZkDg8Aj/TdOqFwqf@ziepe.ca>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <ZkDg8Aj/TdOqFwqf@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::6) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM6PR11MB4595:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7657a9-afe1-469e-0491-08dc73275de8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWl2V3hNbHRWbURHN1U2SW02STlnQ3NaNFNzVVhUYm1rMUtqd2wya2Jhc0tV?=
 =?utf-8?B?QmtGcldjaDhoZmVMSW9ZNVZOM1MwZzd4NXhPY0Z1MVBLcVZaVlRaekdvOFpK?=
 =?utf-8?B?QUlDWjBRQVg2eTg4ZWwyNXFuR1FySHZVWE9Hdno4T2IySExRS3BCMWxObktp?=
 =?utf-8?B?WHM2UDM1dVpKYk54UkFpc0RwYXdhUk92SWlZUVluY3ZOU1Z2TTBtNlNPcWx0?=
 =?utf-8?B?RWRhYm1IQkZLek1IbHc3SStySHlBN2I1REN5eVNGZ3ppOVhkcUZLWmpqYkhj?=
 =?utf-8?B?Y3d6K0duVmdaMGE2TW9vbnNKSEFNSHpZdktTSTJaMktIWm5MOGRwVWRzR1ow?=
 =?utf-8?B?NE5IMjhWdGZyTDFXRWdGK3gycE9HSGdGKzRXQ0dHclRMUXlucWR1VFBmbDFa?=
 =?utf-8?B?VjZUbzZBNXR5TVdwSE5BenpmS0NHUHBVRFBnZEgzbFh4bm9VQUVkeEl4OXpO?=
 =?utf-8?B?K2MxdFVLaWx5ditrMFZ2SEFWWDNVRnUydHJiTm5MMGI4dzlTbjIrVnEzdmVY?=
 =?utf-8?B?RHVhTC95K3pZU0RObVRtWjh6YzhCNDczYzZuSUFZUFY5M25hbjJxV3NnY1Fh?=
 =?utf-8?B?RUZKNVJSWGU4QlR2Tk1ZTG9VNGZTdnJoZmlqK3pvY0ltdmVvWjhTWXl2K2tw?=
 =?utf-8?B?NkZnakhxblY5RFdPVmlSKzBXL3pBMHZ2RVI4UDhCN1NIUXB4K1VIV2V6Q1hl?=
 =?utf-8?B?LysrU0piQ0JkSHZUeU8yQmVxK0YyZE4rQnpQNElmVllaTWsrZi9lNVJRbVRa?=
 =?utf-8?B?eGpDNytjREI1amVzcWJqeERKaWFQM09qMjV2Q3k1eHJEZlVDVlA3Sk9CdUZn?=
 =?utf-8?B?cFlETFBoUHpQL3lFVVNVdkFjeVI4QkxBWDFsVFBmVFZVSWtFQTBlS05tU2Z2?=
 =?utf-8?B?QmpMdjZ3bXJJOVBQd0YzUWtwNzBuSkg0V0gyN2Z4dEIxeXJZR3k3QTRoaWpS?=
 =?utf-8?B?WFRPZE5vcHlEWDBrMmkzcldtblM5aUhqZUJkOC9PbkQxV004dG5Ud1BjeWdO?=
 =?utf-8?B?SkdrRGhTTFNtWW1TVlFlQVp5emhpaU5uTE1OcitkM2srbm5VRHVrcjNzL0li?=
 =?utf-8?B?bjgwZTZUMndDZTA3SGFrblp4Ri9iQUFvSjBMMGVrVGR6WnlFa1R0VDNTZThp?=
 =?utf-8?B?TjVZSjV5eFNpbEJWc3FnMTRLdzhEZ2R5WDNURXZPUkJCOFlqbEQ4REZuMStF?=
 =?utf-8?B?d1IwRWVlZkpaK2paOGkvd2MyWGFDZnNydFUrMFNhMmo5dEU2SXFuZjlvV2NG?=
 =?utf-8?B?Z3R5SElselE3MzNhOXVTa0VEVGh3Ymtpc0ZUemcrWWtWeC8vRGFqV2NSN2Yw?=
 =?utf-8?B?TExoTXdhNDRnRVR1eUJtQVptbXZpaE1TMlJCN0V0aHV6YkpoVnNqOGREOE1t?=
 =?utf-8?B?VzBDZzIxcVVULzBTZ0RsUDV1cDltWkNManVQK2c2ZzVjNFRDMHU4aENTYlMv?=
 =?utf-8?B?KzZLSHBtVkZZQkM4RDdFL28yRktVVy92cHBqMEpSNGtnZTgzY0ZWNzZET3d2?=
 =?utf-8?B?eWtNdnQ1YkJ0bGFudkJqZUJya29pR1ZhL29Mcnljd0t6Q3lYNjZpbEhLN0hs?=
 =?utf-8?B?cmVSRjhIQVlLdlU4SWwrUWFBMlh6QjVtbkJIai9UTnVXOVM5NEhZWVRTOW15?=
 =?utf-8?B?VTBjYXpnOGNBcHgwbFFnVUVQSlUwTnpHaXV1NStOY1lBcTBvaFJOTUJiODlz?=
 =?utf-8?B?cWpnWHhPL2xwaVFBdXFReFoxT1JLS1crd3o4SzZ3WC94eHpzaXMvWWhnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVJVSVdiaFlLRFJzb1pXYy9rcHhSVWFrK3RNZDduY0VBSTlDVnJaRnNiSjNk?=
 =?utf-8?B?MTdsYkxJbWVQcE1mQTZRLysya01oNmJUUkxpOGF4UVNVN3JZd0xsUzlCOFdj?=
 =?utf-8?B?ME9ENkc1cHhSR05QT2M4V1o0VmJpQ1ZIeHh2dlZNRlFDYUhQajlXMk9GVHFi?=
 =?utf-8?B?RE1kOTFONEZSYWVub1FpMkZHY3Q2eDRhZCswTldmNS9uN1ZYRmVJUGZZZFpE?=
 =?utf-8?B?WG1yS2FTZU1UVkRhL1krczMxMDgyVklVWGZPWkJlUVFmN2djVzJIOTgvSUNP?=
 =?utf-8?B?bUlFWmJ2Vk9MM1hyZFdrSmVQbjV3bDd5WitKaEk4Q3VYdE5ZQzhRN2IrQ0I0?=
 =?utf-8?B?YTNtd2FDcTRxcDZvOVRRbWZobkQ5OWZWTFZ2YnZhOCtpVGMyc0xqY292NTRx?=
 =?utf-8?B?cVduS1lJMERmbXIxWGZHR09nY255Z1BONzR4ZVFQd1Rjd3doZWZpTFpuWGZy?=
 =?utf-8?B?Vkgwd3JkeWl4VmJBbzlubFF4YWNseFphd2RBOUc5NlNDeTZaUzNtV0poUE5y?=
 =?utf-8?B?MVVPZ2tIL3lhK0RjZmt6bVVDQjhzcFFxK1lxaXZ4NlhNL29TdjNZLzg1TWFC?=
 =?utf-8?B?SUx1czY4eFR2TDF0a3g2cmNITkVuSE5XYWROenhaTWE1NkZXU21URUR5T0Zr?=
 =?utf-8?B?MmR5OW1NTnI0K1Fpb25Zd1V4M0VwR2ZlbUxrbTZkbk96ZEJ2Mlc1aU8rUWto?=
 =?utf-8?B?ZFJPZVlUNjZ1Q2NScTBpYXUwSnloYWIyUERLSHJvbHNocFhHd2RwMnNzeWFy?=
 =?utf-8?B?ZU94bThrYVAzZlVxRXVoTWVyL0RaY3RjeExXQ2crcFZ0OElrNk9kTDYzb2Y5?=
 =?utf-8?B?VUE5LzlwMk9SalVvNWdNVUVDWjZnU0xxZ2F4NllORWJTcHdpTFAwZy81bEgx?=
 =?utf-8?B?RFZqejBJaEozZnBsTEFoWTB5Q093Q0dZelVZZ2ZzNGxMaTNlT3FScmFibkVY?=
 =?utf-8?B?SnNoWU5DZkxxZWN6VERiYlNQZG9yNDhBV2J4ZklDaHR6b1JxNzhYbEpRZW00?=
 =?utf-8?B?VXp5THdhdk9wa0Z6MDJMRURsQzFPTjVUZjgxbERraFlPQlhYcWhoUko3VzJG?=
 =?utf-8?B?eVB2WWZYbThjWDZrQ3BTTFhCWCs2cTlRd25kY29wRkJzRmYwTDd5YzV5R0Jx?=
 =?utf-8?B?c3Fsc0FvMmVoNEhpcTREeDVrb1Y3TytpUXowYVIzb3hMZmhhS1htZFkyMno5?=
 =?utf-8?B?NkxiUDhxeXlYUm5oZWNFcGQ1aUN6VWdFeCt4U3ZqaEJFZTA2c0wxODZ5M3JT?=
 =?utf-8?B?SXFsMnE5QWNBb21mOEF1ZmJYN2N2VmxNV3ArR3dxQk9oa09tZWdzVVJJVU9j?=
 =?utf-8?B?LzBQZ1p6enRYdHIzV0h2TTJkcjVCdmhOdURQNGVQVjNQM2x5eEw5Z3kzZ0VK?=
 =?utf-8?B?c2cvNjVuV3pNdVdTWnkvdEY3c2xONGZDVWp6RmFORll5a0Rpd1U5citBdFdY?=
 =?utf-8?B?SEJJbnlYZU5PR3craUQrM1U1V2d1Q3NOaFZFMC9EdU13bXUwY2NhaGhPYkZj?=
 =?utf-8?B?anNKcUNtMjNDWERCUHVqcWx3NzRrM3B4bmF3d0M3L29TeGdnM1JRQjFLaFVQ?=
 =?utf-8?B?eHp0NjYxaWFGT0srd1JoK01qYTdjbzZjUElqSFo0S05uSnBrc1BSQU4vMWZY?=
 =?utf-8?B?TFR5UzBqaW5TbWtSdnRpV093TUticzA4RUR5aVJId3dqaGhRdzN0TjRPYXJW?=
 =?utf-8?B?NW82WHoyWTlHLy9lUXBHb2djWnJZUE9aTk5FdjMzSWlrbnJjS1VYL0VmY20y?=
 =?utf-8?B?OVFOWW9zM3NNaDYzZ3BvRkZCMXdQVGZzcVBUWTVlTzlURVZQQVlOdDAyOVFq?=
 =?utf-8?B?RjVYa2VoRm1udDZCaVhPYWdQOEZtNFd1WnRiek5PQWloYmt0R2lNVjB5Rm8x?=
 =?utf-8?B?bHlGamxGdWhrdzhGSU94U2FEY1JyWXNONDM2dHhlSzVDTFQ2R0VQZ1M3R0hp?=
 =?utf-8?B?RVpOYzEzUjZPWE9EWU9LU2FwZk1zQ3p0NGVJNnpwbndIZU9NalVYL2VuRVZu?=
 =?utf-8?B?cHlMK3Y3bzArVStTR2JoUlJFR0JqS1hkdStWckozaktmWitobUJhV0l4c0Zp?=
 =?utf-8?B?N1pWK3RQNExNN1hjTWp4Z3VQaTBJQnNyRmdvczl5TzNGOElsUFAxRFlzTlpu?=
 =?utf-8?B?enFldTNVL3ZpYkFKUWVkUTdaaHBLeEN3UGFRdU5ldm1hTG5UZkNXRitkejda?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7657a9-afe1-469e-0491-08dc73275de8
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 08:33:29.6962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtNb7YReLhYO8ySzjcecyS0Hcn5pBw8UBRh7iKm/m2PDCAnqITyU/C0v970daW4Vj66FdhdkN0HXmPPdo2RCRmNQZKHOamddA4AJTiL6aXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4595
X-OriginatorOrg: intel.com

On 5/12/24 17:32, Jason Gunthorpe wrote:
> On Fri, May 10, 2024 at 02:54:49PM +0200, Przemek Kitszel wrote:
>>>> +	refcount_set(new_ref, 1);
>>>> +	ref = __xa_cmpxchg(&irqs, irq, NULL, new_ref, GFP_KERNEL);
>>>> +	if (ref) {
>>>> +		kfree(new_ref);
>>>> +		if (xa_is_err(ref)) {
>>>> +			ret = xa_err(ref);
>>>> +			goto out;
>>>> +		}
>>>> +
>>>> +		/* Another thread beat us to creating the enrtry. */
>>>> +		refcount_inc(ref);
>>>
>>> How can that happen?  Why not just use a normal simple lock for all of
>>> this so you don't have to mess with refcounts at all?  This is not
>>> performance-relevent code at all, but yet with a refcount you cause
>>> almost the same issues that a normal lock would have, plus the increased
>>> complexity of all of the surrounding code (like this, and the crazy
>>> __xa_cmpxchg() call)
>>>
>>> Make this simple please.
>>
>> I find current API of xarray not ideal for this use case, and would like
>> to fix it, but let me write a proper RFC to don't derail (or slow down)
>> this series.
> 
> I think xarray can do this just fine already??
> 
> xa_lock(&irqs);
> used = xa_to_value(xa_load(&irqs, irq));
> used++;
> ret = xa_store(&irqs, irq, xa_mk_value(used));
> xa_unlock(&irqs);
> 
> And you can safely read the value using the typical xa_load RCU locking.
> 
> Jason

What if I want to store some struct, potentially with need of some init
call (say, there will be a spinlock there)?

I believe the solution is to extend xarray so it will alloc the struct
(think flex array or user/priv data for "entry") and even init it
(so two new functions).

