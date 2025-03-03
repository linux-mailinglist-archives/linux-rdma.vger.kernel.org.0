Return-Path: <linux-rdma+bounces-8262-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C3CA4CA1C
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 18:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017AD1891E5F
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 17:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491C322CBC9;
	Mon,  3 Mar 2025 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fABsrqGP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4371E215047;
	Mon,  3 Mar 2025 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023313; cv=fail; b=Kiwb3ASgFOdUb96dOhNu4T/1Fj5OvY1lZH59d8ksbFQp2OMkd8QYAZSeHHbQa5Vtk39f99uqh1DaThAU4t1WYJzEwJpryifM/l9q1LluQH22dQ6g+pI/RqaahYhnUrahAb8JFPciJnaQcCnNViS8NWwAqHndDrpRFAjuO/ynjyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023313; c=relaxed/simple;
	bh=aomrQ78pUPa32VlpdVYkQpO9a1R2gdkWfYReOTlaRYs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N+dnw+FJEmuAZaclIiNtPCH2dIBuUB9eW650bfno42KKIM+wjbDqzMnz2CPsKEIdlv3M6E+zYA0rb1e94e66tbcZVvtDARfBAHxNcuV1rvhZ+FXy4Hfjmlmsm62Oj2xFHni9I/aemGymFyu9ZUxE+2d28JX2qUlHCWRGyw18Cwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fABsrqGP; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfDCdfJhgwoUjL/zYtrIIFioY7vW8BRnC8tz/0OyKHxFCyj9lbFD0H+3f85/2JH8LXZUv69i2UV1FOa2KGMIcKTd4uRrvQqgsGzyd78Y6pU8+YyKPLp7HG+yllhIIypdovg3ZrMcuT27pcR2hCBgcn6XEZ5/lqgM8N9B+G1pA+qtJze9YGCu2HWLVGaanpbkVL5bM58WMRGKuSQ16SJkWY/i/EVG5FXzBmzgFRfvlsYlO8U3BjDuJ2B7MMc0UncPyzGiIjnLjpt7K/jc5KvhW1We9D5I+5k21GXl0va9KSrWa2pAhVfxzu3HnehIVVXVQiFNE93FJCZDxJWnIomlyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIBJF1PUpWiqwV2VMA2dQ9ybvNKgVb7rODjV2GDO3Ds=;
 b=o5Ch3UPxlNOmRGdbMygYSMX1lR/X1h6x2CvZ6+Y553HhxMl/yxNa+HSpYvrFzHfNPoCzLZ1WkPLH4er7aqrFMHmYKotAwRO+eCJxRD8v4GAsfpjk2OOe9JadYaxSFGtnWuBcACsFLqUCfrOi/Oz/HB+u7xflVvlWsV2AnDbcbzHKiQ3dl61HxHoL6NGRYsaoB++2BCA66+JUZrQmiZIpxcdbCdr2r2YA9fcLUjypk56eIppKeXsQeYmjOJy2A7Wq+jZoliSQcLaivWROT0Prx5FmkwMxQNFwQfdvkXD7OuxkjbmOcwEdCphhjmqIYFyGoENNoj/zAieNl4HXWUp/ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIBJF1PUpWiqwV2VMA2dQ9ybvNKgVb7rODjV2GDO3Ds=;
 b=fABsrqGPwSLQesXdQbsd77NPg+j8+GIp0BlxXMl642xZYDPabjasDLejRLo1lAGess9zLKIAHi2/w62JbS/aLdwQIlPLSEOAiS85SVikuu4nCLYMAK8L+aYMJ960a0V5f7c6+w6e1Gd91zEJe7+ZrMClkenTJEIxT9+dvkDDe+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 17:35:03 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 17:35:03 +0000
Message-ID: <38f8754d-6afb-4738-8975-e007aa0e201c@amd.com>
Date: Mon, 3 Mar 2025 09:35:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] pds_fwctl: initial driver framework
To: Jason Gunthorpe <jgg@nvidia.com>, Dave Jiang <dave.jiang@intel.com>
Cc: andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
 dan.j.williams@intel.com, daniel.vetter@ffwll.ch, dsahern@kernel.org,
 gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
 jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, saeedm@nvidia.com,
 brett.creeley@amd.com
