Return-Path: <linux-rdma+bounces-12787-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA58B28BBC
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Aug 2025 10:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB476AE12BB
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Aug 2025 08:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7424923505E;
	Sat, 16 Aug 2025 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b2UZI+EY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A401E0DFE;
	Sat, 16 Aug 2025 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755331905; cv=fail; b=qh7rFaZXVvNwLmpagS6Xv+pDepinlibDFZ8M+eC5WZYktGRF1ax/NqdU8bRZhIdjgqmaZVDptzJ5Qp3LcVLH5Q/6vg6iUlm6+xcCut1BDyd7DmuYUxoLGtFcbixWk+IVe8ipqzn++u9Hdtf3E3a3OkAF+MOf3Dw9r9ABN44Ylco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755331905; c=relaxed/simple;
	bh=APZT3uIM18Dy60UNiE2VKuZerk0ERl9yprU4JnZ7bJU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HO3oqa3uMdWwjo+SXjk90Kbqv6+y+tb5V41pRUskH0OUXr+sYOiEMTYnHl8DXqbHLv+mipCoPwQpUHEWaWFD+26PyqOqOGdxTV8i3+6SCcIc2IGCDYWa0Tia1jnEGJGBk1r6d41VCzq+QYr1IjyDP+r0OqngVqR34hWURH8Ma0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b2UZI+EY; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ya0O6PP9G9KWj3UJXTaSASMjBVfIJSlfhyG4yTpXg5xxsveCliXiOlpKgKD/f7qiLh/8lr165Q+V4P9zM1mN9Fi8nbSXWKcX0LHLxNTuz7Brmgd9av0ElIsMbfFkspYH0+MhYaiot8aSs2CRnQVSOPJhP2miCfLOUZMhwR9NP69WxdJRBcecWCsf9cnhxswZlZynDBXUo9vEFR00p6KIBTto8l46SXcnF9o7skFEMvq87o9sGGZTruHcxGunZnqCntMVvfmsolhEGL8/v2SFZUHvSWCKFmVGD+BikgEGSU7j/819OJWNgJw/PMs1fF4yjsecwOQ8uhpYyw//4kO6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APZT3uIM18Dy60UNiE2VKuZerk0ERl9yprU4JnZ7bJU=;
 b=BhLzvciTLc7awFmE+ApXUPO8jtUD7WgfJOFS06iShHFxl/2R4ZYb2x3w0CEZojIrPo9car9TE0knOLk3zkWM7cfVe1g+1qRgeVu3tes3K2Xk4WBf1qcJ47G0/sWlnZMM/Xj/HhEKhX22OGzRNiC29O52GMVbO2NiTTU4dHt6zuX5ArtWYqr3vQ1Z3YlNFguSmp5LZ49rDp4WnLrGmNh70iNhy1dpvGFwF5FUEV+i5Buu9ivc4keTdah8veafkm5FLH+SAf1OpXd+9z1IrP3jehDUYO+HC3k3iiml3sUDO+tG2qmX1rhO7qA6iCI8aUFVc4fzARbw/wfkHh+zQjSx0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APZT3uIM18Dy60UNiE2VKuZerk0ERl9yprU4JnZ7bJU=;
 b=b2UZI+EYCZ3wC+pFB+HSBukaqI3nZSbOnglfpHm9M8e5VtOhW21iJYwskyy4qquYFs7FJEY4/2avM1mi7/1F2buc+K6J1f6cOIAVrTjQzKLuR1xe8cmnBi3KmRBOldPDSvReWna19mw/5VhDFsmUgAbk+7LKY7C84R+e+7ANWJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 by SJ2PR12MB8977.namprd12.prod.outlook.com (2603:10b6:a03:539::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Sat, 16 Aug
 2025 08:11:41 +0000
Received: from PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f]) by PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f%4]) with mapi id 15.20.8989.018; Sat, 16 Aug 2025
 08:11:41 +0000
Message-ID: <44ff453d-3c85-2303-44a7-a6a2e48f8adf@amd.com>
Date: Sat, 16 Aug 2025 13:41:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5 12/14] RDMA/ionic: Register device ops for
 miscellaneous functionality
Content-Language: en-US
To: Shay Drori <shayd@nvidia.com>
Cc: sln@onemain.com, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, Andrew Boyer <andrew.boyer@amd.com>,
 brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, jgg@ziepe.ca,
 leon@kernel.org
