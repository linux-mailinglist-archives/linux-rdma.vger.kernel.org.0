Return-Path: <linux-rdma+bounces-5189-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4D998E9E7
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 08:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1551C21E6F
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 06:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4373A824AF;
	Thu,  3 Oct 2024 06:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VK9uosCY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CFD537F8;
	Thu,  3 Oct 2024 06:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938657; cv=fail; b=ee6ciCQrWugcL7W+gT2TmFdoZw/8U0hE9N8OnyhujkfaEwFOa/69/i4R1uUrR94aQI4n6m2G0CqDMsJrVI/cOoC3GpPmlndoXdMyokeWWBEyZ7ibLYSazcm9uDXltmwzf8IrfEJLuvZOCzzkwYm4y5vRwTo7dEUiq05wC+rEvH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938657; c=relaxed/simple;
	bh=/1PxpGtRc7TjLsWRxBJPa9CB0+YECJKZ3vAySo/0pYQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e2blhfqXrpb+hnT+WaKlKI50BbmzCv6s+92aZyu5PkB+f4eDCCNB+1BHtBa+i0rpFgfEBct0ejreR8pRookYNMS/vz2qYMCnNbzIvow7kEb2S6atG2foNUWfYs39fE7Eb2rngo7Z/HrwgfvelY8QaQAsBDqMkdEQ+9MYHTyBYeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VK9uosCY; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727938655; x=1759474655;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/1PxpGtRc7TjLsWRxBJPa9CB0+YECJKZ3vAySo/0pYQ=;
  b=VK9uosCY7/Kff7roYWhyd+U0iuZ+PQwA8+JfY9Z0wN4urJnqVVDZhN3x
   QZFZZUxLwUor+5Us21uh2pGwbD1llZScqnGwXDAj/gq4W9sjrTnEXsw61
   qUx1/4rkgSojxbss9wQwLFDn/1z9Ye29gcyEiZRQdrEJ3VGZVuCsF5Y4Z
   GytlNpdndjS69QsLRDuSuOggLXc9gs3GJimNgIV4MqxnbBN+6jCv2fyBq
   hh54+CmU7Nvxq4kPST9Iy913KqrPmUKCa0k8Sb4C4WdilQSVUF2mdQBRQ
   vYgWm3LbVmYfiu8yUV7BHAyRSGjF1bOHAUD08EoBvjyQ88UH8v6uvaP3B
   Q==;
X-CSE-ConnectionGUID: 67Rn3RZNRFiVERkpQEvBLA==
X-CSE-MsgGUID: 1fnofwp+RwiEhECqO5aAVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="26630573"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="26630573"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 23:57:34 -0700
X-CSE-ConnectionGUID: fVMdJ2LqTIqVrsgotlACSw==
X-CSE-MsgGUID: WDEjYq0eSvGxy413hc+WLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="78272331"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2024 23:57:34 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 23:57:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 23:57:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 2 Oct 2024 23:57:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Oct 2024 23:57:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0rinugQx1hlEIQJ4ZsTMGdTntKAjb1yX07nBJeGsgxNOuY/t1ILt4iuGOWKJUqsnlfcpxyoGRx8ZDDBK2SE5hGuYgaHW4Nv2MX46xcf153ZjRIfQyvhqoCgeT3A7T4fLqpS06PLJdrPORYj58Wwg8eyqFbfLuhZ4/mkLDJm3QsBrE1My8Wl+F1+DlRrQ2cwj4ybaMB33AdkAuKyNF+GVti5/yIPnRrEXx/qTJyMmSSWrvOCUkotfD1yuOZb/F2Zpp5FXYyGf+2YWsTFfy/aIfAR2NQ+US3CFzdz8WRS8d11mLnhg+uMbzZAUNSZU9UUHylvWwxDBQ025wRgK6s0Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsR6lVwDwiJo63hCOrddQbTR1YpQfWPhMeBySzrsv1I=;
 b=VZuFGaa9BDOllV34ztbbGMcE08cZMBhDriNZTrt8BWlqqkdXjd1v5ebwRC60YIfCmUk+DD6ADUmm2x1jDLAbrD+7tkxp8Y4tRH6Pn/WOEwC2tr2vrxm1bARYEMtaO/NiLs/ZaL93PBlI2QmG3cNVVbIk4onrdZXLwLL7gYMdf2TQRGDp0Ll/QxX3kW2Df4PE0qZoZnq9TxUHLYX/rXdzpHWMadSHaXH+x4eNuLZZTxeHJeAc7rYkaicQPwnT2dpOw2iQPppErAk7vS+wxWgokLrQcqGH+w4fWCdMpP7FDOVNH/+P8hZ0ZpuJTDbs8FAlTTMtjKq9rlUGxT84QX7lZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by DM4PR11MB8157.namprd11.prod.outlook.com (2603:10b6:8:187::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 06:57:31 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%2]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 06:57:31 +0000
