Return-Path: <linux-rdma+bounces-12539-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BC8B15866
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 07:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3995545A41
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 05:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726931DE8AF;
	Wed, 30 Jul 2025 05:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sAPZSXOt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D25A15AF6;
	Wed, 30 Jul 2025 05:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753852338; cv=fail; b=krQJcjLFdo/cCJ7G50cNEboR37eAAWajCMIJ5El3SHG3zQ2nHwyd/XUbk2pwXW83yIi14b5Lxf0obRmgITTbp2HOBPpiesBJaS43o7qsxOSvgumh4saobkKaTj/3qsi6xzm64enEHL45V+0H1J7W38XsNRufkWLyynqNXU8Faq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753852338; c=relaxed/simple;
	bh=U66RslzH+ISZJYfFfQ9yxZaEoR0froaCh37tacp+Z7c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VRo5iUlwWpUrkhI1T0z2UKFyzH4aT2H0h26HUaV1htzb9F18RQL9I8RvrUiJLEvCETpiARkNcn12xD1mShEl4lPmZCBjE8UThmURwENiN0zPoVMazm7NaokVc/cWErxxAgv+5ryqiitN4OXKGRJCkLPJpSWUQLgtkhQvPDBWPpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sAPZSXOt; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7V+SbftlavNf4R6uAZoJiRT5x6CxvsetMGxn0DMt8xrm8d+f4GAacaAGYGk9Bxg3nhgD31u2Drfa+vNscVt5eMi1XCctX+3iPoWfmKR+YWRlPRScKsV50lJ5W67mMWC5A9ldQjGzZUSP8vkATlytqTCLMSlasOmLgsXu62fG0N98GTN/mHA9zXgk46IoKpSZMw6u3LJPl0fIfHedKSoJsrGYi3jpD0qCBoKRyCvmJ+xsfIoXNZaHYMkYzLfiMX2f8AOFeot4mqpjlGjaXTFvwI3F1FGqiyg5iTvL+ZlpOGhwSwp1JWU5wx0fRk5u95E+8Fa9MyVFRPzly2oR016mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dUaCroVle60YM4yzf5FesD/djAS66r+pYhXiLiZ8J8=;
 b=QzJcGVBcBTUi87vq7MEYrvsPnrJyn/LSMbrsK4FelPbGSw1soDgkBGZDvOjKVQlu1VmymFO5FrU4lSLQYUmnURJZoqbdKK/lcQMXOu1Esg5jaxRODZ3EpSiEz6j1c8Jpeb1dZ67VTLaYU5LjnJQQw/cWtGueSxfLTtdHZYt2GpLvwUJhwtIGE9s4ZBi05fxUyzJkKdTnke6g4OrUSDnefvDfF4uIt8ao1ktvPKkF7iorfGGJjWv/7sM0orNJj2RloqCNLj/x7D5ZFhC7RuY25C3LJA2poHMNCJG7LGiSIeZZy3x+m6KfJ6O5kHYLS005NZiQM3/VrdIySSiTGXxCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dUaCroVle60YM4yzf5FesD/djAS66r+pYhXiLiZ8J8=;
 b=sAPZSXOtpAn6sBUYltqdqQRiCryPJGuwfgZkGl9lTE6i5cIHIIsNL3lgoYxrhhcGoivM2LokvnSnYaqf29i0Zk4WPuprlmEaw9UGsSTGKdAB40ge7f57FsbHgCnJbMezEOpfd5RWoQ63VIdzFfIJAbIjEuGxqSBeglUTXh0oZ2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 by IA4PR12MB9763.namprd12.prod.outlook.com (2603:10b6:208:55a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 05:12:14 +0000
Received: from IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3]) by IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3%5]) with mapi id 15.20.8964.019; Wed, 30 Jul 2025
 05:12:14 +0000