References: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
 <20250814053900.1452408-13-abhijit.gangurde@amd.com>
 <7e214d52-88a2-4413-bf3e-41dbbd93594c@nvidia.com>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <7e214d52-88a2-4413-bf3e-41dbbd93594c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::24) To PH7PR12MB9066.namprd12.prod.outlook.com
 (2603:10b6:510:1f6::5)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9066:EE_|SJ2PR12MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5922cb-df23-4230-9135-08dddc9c87f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWdEYjdpaXk4YUtOQ09FZlNzOWpOUGhlcVRORDlBWk9PMlpHK1FDVzJnSWN3?=
 =?utf-8?B?cGVRbS92S2hVQ0lNYzFMVlJIcEZ3Z0lRWlZISTQ2MTFaYXpzeGJYSktLUWRT?=
 =?utf-8?B?OGticDl3ZkhCREJoV202REc1ZnZqWlU2UmV2SnVabFJ4ZW9iN3hEd1d6SkRF?=
 =?utf-8?B?UmRSaEsvYTFVWG5TRGVDcThJZWJrMTJjaDVIUWVjMlRHUmd4a3JpZUpSaWxr?=
 =?utf-8?B?VFhNTnZ6cHEzcEhaVDVXeUxsWm9NZ1g0N3Z4R1ptYU14Y2I4U3o5UTRLSEww?=
 =?utf-8?B?Q2tpajViUUNiOUt0MGRzc2FTQnAzMXBnOStjRTBiQ1dUNzlnbGtQNitHcTZD?=
 =?utf-8?B?akJLczZ1RjQyWGk1MmJVdnozTjR1Z1pZc1dXeEM0VkhkZm1FQzIyMERXdzRo?=
 =?utf-8?B?aExvVDhydkZvRVhiaXZ5SkZLem9iKzVIcWUvV0VsTXF2Y2JPbEhSVzZ6YUJ1?=
 =?utf-8?B?cnV4bnVEREZlRnNZRlZwZWl5SzhsUnFXS0JHTWd0UERXdUZmM3A1N1YyYU1V?=
 =?utf-8?B?NTR6WTVEd1J2Y0hiOVVjRWxrSzRwYUU1UzJSRGhyaTVOODFoZTJOVVQxOUda?=
 =?utf-8?B?cW9MbWZwUXNrUDZXU1BwcUtoZ0dZSkNJZkdzOUkwTDJaNzBmZFVva3RpNFlk?=
 =?utf-8?B?TkVmcUlDazJOTzZqMmg3SlZXMlVvUEVWWmNQS0o0ZHh1SlJzbFNzbld3ZlFH?=
 =?utf-8?B?cXgycWNheDBPNFlvVE05V1NDOXV6SmF6S0xsK1FlRlB2ckc0ek1teEVaSW5t?=
 =?utf-8?B?dk5GWTFMVER2aVVqakY3dHNDM1B2L3FrOVlWM2VQK0szSS9RRUtPeVZmVE9X?=
 =?utf-8?B?YlRCMnVxWEx2Zk9aa21xT1JkZkEza0s1UHNtYTVWeHYvSThZSnA2R1V2dG40?=
 =?utf-8?B?enZLVkF2bFArVkttM3RhRHZXTVdTMjhCVnRybE1tdE9IZEZtamUxcWtXdkFi?=
 =?utf-8?B?RVNWdXFBcHhMMTZLMlNGMTlucEVaaTd4NVdjaFVsenJiMkloTTVrVVJ2UHNW?=
 =?utf-8?B?UjNGZGRkak5TTmowQWcxWXZqemNrU2tvNWhoWHdiY0l2R0tnWVhPOWp6SzJK?=
 =?utf-8?B?dU1iU1UyUWZIdUhxbDIxRkxXSEtrWnI2T25QdlZib3lZTFpnMVRELzdjc2cr?=
 =?utf-8?B?K24xYVUveVVnWHJxeTE0c1JyTFc4UzFaYk1wWVh0R2poK2ptRkxXQlZiYTRW?=
 =?utf-8?B?ZmlUWk1tY083NFZRQmVkNVB2RkRBUEdHN0d4QXhCNFVHazhMOHlZR2l3VUpx?=
 =?utf-8?B?c2ovU0ZnM0VQZFBybTdNS0F4b1pGamFsS1YzN01jeERBejdUSTg0NzNqT2tu?=
 =?utf-8?B?ZkxUVTlsQlh3dE5sM2tGc1Q2TEFZOURWdWQ0cms4TGpVbVpaQWlkMVRvVEEr?=
 =?utf-8?B?aEtYUHFjMjNndVZ2VnpxL2ZMM0dDODVmaHBUSkdIL1lZc1dydlVNS0ZQemJF?=
 =?utf-8?B?MTdsSlZzNWFuM3k5NkFNNm1JL3FUYTdKcW9GT3FDODIrbDFtYWNLenJETmRj?=
 =?utf-8?B?Wll3cHlnbzd1b2wrZGhJSTlCcmg0bGloMm1DUXd5UTA3dFpnZGVYTkM4djVq?=
 =?utf-8?B?YkFqdHNCS205V3h0SERzMzRpdzBzWHpGajUvSmJFdHQ2VCtZaWVmTzJnYTJI?=
 =?utf-8?B?S1lhcHV2cEFtVzhVNHUxenZGbVY5dlFRMnBBSnp2eTM3VWMyL04wd0dtM29t?=
 =?utf-8?B?NGszMHZZWXhBM2NjZHRWdFFtdVc3RWlyeGU4Z21GYjRGTUlpU2hjU09iRHhJ?=
 =?utf-8?B?NVRwcTBoWmp6NHR6Qi80bkI5Z0c0RzRVQXpkSGRXOHowcTd4QllrcmZjc3Rn?=
 =?utf-8?B?Q0tqVDZNWTQ5Z3VvUHRadnEveWpwMmQ4QWdPamVnRU1BQVVZaXdIaEJaeFVn?=
 =?utf-8?B?WldKOWFBWlY0eEJKZ1hhSWFUWVRZcUdQZy9hMnlYN0dUdzBEMGozRmM4Ukt0?=
 =?utf-8?Q?s0rVx84+5NI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9066.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVRyTkpvQzhaVlA2aHVDRDUreHl1Uys4NGd3bC9tMmNHL3I3WHBZL0QxbXNz?=
 =?utf-8?B?OFliLzNCeENFQjM0bzFEa3RDangrdnN2blQyS2JuZFh3cTROY25IRVB4RTRp?=
 =?utf-8?B?ZTMxYnlOWTJKMnV2ZmVMV05zeEwyOThCSkhOTWoxQndHRFRtT2taNk5FWkxH?=
 =?utf-8?B?KzNTa1BnNVR5OWNjTWdTN1VFNWcveWx1UmFUMDZUMWZSbzdETDRoVmFFVGxl?=
 =?utf-8?B?VGI4UlhkYmFqamZGdi9odE1yMkc4c3hnZHBDSXZvWmxLRStrM3NXSk85NEgw?=
 =?utf-8?B?T2hRbW0yN2g5cVhIcy9lUDZLRkkydlN6b3VaUCtVcXk5ZHN6d3g0akZJTG11?=
 =?utf-8?B?bXJieWhIcCtDVzBGYWk5MUVCUDlESjhLeWhraWdqOWdmMyt1dVlObWhXNU9k?=
 =?utf-8?B?ekphTnp0S1VWTGNOaDZSMExYNVV5U0NGYzQxZlVwOStHL2FGNy9IN004TUVI?=
 =?utf-8?B?L0ZLeG5SdExGVmZwbXRTSktqUHBTeWxZMWkvTlRlRXcwSW03Qy9ZWnREdy9O?=
 =?utf-8?B?ejcvRlZSVlZMYlF5NjdORFFZc0xRMlNrTUphQVVLa0ZzT2FjWlkrTmdieFRQ?=
 =?utf-8?B?RHFXMjQ4MUlkRjBDV0FuVTVPSWJyZURqbXZGR3hRcGdmRzdYMnhHN0RrZ0J5?=
 =?utf-8?B?aGZXbWNheE9adDlVNmJTS2JLcGtCam9UamRIbDJTT1hpdXZ1d0RXV1YzYVZu?=
 =?utf-8?B?NHFmaGpqWU40bS9ONVdQbTlkUU0xWWxhRVorS203eGlrUVpoWjBoTnh5N3pw?=
 =?utf-8?B?K0VSc3pHQWc3UFJMWWhHR1ZrenNKUUVFZlBEaVdiVFRoWjUwNjlyZnVpampn?=
 =?utf-8?B?OG1nUWNSLzZvcUpjK0lsUDRaTkc3Z3ZQLy9PNWxHb2JNYjFybEVJTTJGNUJx?=
 =?utf-8?B?VE4zQ1lhODQ3MHNETjUzWjNlQk5LQW5ud0xJT0N2QnRkaWhtMmE2TWhZZnZV?=
 =?utf-8?B?eCtFd3YzUlduQTZtalJxbU1sTUx5elBIRjhRUFJXYk5zWEo5TzJMK3lUcHlk?=
 =?utf-8?B?aWthcDhqNjhiWkxNZEkvUlRraVZ4QlNYWSsrbTBsaUF4WWcwR2xYeFZIQTdC?=
 =?utf-8?B?aTh5cHdTWEhJaHRSZGMxSG1pRkVRME9BWmNiSDB0UGRiK0tzYnVOYkQzRXA2?=
 =?utf-8?B?Wm9jZDRDczhBT2txRkRlOVNueVVwdml5TjBZUWZlYUkzQzcrM1AzM1phc1Bn?=
 =?utf-8?B?cWY5Y056blU4bTJycnZvbDJ4ZDA1d1lkdlArMnVmMlVIRUEwZmJEWkcxY0N5?=
 =?utf-8?B?T1hDNURzWmlYSzFJNEY4SnA1em5kTDZ6ZVBoNWFvdkRTYUVoS2xzSTRVOE4w?=
 =?utf-8?B?dnVGdzcrN1FhSGMwNG92c05zUE5QdytOZUhyd2xSOGV0TjByZFZXVWVlRzFW?=
 =?utf-8?B?YVozU3duSG5LVHFUclJFWGtHVlorVWY0SEU0Tm13RW05Uk0vbDNMOEY4Z1Z1?=
 =?utf-8?B?L3BXY1JMTXdpWURFdENyTVo4d1d2MitGR3draXcrM0cwV3JNWVR2bWY4MlBG?=
 =?utf-8?B?dXFISUV3ZTVwYnMycGxhU0kzZ1l5SVQ5UjcybTViZUZiUGVRWS90TDhJTTJN?=
 =?utf-8?B?RTF5QzZwMWJRcXV6UG9lb0c3RGIyazROZkRNS3NZWVBnSzduTENEMHl5ZEE0?=
 =?utf-8?B?Q001cVZLQ0hVbE83TmxGOTVHbUhWTUZzRHpoYjhZL3AyL2RDdXVBVFBxM1BP?=
 =?utf-8?B?Y2p5eXpiYW0zOURSQjhMNHNyVmJQWGYwc0Rza3NMWWRKSTVueDJtcUlQbUNM?=
 =?utf-8?B?T2pYY2xScytoU0lTc2ltcy92N09aRVpRVW9pb0RLZFhHb05JdUNPZVBxdWln?=
 =?utf-8?B?VE5yMnJLWlgzalp4QnlTV0k5UnZSQ0d6dTk2UWtjNVU2RE9wOTVQYjZtUEQx?=
 =?utf-8?B?TkVVZlZmUCtEeE9QNWpCay9CcVczZ3lZSWhUTTNldGhCRTBRYk5weTBVTC9y?=
 =?utf-8?B?eEtpb29XWmJRK3F3NE1rMjlMNi9VTWVuakpMRm41b2pOZFFLTm15K09raXZB?=
 =?utf-8?B?ekV3S084QzJBSDRXejNjRWgrRmVQSEx2WjMzZ09FQ0U5dGxxSWZxTWIrTGNh?=
 =?utf-8?B?aWhBMmNzN0Y1TDNad3N2RFlpUWVKdWF4RHRiNlgwZXZBbk1iaGZkL0hUYU9V?=
 =?utf-8?Q?Oq1UFPsiCX0C48mUzJ+e3ix1a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5922cb-df23-4230-9135-08dddc9c87f1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9066.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 08:11:41.3711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWFIDaT/f9Fq/zw1MN3SwIMgbgIA4Cv0q8z7hEDgql8vEiScr5c0JuuteVrcgbxupFrhoTNOkkOmlWhDHWeo3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8977


