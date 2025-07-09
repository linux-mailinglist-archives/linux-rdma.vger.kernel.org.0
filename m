Return-Path: <linux-rdma+bounces-12009-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C310AFF4D8
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 00:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7295B4A0C7D
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 22:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450EE24EA90;
	Wed,  9 Jul 2025 22:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fT3M5sjO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3EA801;
	Wed,  9 Jul 2025 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100685; cv=fail; b=h+SzKKJnGQTCT9HBYeUx3KWGeOAXcHre9z3JgqfctTuLT0zZNUVqX18Dvq2rg8kTd11h4J0FWNBDTbfJgK0zENX/wxII1YAR9kOaDl83jAfFPfq1qG6GUmgl5DTP96ENsTznSp627t2H4+iNUQlTIf3IFTo1QkbskKmDsKdrRgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100685; c=relaxed/simple;
	bh=CYY7iU32Qk1MAZycH4nzakUVEAVa7URAyOUkZij15mw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O3gSz2RIi1hZsG2UU9uo4GlW1NuInnCk0osXHARh7W6PT9kYSJymddRqEZ6pNNhrF+Vme1j/6tA6Qo6BX7hAxYmtw0b0jl5MLJBQ05QCxxMIthxjWvQH6fdL8me4f36zMpCp0dmP/r2SjyUvWpb7CVwg9QJ41Af2fZ6r82F/BGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fT3M5sjO; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752100683; x=1783636683;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=CYY7iU32Qk1MAZycH4nzakUVEAVa7URAyOUkZij15mw=;
  b=fT3M5sjO/6eNSYxRwst2i5O8ABb3Um/wrbtooBwPVgbA/F9w71a3Qewe
   ZxcsFhcrJRfxm1Y/hf1PcGnKHztWcGuRBHMmeyA8gGBYpOap8PwRGl9QN
   6CKsgqQYSVhAtVvRPFN8Sh8vAUj3Pq3RGHa6HwnmbhVyP5WWWP6+zBROm
   AaeoUs38cycBZMMdc/0F0A7LvLpF1mPfK8ndJh/sh6wWyCLDb4SwcX+xn
   23ALaCkuc6p34uK4JC/LE6aPZihCJv1Fb5V2loZqgD6H7gk2zKyk2KyhZ
   y89sb0fsmbyWV8VkYhJkDQUZ8EoAQjoMHzMqNRR3eTucA8qbZORD7d64M
   g==;
