Return-Path: <linux-rdma+bounces-12973-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F511B39868
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 11:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2117F1C273DD
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 09:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405C929B20D;
	Thu, 28 Aug 2025 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2pNggRfY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7A523C507;
	Thu, 28 Aug 2025 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373806; cv=fail; b=N5L8Zqr/9DXd/MhXD6U1BfbeIVtcxPJh6ISyaRA4o2RDhcK/bZcn+t1MEhYGX+kcWInkXkFFDNvhs2tEtJ91v0tuhVTkWkYGtaTgzPvNeNAk/q5Y0YFfbVS9TzNw+ulIfNNebHfO/ylGbT3lAXYIvq2pUst85LySGk2F2Vwqdwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373806; c=relaxed/simple;
	bh=hhxDeGbK11BWu2CAUqyGTl0OR9ubNwVy4HB8JfMtfDM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gikfr070ZZvCFcSJ3zNopyJ9GyDbTnss2Lo7dySSt+QJcq1ElOKXwXbxbllqsHXd8XSEsjYIalXeulCaqao3BE2lP/6gapWomxEL6rZaYEuGW/OQrpVY0+7ZLoAAwgJxkbvGdoa2QIIfVMWGRUVy2CXfGAkPa4/M8FuAnvKbGZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2pNggRfY; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcqACIGwpBnwQNf0a8DSZQdUCE1l5ozGwzhAu9Nqh+iNhZ5yyeMhb7o1CyCvRQpDHoXKZVZQqaWYt4mBC6GgYRCXDVmkvGC08hQJkVHhqnTjMSZZrbQqnRYriM5aeCD0dWOEW9y4rGerb8486frrW/bwLHqiE0eDLOIGVLUHsIL8tNGygDzn85Og3mle57gfMFuOOlYsax393nJMA4nY/6QW6c8b5fMnJgYs/m2rTjhlQhXnMIHQew1hsr01iFnlP3e2OW5aBl15uaQ+RVF0B8CuvLFVh1LFgxqizbXvUwDjtC/Dxx9CoiLOulPjGWXQkYi0SD3wUP6d7jw092MGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZvGCqQm1HLNlc+WQCpHF+7K3by8k2oq007R6pkaRYE=;
 b=icIbCXnLGqhoeb/nxVh1sriUEgQK2ecWB2GawEdf/TH5vIz8PNRwOzyTkLUpEiAUHi/Altln5A7sG6V5qR+ShYl/rdX9lbMKUMeZW9Zt7CmnUUa4jDi+wne74MIpefxls63Y9ArmNRAT2uFFxYUjRVOsxG8beDB+GMEh+MfFCIklegPYTmxBcT6pcSHkykZ/ukwICzbtcAsqHC5rQ7kyFv6AWYRKJBoGKpO0/ns76+Rvjq0LeCZ32WNeaxGZ2H+d3j0+SIzxb5f4WxyU0kBzzw+fsUsgMiQrJlGYXfKLG/0y2voqgpG70V9Km/3zHYtoOYmnLtP/w3ojY9co9dDBZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZvGCqQm1HLNlc+WQCpHF+7K3by8k2oq007R6pkaRYE=;
 b=2pNggRfY9VlYumfnkxX117r0fmcCXcxrJTwo7RFRJedjuE8CQvF8r5GYtmBFju6bSAoj9ngwDwC7MEozTe0taUBE8Y820+e/mHjjo4fWvmNJe6IL5GX0vn7x7Sulke0Q2YJ22JhzWIipbrCLxoZObKPz0rU5oxXeq4lh3/cIt8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1SPRMB0007.namprd12.prod.outlook.com (2603:10b6:208:389::13)
 by CH3PR12MB9080.namprd12.prod.outlook.com (2603:10b6:610:1a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 09:36:39 +0000
Received: from IA1SPRMB0007.namprd12.prod.outlook.com
 ([fe80::3c7a:6436:c566:6354]) by IA1SPRMB0007.namprd12.prod.outlook.com
 ([fe80::3c7a:6436:c566:6354%3]) with mapi id 15.20.9052.012; Thu, 28 Aug 2025
 09:36:38 +0000
Message-ID: <fc57af3d-f2e0-2479-435b-b70f68cd5f67@amd.com>
Date: Thu, 28 Aug 2025 15:06:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5 11/14] RDMA/ionic: Register device ops for datapath
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, leon@kernel.org,
 andrew+netdev@lunn.ch, sln@onemain.com, allen.hubbe@amd.com,
 nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Boyer <andrew.boyer@amd.com>