On 8/14/25 17:02, Shay Drori wrote:
>
>
> On 14/08/2025 8:38, Abhijit Gangurde wrote:
>> @@ -50,6 +251,17 @@ static const struct ib_device_ops ionic_dev_ops = {
>>       .poll_cq = ionic_poll_cq,
>>       .req_notify_cq = ionic_req_notify_cq,
>>   +    .query_device = ionic_query_device,
>> +    .query_port = ionic_query_port,
>> +    .get_link_layer = ionic_get_link_layer,
>> +    .query_pkey = ionic_query_pkey,
>> +    .modify_device = ionic_modify_device,
>> +    .get_port_immutable = ionic_get_port_immutable,
>> +    .get_dev_fw_str = ionic_get_dev_fw_str,
>> +    .get_vector_affinity = ionic_get_vector_affinity,
>
> I see there is no usage of get_vector_affinity(). It is called from
> ib_get_vector_affinity() and no one is calling ib_get_vector_affinity().
>
> So, in case you re-spin the series, can you drop it?
>
> Thanks
> Shay
>
>> +    .device_group = &ionic_rdma_attr_group,
>> +    .disassociate_ucontext = ionic_disassociate_ucontext,
>> +
>>       INIT_RDMA_OBJ_SIZE(ib_ucontext, ionic_ctx, ibctx),
>>       INIT_RDMA_OBJ_SIZE(ib_pd, ionic_pd, ibpd),
>>       INIT_RDMA_OBJ_SIZE(ib_ah, ionic_ah, ibah),
>
Sure. I'll drop it in the next spin.

Thanks,
Abhijit


