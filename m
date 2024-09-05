Return-Path: <linux-rdma+bounces-4778-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C4F96E465
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 22:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A9428A498
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 20:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE341A3AAB;
	Thu,  5 Sep 2024 20:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OHvUSkwk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480611953A9
	for <linux-rdma@vger.kernel.org>; Thu,  5 Sep 2024 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725569337; cv=fail; b=haccdLQ0qIDdAeWePU4gyZInXSxkSmPqQ1BoCaaPoAV80+vJfIJ65FfU6JkJjM2JZWLWG6PjljIg7VqO2tkAqU9CeB65WdO7pwM3BfmtWYnRQMQORTM8M4+ik5n6JKwBrIz3awXc6y3YuaaLKW1f4Idy+A8dr++cnFvjkpWVKu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725569337; c=relaxed/simple;
	bh=t/I4vYGACv616Znx6Xkbl6j0zIkwhYdVT72sUCq62sg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ms5y9GeiV1fWuOz5D7K2DRSm702iavM6285nxCDC/4oAUN1QpWYPORWTnWML6s+fplFDzgbRIwwXnYydjnSeGTmN7tfWozbNKYbUwGpUyE/+GgG0tkpGrLv3u9gqyPx4O4+YwVYCAW8C4fAQ/F2t4FOF2zLcehZRqRyX6svr7hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OHvUSkwk; arc=fail smtp.client-ip=40.107.102.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBEIaQpEBvMTzubc7t/6P2sIWgBIABzFvkO0AYTVIGRFFsbKFvd4okPvvdG8OAWBtjviN1aME+0k4B1GBIsW+2yemx7KlJ1G6d+mMQOsu8CzHly8lkPT7ZRMjnEYWSPyQXR7BL3zhCnKfGpZC2zCVpR9+llOyMDMrFAmH6XKtJwGzbPN3RyXQ3Rccnqhpg+9u06jSJPuB2r9Ri3V3ksEM1beZuDAyci7GmrpQU5uVbDMK2N+/YfTIsSzID+ry08lUZI1HT7tU+r0HxTZVBegNJmqJwZXcAQmNlyOYxMEfQJRIoosUap5RWNzSD550fagnqxdifYUJ6/9kLtQhv3LLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3n+24ukQM6oWFCj/+exoIvIooR4egpFAs27FZR1y5A=;
 b=lZq7nd0ToaOxqen1JvOt68lablRMVjA8ODPzesTA6H05EHBwvhzUDqcHum6dDrjD5zOaaVfuKCkZpd9tkOX5epBBh8EcJ3wwklCnvfiEottevAL7mommDRfDxAptr8Q6xcmquUBvU11p/SQtQDqHMdqxHY1HnujLeB99RBf5WGAp9ZCFkNu+RwMCeTBDIc11Xv8sqcsyD0YH7FOAo8A7yekeKLEppfu6y/jCN1lUQa1lLs8oIrw6px/B+/AtYlKIi240RF0+VArTmsrrBkd0nDSFCnaVUH0TfYpjXoWJ/prxsKx1+fZ5uoHqh01NUYmrw7BSkEsDXFHnLdxzI8Beog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3n+24ukQM6oWFCj/+exoIvIooR4egpFAs27FZR1y5A=;
 b=OHvUSkwkaLvDSSUN7c51OkkE9dR8MyHkd2qWI/uCHEZLTs0Z5J+Yk1Du7seM/ro+bI4zMZZBrfHozjBYjwr7xyKd8XYUtsTDWFwy7+v9K8MlQZvZK3DbiKdXv+oi49KSZN3VCkHZho06BqyhK+RPNbuckp9iU/UtcKB3iQtVnhvAa/0JL5V3NRVKrek8T1sh7xSb9pJlNZHPMZ6av7SRHYu9SQM0019ie9U5kRlzmLiqZiV5bb9W+cgqGsVSePLJllPQXD+VZEQ4cq53Kqkyf585yiQXBoVRcLlkW0LOcs/NSpOj/RL2fKVk5iKRyE77e0VkNu9C8eXGNQO8N4nGXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5)
 by DM4PR12MB5891.namprd12.prod.outlook.com (2603:10b6:8:67::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 20:48:52 +0000
Received: from SJ2PR12MB9086.namprd12.prod.outlook.com
 ([fe80::d1f8:1abb:a524:9a5c]) by SJ2PR12MB9086.namprd12.prod.outlook.com
 ([fe80::d1f8:1abb:a524:9a5c%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 20:48:52 +0000
Message-ID: <9ef3c49c-9e38-4d0c-be54-4a3c0b93375d@nvidia.com>
Date: Thu, 5 Sep 2024 23:48:30 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next 1/8] net/mlx5: Expand mkey page size to support
 6 bits
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: leonro@nvidia.com, linux-rdma@vger.kernel.org, saeedm@nvidia.com,
 tariqt@nvidia.com
References: <20240904153038.23054-1-michaelgur@nvidia.com>
 <20240904153038.23054-2-michaelgur@nvidia.com>
 <20240904161839.GM3915968@nvidia.com>
From: Michael Guralnik <michaelgur@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240904161839.GM3915968@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::9) To SJ2PR12MB9086.namprd12.prod.outlook.com
 (2603:10b6:a03:55f::5)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9086:EE_|DM4PR12MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: 5859fa5e-3194-4b58-24ce-08dccdec26cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDZMSVVEQ3IwVnJMVjQxaHZ2YVBycFRnL3N3dUhoY2U1NGNZZDBGUnFYUUJK?=
 =?utf-8?B?WVhmelVaWXp1aW1FQWlKNlZmTXI2OE9XRThrcUZUTGNCaWFtaWx2NEZGT0ZR?=
 =?utf-8?B?dWFPcU5hOXEwQ3Z4TUhHWXdYQzBzSXJzRE1MQUpPd2dDRTNHNWpCTXdqQTFL?=
 =?utf-8?B?cXlTWmtBcXRGWWljOFpCalc3UUE2U1VpYkptcXZoRjBKNllnRHB1anFSTm12?=
 =?utf-8?B?Y0xCWnJIdWI0VVcyMEFHTlk2bWtsajdCWXpCYXVmOXp6aG0yOTJZRTlYSGpv?=
 =?utf-8?B?OExtNVZtOStWUEtHaGtkei9BaGlnSysrRmFuRCtWbmhsYW9lSHVHZGZEOWZm?=
 =?utf-8?B?MHNTZ2Mzd1d6bHh1SnJSR3J2Y0IvekJsT3pYZUZuL24yZGVyY3VvUXFXM1po?=
 =?utf-8?B?UUF3TXpPMWlXbDdkZnlKMllDUmRvMzRucmJycFVHeVV6NE5SWHRuWEpZbFFB?=
 =?utf-8?B?RkdpcDMveldvUDlRNGtocVY0NXExWlNrZlB4WjFDT3lTOTFCaGxHWWkxaDIy?=
 =?utf-8?B?TnNCUlBNZlVFZFBZRkgxQ3dPZFkzL3FLZ0xMQ2o2elIvSTh0dFNPRDFocmE4?=
 =?utf-8?B?UFMrT0h2TGF4T2VzYlpBQXVJbFk5dTN6cWkybFliUlM2eWVGdUNoV1Zkc0Fq?=
 =?utf-8?B?TnFGVS9IUk5UMmw5c2k0dCtGOStBa2Jwa2NJWW94RlZmTzBPY2dJNytJd0Ja?=
 =?utf-8?B?WEFqMmVUcm5ldXVTRkx1WkFBU3hYbmpDQ0IvcWQrcktqRndQYS9pSmZUTDJm?=
 =?utf-8?B?MWN0TENPRWhEWXJXQnI4d0FmbXR3T1RTa3h3QVBGQkVXa1RoRWMzN0FtNGhN?=
 =?utf-8?B?eTNxY3NNU0xtV0VLaVVDeUdSOXNRdDNENWtmdUNxMElFbFovUktaMUtIWmdw?=
 =?utf-8?B?T1N0ZS9pOUVQTStWVGFLYnowY0M5V3o5Q3NXZlNSNE5HWGxDZ0hMemhXalFm?=
 =?utf-8?B?OTR0akxEMkZCVytCK2habS9kajNMOVlJZ2drTVhsSkxtWDlWU21ScE9NZjVK?=
 =?utf-8?B?WWNVSis5dlJWa3lob0E1cXdCM3NpNDFONzRNMEtiQUVkakNRSm14R1d6YWpI?=
 =?utf-8?B?TTN5SkFsZW1aZE5UQUZUbFh1c0YxZUtreUIzK2hKVDZCeE5yUUhzS0QyQWlt?=
 =?utf-8?B?SUlDMk44N2ZGMzlsUGxRN2JvOEJNYytXYzRlKzFEZGp2eHR1YVdMVjJLNE5D?=
 =?utf-8?B?bkFFTTY0a216U1NvT01zWDNDMWtWemZEd2NqNjFHRnlVcEVVSXZnR0s3U3ND?=
 =?utf-8?B?OTM3UUVSMEhSWXlta21nUFRVdkZrUXcxZ2d5ZWh4eHpFeE5WK3ZNT0JJc1FV?=
 =?utf-8?B?dnU5aEtrRmdlZTJCVms0SXR4dTRZVGJ3QjFhbUdiV1ZVcWU0dEthQjhlTzEy?=
 =?utf-8?B?L2ZRQ1V4UW5ONWliOEVtY2Zkek9GU09KUFNZcGdaL0hVUEdFNHRTK1hLYjVv?=
 =?utf-8?B?eDFob2ZKb3JOZEFpazRtcWIrVmRlNkdTWkdPeXNwMUFWY2NzNXAza2VRVVV0?=
 =?utf-8?B?d2IwbU4zMzhIdnNmRkFyUWNrRFQ2Z2RFejNIUHpwV3Mwb2hBSzczQXF5UFEw?=
 =?utf-8?B?blRRMXBGcHhDYVdrQnZYWEVjZmhoRExZUmk3RWZ2U2l4eUI0SW1TZzV5KzVm?=
 =?utf-8?B?MUt6b2pMNHdXVG41Y050V0ZSa3B0WUFubjlhZjQySDMvczVPcHoyYVdZYW1o?=
 =?utf-8?B?S3hrMm9zMXpKWHhtY1FOT0NNR3lUZ2FiTGd4dVpGV3FlVnorT2dpTng3Rkls?=
 =?utf-8?B?SU03UlZRdUVvV0dIbm5HbjE5eXU5QzBDakZUekFucUNySmxabmRXOXVzOVN3?=
 =?utf-8?B?KzFHL3NRblhzbUNnSGNDZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9086.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHcvc1hWeThDVWhPSkUxZUtOWDNPYzBWUFA1bnBlcWoxUFBtem96ZWdYMEZs?=
 =?utf-8?B?eXRWcWdGZER1Q0VmZHlCd2UzQmpmS1RFQXhLVGNkNFg2ZERhYVk5SEE1VHd2?=
 =?utf-8?B?SDNGTG1nNElOb3JaUSt0ZWd2OWNObWovYlBCME00eW5FL2ZwYmMxOGdTNGRn?=
 =?utf-8?B?Q2FLMWZRa25xenZYSDR6bGpSR05MZHJFUUFTQWkvcXNkZGdsSDAzcGhEWnp2?=
 =?utf-8?B?YlNJUHVHSkZZMlhqcUNsRlR1VFB3NStUQmhBWU5HMGRHbnd5UWpkUnVtSGRm?=
 =?utf-8?B?ZGdPWlNBeEtoTDRmQWpVdWQ1U1pxUDd2SzEvSWdLVnNPZ29hWTh6SEoxUjdq?=
 =?utf-8?B?WDg3NVZUbFE5N1ZuK3orTHZwM2pNb2sxMDlreUFDdU4rZHBaYmNFSlpyOUR6?=
 =?utf-8?B?NUtmUTNoYmIzb2lGNTArUSs5M3M0VlcvcUJUU0xqTldQUVQ1Z0l1QWI1Wk45?=
 =?utf-8?B?MTBER1VIUjIvSVJaNm5qd3lnNW52cVRrU2lJZm4zQmRTazZaWVJBWlpvWHFF?=
 =?utf-8?B?U2tNTGs1aDU4bm1NRW5RMVY2MVFhbUxDekh5a3lod2JiN2R6L1RJQkJDcjFk?=
 =?utf-8?B?ai94di9uV2lQeDBLcEFBZnNrT0JDMncxcERhSU5lN2ExNldiSzRyWDNCWVJa?=
 =?utf-8?B?L0RlT1Ivck5KVm5NRXlmRFJhR1dOZ05LMThoZHZBNmd5Ui9lcnZCM1Q4aE9R?=
 =?utf-8?B?SGRIVUJLeGsvb2tTT3A5NUZ4SU95THhLZlFhdlRtWnAzSHV3cWVXSE9uNGRx?=
 =?utf-8?B?SzkrR1Q1aFBUdUxKbWhYbUFKeStyM0wwbFI1RTJhbktacUtvQU9TSVEzZkNo?=
 =?utf-8?B?MXdOYUJiWUpRWWNGUEVwUXBrTUJ1cFkrbnViWE5hREdLOVlpVWF2ZWw0UGNJ?=
 =?utf-8?B?a3h6V1kxNGtBOHdnbTNHZmpqb1hFTUc1YjJkZ0FRazVvd3VEZmpvWEZ5OE5S?=
 =?utf-8?B?d1ZWR1NSMFY1WS9zZ0diTlNKRVBxdE16V0NUVVdOWXp5bFRsamZDWmh4UFli?=
 =?utf-8?B?WUpyL1E3Y1l2cGo0S1RWbm5Hc0s1aUdHaXdqbGxKbStPRWNORFkzbkhPNDdN?=
 =?utf-8?B?VlhTYTNWa3hFeENVckZkdVRrRUZxazhuMklURW9FVkhNb2NsYzNUWHAvV05E?=
 =?utf-8?B?cGxQeDZKTTF1bVo1aHZoVExNWjNYd21ieXVIVGlsVWFSNlNiSEZiZkNiMFVv?=
 =?utf-8?B?dEc3R255YjgvcFhsZnErSkpKWGlQU2lST2ZIUk41VUpMMmRreHdJUS9LRkU0?=
 =?utf-8?B?cWNxSUZQbnFYZjN6bllDa2dEc2ZEZzlOL3J2b2lnTGFKQ1g4S05STnJjZUhZ?=
 =?utf-8?B?eVNLVkJHVFBndXRkRkJQLzdacktaSjlzRURyNnFjSjk3dnIyUkNOTnE2eUFC?=
 =?utf-8?B?ZEgyVmRYd2wwdEMzZDl0c0loYjZTaVhvN0JzTWJETVU5b3ZYVXY1UE1DUUd0?=
 =?utf-8?B?VUdBVm5Ka05Db3hhYlAyaURvRlVlaUMySlpoNExhWUlVUjZ2dURTUVpZWnJJ?=
 =?utf-8?B?TFpRb29xelFrY0NpZEx3cjZFc2JyZkR0MEJYZ3RPZTFVV0VjZm8xSHFDUTJU?=
 =?utf-8?B?c1NNbU1zRTQ0TnJhei8reDArZEZ5R2srL1NHbktZL3o5R3NpR2tBVWRnQmpv?=
 =?utf-8?B?bVd2bkc2anVINmFXSkhyaWJxU1gwVUZrdlJmak9UTjd2MUVuenNUYWhlRWw0?=
 =?utf-8?B?WUtyeFlyclB3dmpTbFFySG93Y2tGeWFGUDNORXBMR3puSktyQ3pydExhRVZQ?=
 =?utf-8?B?ZEk4a2d4REdlSkQ0VVk1ZmRSUzU4TkJnSkd4dTdPMVhsTkllWi8ybGNKWFlB?=
 =?utf-8?B?bjZYdndjb2FRM2tOWUREQk4vK3ZjOTRLbVpGZVV1SXZvRnJZRHFzK2NTRWt4?=
 =?utf-8?B?MVZEZWhZSi9IeTNDK0FCdXFpR3ROUkd1dDZsK084SmFRd2VGYmQzdkRVWXFJ?=
 =?utf-8?B?SGtjbHlSSnk0OE9zUVJvWGtvTUdGR1kyT2FlUFpSRnBtaGllYWNvSFZlR0w2?=
 =?utf-8?B?L0VlWndqL0F2WWVFZkRJYWh0a0ptdkppRVVGaC9hbHhXUXg3dGIvWGdLbVk0?=
 =?utf-8?B?MUM5NWdLV1J3Q25PVWd5c1ArQVpZbVpXNGlkS0dBMlVGWWJ0T3FXRVlCTzM4?=
 =?utf-8?B?YWg3TjlUWDZYOEJsSXl4TU1HeEQxU21GVUwxS0hPdEZ2cGRBWTZHZk9yVFpU?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5859fa5e-3194-4b58-24ce-08dccdec26cb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9086.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 20:48:52.8972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rc5VCF57UEsHRVVYaCkScZ8BskSOSYJH1mSmaN8RL5RZl1GB/arsNaHvVqvMXXTYp38UHfYp6o7FhePGOzwxQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5891


On 04/09/2024 19:18, Jason Gunthorpe wrote:
> On Wed, Sep 04, 2024 at 06:30:31PM +0300, Michael Guralnik wrote:
>> +#define mlx5_umem_find_best_pgsz(umem, dev, iova)                              \
>> +	ib_umem_find_best_pgsz(                                                \
>> +		umem,                                                          \
>> +		__mlx5_log_page_size_to_bitmap(                                \
>> +			MLX5_CAP_GEN_2(dev->mdev, umr_log_entity_size_5) ? 6 : \
>> +									   5,  \
>> +			0),                                                    \
>> +		iova)
> This can go in a real static inline function now.
Ack.
> Isn't is mlx5_mkx_find_best_pgsz ? It is only for mkc right?

Yes. It was written to be generic but mkc users were the only ones 
calling it.

>> @@ -4221,8 +4223,7 @@ struct mlx5_ifc_mkc_bits {
>>   
>>   	u8         reserved_at_1c0[0x19];
>>   	u8         relaxed_ordering_read[0x1];
>> -	u8         reserved_at_1d9[0x1];
>> -	u8         log_page_size[0x5];
>> +	u8         log_page_size[0x6];
> ?
>
> Why is this change OK without more changes? Doesn't it move
> log_page_size forward by 1 bit?
>
> Jason

The reserved_at_1d9 is the new MSB of log_page_size that was not exposed 
in ifc so far.

Not moving forward, just extending by one MSB bit.


