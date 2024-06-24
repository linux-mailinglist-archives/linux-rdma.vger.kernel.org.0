Return-Path: <linux-rdma+bounces-3454-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B90915824
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 22:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD3A1F26E6F
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 20:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171F61A08B5;
	Mon, 24 Jun 2024 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1cB66+z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32FE2233B;
	Mon, 24 Jun 2024 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261686; cv=fail; b=RY8JxTxjlaojStl/pTwo3s7wkK00n90CJGucnaU+/QBBnoL+voq+6c91n6phl2qGnuTrBLIl6hlEh45hY6HNk6txYwQNAAyLff7Hba4lRf3aPTdNR9Gs+Y9KYD08kPGxM2jzosG44ksqT5feEx5B4KyApIBG/n54VqmdFN612Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261686; c=relaxed/simple;
	bh=uHR1oCEf1jC1IKe5sOZL+6J8jSVvXYUBfkEEGAz/9ug=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qpzqLh8PxP0qwe9Hz8hB/5GWs7FQaMhhqJJ6xvEWsFUuF+KsRyNxANOAh89wT5zfPko3U/aP3vypMXdP5PimlmFXo/5ezlLnKUVQrQyDwz5M9i52YT5DOHZrSd1w2FPRiGfMPZOoejc0XVso2o8KafXhzSx4R24Qk4V6Ug6HXdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1cB66+z; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719261685; x=1750797685;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uHR1oCEf1jC1IKe5sOZL+6J8jSVvXYUBfkEEGAz/9ug=;
  b=H1cB66+ziN60PHwhd8aCBjWqf0LGyFAWWDv7lZnsOiSxUX8cURFoMJuQ
   IgGEXLnDfoL6r1BmC4T0m3kS3WUJ3BK2zv9GwqHw1hqXUi/IcshQ4SzvJ
   58IWjvbSecxjt47N7QGZ3547uYyM6pFiNG0C+bnbSebkzMOKTt72fedY5
   iMujIZA19iAVRwNOrvtr96vnwhbcJ4sb2NYSoM1CoMmbVr8GOHliVTbkQ
   YL12gXuwNMW0gEvD6CKr3pT8YliDjQKv7qUNONc0e+i7vkcaqNZ4iCH2e
   n0mN0iuYsr4Wj7tMKYE6MU/xFGlty/moSpMiyPx+N3RAK0QRracGviPEa
   A==;
X-CSE-ConnectionGUID: L65tEDA7SeGcbc0J2iiHjA==
X-CSE-MsgGUID: cahI1SXcQiSpHM7KhyghkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33711717"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="33711717"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:41:24 -0700
X-CSE-ConnectionGUID: X1hQzXDNTnyNddKaYjjEsg==
X-CSE-MsgGUID: Cx7TAD3UT8eyq2F/xCS7Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="66634991"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 13:41:24 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 13:41:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 13:41:23 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 13:41:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bgc0o/flQ71zsLJkw0W8oOSGouzhGwbQbt5+BquyGm1qAC4KE4DOFCwKV1hMNTjGESl2GYQ9us5IUJx3DGf34PQemfafDBQ6CD2XrnwiU0NGd/FkDUXTLB3CnonXc2Ac75jPryG4V/5AqLEapv3fn8TtGSF7LuHssaFLwDW5f9lcoIL6rACNqNKqzIOvQ3vh+Vo43oYeyZC5ClXGcYk/isYo/rfk+wiGoWGwqCE0JINmQy/EmHQsnSL+dbwVZltuwgytNH8K4M9GHWqcqWKAwn3Njoq93Zp7Mo4djCjJRfT6yxzCH2FpwRSRWODYoryn+bXQbnGiruqIhcwBNLj1SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwthdUxKltUXwFhKxaJsY3llodHyFLjszBuKxy22A60=;
 b=EdyOcYc/crrX5CGtDtIZpwWut+Vh+TAfysCGMZVo+eV1LLTRpsh4HH506FqKUsmQhTIEZvmiVca9zNNlGS/Xxqc7iADszY3AIhq8QEeb11746U8O3/fpLT/HCxc1+D86gRampnQPtmfDzRO84Ty4l0L+pCZmRVL/M4UtM79OnSrLl03pbAG6KAWCGTpEakjAkrYQ2T64TFGbppH6wGYwrEH2Zb3gNaaSlEl2XFU7ZF2xOhRkh5kerlcDphvTjbBQ77VLk/3HiPrWBiC4H+xf5JVR10bGPq5CJ/AumBfR5ZUdxkUz1LmJKgrm5XydZN9WT4Efz1rl5FSnO8uAjxcUJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by IA0PR11MB8419.namprd11.prod.outlook.com (2603:10b6:208:48b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 20:41:20 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::c625:ce3f:cb4a:db14]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::c625:ce3f:cb4a:db14%4]) with mapi id 15.20.7677.030; Mon, 24 Jun 2024
 20:41:20 +0000
