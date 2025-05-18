Return-Path: <linux-rdma+bounces-10398-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62928ABB0AE
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 17:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5981894ED1
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 15:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68C7219A7A;
	Sun, 18 May 2025 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s1/JbRuh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E66155A30
	for <linux-rdma@vger.kernel.org>; Sun, 18 May 2025 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747582128; cv=fail; b=TqfUs83FAukxdTEK3WW/g6T2dcbm+sXnq0HPUxpcZ4JCLl7aMJ0yhCWz2DJASPtBdcZE6MRgwrYlRwZwK15LPRQTML7gby+ugKiUXNXd18kHEUwIeBr6UmwO7VXjuEaK4dXRCSTYMjoX0GODD4C8zkvCi1/eg+cvpPOEJfKkfNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747582128; c=relaxed/simple;
	bh=JLYpjn8GN1RwPMfz0a3xrKtpz6O9EliS1zBeDmkl9Us=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oDA8Rt4vLHbASS/uNxcIstUuwQeMcJneFwcGtgyZu8wBP8chcaGSazxezF4Dv9bUdvsKhVZa/uhMCvvkRGpjqYP/jVwUkxGltj20oh6c6ytlDW9NF7QqbvY/sD2zZrm+ZhOwaNE8cOOM2JAaGTeY+5IdfLLL5Nt9mbaJfKS1ru4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s1/JbRuh; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r25gVPLWE9kCvRVjahWnTWFoCeIaRUb7ow+IWueXVU+nVWbD5ny/YQFddYp91NsUhavo9RyNtyMmlT2Z3mSLty7vcYINTs2pDUgQbkwISrTfmA1GxY4jLDauIBthwbEFai2oNdMVBBnJJPLZuimNr9pZODIhpCL4eJdbDNkZM5oPsbEMrVHQC9vTCGhbEGCXsbAPEf4SoHveGKrtzmhRGhHb4NMSQJDumj3M42glEU45s9XEO/pTLhCGon/mbWUofsp0RmIwPShfURPEN4/ehCgGUr489lhlS43OPprtaMQQ8mfpS0Zqmbad5ElDCiIjz2x4I6tKweLDOmDa5aXnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHGracXaNnftxtOXxZig2+XCNnkryago32cyzXIk8B0=;
 b=jQ1h5CCmlKI3Vjc88fRYu8ON4VI7W5Aw67LDX0uVquWu10vBOJ7ShA4RFXqPo2m8AI5dYEUN3XDx8U/u79Gn8p74gRRWNP6pZPMCXIsDbSLPavLn3iuSPaHfvLlqqGpOe1BYuct6GvmusIzJoU2PmtFycqDAlZBuQClKFvnb7sQZHpmJVwTcu0pOHyha9rq+t4MZiWIKjXValsd6NVerL7u64TNqRB9w1k9zTeX7XxdbT33VGzEr9FCjg1D+npm7UiOwQJQLFiuTG/f3m/Sk2sExibsdmD8xziByyUNPtoDIjEFKeFP/Z85d+wzjBpODeVdy4YawHke5WVe32yifSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHGracXaNnftxtOXxZig2+XCNnkryago32cyzXIk8B0=;
 b=s1/JbRuhnYtQxVrSYrqnxxrkx4uA73k+gN2qJ4rszIuSWVs5Ql7FEozHllFNJiamInSYbpS+qHvx1EJmAP7gF9pq7t1+cn/goqkOa4csXAwhIPiEY4u6n3X5PNS/MjQ2TPmuNRqkmODl4UV/QZRH401hNqlEkECOOb5UKPT8EA8gWDlxrOw23LVbERl8KzkdCF4T6crG7l0qId6R5zpWdJRMO0w64UqrXsa6lTYByqJzdYLoxnM/l8OIvHMfwIHfVlZvXxhxjXdleX+o7D2yS3q8n/JsmExlmKHnRZUVcZf7gafuhP03TbUoa7KKMWxN7RpFNsNc2eAfYCpD6MeGpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Sun, 18 May
 2025 15:28:43 +0000
Received: from SJ2PR12MB9086.namprd12.prod.outlook.com
 ([fe80::d1f8:1abb:a524:9a5c]) by SJ2PR12MB9086.namprd12.prod.outlook.com
 ([fe80::d1f8:1abb:a524:9a5c%6]) with mapi id 15.20.8722.031; Sun, 18 May 2025
 15:28:41 +0000
