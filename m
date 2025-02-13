Return-Path: <linux-rdma+bounces-7755-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5015A3519E
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 23:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445EB1881557
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 22:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9472B270EA8;
	Thu, 13 Feb 2025 22:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TWTOEobX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C09212B3B;
	Thu, 13 Feb 2025 22:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486956; cv=fail; b=bQ3ErQc992t0UAyC4j4rbdXRa/rN3y+w0R/8bi9S4CbZ9OJHZfI9eaW9ECeFXeohW2rBQOzoUmAtvZXv52fhQi16rmE28B/2pOTX8y3Y3PzIDYGOar6ip3NLIZE/JXo/bJb1ukbVpX6jjXgboxOqqKeohzJ4weBDxLYDCB+i4qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486956; c=relaxed/simple;
	bh=pISktjzXwmW4ylHWJxBnOF6GNYFetMeEjx6HrmQScW8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O2h2lVsVIZ9IHeKL/G40i05fU/Vip4Uu2tgzzPRzQ3tfTfod+UXS6jAQzYJ414DaXhRAym9w8KIa9VviQBOooRTHXNBK/YXN/f5hwy8J4Wi/lyoJUtbCX4Umzx215ueGqz+xhtXup3WqSDSZKecdqzJ+airGB0juRChEQZx3in8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TWTOEobX; arc=fail smtp.client-ip=40.107.95.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBP3XSHWkZq5rsnjvi2MpsY8/9spnCIjSy/eZQIYA9VwMek3NuRSbMwuKo6TY2AL0awV9Fp32z7+xuNFVVxJrbk3e2GoQTt9k9xHLlOiXhtE3MfzE2KBOBPjUcANYj3ATBTqnnGPn7YJdSFdI2MHYgFgNtlfxQhGogUL+uYI+E6M+i2A/k7Fy9g/Kw7bxSa2HOq+GijHY3cMX3byMxyxKGT/BImunqnz1vgvx97RD/kKWbDKNEkW8gfbGk5GnP/HbKlyHtPxvmq2c/2LHWe7I1RV7mq/QZFVwJP6M3Sf6ZiwKOutnI/Cjui1g9fOxdCHIszJe7Dhbx64EodGHxgRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ue2PqMOGCnLWJJyIl1xg42AfYeS/T5lBIKIIiwSgrLo=;
 b=gmoVChSrSQi2qziD/PlFzrkNC6Z3UlIpaPqlgg0DnWQ9Ru7wU5cXXjIDuLqZ+1KbyiiOFe2h2353qTbwkNUzs1e7ANtUxGYpnXiOu0cMoYgzfXQGaEgjSL9zOnkGwzGwpkstAfZPMEaHXcGQVY8p853AbpfxQYrolgypWZ0Q4QEX+q/sqpANhqSYprRbBZKt408wOTF6tDAbbkyQpzFkv5Tl0qNHluX/2uT1KXv+w37W1iwMhNRtIB29eXm3wsMx6vMbqv58ap6nYeh8k69tiKX6rIeTuocLrr1PyHMKsY2OVwO4mnVfFW7D659jB1yWgurjaE0rchYsh5MG+dofIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ue2PqMOGCnLWJJyIl1xg42AfYeS/T5lBIKIIiwSgrLo=;
 b=TWTOEobXHeFzdynJkfOkhLfFN1gYDZ3qT0f3zDBSlPXDyUbyl3U2nEmjQK2hebDxjBQMit6DpzxiGPOn2NkNs7K+xiFzob00IRS/ZBj3pElZn3oUnk/nOukQLqotjP63hSjV4FS1lhcdoNQc/lDqwHmzO1dCq+QfDtNRBOtka7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH7PR12MB9201.namprd12.prod.outlook.com (2603:10b6:510:2e8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.11; Thu, 13 Feb 2025 22:49:12 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 22:49:12 +0000
Message-ID: <46a48aad-59d0-4b86-b994-2a609ff0283b@amd.com>
Date: Thu, 13 Feb 2025 14:49:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH fwctl 2/5] pds_core: add new fwctl auxilary_device
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: jgg@nvidia.com, andrew.gospodarek@broadcom.com,
 aron.silverton@oracle.com, dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
 dave.jiang@intel.com, dsahern@kernel.org, gospo@broadcom.com,
 hch@infradead.org, itayavr@nvidia.com, jiri@nvidia.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, saeedm@nvidia.com,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, brett.creeley@amd.com
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-3-shannon.nelson@amd.com>
 <20250212120353.00006f22@huawei.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250212120353.00006f22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::21) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH7PR12MB9201:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aafa835-1f52-4546-ace5-08dd4c80a2ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TytXWGU5cHdPQlE3MUl5SVB1UkszelZ1NXNNdVFRUjBoeFVieXFNTVAycXIz?=
 =?utf-8?B?ZWtvTnEwUEhjUkZLME5ndVBGYVRtMGNqb3FIM21tNkEwRDVSVTYzSmdmNEFH?=
 =?utf-8?B?OHRFUjhGSCtBeUZqS3BLVG1acFFZTkowMVR5cjF6bGNtdG1tV0RSRUhlWVQ5?=
 =?utf-8?B?TTlxWCtMQndhMG1NU3hrdFFEMno0VXRXODZ1Q0F3eTRubmlnL1BuNTZnWEYw?=
 =?utf-8?B?NWFjZ1F3WDl0YmFrQmlDZXhZVUpkaFN2emVYMThrRGZSVTZ4WXdFeGxjc3hn?=
 =?utf-8?B?SzRNWDlWN0N3TlBHelVKSE9VcTlZQ0JmS2tseU1rU3k1TVhRaUxGaVBQeE1B?=
 =?utf-8?B?THVybmJhak9RR0o3UVRmYUFtUzlCaG0zTlNTa3ZiWWZtalVmaGlidGFlZGlv?=
 =?utf-8?B?dXRudWJuTmFRTEcyLzRRSHZUUTVWKy9ha1RhNk5ZZkhCWUt5T1JMWjAxamFG?=
 =?utf-8?B?UDE5MUl5ZzZQMElpakhXS1lmRFNTaTA4N3NnSS9GQlR0SG5Kck0xUElTTjZa?=
 =?utf-8?B?cUFpUHFuYkFORmNzQ2RxYnU4SVoySHNFaXd5c2RKc3BldTNpbmljMTYxaEZD?=
 =?utf-8?B?cWhKaVhza2dic2Uvd2NwbXNKeDJFL1pkL0c0UURUWFk0QWd1VzdvWFdPUEls?=
 =?utf-8?B?Q3Z6ZEdGSEhJWGR4Sk11cUlWaXZ3TkdWY0c3K05jL1V6c29CQ2NXZXo2bmJt?=
 =?utf-8?B?S1NsYmVDcndUREFBdUhqYnpyNnkyV2ltRDlxd3pRRlNPVVBoNUlEV0F0cUZw?=
 =?utf-8?B?SkpRUmRPNXdTZWt3eExsNlRBWlpyRVdJck5udnh6Z3BJOTdmTVZVaVdhMTU2?=
 =?utf-8?B?TkhTOXNFb1JCQ1MvRTVlejJSSG5renFSN0F2eGc1SW1VU3Mrb242VUU3NXpJ?=
 =?utf-8?B?c2czL3Y5QXJpQkc5RmZBODZZd3ZJV1I5eVIvUXBHNzh6Rzd2d094OUZaQzRS?=
 =?utf-8?B?UTc2bmJtelZVZ1FteGhOSVBKaTk0bUNvZGJCKzU0bEoyZ2dDZ2hkYjl1MGtY?=
 =?utf-8?B?eURLSUlwYk95RWlDQTBTaDgzdkJFRXNvSkMyNk5ZdU1La3RDRFV5U1c5MUtr?=
 =?utf-8?B?ZkpOWDBkQ0ZjUk1IWC9BVVN2aXpxTHRXQlJ0VTZ4MUlxdmpVK2htV1VxaFdS?=
 =?utf-8?B?UjVVYUdQa2M1eUdmLzNCYTBDSXE1ZFExc1AvZlBlN1BuL3k3eWVDL05EcnZu?=
 =?utf-8?B?a3duUERjNkY2REl6VHZiZ2g5MjFScEJtS282RGg3RktLamtueFNyNm5ybWdw?=
 =?utf-8?B?SDROTENHQllqVGZlb0pWNTN1U01NWWM2ZU1BOWg3Si9wd0s5aG9icENQQ0Ri?=
 =?utf-8?B?LzFUeHpkNHJscTJiN0xSc3VDRFJTYkVxd0h3cVY2bmQ4ZGowZkhWZVNENFRY?=
 =?utf-8?B?UUdQTVlWRElvMENjRVBZbFRZa2hLWFhsY0dsYWJSb2YzQlpvVTVPWU8xVEo3?=
 =?utf-8?B?emdZMmIrSFhLNG9IcXErb0VENkozTzd6T2FSeE1saDhrbElXK2dVaXF4WUFQ?=
 =?utf-8?B?YVRHcFFqMEFiSm9Pc1lBeVQ4QXhBazN6M25DL3Z5c3o2RUd4aWR4a1NrY01y?=
 =?utf-8?B?WWh2NFg3VWlWT3pHVmdFYS9QN2tMclgyQmU1Y1drc3FFUWZwNzY1MVZDQkhO?=
 =?utf-8?B?ZXhzTVJnNDFlV2VjMTF6UXhvSnBxbDMySVExZDIzWnp4U2Y3OVhzY1ZzZVFL?=
 =?utf-8?B?SmRnT2k0VmlLbUdOenZkdnBlWVRFaGRVUHlSSmZVVWRFZVcySDc2c21VSERm?=
 =?utf-8?B?SWg2ejRQTHE0U1BGMTVaWnRIakg1VGcxSGQwOGhuU2I0VG00L3lHSTQyakNZ?=
 =?utf-8?B?RjhacXNENi9HbFZvdnoxdEI1WVdBMFJ0L0ltY3ZsMDNKQmNOeDMyN3N4ODdR?=
 =?utf-8?Q?MpdG98RRzbxw5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SG03VjdWV21vSW1SWGU3Ly9LRWNaR1ZtUUpoZmlHWlMyUUxrVEowVytUV1lp?=
 =?utf-8?B?SVhHQXFOcFJMRnJyWkt1NlpiL1B0dlpaaTV0aU8yb1RWSHNTa3Q0bExJNlNG?=
 =?utf-8?B?Ri9KRXlkV1h2b2dRK1VndVpiN0R6b2JUT0VRTWNmVHdGdkZhNklPM2ZUdDlM?=
 =?utf-8?B?RGZsNW0wV1dqNWFSZ2dQa1ZwZmJCYlc4YzAxTGRRREtpUXJSYUwycm5SbG5E?=
 =?utf-8?B?K3JnQmlZTHRscVVJd1dwdGdiR3YraHY3TXZXK1NGU3N6WUFjYlN5K0l5dXVp?=
 =?utf-8?B?VWpSRzgzU0xmNzcxY2k0UU5DbUhnclkvaEx4a09GYzhiTVZVdVNSb3RiUXhi?=
 =?utf-8?B?bWNRWVYxUURETWpuOVJiYkxYaVhobjhWWlpxOC96ZHpsYXF1N2liQkEwWWVo?=
 =?utf-8?B?ZUZVb1Z3RnFaekxTektCL0xXY1ZodFV2UmZ5eVMyVlhKK3BoSDdyQkdldXF0?=
 =?utf-8?B?WHNhdG5oekFQQ24rOXhKeS9pZWtJMWI2R0Vhb3pQRXNnRXpsTTVENm9SOVFh?=
 =?utf-8?B?NmVQUjRqOThtWUFYdHdtUnRwQitKR2RXK1RxWnU2bWpVNW41dm9XMXh6dkJr?=
 =?utf-8?B?THhpeWlMTjNyQW5qUDFObmdPTHkxMVI3YVI1aGNhMzVmeUlBWUUwaFZKaFFq?=
 =?utf-8?B?bjhHOTI0Z2hwamJiUm15OFNBS0JzU0REZHp1djdvT2ZWTlRndDkrQVNvcnd4?=
 =?utf-8?B?Qk5RUUc3alNKY0tQa2MwWHUwN3c4WjB5dEFhWk5DVzZKTTE2UEdXT21TREFz?=
 =?utf-8?B?UmYrTzlNcHM0UHM5WjlyYlFxcEo0dmdpQXFwTmNOblJKemQwRkxxV0piOUhK?=
 =?utf-8?B?S2x4YUkxL3MyQ2xRdkRRcWpFTHZ5K2poOERDSTkyOGdKR3RKbURvZkNMWUdx?=
 =?utf-8?B?R21tV09SSlVtelF0dTM4Yy91cXNzSVRHZGQ0S0JQVnlYYmMyUTJDQnJHYTJJ?=
 =?utf-8?B?dlY0OWRSZFJ2WEhhZXhqenZLbHpHMjNyR2ZPdmw1YjZsaTBQMTk2and6YWZY?=
 =?utf-8?B?aEFSazNIa2RsN3ZBQ05uSkQ4a3J6MnR2eWpUZ1dOZ2pYVzF6NlZWMUprdFc5?=
 =?utf-8?B?WCt3UHZZWWJmOStLWUdyNnpOSFBCTU1Jb1VhRWczREdjZkVFdjFwSDF4aVli?=
 =?utf-8?B?N2RNQ0JyY3dwU2cvMkprMmEyNG1uNkRLaStqMklySVo1QTE2enNTVE5iR1Jj?=
 =?utf-8?B?YnlVZ2lIUUdUSEJIQUxPTGpEYUF4eEhIRHNTZlhiV0tvRnRXNjUrMGJXa0NE?=
 =?utf-8?B?dzk4Q2lKVysySWY4blNVdTVPZytsbWRVNUVWNFJ5dlM0MGRrZFRNR1lQVi82?=
 =?utf-8?B?ZUVmM0d1eHlweXhRa2w0d3RhaGd4TFpWb0d6ZG5Fb2hKM3o2WStqY3JScHNZ?=
 =?utf-8?B?NUFDc3dJc1MzYm02amRwcHNVazBqdHZBT0dmV1g2YU5oS2p5aFVPbmlCVEpO?=
 =?utf-8?B?c0kvVUF3SXdmRWovWjNtR05GTkRoVTdKdlFJWEZTaS9zTDE5d0F0SnBJLzZG?=
 =?utf-8?B?K28wVEFOWXV1dnNDODg2WUJNSlh1MFNXdkhiSjdTRG00Qkl6dFg3NDRLWFBO?=
 =?utf-8?B?UFRmOEcrWi9aV0pLV1R3RVpmQ3dKdDNQRHNYcW5neDI1UDZYRFlnODM0b21I?=
 =?utf-8?B?TTBxSkxTdG90dXhYdXdSZUl5K3g0SEt2ejhHbFhVbk1RMTh4SjNsek9LVGZa?=
 =?utf-8?B?N3lXMUNRVXVWSmN0OUdsb3lqcjg1WU9KVjdsa2dsM3NXU29Yd2J0cW5LUTZ1?=
 =?utf-8?B?UnhYUEJnV3MvalNQd29UMWVCa0tWOS9XcTR0Zk1LYVRLanJFaXdMVEZWODJL?=
 =?utf-8?B?Y28ycUI1Q0gxdzdYUEF3SjZLNlZSd3Y4V2N5ZDVnOFBiaWFZbU9sNkNkbFkr?=
 =?utf-8?B?cy9tbDFLVHhFNzRqR2NETXl3c1d6ZWFtQmFiK2Q2SFdoeUhsWWFjUnVPZ3RQ?=
 =?utf-8?B?RkhRQm5NU2s3TWVHOVk3d3Rid1RlYWJHM3h1YnJHR09xdWdFbHJWSTh6R2xS?=
 =?utf-8?B?VkluMm1UOGJZdGVWTy9TVHZGdHJ3THNCcmRlNUNkWUMxTm10R3JmaDNWK1hP?=
 =?utf-8?B?dS9iYWZyK0x2NXZyUm5aRElUV0o0RUhoQ0xuTUJqcGlwWFVSSVVvL05PNHdZ?=
 =?utf-8?Q?+ibdNayhyJeUMMdXJHbCB4Qyx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aafa835-1f52-4546-ace5-08dd4c80a2ac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 22:49:12.6747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWKvp3eTJsNtUN1EMux8wMHKI3PXzf8ppaL/yX5HYjO2ywntRtEK6pb5hsnTWHQGGwSE4EzN+S1ufRq/3FS0GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9201

On 2/12/2025 4:03 AM, Jonathan Cameron wrote:
> On Tue, 11 Feb 2025 15:48:51 -0800
> Shannon Nelson <shannon.nelson@amd.com> wrote:
> 
>> Add support for a new fwctl-based auxiliary_device for creating a
>> channel for fwctl support into the AMD/Pensando DSC.
> 
> auxiliary_device in title.
> 

Good catch - I almost had them all fixed...
sln