Message-ID: <1d64b342-2ec2-b3ed-c341-9c05d36bcbef@amd.com>
Date: Wed, 30 Jul 2025 10:42:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 14/14] RDMA/ionic: Add Makefile/Kconfig to kernel build
 environment
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>
Cc: allen.hubbe@amd.com, nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, shannon.nelson@amd.com, brett.creeley@amd.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jgg@ziepe.ca, corbet@lwn.net, leon@kernel.org,
 andrew+netdev@lunn.ch
References: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
 <20250723173149.2568776-15-abhijit.gangurde@amd.com>
 <62345993-46bb-48d9-853b-09a82b03edaf@infradead.org>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <62345993-46bb-48d9-853b-09a82b03edaf@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::21) To IA1PR12MB9064.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9064:EE_|IA4PR12MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e1da09-edfc-4e57-ef6d-08ddcf27a53f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SERqdHRPeWtabVRYR3J5SE9NRWxkWVBWeWFTeGV4dlNFaEJXZHFXKzk3R3BM?=
 =?utf-8?B?UWNhZkV6Y3FnVmp2Y0tkOVhoWTZKVC82NkJEREF1L2RNcDJ0b29Ic1oxSU83?=
 =?utf-8?B?SWVrNjlEcithLzc4MWU2WnBiYUl3T0tIOGY1dUI5bHdGQ2pjRG9Ma3pvU2JT?=
 =?utf-8?B?WHdaKzhqZGJPUm5lRzRLVkpMR2E3bE5VclR5cElwbVRqdXJKWjRtdEFQVzdU?=
 =?utf-8?B?MWZoR2NRSDZFTVRtdllHSzFZb3pTS0c4QTRTZXNjZm4zKzd2enFaZXRjVlV6?=
 =?utf-8?B?Vm5xUW14VGNkOHhQdXlPa2Z4VktnUXJORlVCd2ZWQ2JrbmFqQ3c1Sm0zWXB0?=
 =?utf-8?B?aEJ5cWVsU2E0c2tEWENhaTNmb1RLM2tUQnJnQWtPejZNeS9IK2xySVlVcndX?=
 =?utf-8?B?MzFkM2JvaVZHR3dMcEo1YkVFaHhoM3ZuNyt1S0l5disyZ3NHQ1o0UlVCMzFZ?=
 =?utf-8?B?bndUakJmMHdqZldPRnloSTNsdXVaKzRucTFLclB3YTh5WlY4RldBcHJ1Q2Vu?=
 =?utf-8?B?TlVSazc0ZHNZOWFDcW9CUnNKQ1pxNlZ3Ykwrc0RnNGZBVUZpQVcvdEZaSkFD?=
 =?utf-8?B?MFhpNVpsTjd6dzRnSk8xWnFwSVNVTUIxd0kxSm84UTNsT2Y3MTlCTkJZQnpH?=
 =?utf-8?B?OTM4RkNBVldLTTlHNElDbjBvNGlDb0FpRWN1R1IyVVN1RUFlZ1krSmltTzF6?=
 =?utf-8?B?bGtPZ2s0OVg4U3gyV3Ria3NtdkFMclo3SDdySzNoeVVwRFFoZzBvalI4NUJ2?=
 =?utf-8?B?R2xBM2N6K2VBVSt0TitWQmJqWmxUQWliS1hVQzErelJwTlI2SWpSQWJDVm1W?=
 =?utf-8?B?WC8wcFlwVkVJc0NOVEFBeWZIVGFaM1FPclIzcCs1OXdYbDV3TVRtNWwxaVlQ?=
 =?utf-8?B?b0JZbkorWDdiQ1RINWxPVnNDWDhhU21LVEFvejA0dmRYQS93Ujd2QnFPNkZp?=
 =?utf-8?B?ZzcvT2pFN3Rqek1kMFI1QytIMGpnTWJWZ1RBUWp6d3FjSlVmUWtDaDd0d2Vw?=
 =?utf-8?B?dHVEMkVIcHpZQWRoNmwvQ2tacVJLYjRVaisrZWQ3aDRGQ0NxN0ZaSVI3SWYz?=
 =?utf-8?B?UXdQbm5SKzdFZmRmb2diVWdlZ1E5Q2VxTE43SnBpQi9YdDh3bDlkenh1Vy8v?=
 =?utf-8?B?VnBFeDZKaStCTVRTdlIvcmRDS0pjdXdNSDVkL2JKSTdhS3BFelZnc21jTlhv?=
 =?utf-8?B?NFVOQ1BhUjVqM2VHamdielZVMGJNNVMyZDVWemNtVGZZaFNENG1sb3ZhR282?=
 =?utf-8?B?VXg5R0dibHJHYVNrZTFENUZLTURteWdPbGxodHgwaUh4L1BwWHZBVFY3dmoz?=
 =?utf-8?B?MzVQR0FRVjIwamhPd3cxaDVjQVZ4Y1M0QU9QOGNSb1dXbGxTRXQxZGRYOHVI?=
 =?utf-8?B?S1dzbHpFYXQ1cFBUTFErRXQ1SEtUYU84VlBSSDZHUi94YlUvRTRIOWlmWmdS?=
 =?utf-8?B?eE0vYWI4QmNVNlRCTnVGQXV5clhHd3YxeUlxS1BrL2hrbkt4ZUNPNWVGRUg0?=
 =?utf-8?B?VGpod3dibURkelhrU3ZmdGYyZmdwVEUwbUlzTE5QUHZWek5LbzFHUkt0YXAv?=
 =?utf-8?B?ZXptNVJWWkRWNEF3RnlXaHNVT3IvN0pkUGlieUNVcjdEb01RNW9JWVJsWlFl?=
 =?utf-8?B?UDVMTnVLWHFFMmhDMkFoQXRnSERyVGhnc1o5eTNmbVhBUHM2RG5JSThYSFBI?=
 =?utf-8?B?VnhZd0JIMjJoUkpGZ2pzRHZmU1dFN1dxY2lXVDc0ZkJaTXBndHhhT1oyeGVU?=
 =?utf-8?B?dGh0dTZrYnFiZi90dGZXOVR6aThsSk1yMXRzTVVzSjUzb2hFUjZrSjVYcTMr?=
 =?utf-8?B?amVzbWsvK1ROVGVJVHErV2VWOHM3Y3JjSkM4SlZEK1FjR2gvZEoyNHk0L0lR?=
 =?utf-8?B?Z2l1T1l4ek44dUlLK0o1QUJlZVNSY2dDaU9KU3JaRnJPOCtIdDhCdlNUMVRW?=
 =?utf-8?Q?jJKOgGrAgLo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9064.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2FKWkowTHl2V0VCYTJiMi92Q3pWakI4N1Z2MVN3eTFIZEgzNkFtbDdlSlRM?=
 =?utf-8?B?RnJMbE5HTk9FR2h6ejBGbVVlL0lHOVNQeldCVlJ4elYwODJNMGhKTktIY2FZ?=
 =?utf-8?B?alRlRHNyd2ZrZEFydVZ6RUNjS2F3Ulk5bEJmYkxqQ05WMHFBcFBYZ090SU9T?=
 =?utf-8?B?Y0dzQklBOXZUcXpzc0trVGQrRVZmWGFTL3QxVGRzZ25oM1VuVS9lT2Jqdy8y?=
 =?utf-8?B?VWFoL0ZwaTM0UEo0U28xSjJpTnVHaGpHTVdNUXJCYnNVUGU5M3ZHOEU1SnhQ?=
 =?utf-8?B?WWRTZTJFRzEvYm9DbE41VDdiaVhkLzFKT1lMUURkRFN6ZTJqSWo3eFArQ1BL?=
 =?utf-8?B?UHV0N0ZaOWpQcWM5ZVVQMW4xcUhhaUlUcFd5QmN4ejNwMUhObU0wQW1hTDk2?=
 =?utf-8?B?RkRiUnRMTkZ5czF6UTVCakJQKzg3T2o2RmpxSVU1a25LWnNkY1BRSDNDYmU1?=
 =?utf-8?B?clNSYVhGeTlTNGxCQ3lPazd3YWUwWFhjcDlwa21LNkFrdWhXVU5CK3gyTEdw?=
 =?utf-8?B?NVk5bmx1NUF6dW9yU1VhQ0R3ZnZ5ZUx6OWZwTFpkTVJEekR6S25pZGFidWh5?=
 =?utf-8?B?ZUZvSEdqOFhlTVMyM2tZV0pqdlNMRDBJT1ZSZ3NRNks1RVBXZFo5SzY3YXd4?=
 =?utf-8?B?c2F6UEtEbW02M0h5NGVBZGJ4eE91RVlJNGlxSmtnUmZnUk4vNkFXcDRzZ1dU?=
 =?utf-8?B?S1pVWS8vOVFkSTg1L0lyZHE0anNOWjRPbkY4MGd4QVVYbEtVeHZBdUZiVjU1?=
 =?utf-8?B?Y0FLaXBLYjZFcGVFaGl2Y2hCdm04TGpPQy90c2lZU0dMM3ltbUdRdzZObVUy?=
 =?utf-8?B?V1I2eURwSTZwbktiNXp4bWR6TW42R2taQ1YrL0Y0U3paR2dSMFV0cUlOc1ZR?=
 =?utf-8?B?ejJwK0plNE81UXJzKy9GRVNDN2NTemxQZEJxdUszaHppdmZIeWFQcnJuVmJ5?=
 =?utf-8?B?L1BFeXFEenloYmFqYXpSL0cyR3A0OU5sOFB3L1RlaCtZSjBBZksxaTg2Q0Ra?=
 =?utf-8?B?LzM0aTYvY2dpVGRpNjYreWdqd0RVdDNtZjluOHVQckN0eEl1WlFDOEhyNllS?=
 =?utf-8?B?U2Rjb0dtc0RCMENZWTdsR2pRMVhEalJjWmk0RCtiOHgrY2kvNCtob09qQ3pv?=
 =?utf-8?B?d2l1TG1aVHhZWXdYMWgyM25MSmgrUnR0T3l0S3E3RHBUMERIbU9VMjFML2lG?=
 =?utf-8?B?ejVzSjZGTnFQNE5UVDVZc0lESjlnUWtOa0NJMjU3UG0vNWMxelovTEptWG50?=
 =?utf-8?B?STFSRklQR1NEU0phNjVLdEVNRTNwRkNiMjVia0xNUDhkT0dlVjd2UmZua0pn?=
 =?utf-8?B?NTRVODQzanhsMmlQNmlFVFJ0U1ozbU1uUVgvZU1IOHM5VlF4cXFxZEFadVlX?=
 =?utf-8?B?b3cxb2c2MUxkWk80OWt5YTlkVVFEZk9oQ0RPN0NVY3RBSnN2aEhwVmlhOWlH?=
 =?utf-8?B?NitRM3dyUXZhbmVjZTB5SDF6STNxSmU2QkQxTGgrME4zNGoxY1g5VXU3NmtR?=
 =?utf-8?B?SWRNOWovUGRrWUtpTmwxMWY0QXc0SHd3SE1aYnYwc1ZFb0Z5bTNPTnRWbDV2?=
 =?utf-8?B?UUdCSmZ6d3FSVmlqRWUySjg4UkZSQmRWUzJ4RitnbWZVcy9wWVVicGlEKzYw?=
 =?utf-8?B?UHFOWFFiK2VSVEIrSTZoSDRSNWUwVXBKN2RvUGV3OVN0NlBqSUdDK0RCd0NK?=
 =?utf-8?B?RWlsbW96aUMwa2dxRUtHaUJMYnFZRmVsTkY3R2M3Q0NpMHZOYWhtR3ZqOGRI?=
 =?utf-8?B?UUhrWFFDRTBUNWh6c3dyMFQ3WktUaFF3ZWF1eU5FNEpJSVQwVFFzWE9yY0d6?=
 =?utf-8?B?VkRyaEhTa1hJS1dnVlNBTkQrSTVyYW9xRUIzM3hrOTZBeTVQQ2JsbnlEUjMy?=
 =?utf-8?B?b3RVamUrMUthNUtWQ3ZKV3FQZ0VraDBkaTdPZ0hqTFN2N2IzNjVPV2FHMDcx?=
 =?utf-8?B?UWQzbmZmMkNpaWlwUzV6NEduK2lIYWlKN1EvR1pCRGxVdmY1SjJDRnRBQ3Yr?=
 =?utf-8?B?eVIwMllZUi9MS0RiQlAySmJ6emwrVmxBSk5aUnJsNzFOWnZ5d0NCMjBlUElG?=
 =?utf-8?B?UjBjcW1tYm9wRHNkdjAvTUdScjQ1ZHNCS1JYMXpJcEtadGhpZ0FqZWJCZ1Jw?=
 =?utf-8?Q?mbKoU55Fjr60GJhE1aaz80al2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e1da09-edfc-4e57-ef6d-08ddcf27a53f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9064.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 05:12:14.3266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maPerKsvS7E2P4v7NVhGF6t0SqW4ZbmYFf0TI/XJIen492XMZTOEka5yl5iDy5hhrywcU8R8K3MgQM+s3Rt5lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9763