References: <20250301013554.49511-1-shannon.nelson@amd.com>
 <20250301013554.49511-5-shannon.nelson@amd.com>
 <01e4b8ad-82dd-43ac-92b9-3b3a030f86bc@intel.com>
 <20250303172953.GC133783@nvidia.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250303172953.GC133783@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::12) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc93022-63d3-4dd0-c298-08dd5a79bb0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXlOeTN6SWpjbHpDWGFyaGN5RmduOUR6aHdpYXN6Q3VVVm1tWTBYNzdRMi9l?=
 =?utf-8?B?eTVBR2hNcmQ3SDRmd2pYcm9UYUxLbmNTQzl2d3pCdCtKOVUvbFE1Y1EvWVpT?=
 =?utf-8?B?Nyt4UFNvcFN0WktVSk1VZGlIVUJPbU5lUFkwNDBodHlzNFJwVnRqMVZKRk1W?=
 =?utf-8?B?eGpzekdFa0JPb0dGbCtnd0gzMjhPTk56RGMydFVrMzJBd3ovRVM4MkxrdWsy?=
 =?utf-8?B?a24wOXpEMkhBN0x5WitRQW9ycTZxUlUwYzM4ZHBHWEI3UTgya21aOEpQQXNP?=
 =?utf-8?B?QzUxWlRFeHVkOWE0bCtxRm9MNVdncnVpa3hRNzFZaktSTGdLWXFEWjRkRFV1?=
 =?utf-8?B?ZnJWUENmUkhscnlxR3FMMUpKN250TWNQbmlOL205NUNQWDQ4Qldvc2dlMFlo?=
 =?utf-8?B?UzhwQ0pacUt2Y3Q4TTl2ditobUliMDhBWXlzV1pkWDFHNFhoZkEvazFiQ2RM?=
 =?utf-8?B?L2N3V0xKREVpc2J6VGRnZU5PMlNmL1dZbjAxc2VWNFlxdmpFWVp4NjJQZEdo?=
 =?utf-8?B?czVncm1lemxpZXQwVEttSkkwZ015VXpuUVY1aWRjRS8zQjJTbmNDbmdIQWpl?=
 =?utf-8?B?dk9uVW9CQnhhVytXTk5wdHFMQUg3Sm41RTJXTnl2VGJ2Wk5nVFNxbkdoUnk2?=
 =?utf-8?B?TUorWXpvSWhqNTNFTU9xZFIrb084VDNuMVphWTJEMEpkQjJKWHdJeWxUQWFn?=
 =?utf-8?B?TVVUM2haM1RTSkRzR3hHT3lyQ0lOdTd3WktFYVpNWVdaRkVnQTBBZ3JiVXlK?=
 =?utf-8?B?VlF0aDRxTFVtZ2VHTjNmdS80U3Z1TWgwMlBCMWJmUXFSS0tpdXpBYlpZU1Bn?=
 =?utf-8?B?OUR2ZHI0WVpnSStJdGdsRHNEWmVVZERQdG8vcXBRNWVma2kwUDQ3VWVFZi9H?=
 =?utf-8?B?WGI3cjBwV1daZTkrSU1veWFvaGFrdW5kZEJpcE1yeDZRa0ZWb1AwNjJrZHpk?=
 =?utf-8?B?OVBZSHNEaW14Rmc3OWZOcmZERTd2cWZ6YktBVEt2NnVjeEpGeDJwWGxhM1U5?=
 =?utf-8?B?YzdYbW94R2tMUU01Q1JUMjRMSUFYS0Fja2t6MEVvcTNtSEVkYVZKWXdEK3Fa?=
 =?utf-8?B?YkY4MGZMbUNUOEg4SWMyNkQ1dWlQU0lUeFZ3YW9tRElCaFdobCtoR0kzb3pq?=
 =?utf-8?B?cEdDL0Y2THFiZmVnL0FJRFRDYU5xaGVkK2RwTllpODZ4WWdzMFlmc0toQkxH?=
 =?utf-8?B?Y0E3M2xuNythU2ZHc3AzemZlRHlUWGYvM3pkREVJdDdlYjNEampjMHJaTjNT?=
 =?utf-8?B?djJGaFVrOE5KY0pwR1huS2ZuV0pVa2xCSEF3TVFMNnJHNVIyd2dYQ2syTE1J?=
 =?utf-8?B?VG5mVy9lNGE2S2tUaVB2MzIxMUxlT0NRdEYxeHdJQTcxWGhiZkFGelFGUEs5?=
 =?utf-8?B?anJiREFWVzFMMXhqQXhSZHJDdWpaeGhuY1BwQWVmQzZzbWxvMnEwQmdJS2hG?=
 =?utf-8?B?c0hjbjA1RnB3QUtDOTViZzFrS1kvV0tJdTVvZHVPSkM1N09EZk5jaFhRSW92?=
 =?utf-8?B?aFdOMmlRcVJrRy84V0d0Sk05SkpmZDQ3OGk3U0dzbm9vWjc3YmhyOFpJSFpC?=
 =?utf-8?B?bUVMOWVJVmhrM2ZHSHpSZGVGajc0WkZ4cE1kMjdwbnJ5d1BpWFBVYjRTRTRk?=
 =?utf-8?B?WXhWeUwvd0hMS3FnVm5qZFlXSDNQc3UycHZTZ3hvTnJVZ2NIbU5sazFUR05s?=
 =?utf-8?B?cVEwTFdVTGFvWEptSEhNU094YjBYdlI5N0c3NG1GbEVlTzFtdWdCR1VkSGQ4?=
 =?utf-8?B?UzZlMG5XNVpvcU5MT1pEdzVQcVhHSmRxeWlmYm91T3V1MFFjZHBLcHhyTFho?=
 =?utf-8?B?cWtLbzd2VW5pbHlFZi9yRnFGbnhqYzN2MGhKMkl3L0wrVUZLejR4RGExdVdw?=
 =?utf-8?Q?FFqC/hRZA5bXx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVVNUWZjbmVwV2dvYlJxL0hZODFUSko0SWl4VzIvWCs4NUovNHVIdGtBWHZX?=
 =?utf-8?B?YnZYaFV2SWJQOXdGd0Z6Nkh3bFRLaTBOZzJDYlp3WjRDdTNxSVpyTHYycndU?=
 =?utf-8?B?Z1Erc0RDUUsxWUxrZjNFNlRVSmNTNlc4TGs1TWVJTjA0MVdDWjZzVDFoT0FS?=
 =?utf-8?B?YzdVNS9xeFE2YWNERDJjNmhUN1ozek4zUjVHd0xjYXMvREZMODhQd2J1aGoy?=
 =?utf-8?B?NFJ1TmE2UUcyVFJPTzlZMlZVZHphSGFDeGxtcytrQzFlUExKK2lOY3p6WXor?=
 =?utf-8?B?Y2JsOCs2K1JkRXlTUkdpWFJIa2ZlYXdwVFNacyt3a3JmMlVRRGFqK2pFUFpp?=
 =?utf-8?B?dzQveE5tMm12amM2SncyZHVlcmZPWjRCWVJjL3BCS0F3NWt0MmxhMkhvczFR?=
 =?utf-8?B?MjZwNTVjcG8yVDZDQU1OQ1Z4L0M5NFhJTTVScjhVQnRId2F3UnYya3FOZEk1?=
 =?utf-8?B?dU4zNjBIN3E0TExZTDVmdUJhb25qbS9QRE11UzdIYVRIbjlSb1FYc0FLSjhq?=
 =?utf-8?B?Y284dzBlN3dXazNiUnN0WmNEWkFtaHRWYklaWUR3Vm44dFQ5RGkyL1pKYXFW?=
 =?utf-8?B?UGNnTXhJTndJUWU0WW43SVBJZjYySlRrUHJlTjdXcld1TDNCZk1IM055VWN0?=
 =?utf-8?B?WWYvRkI0ZTJteGYzbWRQZFN6WW5jOGI1NWpUTWhZTThrYXJRVElpeUI4OW9E?=
 =?utf-8?B?Y2FGbW12SHFSdlFYeERqeUFCcEpvR2c0ajNMWGprV0t6NmVWRmNhYzdmWUJE?=
 =?utf-8?B?QitEeWdRVFlVOEJWSnRHL3VrS3cyWnAxYldPWGwxWUxwMnFxai9GcWVpcVV6?=
 =?utf-8?B?TjRPM3J6THJxS0dQck9LQit1UmZPQlpVTllzVTRqM2M3ai9qY3BXdU5IRGMz?=
 =?utf-8?B?V2cybVZtM1JId1FqcmFkQTNvSXhoS2U5SGI1eW5yL2NncTkrUHVuazVMR3lU?=
 =?utf-8?B?Q1ZPZm1sWFQwWVhLdmFlczFpQmZ0eGlES3QwK2FIZEUxRHNVaUVNMHNUYk4v?=
 =?utf-8?B?Q0tGNTg2RWZLRlA3L0trZzJwS3lCalZ6WG5EVmY2b2wwTGxlYmxqNXZpWDdG?=
 =?utf-8?B?NGF5d0JKL1RtTzVCemZFTEZYYVN2VG1CdWlRckhZYmh3emJXblBLTFdweGp4?=
 =?utf-8?B?Y2xJQlo4MDZqMXREazdxREJqMFhwR1l5aTQ3LzJkT0V1Z1VnVm5tR2xwNXhk?=
 =?utf-8?B?a2JFVHJTR0V6U1BGWFhLaWNLcmt4V2pESytrU2doZzV3VGZKV0lENVBsK1d4?=
 =?utf-8?B?eUc3TC80OUpQSnladS9tS0xBek11blh6emJPd1hXVzVNSjR3YzV3UCsvbXU2?=
 =?utf-8?B?cWQxTFhYWkpvRHRncUN2czQ5aWZiZE03WUY4dGlUN2FnRHY3V0VYdmo4Mmlq?=
 =?utf-8?B?QXBXeUxTOFVzaDdhck10ZW5pbkJNS2EvcHlxcENEQVpQSDY1RmNWMGZWV1FD?=
 =?utf-8?B?Z0J1QWZCSVo0VFV6UFdyY1RGNXZsNGJuYXAvV0NySHFWSG9aVTI4QTNqa3I5?=
 =?utf-8?B?TjdreFg1Sml4U0E1ZzlVbXRkT0pJUlBkTnB3MXhLbWthNWNlSGMxbmZqVkp0?=
 =?utf-8?B?aEhJNnM3M2VObXRQOTRtN3FsR2pJOHhHUDhSM3lkQnlsYlF1RUxaOERtUzUy?=
 =?utf-8?B?WGtYNmhmWUdhK0xCTHJvd0hBYUphM1lIT0NrQTZveThUMlJjUkJXNmh4VHhS?=
 =?utf-8?B?VzEvWTdWT3J6NmR3dTU1Y0U0NmRDRmVNeUFZL3FTbGsrc0hYOWVGbnBXM2VL?=
 =?utf-8?B?SmRZbXJlT2pqQldNQWw0V01nUDRrSE0rLzMrbGhaUThiVG5SeTFFcGNOYW4v?=
 =?utf-8?B?Y2RXTEUwYVo2c1hGVkFWNXVCSUh0enFPeTBKVzBOWUlTUzlESi81UXlFSjhx?=
 =?utf-8?B?YlZHQW9DeFlVYlNrL1RQaC9jUkhhQXlKWHh0TnhVelZjcjgyVFUvYnV1RTQ5?=
 =?utf-8?B?SjZ1TU9DeUtrTzRsOXFKSFdQZkNlZHdycndKY1hrYmZpS0xUUkJwT203OTg3?=
 =?utf-8?B?MjI3V0dRNmdlTEFGYUgwSGRlaDZhQzZEaFczSGVvWGtvWmlGazVMaHBlcm9i?=
 =?utf-8?B?d3pxWWlROGZ6Z0x5T0tYUDVUNDZPUzEvWFNYZ0ovSGJwTEVnYW9vSnFJUmdF?=
 =?utf-8?Q?zcjo5AyrQLtlwStk1avwSDLD4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc93022-63d3-4dd0-c298-08dd5a79bb0a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:35:03.3805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLcERjvnkgauNXfuB9LCBg6gC4lRh6ZdKul/QLgggohmuODD/TmkpPd+F6roxbzqtKURv0JX7jnRq6WHrCYdcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229