Message-ID: <566e6e9d-4c6d-4bac-9a93-e760b9ee4c1b@intel.com>
Date: Thu, 3 Oct 2024 08:57:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/mlx5: Fix typos
To: Andrew Kreimer <algonell@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>, "Matthew
 Wilcox" <willy@infradead.org>
References: <20241002200838.7316-1-algonell@gmail.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20241002200838.7316-1-algonell@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0110.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::7) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|DM4PR11MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: d375668d-8656-4516-0019-08dce378a6c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?di91MmtuZ1JsODJ0bWJmZkNDOUFOSGVsNG5YTC9DT3pVWlF0N3E3N1hkM21a?=
 =?utf-8?B?cXgzRFNGemVzY2VVajZ3WDRUR21KOFhRU0NBeG55djJsaEk4cE1nYzVGMWtE?=
 =?utf-8?B?OTEwQXVJNXZvVXdDUk51bFkrYXhuRjZkdW5DaW9sQXladWhmVnVWVnI1TER2?=
 =?utf-8?B?WnlVbFZ4cVRlRmJtRUswdXFuYU15eDBZcFFIbU9Gck1CelQ2dkxzQWpxR0xW?=
 =?utf-8?B?Q2NOeXdUZUo0UWxDYVFCMTdxczBlRmVhR1kya3hWbk11bk5DWTRHcjQ4NUw3?=
 =?utf-8?B?VC94R0htSC9JdVUzNjlyTnc0aFZTZktvQ09DeXlESWpBZmEwelgxYzJvZlRS?=
 =?utf-8?B?OUNxeXl1NDBPL2ZEbW1RR3JiK0tvb0pFWW5XcVhPU2kxTCt6UmpyL3BZR0tu?=
 =?utf-8?B?aytXcUczc0FDRmdaVFcybmlKNnhRNVBPTHJIMTdCek04VHV6WTdKRVBrZVlC?=
 =?utf-8?B?ZUd3ZFZLcFluQ2hHVmNWZ1VsYTB6dm1rcVFmcVI0UnNwb3EzZHNEVmxFZzJD?=
 =?utf-8?B?ZmwxdFIrTGNWNWdnUXF2MVVZQTZIY1lnd093NUdnVW4zOCtEeG9DdTB3eTFn?=
 =?utf-8?B?cG9ackZ5SVVIRnByUkFFbnZ1bTFnSE9rTE9OSzFVRG9kUk9WMzBlck40SzYz?=
 =?utf-8?B?WncxVnExcVVaQVBnZG5BSjBhRll0c0FqVE80TkRlbm5UcEJVdmtaZEx2R3hR?=
 =?utf-8?B?d3g4cngzWFFSU1ZXYS9mNkJ1K0NWdEJtZEU5NDlmREI3dWd3aVU2bXphSlND?=
 =?utf-8?B?T3B3c05NbFR1aWJucU1qL05JZ25mVjhBVFdoZmRJTW1nY2RCZWZrWkVRQUpy?=
 =?utf-8?B?TUkrUG5RUVk4R0xSVkJ5Wkl1SFJDME1xTHZFVVoxajJTM3EranZwVlpTVW41?=
 =?utf-8?B?TDEvcE0wWTVaS3dvdVI4RnBTdnhBNTZyK3R1ZnpFZWJqaC9vVmFHU1NlNUNY?=
 =?utf-8?B?a2orbnd5SEVwdVlEZWY3bzFXdWltcFJoRTdSNFdmbmFvV2RQamlyUTZNRWNS?=
 =?utf-8?B?SU9WaTRwVTJJRy9jYXlVZHJjZUxuMmhObzJWaVBXbXJsWlg1ZStDVFk3YkJx?=
 =?utf-8?B?RkRPVjVvSC8yaGlKblhXb0RCWkx2d3lWKzFZanBWQjc0SXJ6Q0laWXdoZm1j?=
 =?utf-8?B?QXo3QXJaVUhjZ2hiWFFJOGxzZmp4YkRxNXh4RmlXcmNQQk5IcDVvczVQdndY?=
 =?utf-8?B?cmZyNmxGNzBDS0xUaHAyaXpGT3lsOVBXMUxhU1RwaWdqVjc5YjJWMFQ5NUdN?=
 =?utf-8?B?eERBaXFtZlQ2UVU4YVVDb1o0ODY4aGVtMnNyT0dGV1NCZ0VXZ21qWGoyb1Rs?=
 =?utf-8?B?a0RYa0NRV2V4M29BNHZsL1A4bGFVcDdTUFpnYW5VeHZwd3VEbU11SUJhaHl3?=
 =?utf-8?B?aHN6aSsxNVY0SVpMN1JHSzBSUVJZd3c0ZGVMOE90bHJuQlU5ajJKRkg0ajVm?=
 =?utf-8?B?TXJQY3hkcWovUFR4bkZMMENqemYwa2c3RlJnTStEdzRSSHAyOENUdElvelNT?=
 =?utf-8?B?ZDNIMDUveUQyRHZaOURjbm9pUFRVUEdEcU42cmhJRnRNK3N5WDFpbHh6TUFK?=
 =?utf-8?B?S2oxSGd2S2JBcjJ1V0g0WlJwcU9Oc2xtT01uTm5BNDc4SWpFUkVRTFQ4WjQx?=
 =?utf-8?B?TGcyMWxFQk42cHhUNVFhaUttT1h4KzhjckY1cFU4V29zejdqRGxJcmlsQURB?=
 =?utf-8?B?TnJZTTVpMi93N2psNC9LbFc0K0VpdWVpa1J2V3F3RHR5dXlhNnJkcFhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clR4QkxPbVlzZXpybWRac0ZQOFBZQ2ZkQkRzMStLM2NiYUlZZndMNVNXZXR1?=
 =?utf-8?B?dTY0TDJTVm9QYVNRcW5oZDRxYXZXZjRPa3d3cVZObHVRb0hDU0VaWjZLaU5v?=
 =?utf-8?B?bDdXSWtGd2FucDhQdkFoMnk5eno2T0hNeWxRNXNRZjdyUE9iRU0wdXN2cDd5?=
 =?utf-8?B?aEpKOENheVRFUUJQRHphcmVyMVpYZHJPd3k5SkdJZFNta2F1Mjh3ODVQajFK?=
 =?utf-8?B?TVJuK2hDUDNWYjJjU2Q5cCtoNC8wQ0FsN1kyRXZrN2ZlaWo1bjh4YkJkRFpt?=
 =?utf-8?B?TmJLeVo0MzFTTUdWak1LeEc1YWdleDcvS0ZGVGJ1QmZvOFNRbFJnU1VTZlYy?=
 =?utf-8?B?a0lESTl1WXNqRDJuY1JtY29JU2pILzZsblJQRkNrSnQrSHdRMWxqbW1pV0cy?=
 =?utf-8?B?S3RqODMvT3lRYi94V1MvcXJrZUxxbzI2MEFzZmdNeFNxaFMzbloxakhmbkVh?=
 =?utf-8?B?bGp0MnkvcVhpV2NmM21qM1AzSkRId3BFRW9ibVFOQ0hMZEtpcWc1c05ab25V?=
 =?utf-8?B?ZGg4WnRPWDc3RWZlMit3c2YvdEE3dy84SWNuMkppSmFFdy85UDc4M1ZaQThw?=
 =?utf-8?B?Q1ZnVzRTSnRVNjBiekZ4K015MG00NUMya28vS0cvS0NnZzRadGkvcWtEMDMr?=
 =?utf-8?B?b2E4MDNCZ2o2Z0o2L3M5QTJtaUtxNnRVOXFGSDNDWitQQi8waStCbEphaVZ6?=
 =?utf-8?B?bXdpM1JzRGpqbVgxTTY3bFhQOGpBOFhVRXhaUkJQSGE3ZTdFT3lEK2pOT2N1?=
 =?utf-8?B?VWF2am13d0NpT1ZmSXdPRTJ4ZVM0S0JRMWM3c2ZLUFhVT3J6dXJnR0ZKaW80?=
 =?utf-8?B?Q1JWejhSMTJxazJ6WWZXY3cweW9NeHZuanJXY05lTzdsM3BJQXQ0cmpERis0?=
 =?utf-8?B?K2N3aGE2RHB2YUxoYmt3TERFOE1ldnVYcWhXVmRrZ012bUlNWWpsRUUzc25H?=
 =?utf-8?B?ZU9TVFZWd3YrSUJJMy9qR25DK1ZXaXVBWVU3OUluVXpIL0tySWJMK01IQThR?=
 =?utf-8?B?V3dNcUp2MnBPd2xXaWtFN3ErMEZJQlc3aWl6cFcvQmkrYTRxUTVxc1lUbGlv?=
 =?utf-8?B?b0ZpejVRQVNPeWVVemJMZ0NWMDJSMUE1SE9KTzRCRDQzbTFlUzhsZlFXNVdT?=
 =?utf-8?B?QmI5R3luZTdoSzdwUm5STDMyZXFSd0xab2JKTlNQYzlXTXR4M1RETHhaLzk5?=
 =?utf-8?B?aitnNm5kZ1Bpb1RNdnFEVnJvUnh6N0w0enB4SVpFa0xMUURYRjdSR3VUWDNV?=
 =?utf-8?B?dGJzdG5nOXU0bU1YbjFpajBtTFZtL1ptYWhOZm1vcG81MzF3S3dMMGYwSHlR?=
 =?utf-8?B?SkJyZ1RRZVNOV0I0QnVmU0Q4SEh6Skx3UFcrWGpaYlF1RHpLWWdGNkFwbElq?=
 =?utf-8?B?NUR4THRTT2h0UllXNnpCTjZLSHRwaHcrUFZTelJGRUxVanZqeDB6L2hYNGE0?=
 =?utf-8?B?YkRhL0p3bjZCV0VNZEVFc01nVDZzVlZaTHVkNGdjS0VCU3dmWDYxRmJ1TGxC?=
 =?utf-8?B?ek9LQysyaVljbXFSSHJQckFDcGd3LzlhWmZrbVNmcnIrOXUxanBiRDdnRXhH?=
 =?utf-8?B?M1RqZThKaWFsNXBxeTh6L3pHSHY4T2ZEOG9TWE9ScnFHaGMwNlUrSzd2VXQr?=
 =?utf-8?B?aTZrbFB0T0JKN09GT2hvUU01RzJVRHhuZnhnWnc3ZDlhVWY4dGRPeWZXaXY5?=
 =?utf-8?B?aFhiRUE3TEhWZk43ZXNqRHJyeTBOL1I2eFdIWU42cEJqeThnaVdZd2dFYWMv?=
 =?utf-8?B?WkVoV29YR3Yzbnl3eVJBWW44bDAzSlUwNDFhR0pRbzVraDJGN0tlS2tBbTdJ?=
 =?utf-8?B?a1o3U2NZOGtFcW11Nklwak9CTUlnT0l1QWttbzVvaVl5MVllNUZWU0pSUXhP?=
 =?utf-8?B?UERIMnEwcWszaVJQVWRLUXg5VGpNQWd5YWl4aVN6VlVON3FOeTU0WitVS0x5?=
 =?utf-8?B?czQvODF5VWM2akNqeDAvWkVKNHJlUTdPSkx5UkRsZ1VwRDR5ZGtvZTZ0NmNE?=
 =?utf-8?B?b0VHcERQM2J4NFk5bVQ4Wm9GdGVycGtNaENiTjV6YzYxREJFMlVjbjJwWjRM?=
 =?utf-8?B?aVV5cFlRUXoyOGJYaVFNYmQ2NVVpaWdtaTJXRXNVM21uVFZWaUJqM21YQ0Zx?=
 =?utf-8?B?KzIyTEdEUUkxUitWZGozUGZBQitzNmFvK29pYlcrYzdSMXE1WUxqQy9UejQ3?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d375668d-8656-4516-0019-08dce378a6c4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 06:57:31.4895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMa1zzLn8h7ooLSwgx4BU4msZBYHuoxDTY8RFCEG6I52fbY9Th58nO3O9eU5PDXq21OPv32k/243dWZsgnejOwc6muEvx0rks+kUJSERbBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8157