Message-ID: <8e717caf-d5ca-4b79-848e-44ea14fa0195@nvidia.com>
Date: Sun, 18 May 2025 18:28:36 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: What performance is reasonable for ibv_reg_mr?
To: "Koopman, T.J. (Thomas)" <thomas.koopman@ru.nl>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <DU0PR10MB5923C51E458A0EA4370BE1FA8A91A@DU0PR10MB5923.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Michael Gur <michaelgur@nvidia.com>
In-Reply-To: <DU0PR10MB5923C51E458A0EA4370BE1FA8A91A@DU0PR10MB5923.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0117.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::15) To SJ2PR12MB9086.namprd12.prod.outlook.com
 (2603:10b6:a03:55f::5)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9086:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: 4775ea4d-917f-459d-6894-08dd9620ab32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eCtkYlRYeFBjOGlYeTVVdmc0VU1NVytVQWVsWTF6bUdHdjU5dlZEdHVqaEE3?=
 =?utf-8?B?QXBTcysxeUR2RlA1ZnkrSEtJUnp1UWFWNk8zcUVNVTA3VXVyVExuVS83a1JV?=
 =?utf-8?B?NG5nbEorZWQ2L0k4Ump5djB6bVNKMEJMZWVNdGhnRTF0YStHaFZzQyszZnJO?=
 =?utf-8?B?TCtZNThqL3NoWVgyb0FLUEI2YkF0bUVJUXdFcnJLK3RpV3FuS0hwcCtGM3dJ?=
 =?utf-8?B?RkorQ05sdGozWjl1VFRBYkI4alZlOVVabFcvRTJEaVUyb1MxR0JJdGZWRGlQ?=
 =?utf-8?B?d2ZFeUFpaTgwYkxYUzdxeVlweU9nWXpxUmtKSkNrRXcvamhDaklMMGtSaVl6?=
 =?utf-8?B?OFJkMHZ4UjErTjRWS1BYeG9qd1NvS2N2SSs1b0FRWnBjTGlLL2hKU21nRmxU?=
 =?utf-8?B?VTlhU1ZheWZJdTlMVTlldXBMVERtSlViNXNhUW0zckxOZUJMVXpOWVQwek1B?=
 =?utf-8?B?N2krS1ExeEp5RXRIcjNFTGVubFMzSUhGb2h1VjRwRVBNRTBkWlJBb1p0Tmo2?=
 =?utf-8?B?MU9rS2owZ0JUdVc2WXFnV3lvNms2Q01RdmFpSnJHR29PT2pUbVZnRzJZU1Bo?=
 =?utf-8?B?ZVdQT3Y1MWIwazBITGJzN25KYmpidWVuaTJtQW5pMlZGbk5KV2g3NDliZHY3?=
 =?utf-8?B?YXFURVZkWDFYbHdzYjU0RDhMeDdHc05jUzJUNUEycmZJdXNRWTZTTkR1R093?=
 =?utf-8?B?Vm83Mkp5WmZ5RW9xdTFrbUloMnRGWDlDaWJhc2M5VXJDU09tejNmWFhmZTEw?=
 =?utf-8?B?VXUwa2ppbWpqUEcwZzZEM3BrZVZqY3hnNzRmWjdOTDNabUtIRUZGbUY2TDBn?=
 =?utf-8?B?bEVkQ3BhNUpDQkRrbitNQm9rWFpwWUxxZWhRbTFxKzl3b3FHWkJyM3JjN3FD?=
 =?utf-8?B?VFhEYWQ2UUFQNStDL1M4NVpQWGZScW96ZVNCSU43bUs0T0V6eUhWVy9VMmJ2?=
 =?utf-8?B?RlZ0SlB5eTNaTmhKMCt5MjRjYXlRWnVkM3Q2WGRlNFJaemRHeFNsWEF0cnNp?=
 =?utf-8?B?Zk1ndkdibktGenJZZmtQaDBnVk1qTUk2NHNnYVpUdThGMTFOMmJCOXNRaUVr?=
 =?utf-8?B?b0J6cXZ5NWhPNjdRdVluSlVDeFhJdkZJWWYrQVgyNW9UemNkR0Nhdi9peXNk?=
 =?utf-8?B?ZGlGbERVbW04NVpIdlAyQStaV3EzaGo0SHRuNkJ1OVVHVDdZcFJTZXJHRmxi?=
 =?utf-8?B?a2pEeG15ODdYbHpLUklpMjNZNmp3ZU4xWlV5MlRoZVhjZzkreCtYaVpQd08w?=
 =?utf-8?B?cEZIeExpdEJQajR1T0Q3N3RNUzVOYXZUVUhUaDlublNvcnRPT2lid2FoSjZ1?=
 =?utf-8?B?RnFyOFF1YnRkRG9rcWdleU5wWlViMThyTXNaVGZrV0U4SGRyODFtK201US9T?=
 =?utf-8?B?c3hqWXlvZEJnVktmOUlUTmtXU1I1Vk5HbHErN01CMWNDck9QVGRpdUFYTDRG?=
 =?utf-8?B?T1VqWTlOd2RLck9PUXllWENmaFA4TEZQTEdlR2ZkZkpTU0FQb2VDUWIyRTM4?=
 =?utf-8?B?bCt1bys3SEppSFNpVEtQWnZGQ2Z0ZUhSRCtKMllxRVpxd0pjaWt6SUdXYkRU?=
 =?utf-8?B?a1B6V1diRW8ySmhPMHcwN0MrL0FtTFltN3lqNjVwd214OGlXNkJtTzlUT0pr?=
 =?utf-8?B?QmlxMjFCQ1lvVXBDK2pGNFlBWnJOZy9PQnBvcTRrR0tidlZzc1o4cVZXM09h?=
 =?utf-8?B?NWtQRXQyZXozT0NoK1poeHU0WDgrTGg0RktrdjZtMHp2ZGZJRU9rcmNGdGdo?=
 =?utf-8?B?czN1eUtheVVxa1lTVHhGUDJvNFN6RVk4N1B1aGMvbHFWNWpkMXl6WlVTbGxY?=
 =?utf-8?B?a1NNKzVOL1d0Vi9rL01obkJ2SEE1bXB0eWptMldQbUIxOTNKMHJOT0FFTi9G?=
 =?utf-8?B?bnZGWFZ4WTZuenRxUkwyUG51OGNQQ0ZVVGNkOWNZVE5FSkNhcTZKZGxxNjFu?=
 =?utf-8?Q?CHQ5T4nz2YA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9086.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjZpT09Pbk9RVGdhRWl6dCthZGltRUhxVDE3V3FiY0M0UlRVOGZnMGlNcms3?=
 =?utf-8?B?MDdtcFpGcjRCdkduYTlKOE1wdnAyTm9zcjBraE9uUUsrc01LWmtSb3EreEtL?=
 =?utf-8?B?MzYzdkxsb3JJdmhtcTZuQnFzL2hPN2NjQS9HS1JMTFBja0hqQ2VsTzFqQ1BU?=
 =?utf-8?B?V3h1VmlWK1lkK2N3WmEyLy9lSisxRTloSFdUNTB0ZEFYK1paRjA0R01SZWw5?=
 =?utf-8?B?SDJaR0lSM2t4MkZNcHhuWkc3L2puRzZDNVo4d2xHVXRkZCtzbDJJMDIrYWhE?=
 =?utf-8?B?N2pUTG9JanphZW1nblp1SjdraVZ2QjZFb3hxWlltR2g2eGp5VDNsdGo3Q1Rw?=
 =?utf-8?B?aytxcEEzeE44WXBmTlI1bmQrMWw4UURkTjhyZjd5dWI0NHo2aW5acldtNXJo?=
 =?utf-8?B?YnhPQVpablBPeEUyNDNscHVJZGRWN0ZUQWFVL1BHUGo5aVpTejNVbXVyYjZF?=
 =?utf-8?B?SkhHM3hSN2NIK2pKeG9yNmdITFAwWlQyTENDN3kzRDJWWGxiNXFUVlRDdElV?=
 =?utf-8?B?ZGN1R3ZtWXRaSEl0OUgyTUVpMHVNbzVxL245K0ZSQjExaFR6NDFiZ2lIMzhy?=
 =?utf-8?B?VmlhdXVaSEtTaFNnYnRia0t0ZmVJeHNJWEVBcEFrOTVpeVdRaTR2M0VqcHVm?=
 =?utf-8?B?c0V1cFEvNlVBMDZBZCtvU1RRMzltaVMyQUUzOVhuZ0lPSEtUR3l3bjR5NzRL?=
 =?utf-8?B?THZRdS91NWNGVytvNHJkU0hvSzdISzV4aVlYNHBYbEhUNVdZdjZNWXkxNVF5?=
 =?utf-8?B?SVhVN0tqV1JtMlFuTUhHKzBtK2ZpRnZ1KzZKMzdIWFd1SG5GSDNQR0p0eXA1?=
 =?utf-8?B?OHY5NTA5SUZsSXJ3U3RrQXFoTlVPaGhwRm0xWDZuemdLQXV3MEVxcTlzR01U?=
 =?utf-8?B?Vy9JRUtQbERINVVHMlh4VHNVMU1BVFRIT2piL2hKQkVzMjNnbXBUVUE0NXhD?=
 =?utf-8?B?SU95Y0tqV0tFWVl3SW83LzVpSTRhY0FUbFNHd1lCTzNlNG1yRVJkdVZUM3hh?=
 =?utf-8?B?QXQ0S25JOW1kbkNWMDkvMlhhbW1ZcC9pbkRFNm81Y1V2N2NOOWdNNHAzdlB1?=
 =?utf-8?B?eElJeXNNeEFESmRTTXRUQWovWmVrUlh1dFBsOW1GNWhjNWlHQnlGVXlFdHZJ?=
 =?utf-8?B?STBsTXpiTU1PQU4zdzZiVTYzdXJOWFp0eWhENW9tMEhnSnVuaTFFVVVueHR0?=
 =?utf-8?B?cDJNY1lFODlZZXlkeGRuRW1TK3NNZVg2ck9QUlFJNGV3djF2RllRUWtwUjVQ?=
 =?utf-8?B?YW9EM0J2ZUR4YmVJV2xOT2hvM1JlQXVpdCttcktwakJSamsxaDMxWUdnUzNM?=
 =?utf-8?B?ODdzZkt1M3lDOEFsUVBSVmMzekdSWTkxNkhwRWtqSTQ5NldOYVVhSWozL0xi?=
 =?utf-8?B?UXJlUzRTSlFVM1hLL1ZGUUdWUmxuR3dUa0dQRjY3Wm56VysxbjdoRnc0SjAv?=
 =?utf-8?B?K25adHVzTlJDbWkzVEVQZmd4U2JLUGt2bmZETHJXZGhJc2Q4L2pRS3lha2JZ?=
 =?utf-8?B?TkhOcEwxY2lyeDhZSGFGU0hMQ3IxSnRpM3hsa012dzdxV2szSVR3ZHI5eGYr?=
 =?utf-8?B?eE1oQXRvenVRUUFEY3dUK2cxQ1h0cGVzYWJkQ2xhUXA0TnplMHZrcThaYldu?=
 =?utf-8?B?WUtnMEh5eHY3b05jbDkrK081WEd1ZlFmdSt4NU45R3VUQzNONWVNT2JVS3Vq?=
 =?utf-8?B?M3JDQUs1eUROT0NzNFBwZ1YwdnhtWTFOeldwbXpQY3oyakZJVTgxOFU2d0Zy?=
 =?utf-8?B?aWoxOGtMWkRYSWFVNy9NQXY0MUw5OWh6aURiKytmNHhxVzVmS3NPQnJ3akNv?=
 =?utf-8?B?b3E2R2VWUzV6VDRuNy9iRmV2TlJZWG1Lc3NESWhaUzFlOUJZOXgycXkwWGpq?=
 =?utf-8?B?RmNpT09NdHlDM0FCNE82U0hPdCtxQkNxZC9ZV252ZW5pUFZwL1J1aDFybFVO?=
 =?utf-8?B?bUhlVkxTNHNBT3NWSXhUcEttTi95SDlOV1JzNlVTM2ZsZFB2Wm5XOG1rWGM2?=
 =?utf-8?B?Uy95TFlhOEM0U0IrTXl6V2hrUGJjVkZ4RHJIcitlYTZYZ2xZRHFlQ1F5NXNP?=
 =?utf-8?B?S0pyd0xCZzRDVXhORGJUL0ZoeGM4OHpxaWI5c1dDME5lNXhzaGU4K3RkajUz?=
 =?utf-8?B?M1RQRDArcHBpMThreTdqejAzNzFvT1ZTNEJVUUsvOFptQ01uRys5MHlPTFAw?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4775ea4d-917f-459d-6894-08dd9620ab32
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9086.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 15:28:41.4636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EF0IAlot/gXOwI2a1vD91Iikl4TFt1pgYdYSIqpzqmEBlMaDETkgHnBv0CYVa2DhO15Ixo3EPZogyIAMyz05TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802