On 3/3/2025 9:29 AM, Jason Gunthorpe wrote:
> 
> On Mon, Mar 03, 2025 at 09:45:52AM -0700, Dave Jiang wrote:
>>> +static int pdsfc_probe(struct auxiliary_device *adev,
>>> +                  const struct auxiliary_device_id *id)
>>> +{
>>> +   struct pds_auxiliary_dev *padev =
>>> +                   container_of(adev, struct pds_auxiliary_dev, aux_dev);
>>> +   struct pdsfc_dev *pdsfc __free(pdsfc_dev) =
>>> +                   fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
>>> +                                      struct pdsfc_dev, fwctl);
>>> +   struct device *dev = &adev->dev;
>>> +   int err;
>>> +
>>
>> It's ok to move the pdsfc declaration inline right before this check
>> below. That would help prevent any accidental usages of pdsfc before
>> the check. This is an exception to the coding style guidelines with
>> the introduction of cleanup mechanisms.
> 
> Yeah.. I'm starting to feel negative about cleanup.h - there are too
> many special style notes that seem to only be known by hearsay :\
> 
>>> +static void pdsfc_remove(struct auxiliary_device *adev)
>>> +{
>>> +   struct pdsfc_dev *pdsfc __free(pdsfc_dev) = auxiliary_get_drvdata(adev);
>>> +
>>> +   fwctl_unregister(&pdsfc->fwctl);
>>
>> Missing fwctl_put(). See fwctl_unregister() header comments. Caller
>> must still call fwctl_put() to free the fwctl after calling
>> fwctl_unregister().
> 
> The code is correct, the put is hidden in the __free
> 
> However I think we decided not to use __free in this context and open
> code the put as a style choice

I'm of the same opinion.  I pulled this pattern out of the other 
functions, but left it here as it seemed less 'different'.  Maybe this 
will go away as well if there are other reasons to rework the code.

sln