Message-ID: <0b926745-f2c9-4313-a874-4b7e059b8d64@intel.com>
Date: Mon, 24 Jun 2024 13:41:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] net/mlx5: Reclaim max 50K pages at once
To: Anand Khoje <anand.a.khoje@oracle.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <saeedm@mellanox.com>, <leon@kernel.org>, <tariqt@nvidia.com>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>
References: <20240624153321.29834-1-anand.a.khoje@oracle.com>
Content-Language: en-US
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Autocrypt: addr=jesse.brandeburg@intel.com; keydata=
 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
 /fnLfll98Nhx
In-Reply-To: <20240624153321.29834-1-anand.a.khoje@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::33) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|IA0PR11MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 4321acd0-f2ed-4a35-2dec-08dc948e00ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|7416011|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWlQK1luMVdDei9aZ2tTN1RodXNYU2tucUVNT0xvYzdobUZSVWlQb1FzSjhE?=
 =?utf-8?B?SjkyTmVjRjlKVFVXZGF3OFlrRmIvemlSUk5Ndkw4T2ZlaUdUYW5NWG53UkZS?=
 =?utf-8?B?aGNzQkZZdElQRWpkU3YwVUx6dzI1NXlnWmNwTU1pTlYwY2NXYUEzcUdTT1Rx?=
 =?utf-8?B?UldqTEhyTDczaFlEYmRGS0JpaVhPL0VEbU1aRUQ5YjJkbHJZbVpWS1JwemxN?=
 =?utf-8?B?ZW9oZ3UrQjNuS2ZodlUxUERSbGxLaWFSSFBFWXpJU0ZBSFordHM5WHgzc1pX?=
 =?utf-8?B?SExuU1ppVi9xYUl4NWtoYnAxMlpIYWRRamlCZnkzMlhtZ2d0ME43VjhnYVFi?=
 =?utf-8?B?d3VyanpPclJ0V0pmZVVTbER0UW9RZHI2VGZJNU5zSkVsbzQ5SHhLOUw0UEJu?=
 =?utf-8?B?VnlackhzbWJpWVRCbUJqSDA4T0N0Ri9kUEhUUm9FTk9jSDRDeklRa3hOZlUw?=
 =?utf-8?B?ZEZ6bEgzMTFTbDJ1OFU4ckF2VnJJRnhjVE15aEtYU2NteGUrcUZCdUs1VDRv?=
 =?utf-8?B?TXBJaDYzVEtLd2xPVUhvNHJhd2lhcjFSczd2SlNkSXRHV3YvSUVDaCsxbSs1?=
 =?utf-8?B?dC9DWGswYitSZ1lZWmhMdWdVbXpxd24xWmFOZ3IxNGJGUDdDaFJ0U3U5TzQ5?=
 =?utf-8?B?YzI3OFI3ZmVpQnFVb083TVVFb1ZqNDBzYkZkVUJEbm1vR3ZhTExweklkZFlR?=
 =?utf-8?B?QWNvOGdjMWNaNldzNmYrK1pmNm54ekRudnBTSTd5UjNrVERnZXhndFQyOUNa?=
 =?utf-8?B?ZXk5MFVXcEFYOXRhMzBDa1pzNW9neFNPYVNpRG5jcW9ZajVWS1hwRVdPMHUv?=
 =?utf-8?B?QzgvSE9jUXFUZE5INitjNFk5dW5FS3dzVUZGeml1L2tHOFJORkdxdFBkQzh4?=
 =?utf-8?B?aGJmbExSazVJMzRMNWYyU3gvOWdSVEJsOGRXN2RRR2ZBOTlRbVJvRkw1MXNr?=
 =?utf-8?B?L0l4U0RLb21kUERhS1JvVFUxZHNUQ011TFFjRW4zUzVGVGQxOGV3U3NZZHFW?=
 =?utf-8?B?em1KRjlEdENpTkswbUM3eVlSQ1RtdVl0ejNBR2h0L1dxekpGT2hxVzVzSkQr?=
 =?utf-8?B?ZHVUTWFMY0ZxYThOaUVnSk83eEVwRFYvL0RlenlpN2pBeVVPR1JhTUV4VlFR?=
 =?utf-8?B?RWFXbW1uUXBqQUk2ZUtsUTJRSGsvemNvdk1rMFh3bHpmV1ZEd1ppU3N5eXVo?=
 =?utf-8?B?dktpaUg4RXR4ckpTNHdHYmNkVHh0ZW1yRWRxKzBvWWt3L1ZXMmU4cWNOdW15?=
 =?utf-8?B?Q3UzMHhpeFRtK1JPNis1bkRSaDZWRWRTbkRoVE5VWDVRaEJJSmYydWNMWVdm?=
 =?utf-8?B?WW1uRGZEcXdabkxlcmtCdTRZM3UyYXhTOThRNVVUNmNaOE0zMnJ1NUxTZXdy?=
 =?utf-8?B?OXcxb3MvdklxeVgyVUt3d2ZoYnRxcHFJKy9ERWIyamhhU1NyeTRGaW1wZlZy?=
 =?utf-8?B?WjI5WitQblRJSDNMQzRKZDA3U200TDhIblA4VHl1VDgwYk1NZVc1M3MxdDVX?=
 =?utf-8?B?MlhTRzJWNlcweDNHSVZUWmVTbHV0OXQ4K2JyRy9MK2pnKzJtQnBXZ01iLzNS?=
 =?utf-8?B?SzJKcXhISEYxT1ZmaGdlZ0tKWm44OGU4MVlvYTNOUEoyOTJ2Y3pOeS82UHlD?=
 =?utf-8?B?azBEUkpITzRKOG1xR0lyMmNyeDNQbTY4TkorWE1ENU9OcmRHb0xkMm16R25Y?=
 =?utf-8?B?OEhDb0RpRndvdCt6ZlhjYkhQTThEdDcySHQ2ZWxvNndWV1FtMkJWb05UbE5Y?=
 =?utf-8?Q?7d40SsLKU126XboRnI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHJ0UGF3K1FCaEVWUlhXRGQzZWR0RytXa3F4d2liRHB4STJlcjJkVVYyMG1n?=
 =?utf-8?B?WW5sWnkzL0Z2UUNrNEJIbWp1RGJ1WTZyNk1SeGdXYW1IckYwdmorMnhST2N4?=
 =?utf-8?B?VnpZbmRYakY1UEk3bVFvdVhNU1A2bnhSNGZUcHd2WVNsR2FOcHdBOVViWm1Q?=
 =?utf-8?B?eUxkVFY0Ry9mZnBYcVltYVh3UW1DVFVaSmFLSHRNajBJTmRPRG43YWpwdkRN?=
 =?utf-8?B?T3cralI2NUgraHdhSlFueXptb1lkN0Q0WWJMajI5SzNuN3NGV3VUdy95MDh4?=
 =?utf-8?B?TXRqUk5HTnNFYnRlT0FUM2VjMS9CUFlVSUFIcFFnQ3dPQzV1VE1IK29aOXBI?=
 =?utf-8?B?dFFaS1dsODh4bzVlaEFBUXliSHZEdEtxQ3hZdUlLM3BtOUNTZjdXdVZBWjQx?=
 =?utf-8?B?YjMvam91ZWNKRGxmRDJHUDJIU0xMaXVEaGZudWVSUHNrY2s5emlwNWNQZlZj?=
 =?utf-8?B?RlJPU2dzbnNJVFJOc01KUnRQZ2JuRXVlYUoyL2pxQys5M0NUclJERTlZVHNs?=
 =?utf-8?B?VjVJVlhibGtYdGltTkZzd25CelhKLzJ2bDZvK1p3bEQwajVYcEdabjRGTnpn?=
 =?utf-8?B?cjJDRUpDQVlXTURIYW5yd1FNQXd1ZnJWMGJKWmxKMWd2NGthQmVtMmlHVWJi?=
 =?utf-8?B?S1h0KzhTZnBhY01nbjVGRVpKUzQ5T0JEYkxra2FWSzAvcXFNSmlpaHdaSWZW?=
 =?utf-8?B?MmdkTlkvdk1CcWFmUGVCV2JaMXBrSXI3ck5NNW9RSFh5VXZMNis5SGNVNjhz?=
 =?utf-8?B?RjFSZVRsbjYrRlRydkkydEVFNmczZ0syZjI1bGZZdnVUU1J6UlZJVCs1YkVw?=
 =?utf-8?B?cnVxS1JNNU5jV05TRGUxc05mYXhhYi8rU3hNSnlIVDFxTXFWaTVnSHFNclBn?=
 =?utf-8?B?dWptdVZ0WlFXNlZYYmJmMGNxbUgrVldzc1pYbE5qa05QTyszUm1VUjZaMGR0?=
 =?utf-8?B?eE1RVFlYWUNqWUtrcmxYUFgxK284bkVxU0lScDg0NDl1cHdPaG1HRVRLcTZK?=
 =?utf-8?B?VnpnNlhsVzdQMkdWMzFzUXhqaU1pQVNBSFI4SVRrNnE1NGMwaUxWVDdnOHFY?=
 =?utf-8?B?WXg3R0M4bXA5K2RHN25lNER4R1Y0UXJKZ0pWUno5cHZrNytCTDhKNzlSVjJP?=
 =?utf-8?B?b0d1SStEM0NmcUF2NzkwaDE0LzIyaElVRFZEUG1XUjBhUjNVYjluWjdMVTgw?=
 =?utf-8?B?UUpvTkp5aitZWnZPcWJzc2hheW5KWUxaeUFtQzNqQklMTGdUUlVHRzVPS2Yy?=
 =?utf-8?B?SmVGUVAxM1JhZllySENlU0hRNTh2OHRIdXhuVjFUWFUrQ1M2NEQ2SThjaFRq?=
 =?utf-8?B?eFoxL3ZJWTNkYzFnanFObHVoYzlpZi9JWjJ2N3FGYXlibk5VMUw1OGR6emhv?=
 =?utf-8?B?N0NBbE9PdFhwNWpBWTVQZ1Uvckd6bXRBU1VWVEpMTW5IRFE3RmtuU3k5WjBH?=
 =?utf-8?B?Q0J5Yk5wakVkK0VKbE1FZUNhL1VqWjJ0RE1mSEI5UmRuYWVKZmNEY0xRSDdx?=
 =?utf-8?B?UkxtcUMzaTRqUnNSdlAxR2FHSmIzS3FQSjh0YWx6bkRjaEcwRjh2S0ljVDYy?=
 =?utf-8?B?ZXMyZnJ1N3B3NVRsa1RWZnM2SzFYTzZuMlYyc3ZIaHJGNS9EeVYwWGtZS0NV?=
 =?utf-8?B?NG9hNzhLdVZTVDlMR2hMamVOOTI5a0M3bHp6UjdWUjFKQzNtV2lZYUdOUUZa?=
 =?utf-8?B?VEVJaWRHYTBEMk5TQ2h4WWZwKzdrQ09SOVBMOWVGREYzc0orZ1JuckJWS2x2?=
 =?utf-8?B?cThzUFNtbVlVT0FhR2MyTmFtNXBKbFNwZ01HQ3pSclE2REY5ZWdZTEVuMGd5?=
 =?utf-8?B?c2VSMzhBTWo5RXVWekFtSVpNSDBKNng5Z1VVbnlsaHoxTGowNFlQV0w3MC9V?=
 =?utf-8?B?OXU3L2N3NzVEUFdkRVg2NVFkVCs3eXhReElJVVRhQWJuWjh4d0lNak9NZk15?=
 =?utf-8?B?LytQeXF4Z1FSS3p1ZDIxS3pKc2NTWHJKeDMvbGRKNjh6TmVYY05GaHJMY2Rn?=
 =?utf-8?B?YnVRQWNMcTg3RFhUVzQ2R2twODIyRWt6Z0I3OEhmM2RVQ3kybjBNM0hmUEdx?=
 =?utf-8?B?TXpTVkVTWURyQXZGMmhPNUJRYXErWlc1akRYUUg1UjVTUmdwNk5uK3J1bSsz?=
 =?utf-8?B?UlF5MTdhWE5Palg0YXkwSmp6dXliNnBqaGVJZWl2Vk1LZnBJTk4veit4ZUpN?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4321acd0-f2ed-4a35-2dec-08dc948e00ed
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 20:41:20.4885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9YPWUf8Y9Qm/wyqQz+bgq8gadEidLS68Y+Bwj4y8siRwubW0rSFchcIsPK8yh9XoLX9gmSbJfxaZNs57H/chno6DUATt5zRHuUmu/enr2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8419
X-OriginatorOrg: intel.com

On 6/24/2024 8:33 AM, Anand Khoje wrote:

> --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> @@ -608,6 +608,7 @@ enum {
>  	RELEASE_ALL_PAGES_MASK = 0x4000,
>  };
>  
> +#define MAX_RECLAIM_NPAGES -50000

Can you please explain why this is negative? There doesn't seem to be
any reason mentioned in the commit message or code.

At the very least it's super confusing to have a MAX be negative, and at
worst it's a bug. I don't have any other context on this code besides
this patch, so an explanation would be helpful.