On 7/23/25 23:40, Randy Dunlap wrote:
>
> On 7/23/25 10:31 AM, Abhijit Gangurde wrote:
>> Add ionic to the kernel build environment.
>>
>> Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
>> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
>> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
>> ---
>> v2->v3
>>    - Removed select of ethernet driver
>>    - Fixed make htmldocs error
>>
>>   .../device_drivers/ethernet/index.rst         |  1 +
>>   .../ethernet/pensando/ionic_rdma.rst          | 43 +++++++++++++++++++
>>   MAINTAINERS                                   |  9 ++++
>>   drivers/infiniband/Kconfig                    |  1 +
>>   drivers/infiniband/hw/Makefile                |  1 +
>>   drivers/infiniband/hw/ionic/Kconfig           | 15 +++++++
>>   drivers/infiniband/hw/ionic/Makefile          |  9 ++++
>>   7 files changed, 79 insertions(+)
>>   create mode 100644 Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
>>   create mode 100644 drivers/infiniband/hw/ionic/Kconfig
>>   create mode 100644 drivers/infiniband/hw/ionic/Makefile
>>
>> diff --git a/Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst b/Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
>> new file mode 100644
>> index 000000000000..80c4d9876d3e
>> --- /dev/null
>> +++ b/Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
>> @@ -0,0 +1,43 @@
>> +.. SPDX-License-Identifier: GPL-2.0+
>> +
>> +============================================================
>> +Linux Driver for the AMD Pensando(R) Ethernet adapter family
>> +============================================================
> Please try to differentiate the title of this driver from that of
> the Pensando ethernet driver:
>
> ========================================================
> Linux Driver for the Pensando(R) Ethernet adapter family
> ========================================================
>
> Thanks.

Thanks. I will correct the title of the RDMA driver.

Abhijit

>
>> +
>> +AMD Pensando RDMA driver.
>> +Copyright (C) 2018-2025, Advanced Micro Devices, Inc.
>> +
>> +Contents
>> +========
>> +
>> +- Identifying the Adapter
>> +- Enabling the driver
>> +- Support
>> +
>> +Identifying the Adapter
>> +=======================
>> +
>> +See Documentation/networking/device_drivers/ethernet/pensando/ionic.rst
>> +for more information on identifying the adapter.
>> +
>> +Enabling the driver
>> +===================
>> +
>> +The driver is enabled via the standard kernel configuration system,
>> +using the make command::
>> +
>> +  make oldconfig/menuconfig/etc.
>> +
>> +The driver is located in the menu structure at:
>> +
>> +  -> Device Drivers
>> +    -> InfiniBand support
>> +      -> AMD Pensando DSC RDMA/RoCE Support
>> +
>> +Support
>> +=======
>> +
>> +For general Linux rdma support, please use the rdma mailing
>> +list, which is monitored by AMD Pensando personnel::
>> +
>> +  linux-rdma@vger.kernel.org
>