X-CSE-ConnectionGUID: EhVMAsRITqK/Gh9jnf2c9g==
X-CSE-MsgGUID: 4nZYAodDR7akPukRYFHejg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="56982099"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="asc'?scan'208";a="56982099"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 15:38:02 -0700
X-CSE-ConnectionGUID: rtqtVi/pQIuoePvfg+W/Qg==
X-CSE-MsgGUID: PGYVrksPRo672WiopVNw4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="asc'?scan'208";a="160444998"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 15:38:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 15:38:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 15:38:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 15:38:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHsmb3ySEUEss8mhzDy1gbBIqONxT2apY952cE1Y1UYod6N4znADnPA4r7VJQIzWc/JsPcBlGjA1soFEJQ0wxbxLn/OLa8CqI/FwR1eF8fRcxWIHbUdD7X2ck+kUFmN2oA5f7LnB4Drut+HmHsiB33y6QxtxNGWD9q4NwRTrMu8DqR10TUi26r1woUN1HO4OEcQe2hU/48MSuI/1/qtjpLMO/u1x8tHPUileOD2+Q/TJYvjYZ4Mj9KL5KiaHxcK+Q91AMeDp6Q1DjQrIvqD0eX9eDKNv2vnbXVl8HgA0f6oTxsPVWiw4C0y8wZh2CZQW1e5Viutra3svlEVL2aeg1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYY7iU32Qk1MAZycH4nzakUVEAVa7URAyOUkZij15mw=;
 b=HYLHRY4Od2nwuJS8SXtP4/Vc2XsrLcpkVEI5UFPK6TRJVHayBo5YG8luwkwxDt4sae5eDSthNXKS56zewsTodOMJC76HUtIFQNosoJEPKEOpNSAi7UFUDtuQiJ0vRbpTqAZuI0aKPglOgJW0pCAO7y1CwOawv9nRmxQ6Ae5IhC0CwSAhkYoRuZ4TRVZu7TBKW5rbEQ6OPdmB6KvGd5FfJkiHDtdiZltDUcdBQbxRHTRz1UgBAqvIQqfn9f4CRwewdkuAY2ybN3TiKijD/U27OBgsM/0yxduzozN65n9m+JOdMeLqlLP5dXWIiW52fGUv9UlHk0zbcsZ6SqpDM02kHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV2PR11MB6069.namprd11.prod.outlook.com (2603:10b6:408:17a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 22:37:59 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 22:37:59 +0000
Message-ID: <b1afad99-60cf-41e3-8c74-2979ec595519@intel.com>
Date: Wed, 9 Jul 2025 15:37:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/1] net/mlx5: Don't use "proxy" headers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250709083757.181265-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20250709083757.181265-1-andriy.shevchenko@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------7uwQO41rAIRD8XjwO0A0xO5O"
X-ClientProxiedBy: MW4PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:303:8e::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV2PR11MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d16971b-7a61-4034-1a7e-08ddbf39415c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnFsOXVuamw2aHdQYWlGTmpmNDI3R1pFVUtManJocHJiZC9JRTZ0cEoxejl2?=
 =?utf-8?B?N05FMlF3K2d6MVBoOXRmbWtkeGh5VFlQZXRPTDNObXgyRXVVanUxWURjRkJh?=
 =?utf-8?B?WE14QzJCdW1lb2hrcUk2Q2c0ZEpZN2p1RGJacm92cWR2SHFWZ01TdEhMdWs1?=
 =?utf-8?B?b2IzZ1dXZXVkaUFNV0FkbmVsK3dIdjZ4cEJJNEluQ3dMV1FUZFpjdjhtZkhq?=
 =?utf-8?B?N0hYd095SkFJWE0rQ1A1RWVyOXNjVVNuL3FkRzRLZHFURE5Mb1d0OXJzL21Y?=
 =?utf-8?B?c1BxK0RYYnp1V25yMU1WM1NUMFRtZmc1RjhHTCtIL2dKZmhpZ1hDTkRSN0gz?=
 =?utf-8?B?ZXNmUlRMSGlOamlXVFdEKzE4czV2bWxoRlNISVlaRVh3bGFteStDejJCWGx2?=
 =?utf-8?B?UFlQN0FBRjE2RFZBeUY0TnB6b2cyNlhoZUJUMW5VUlFIWWVQYW5KNlZ5OEV4?=
 =?utf-8?B?S1NWeGczWWhVSDNJbk5xaFRNNEdQZHIxcmVZaHdSei9reXdDNnBOUkc2SlJa?=
 =?utf-8?B?TnNaNVVzMVFSeWV1TGJnZWY4ZXpqV2xOMUF4cmZkdWlITlVSUUJLVmhHQ0w3?=
 =?utf-8?B?LytnNjdnY0dXVCtuNmhCTzgrWmRHT1dmcjN3V2pTSVRZQ3hsZ3RtUUtsdytQ?=
 =?utf-8?B?Z2FIRTVISzd1aGUzVGRweWJXMFpGL3FkbEFCNGthVjhBc0JiOUNmMVRUSWFr?=
 =?utf-8?B?c0xmMnJZZGhsN083L3VmekNuQmNqRFFHYW42Y2dUVVZ4Q1E5dXNPcXo4ZFFa?=
 =?utf-8?B?N3hGV1hrNUd2V3YxMnVLTm1JRXVQMndLVFZQOWFuWXJSRHdXWFY0RStQcm5P?=
 =?utf-8?B?WFdMN1Y5eXVBVGtNaityOUc2cmZabVBCallYNEtKeFc0b0FzSlVwMHBYZ2Fs?=
 =?utf-8?B?UHZzVUlhK3k3OTVERW41WlBVTjdRQXd6bjBqUEJvRnBDSklkVU5kVFIzWWZ3?=
 =?utf-8?B?RXJVRS8zMmVUYlhhU2Z5ZjBhbkU0MWRWL3JaZmx2Z2RjN2VoUlhadWRXV3Za?=
 =?utf-8?B?SElGZEwrdWNvYWU3QkRQRVJEMEJkWDFSS0pFaWRkaXhmMGczR0JtdU1vMmt0?=
 =?utf-8?B?QUNMUjhwUncwYVIvM2JueUt5a1VoSnFibUZNSHdvbFY1RnhHN1MyRHZjZUV5?=
 =?utf-8?B?Q3RUeFVaRHJpUU11enlhTndWWFpSNkRUNHE2UGNGdDIwRVpsY1c5L2lvZ1Jo?=
 =?utf-8?B?c3BLS2JHUHFQWUVFU1FyN0Y1VTM2NEtUSHZMb0NOcVZWTEs1cE9jNFR4YzZt?=
 =?utf-8?B?VGszazVUTDIrOGFaS1ZXWUZmZ0JYWXZ5S0ZxWE5TRGdta0Nha3FkeWUvQzdy?=
 =?utf-8?B?Tlh1Q2pBbGhYenNWMDJpNHZmKzJIZnZmR2FETFdmZHBvdDJ1MkpZODVEMklE?=
 =?utf-8?B?Z2pEYjJpZ1J5Y01SWEdIZGU4dkVCaXRpbytZZytoUUk2OUI2ankydjRsQmQ0?=
 =?utf-8?B?R1V2a093TUhOOCs0NkltU2l1bmdzaGlkUjk0SGc4QkNsaXo4MzFqQThhb25B?=
 =?utf-8?B?MU40ZURKK3ppRFpoRVkyUlFpNXBJM0lmOTBZckZlVWx1Zm5TdEczYWZrS3Ir?=
 =?utf-8?B?TDhvcmtNOTh5RHJHNGg4MmViNzduNVorbGpCVTJaQklnSlZyVUZUbkg3Nits?=
 =?utf-8?B?dkFVblBqN1FRVVh6VzBDOEY4bmZRdnRJV0NqNkUvK3hJRWhNbkhncWpYVjhO?=
 =?utf-8?B?Q0VWUitTdUFreGllTjc3VndWd2Zxck91ZG5udXdzRUdPaitqWDJHaDN6TUFz?=
 =?utf-8?B?SmVHak5uMHNia25ZRTJQRDhIZjhmSFBxYW9WNVZvMUJCbEV6blRQMlV5Qlph?=
 =?utf-8?B?cWVMayt1UmVLb1NpNlVhWkVWeGg5bVh4ck5ZRVpDV2pQYTJHSUFqZzJJWE9Y?=
 =?utf-8?B?QWxzMG81SGxlK01OWGpVNjlXaU5kRTFINVVFMUtkaTlJK3ZTRDN5WTJyY3lk?=
 =?utf-8?Q?77aZP6BqdoY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTZRVVBMTjAvR2lDYXU5SFRwVGZ1QzJWaEZKdWpyRXNkQ2hRQTlGMFp3NVRT?=
 =?utf-8?B?aktDQ09RT0VrdE1kbjh0bDh4aTA4U2lUL2VQeU9kOExyUE05dmhvUXFldzZX?=
 =?utf-8?B?dXVzOTBRTVBudVhXejFsTEdjTXFIZTFvQVVEWksvTkVjUEtXUVlkNXZyMTUx?=
 =?utf-8?B?NlJsUzR1QlQyWmtMK1ZkdHRHZnRoeUs3Y2IyMmdxTjhPL0I3ZmdmSWM0Z0Fk?=
 =?utf-8?B?WW4rZENEc3FFUmdwSEdGVWFDQnZwVTVIUE1FQXdxdnVzcCtvb0tFUnpVcHRN?=
 =?utf-8?B?YVlvVTYxTFMxZkYvdnovbEkrR3BiU2FVSmJSZHNqWTNFckEzUGNtYk04bmc3?=
 =?utf-8?B?cFJrL3I2VHVzZ2h4SUJuQWxLWHZRYjNudVRMSWVkdmo4WU05c2ZXVkw2RE8r?=
 =?utf-8?B?NVo0TjBvSWIxS1JyQlNaSWFzT0pnZVAwbTdHUDNOcXdmR1krdG9JS1gySWdr?=
 =?utf-8?B?NDRHMGxxZkZmR0d2ci9RbDVHdGF3bGJheGZlMkZmM09WbkxQN3d5bElzREJn?=
 =?utf-8?B?VDc4MkZPOHVRaFdZcHloQllUSzgzcTBmK2xCUlZDUWFtV1laSndjZXRWU2RG?=
 =?utf-8?B?L0VlUVE2Q05vRHFYUDM3Tjk3aGJaNmRDTUpRWmlVNmZ4TVZKWlVRQ0hic2g3?=
 =?utf-8?B?WU9Xa2pDN28wOU5rcUlxZWlXRStwREJDYkU5TkFXaFl0eCsxTnZmcXp0SnJv?=
 =?utf-8?B?QVlBZTdxU2JFTWw4a2lwa0JSMVJrdEZ2eGRBSkdKRzN3Q1d3S3FXQ05JNXBI?=
 =?utf-8?B?VEV5eXlOZHJEcEZnU2R2RWo0c1V4TWVsRUd1MHNJNDZWTk9idTNCbXh0cU85?=
 =?utf-8?B?ZHBlYkRmcmtyMkJZMFdhUU1YUTVDSDZzanRqcG1zRHVxcUNwNGxsTVJnSjVm?=
 =?utf-8?B?RThvN0dzM2RRTU5GSHFQelhKYnVEMFljaG9CcXB4SkZkUlR5RTU1cUxoNUpp?=
 =?utf-8?B?c2Z5WU5iNURtUXF4NFk2N3c4bk9vV0VjcmJPaVRoMFNtbEtaOVltS0s0STJw?=
 =?utf-8?B?cW5hcWQvTFdRVTNNcStVUzR0TG9zMkQ0ZFUyRlZ6V0k3aEdoV1Jya3FnQWlh?=
 =?utf-8?B?RlozZ0pDTzV6SmVsWm9icjl3LzU4TUNONUxvNGYxNEFtbmFEN05Ic0duY0lZ?=
 =?utf-8?B?Z1NxVEh4cWJrNEZnS3EyVjlNRjEvc242ZkFZQkduRmQwbVVuSzhmRzRoZ21u?=
 =?utf-8?B?NFlLRlU4eDNwdVBkSnEveEZJdzJ5UUhjbFZ0clV2cVdxcENlZGZDZWwyazU4?=
 =?utf-8?B?WklvVnoyV0hEakdPcm9Bb2hhREVoUFlxMlNIckVVQ29hNnFmQ1Y2S05lRHpZ?=
 =?utf-8?B?Z3poeElXS1E2dXIxSG9yWHdKQys1M2l0QjhodmlnbTN5QW1xM0NCUWVSZjNO?=
 =?utf-8?B?dWN5S1ZjMENqaS84Y3pQTzNUWEgwYzc5OWM5M3M5MUo3SW1vNG4ya3hUMFpX?=
 =?utf-8?B?SHhrSkhIWHZTSFM0Y2Y1UlFlUDRyZURIa2lwdWVJZ2FNOVhVM1VOcHpiMHp3?=
 =?utf-8?B?dmZhVWxnRjBaZG1EbC9qMUJ6MHVGbGNyWUlrZEZ1TXhkTDhtRmVhMVBWQy9H?=
 =?utf-8?B?SGFyTGljTUZDWVNlVk94MTIralNJeDUzN3Z5MWFYQXRaYmdzdEJaaU5xRWRi?=
 =?utf-8?B?eS9qQ2dSbkJGU2pxOGducjRFc0ZLTDRaeXhSZXJvRVZxeWdUbWcvUUJscG1B?=
 =?utf-8?B?VCtqNXhTWGlicHlTeDl2N0FRV0VHdE1kTXMrcFJ3b3VBQ3lUbythZ0FzS3FD?=
 =?utf-8?B?Z2twc1loREtySUhCVkRRNE51bzU3S2x3V0RqbWJtZFNVSnc2anhoZUN3OWNS?=
 =?utf-8?B?LzZGbE1ITjlScFc4SzhJOUhoR3NrV2piY3A4bXNveVdjOGtSMGlNOGZzeDF1?=
 =?utf-8?B?RGJObDUxMjd1YUJGREZubTg1MGlzVG52bE9mdWhZZm5TZDdaZjJTWmhrMVZK?=
 =?utf-8?B?UC9nUHBDRUhrckhoM282dk5QcDZ3VUdwS1JZbGxRRlVSRElrc2FlQ0pLZ2t2?=
 =?utf-8?B?cEpWK1NRRVBhV2U2VDhpZ0tUQ21YTlh4TlMvamlBUFNtVE5WdnI5SWJKWkNh?=
 =?utf-8?B?MVJMeUxNQ2RWcEdLTjM0RlhENng1ZUkyR2hSRVRseW1Lb0EzL0I0NVZrTWNT?=
 =?utf-8?B?TGxYcmJDRnFRcm1DQit4TFl6U1hEUFZQamRKRkZJWUNjK09TZmtsVG5LMm1Y?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d16971b-7a61-4034-1a7e-08ddbf39415c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 22:37:59.0315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBbzjssJTz3zklocJG4Kiu73388PJLGXlipac0yihqlPVUaREp1QwTNdv/Ns7o/csUEgUbDEOmU9deV7qv817HJSxCFymaCkTMUWbJUhSCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6069