References: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
 <20250814053900.1452408-12-abhijit.gangurde@amd.com>
 <20250826155124.GA2134666@nvidia.com>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <20250826155124.GA2134666@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::15) To IA1SPRMB0007.namprd12.prod.outlook.com
 (2603:10b6:208:389::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1SPRMB0007:EE_|CH3PR12MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b67b8ec-a6df-41e7-671d-08dde616632f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXh1REVHcGxSM2o4Vk4wMDVnZC85K0FhMFNLYzdRRGoyTzZDREdlV2tLUVV4?=
 =?utf-8?B?b3RHZFV0M3ZOZ1AvWkJjZFl6TmxtZkZPeUtIVlBwaTMrZVpUN1JMVloxUFM5?=
 =?utf-8?B?MTg0WFBOSk5iVDZZcGxkdGNiQ0piMWlDZ1dVOFQzUXRMelc5VGpwamt2TExq?=
 =?utf-8?B?UWdRdG00UmJ5eURzYmgrSitOenI2VG15Y09WYnZDZ1NGRitqSy9xd1RBVzAr?=
 =?utf-8?B?SnRUTjZCVnFVMno1NjVJZXBhRG12K2FjTno3N3hxTG5icDArY1NTVnFqWlFl?=
 =?utf-8?B?WkhIWFZkRHNoNHhPQ1VDSlBNaitLTU9XaVU3MnVVV1B5R09vM1JxZmZNVUhU?=
 =?utf-8?B?QjMzbm5pRkQ3MDB0QzB3T2JOby91cmJIYjFVZDJjSEFUYXpkejd6Z0NpSzZk?=
 =?utf-8?B?VndZL0l6OXRvbmJwdC9oVlc3K2JjSlBDRHg0SzczWEdHdGtSaXl3L2pQanRz?=
 =?utf-8?B?bEZrK2lWT2hPZTdXNnNzSTlDY1R4WGJPcUF6Vk9tMUtiMTNaV0FyYk0zb0VI?=
 =?utf-8?B?UDhyWDJCU3o2WC8rRTFJaGRGWUxycnF4RWRibUdSRFMvVGtRY1c3ZFFLdU9p?=
 =?utf-8?B?M3NkTWc3VW5laDJZN1A4UkNUTExZb0JmN0NrYWg3bWZURWw4a29tTG9pNi9i?=
 =?utf-8?B?RmtnT0V2TloxRHcrWUtBelp6c2dBdHF6Mko5Tk5veGJueEpLeWdFMTRNdWFY?=
 =?utf-8?B?QitTSmx5RDBWcHFMODI5dE8zTkgxNDA3bnR2eUs1VmpsZ0pXdVB6VVhvRW00?=
 =?utf-8?B?bStkYm1raXdTSFdOcEZrNGRnOUdvUzEycVl0Q3h6LzhCUS9sUHBOTzViNXBI?=
 =?utf-8?B?WEsybzFmYXd0RXloQzhTelhYTVRBbERvZUNBOVVrZDQ1Q1dEdXY4VCtUb2o2?=
 =?utf-8?B?MGRwcmRRMXp2djNRVW5xU2pQQThqVjluOThQQXNod2ExUEgrTlA5cmZIdjNw?=
 =?utf-8?B?d3dCTDBzSWN4N2g3d243Tkh4YUxLTDlIOHFnSE9rZHpGaVpBNlpoR3JxbUxj?=
 =?utf-8?B?Nit2dElsNlhFcHJKcVBXMlVTbEJXaEl0c3psbnpJSWl6bTcrN2MxWWMrcU1R?=
 =?utf-8?B?YmFVV2lIT3pvUHRmTFVibjQ4V2N4Y2pXZGcyV0ZRN2gzZWJlT28vUmRxZndN?=
 =?utf-8?B?WXVRQitkVG5ySGxTYUlUNVZoeDcyQ1pSYnlpSHZjdFFmNERMQVd1RnU0NEEy?=
 =?utf-8?B?ZWcvUHFadU14aVJVQlNMUlQzZ05KeldMV0VNNFNoU1FXOG9lNEF1azdlWnYv?=
 =?utf-8?B?VUkzUVpZc3NPbmRGcFdrYjJMTllnNmZMUUFIOGtvcHV1T04xSVNKUjkySVBh?=
 =?utf-8?B?aHlaRjJUTER3WXpTdFMzYm5remRGcnVlTkMyWlNma2JWMTJPWXR6Ulk4TFd5?=
 =?utf-8?B?OUU1cTllQWRUUXFNN2F5Q3RUTnpGNTh4VDZGbGNJYVZ5c3V6aENpdlVCOWRu?=
 =?utf-8?B?NVArOW9zSkpxYW8yenk1YVUxSVJOQnAxZFk2RENZYUVWcWpNYVFuZm5SVGZP?=
 =?utf-8?B?YUd1TFovVlUxWk9KTEY0VUhhNitSRmdhdXBUMEs0U1ZudkRrc1dHRTV3SnJU?=
 =?utf-8?B?RGtpenpwM0xna0lPUXYyVXdMWVFkOTJ6Tk1yL3ljMzM0OUJuTlpia1p2cXh5?=
 =?utf-8?B?Zm5tbm9qYUorbEY0bmk0VUZnNTAyNHVzVlJldllDT3U3RDE3b1d6bXNvNk9a?=
 =?utf-8?B?dGdNdmZZM3BxRFprNW1zckU2cmg4UnhjU2F0NHk2SytaTnFWcisxVjdOR1Vp?=
 =?utf-8?B?bWM5MktVUmZaVTVDWHp4Ny9FMUpUTVMvS1NzTStwaGtsVVdmZWpaZEtKcU5s?=
 =?utf-8?B?RUt6VFFSYkJHdXhrZWtQTU1QT21NN2NmR21INjhOSUxUWlVCSnhzQld2L3E1?=
 =?utf-8?B?cW8xTHdtVGNlMStENjE3MGs1d2xUMjMvME5QczYyUm9DM0dMa0M3VFVzeDhQ?=
 =?utf-8?Q?lj2RN55j7/Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1SPRMB0007.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWQxSzBXY2RlWnhtR1p6MkFRVEtZOTV4V3ZKQng3S09LYkRjQVYrL3BpUXVR?=
 =?utf-8?B?OElBcmhPajJDUzZLbkhvSjVVaUtSZWZiMWVHdW9USW9Da2pXU0wyc2dESkRj?=
 =?utf-8?B?SmNISWQzS2pQN2puT01qTkxZRUhBeVJXVmo1TUs5Y21MU3BhRGhlT3FEVkJT?=
 =?utf-8?B?MklFbEZoY2VjZWRDRjk1cGVVWU9NYUplMzBkT2NwRFRQblpSWjAwTVpZSTFa?=
 =?utf-8?B?UHBKWnlXai9FLzNzWkRNdW9PeU9YRnM0aFNDSnFpcm0yVTZiclFLTTRIc1BC?=
 =?utf-8?B?TzE1YTlSSHRYd3BGYTNOY2NFQm84MHlxUzRGN1NBRjVEQk9RcVBSdGhFb2N0?=
 =?utf-8?B?Y0Y5a3gvZjRVbTNicmF3dEF3cmloclU5bGVFRVorbXJPdXI4YmNBRHBVZlg3?=
 =?utf-8?B?Q2sySlZ4djBIWCsxcVAxRUJLR05xVmRBdXBQMjNoRFhTUVl5ZHJuYnlhL3Ew?=
 =?utf-8?B?My96aWpzNVB6UGJxZkhKSzFXRGgxTWc1ZHBHTCtpNmlOY0E3QUZrVGxmR0xF?=
 =?utf-8?B?ckE0Y1RQMFhCcEFpbFRzQXRFdnpWOUx3Z0E4NUxRblJxSkZPQmdaODRXTWtP?=
 =?utf-8?B?N1U0Nzh6SnpBMVRXK3d5eXJQUU5WVURlUUVkamFqcyt6aW9aaWd4RTAycXRT?=
 =?utf-8?B?dU84ckhyYk1CV0EyS09jVFpYMVhFYUNxb3NpcmhCNHBXTHpKV3g4alptVlI4?=
 =?utf-8?B?bjNSVlJmUGJYVkpxREJXSGFjeDlZcURHNGkrZUluV21RWnFBSy9jWldlQzJu?=
 =?utf-8?B?ZlZ4WGJMY3VpMjFhTFBPbWwxYnBJdEhSSEdObkVUV3RNc2RrTWxVWThqZS93?=
 =?utf-8?B?K1BLYlVNejBlUjFLOG8yS2tsUW1aeDlkTjRyMGtwNFIwN294T1crS2IwemRz?=
 =?utf-8?B?dkpCSGp1dG40VXg5TVQ4MWJrUkZBT21yWnJ3ZmZvN1A2VW9BRzMxS1UrNGNz?=
 =?utf-8?B?WkJ1RHZTbVdyQWRlOExSTHRid2ZYUlp4Y1dZemNZTG1iZHZTQU1TR1gyZity?=
 =?utf-8?B?azNBS01BN0w1UzlocDdGNWI1UG1hem1FSXNXWXJ3dVVPbkNpdjhwdG9xQ3BH?=
 =?utf-8?B?MTYwOG10alJGMVoxTkxpZ1pRWDRNU3ljT3FDdi9mWTlabU4vdmJ4TFdEN21j?=
 =?utf-8?B?KzhveUNzWmVDeGFqQUhlTUlHYzBUTjFObEVVWEdUUG90V2huMVdaUVZwK3JZ?=
 =?utf-8?B?bi9MOHFmUTMyWHMyTXN4M0c5OXNLQlN4MTZEc2dWN1Bxam1IaUprdXBlQnkz?=
 =?utf-8?B?b2ZYbHdJb2hkbDFLWHFWdTJQNlVyV0FwRUcvaXlFWWhsN3kweVpXUXlnbi9u?=
 =?utf-8?B?Sk1mNU1JdU5DWnVPNCswMXQxb29hb2tLeGRHZjFnTmRkVkZ5STUzVFo5YVp0?=
 =?utf-8?B?eU45Z2NoTENqWGRyUDFXeG9rWE1NR2s3Sk9DNVdUQXU2dkNqbWhoc0F6ZXJK?=
 =?utf-8?B?NFh4OFNYa2FrM3NMb0UrdGVWMzdOWDU2cXYrT1ZxSUo0NkMxeDlRNkUvZWd6?=
 =?utf-8?B?Mnl3Zyt1Vk9tVklKQ2doZE1SMXBPVFRSNGZQVm9ZKzhKZW9nVXlFS2pEUkMy?=
 =?utf-8?B?VXVvNVJVeTdlZmRpaFA4R1VrR045dEVsdjFUN0YxZG1hTFhFQnJNdWtYUlVo?=
 =?utf-8?B?eXNmeEJZN0Z2UW42WDQraGhwa0YvOG8zK0YxaS9LdWhpQ0FwNEIzNmkxMmFh?=
 =?utf-8?B?NmpIWnI0dHpESG0xMHBTZE4rQ1NJRHEwdVA1TFJnTFFsSStSK1VQV3p2dko4?=
 =?utf-8?B?aWtrdW01YnRRQ29jcytGaVlSVERaTXhpbHdaVEtPYTlrcjEyYmcwNHlEY1pu?=
 =?utf-8?B?ZFdPcURrNjFwTnZIaldiVHozaXczN2hMK00zdTVBRjdiUWY4aTRmWjV6akpW?=
 =?utf-8?B?ZjR6TWdicXJmcE9WTElCQ3Z6TTVXZkdWMzZjVk5CUFVmU1ZRQjhrL1gya2RU?=
 =?utf-8?B?dmx5aC81NW8xYUdjYXJoVG5kWFg4ZFFsU2J3ZkltUjBoUWZxU3l3aHhET3JC?=
 =?utf-8?B?REg4S1VDamJpaVcxamV2MW81L3orVmRYalRDNkZGNS94V2JYQUx5eTgxYWwv?=
 =?utf-8?B?b3JuMVJlVm1Ia2lzQUZGbDVxaVVKMlpMalBmcmVDeGFhanFZU09BbkZNWWo3?=
 =?utf-8?Q?zY+MQZJsB6fs+8wbdBVj5C81b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b67b8ec-a6df-41e7-671d-08dde616632f
X-MS-Exchange-CrossTenant-AuthSource: IA1SPRMB0007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:36:38.8100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyWkQlA8Ct3FeHzualhTwd8K3j75tLmXMNmtiDgXzgzZNmR5Ir6f6CC8spZoC2VWucw5dIsK9AD0DeRADdKaIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9080


On 8/26/25 21:21, Jason Gunthorpe wrote:
> On Thu, Aug 14, 2025 at 11:08:57AM +0530, Abhijit Gangurde wrote:
>> +static int ionic_poll_vcq_cq(struct ionic_ibdev *dev,
>> +			     struct ionic_cq *cq,
>> +			     int nwc, struct ib_wc *wc)
>> +{
>> +	struct ionic_qp *qp, *qp_next;
>> +	struct ionic_v1_cqe *cqe;
>> +	int rc = 0, npolled = 0;
>> +	unsigned long irqflags;
>> +	u32 qtf, qid;
>> +	bool peek;
>> +	u8 type;
>> +
>> +	if (nwc < 1)
>> +		return 0;
>> +
>> +	spin_lock_irqsave(&cq->lock, irqflags);
>> +
>> +	/* poll already indicated work completions for send queue */
>> +	list_for_each_entry_safe(qp, qp_next, &cq->poll_sq, cq_poll_sq) {
>> +		if (npolled == nwc)
>> +			goto out;
>> +
>> +		spin_lock(&qp->sq_lock);
>> +		rc = ionic_poll_send_many(dev, cq, qp, wc + npolled,
>> +					  nwc - npolled);
>> +		spin_unlock(&qp->sq_lock);
>> +
>> +		if (rc > 0)
>> +			npolled += rc;
>> +
>> +		if (npolled < nwc)
>> +			list_del_init(&qp->cq_poll_sq);
>> +	}
>> +
>> +	/* poll for more work completions */
>> +	while (likely(ionic_next_cqe(dev, cq, &cqe))) {
>> +		if (npolled == nwc)
>> +			goto out;
>> +
>> +		qtf = ionic_v1_cqe_qtf(cqe);
>> +		qid = ionic_v1_cqe_qtf_qid(qtf);
>> +		type = ionic_v1_cqe_qtf_type(qtf);
>> +
>> +		qp = xa_load(&dev->qp_tbl, qid);
> Why is this safe? Should have a comment explaining it or add the
> missing locking.
>
> Jason

This is safe because both the polling and ionic_destroy_qp() paths 
synchronize on the same cq->lock. The destroy path ensures the CQ is 
cleaned before its associated resources are freed. I will add a comment 
to clarify this.

Thanks,
Abhijit