Hi,

 From my experience the memory registration performance is highly 
dependent on the specific parameters of the operation and the memory 
being registered.

For example, most drivers do optimizations for contiguous memory to 
minimize the size of the memory translation table.
And some drivers, like mlx5_ib, have a HW object cache to optimize 
creation times of HW objects required for memory registrations.

In a simple test registering memory regions with only Local Write access 
flag I manage to register a few hundred GB/s when registering 1GB MRs. 
and only a few tens of GB/s when registering in 1MB MRs.

To analyze how the results you see can be improved we'll need more data 
on the specific HW you are using and how many MRs you are registering 
and their sizes.

BR,
Michael

On 5/14/2025 2:48 PM, Koopman, T.J. (Thomas) wrote:
> Hi all,
>
> I have a benchmark where registering 5–80 GB of memory using ibv_reg_mr on a
> node with 224 GB of memory is done at a rate of 4 GB/s. This is much slower
> than the 215 GB/s of DRAM bandwidth, or 12 GB/s of node-to-node bandwidth. Is
> this in the ballpark of expected performance, or am I doing something wrong?
>
> THP is set to [always] and the performance is the same with and without
> RDMAV_HUGEPAGES_SAFE=1 in the environment.
>
> Please let me know if the benchmark or more system details would be helpful.
>
> Thanks,
> Thomas