X-OriginatorOrg: intel.com

--------------7uwQO41rAIRD8XjwO0A0xO5O
Content-Type: multipart/mixed; boundary="------------cX00dtAgUq5gNhgj4rcrVoHZ";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Shahar Shitrit <shshitrit@nvidia.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <b1afad99-60cf-41e3-8c74-2979ec595519@intel.com>
Subject: Re: [PATCH net-next v2 1/1] net/mlx5: Don't use "proxy" headers
References: <20250709083757.181265-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250709083757.181265-1-andriy.shevchenko@linux.intel.com>

--------------cX00dtAgUq5gNhgj4rcrVoHZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/9/2025 1:37 AM, Andy Shevchenko wrote:
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
>=20
> Note that kernel.h is discouraged to be included as it's written
> at the top of that file.
>=20
> While doing that, sort headers alphabetically.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>=20

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------cX00dtAgUq5gNhgj4rcrVoHZ--

--------------7uwQO41rAIRD8XjwO0A0xO5O
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaG7vRQUDAAAAAAAKCRBqll0+bw8o6Cfl
AP4jRzRdXyw0boi8x3Mupf1DdwzlHYPoziBcsVP05DmRhwD/dBVkYtsJTRl/iLeXiZpSbzM0WVnT
DRLdtWM/8lgQIQ8=
=iiX7
-----END PGP SIGNATURE-----

--------------7uwQO41rAIRD8XjwO0A0xO5O--