X-OriginatorOrg: intel.com



On 10/2/2024 10:08 PM, Andrew Kreimer wrote:
> Fix typos in comments.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
> v2:
>    - A repost, there is no range-diff.
> v1: https://lore.kernel.org/netdev/20240915114225.99680-1-algonell@gmail.com/
> 
>   drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c | 2 +-
>   drivers/net/ethernet/mellanox/mlx5/core/main.c         | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> index 1477db7f5307..4336ac98d85d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> @@ -80,7 +80,7 @@ irq_pool_request_irq(struct mlx5_irq_pool *pool, struct irq_affinity_desc *af_de
>    * isn't subset of req_mask, so we will skip it. irq1_mask is subset of req_mask,
>    * we don't skip it.
>    * If pool is sf_ctrl_pool, then all IRQs have the same mask, so any IRQ will
> - * fit. And since mask is subset of itself, we will pass the first if bellow.
> + * fit. And since mask is subset of itself, we will pass the first if below.
>    */
>   static struct mlx5_irq *
>   irq_pool_find_least_loaded(struct mlx5_irq_pool *pool, const struct cpumask *req_mask)
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> index 220a9ac75c8b..82911ea10ff8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -1664,7 +1664,7 @@ void mlx5_unload_one(struct mlx5_core_dev *dev, bool suspend)
>   	devl_unlock(devlink);
>   }
>   
> -/* In case of light probe, we don't need a full query of hca_caps, but only the bellow caps.
> +/* In case of light probe, we don't need a full query of hca_caps, but only the below caps.
>    * A full query of hca_caps will be done when the device will reload.
>    */
>   static int mlx5_query_hca_caps_light(struct mlx5_core_dev *dev)

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

