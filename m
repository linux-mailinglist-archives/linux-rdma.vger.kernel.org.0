Return-Path: <linux-rdma+bounces-13899-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9D4BE3B8C
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 15:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD2F407EDB
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 13:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3661D5CE8;
	Thu, 16 Oct 2025 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mmL74uYM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013057.outbound.protection.outlook.com [40.93.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC04198A11
	for <linux-rdma@vger.kernel.org>; Thu, 16 Oct 2025 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621534; cv=fail; b=FejsJRWVgSYHfL+fES+5sdk06ohhvZPO0NH+/ARM5fd2ze50gSqn5Xdj1JiUn84fMxaLtq7agixS5AL9ZIP+HFkmeFKqmkypJRAY8jWaf9UGefkSES74KPLmjRrnlgJQ5sYKzywz+mShIKhMKCNF6aCK4NVBU9ztOkm2iqoWYgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621534; c=relaxed/simple;
	bh=ry1BC/eO24ahbt7vkRKTlTnMXfEp71YzRM01VldQykA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f3IE4JJmmnxWBUinXx9g8pay7DttkONS4E6S/9q3aFmR8m+2FjdMG4VKVNd8yfKTzei/84a9tx73rnOB4NaqjM9ym0lUWX2CegjyvQjCI0VP77dDjKI7JR/ydRrBzIwR8a16x+NssZtMPUwz/t0Igy/GcDs8v7VyCLTinHQnl3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mmL74uYM; arc=fail smtp.client-ip=40.93.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UT9CiCu7gnkAAR5eOFSOOsVvzWV00bnuMFBUeWkQakX5jvbQphmUZ87zGQMBY+svgo39NieJvtSdY0zRh0PCURmqNyDQjm0dYLqijpkuMQSAKdtahpNm/kXWVUp0eYz+lNHqELwmqLuRmoChog8jhLpUrL9mOmfzt4kX1C6Rkd1/vH4JOf5w7O5IpJsX1mygfYYi2e9hOQtFGwUSIAtLW7QNchrqIkerdpJbCq94eHWrvr/xZTM8OwJFt7aSZpliusURk1fRdCEWa1r5f94Fb+WLyybC+w6hOY2lHn1Wz3gepdFpZwmKMHcxywE+xzMbgvBcCY/yiXHyUeCS8r7kNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O08hovcxDkwVjkzEcjsLYsXJDSyN2mvLrdcbiVjR4iQ=;
 b=OjTzp/q3PrONg4lwpMUdMJ9jFMlhexFSn7VSsIjD/oNgKE0lq/ZJ3ZWX/vL2tCxL0h2QV7XnEEIodOaNXGvgVYyxe40sNjT4qRvC87BLAXWd+JOgGL9DzXPDkIMrWTtXHp3fmyejTlfYPANtdz79jOds89SwMHNE0MyKwZVq2H2toFrVLKmgg92nWeP+v4Mr+iqa2gYvvCsmWZOYEA/Q53lFpl9KPGCdYgbD3zQ5KmO9ZJqh6+/mOJ06d8NNKY2T9ik40OQtK26G/w71MxsE3qSIljZGOLo0R6Hh9WZ6kJORzrmR0ZoZteCfOkG1caXW/tszzi55xpP+P1InAS/mew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O08hovcxDkwVjkzEcjsLYsXJDSyN2mvLrdcbiVjR4iQ=;
 b=mmL74uYMoZmR5xvrzPQG20s4YnRM+mxRpbNl5MSV+qCoFvE7opIBGtK3CBVSZnxVIqmyRczWYbSmbbqE3uzcghlSI6bSUgO7Z+Hd7nMm+79hvcqXBfK8oi1IHcALARixqmH/sLXoEPlUlbUOhx+dfhdVrZrm9Ga0yVHf6sX1drCpoSROjFiGgeEPkARAHsRi8SBKXyDeLAb/Q8P2re1bHDWCn4PyVXpDQzOdRgL85IMSirrZZLDKunJQWkGpb62pZuzjLey3j6nLKh25xVuvffH5srDi7o/UZUy9zJ2AMnyz8wS0zK1UCnx7RIon/rW7jXVTfq77Q2UIBts1/evmpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) by
 SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 13:32:09 +0000
Received: from DM3PR12MB9414.namprd12.prod.outlook.com
 ([fe80::8664:98c1:f040:c95c]) by DM3PR12MB9414.namprd12.prod.outlook.com
 ([fe80::8664:98c1:f040:c95c%6]) with mapi id 15.20.9182.017; Thu, 16 Oct 2025
 13:32:09 +0000
Message-ID: <4b9216b6-25a7-4684-9301-c8128f794541@nvidia.com>
Date: Thu, 16 Oct 2025 16:32:04 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/mlx5: Use mlx5_cmd_is_down to detect PCIe Surprise
 Link Down
To: Jason Gunthorpe <jgg@nvidia.com>, Jian Wen <wenjianhn@gmail.com>
Cc: leonro@nvidia.com, Jian Wen <wenjian1@xiaomi.com>,
 linux-rdma@vger.kernel.org
References: <20251009142326.3794769-1-wenjian1@xiaomi.com>
 <20251009180244.GC3899236@nvidia.com>
Content-Language: en-US
From: Maher Sanalla <msanalla@nvidia.com>
In-Reply-To: <20251009180244.GC3899236@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9414:EE_|SJ1PR12MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: b37459a4-5ce7-490c-b4ad-08de0cb867cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFlTUkNyenRzNnArekdwQW9UOVZUcVEvWndWV1FidHhQU0VnTVNlMitIQi9K?=
 =?utf-8?B?d3NvZmxTMEluVnhvSjR2Y1ByUTNZOUVXbkI4SkxTVjdrYkdCVm1WSTFnZUxG?=
 =?utf-8?B?MzRnR2pXOW0zSUM2YXAxZHloaitTMlllNzBYekJheFpsb0VORUhWQmlQU2RV?=
 =?utf-8?B?VXFld3VKNDh0SkdDVGI5ekhuVXdTZUluKythcE5RVzhtY3NvYWxINWE0Mjd3?=
 =?utf-8?B?RmFnNUNQYWZ2Ym1pU2VuUjdUUENOUHpDVWpzZGpwZ0Roei90NnBIZko4ME82?=
 =?utf-8?B?VGV4c0FWcHJvRmtXSjA1MmttVXBuTVJ3V2VzM1ZQZ0t5TzFIc0pHS2JueHdr?=
 =?utf-8?B?eGdJcDhrOGo4Ui9yUnh0YUpEZ2RSbHdWN3QwVS9tWUdaODJ5SUw3cTF4T3JR?=
 =?utf-8?B?YkhHUmk2amYwUlZlak5oekNOeDVUeE83VDNwT3pPRVpXdVZHNktLR2hSUTBN?=
 =?utf-8?B?L25kQkZkYUpIREpZV2JsM2xmOGl0RHN2ZXdhRDNiYWR5QjhsUUJnWHllbFhq?=
 =?utf-8?B?VEF1L2xXazdPUm9QR1pqVkFJbGZNekZBTUQ5WGpqWC9DZUN4SWx3TzR3RGxm?=
 =?utf-8?B?YnZGTHpxQjArR2JEaGhSajF5M1JYNFNtK1dXTndSSTJFaWxibmlpSmxGNDZk?=
 =?utf-8?B?TnhtL1prQjdLKzNROGZzaUpHbGZGcXlFTUpGMHlGUHB6YUlwaDRVaUNQZ0hz?=
 =?utf-8?B?RktiaWhpeHZpNEtvN2VIOVE5U0UvUkxaNTRuallaM29OeDEzem1Fa3QxcWpI?=
 =?utf-8?B?dDl4N3UyeDRkYk5odGVENTlDRm1JOHdtL3o4MWhaM1U0YlZBdVN1SDEvY3dH?=
 =?utf-8?B?NjhEVFhFOWp6Mm1KM01ueEc5UElPQURQeFFZUEJ4aVhWY3NocWJPMWIyMDZj?=
 =?utf-8?B?WXdDRkVmditQV3VXdzFXekNtQ3ZoVHdIeVVlYlV5VDRWQUVOTmtJV21OQTBi?=
 =?utf-8?B?Nk1OQmJYVnFkSGtGQjNOcGFvdUczc0pPd3hySFFGTWU2cllFV3k4dStVcU9y?=
 =?utf-8?B?MXZxQjNIdm9QWm93aUs3Z0tRL3RUbllBbDBXMDFPdmVSUmVobFlNbTRyelZ3?=
 =?utf-8?B?SEt3SWFnTUZvREF3dUNnYWtuV0xLK0lvU2RwS0hvVTVuUlJMZmZ4Y3dENWxK?=
 =?utf-8?B?RFJVTVpOT2FaWEVsZVVHQVcwK2VtdU9QNkpYNFdLVmNldHI4cHhqSDhXOGN6?=
 =?utf-8?B?V2kxK0EyNGp6Y3UzTEJjeGwrMU1UY3FZUmw4M0I3S21qaGpxMVNxdUFodHZn?=
 =?utf-8?B?ODI2azZCaG8ydUNrY2U4NzdYU3pwYlhnU3JXcHViUlFNcC9pMm9sUi9hYlEy?=
 =?utf-8?B?emxWU2ZjdjVqZ1VNRU9iMnF0N29neUQya05hdElQNnpkK2tmUU9qbllQTkFa?=
 =?utf-8?B?c3YvLzh0VnZhSjVobEMzVktLNUN0NTVkYXFMeXkrS3hBRC9jT2kwM1QvZzdR?=
 =?utf-8?B?T1lFV0I3dVNTVHl2VzVCOWIycjNoQS91VlMxU2toWndjYTgrS1dhbUdES3BX?=
 =?utf-8?B?UFkySzI1RTBvZy9uWjd3cHU5SDNHaG9vVEFMMHJ3NzR3d0hSdWJTWXZzbGRj?=
 =?utf-8?B?ZXR5bklGYXM2NFRRSHdqcnpqcFFja2dHR0Vwb0V3UnpJSE1UVGZScE5Wa21I?=
 =?utf-8?B?b3ZMbzV2RC9UZy9id1JueHdaY3lUN2VvaklaN0VzWEpsTCs5b1dsMVNzOVJR?=
 =?utf-8?B?dml6d3RmR0N5Q2lqZlFTLzhidXQxMC8zblVZb3ltVmhkY05qOFNlYjY0Yzdt?=
 =?utf-8?B?MzhRei9xUDJja1VtMTdZNFEyeXVJQ1Q0SCthVGd6S0FTQ2hhT1NyOEtpQk8z?=
 =?utf-8?B?cVNxS0FxODAwdk5xYlNEUWdQaGJ6elB2NWE4aTdGZUVLOG1KazlmRUJFc29L?=
 =?utf-8?B?TGRSTXRYWFVLbDFJL1A1MHIwbksyK0taM0E5WlBsUTZlUnRkVE40eElzd1Fi?=
 =?utf-8?Q?9X39u4FblpALACJahJd3W0xXAowhXW2d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9414.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTEvYXM2Q0ZLZEdRVEpkSkhJbTJDNG1GTEpudGVIL0RIZDJGVGNYOXBaK096?=
 =?utf-8?B?VjVIMkhHKzh5a3JZUG9va3JTRFl0MFpxU1pLWW9pYXZidW80NFlBQms2MURY?=
 =?utf-8?B?am9sOXB4MmVwMVhPUnZMMkdDejA3endFdDNnVk43azFZZ3Fnc2pyZGxiN0xU?=
 =?utf-8?B?ZFNBS3Z2eU9NYWQwL3lKMlp0UWEvZUJPakNXUmhXNFJQTmc0WVdDQkxuYUtV?=
 =?utf-8?B?V3dXbE4yOGxabnRockEzdWZzYUY2TjlhdmFQMTVoZ2dza0NNSU1OaXIwTk9L?=
 =?utf-8?B?eVpjMkFLVEtPcXFsekRFNU9hL1ZsSFdQekxiWHFVbnEyTVVBcEtqRFlLcFYy?=
 =?utf-8?B?ODIzcUdQeU5tT1dVV1RjbnlpQ1QvdE9CUnlaVXEwQzFIR1dYbnlMYitsWVdF?=
 =?utf-8?B?TWsrSWxReU13WXNtbXZkemp3anRSWGJZck1pcnhDOG84a0hGTER3OWc5RnNk?=
 =?utf-8?B?YzNoVzhoZGtVN1FWa3BaUGxERW8zUEg3Mjh2cFVoV2k5S0xGSDlRanE3SXZW?=
 =?utf-8?B?aWQrVWxtR2lwZ2N1aStQd2hYbXg0SGZ2KzlBdWhYa2pmaDcvYm5mSFArU2hl?=
 =?utf-8?B?bUJCem9BNE1tUjhyejNZUDhyTk5CeXcxMWlBQ2xhMi91U2JyTFU1QzFuME5L?=
 =?utf-8?B?L3A2NDBKKzlYTy8yNFJYWms3NVV6UkpQZmRHY25TTGdnNHFRKy9WL2MzWVFn?=
 =?utf-8?B?czlxY1BLR2NjbEl6Y1JNcUwyQWZ4R1dSbEhncFFIVnB0N2l4K3VRd1NDNVY2?=
 =?utf-8?B?SlpOWHBzKzREbk1OYm5PMVFXMU5XdnhOT1Bhcy9lMHFiVVdJOUt0bUVTT0E5?=
 =?utf-8?B?ZEpRUVRhRXFIMVhBL1FhOUlsQzQ0ZUFKTkNOTVBxL0t3M0JxbzBGU1NOM0w1?=
 =?utf-8?B?MW1DM0VZOTVKbTdSOUx2WUNkaTBYaFZaVUFPdVRHL0l3TjR6aDVXL1JDeFB3?=
 =?utf-8?B?bEdsMWZiNEJIUUFIbjMzdzkrV2pIemFxTDNpZytodERQZk16YjNreVFjN3pI?=
 =?utf-8?B?WWdCTXJyeStFeFNqWCs3bXh2T1JuVy9OUDZSWWZDTXIrSjF5enkrZ1FYSUpZ?=
 =?utf-8?B?Y0V4VlNDdXJCb3JBMTUydmhlQll4UlRUM3FSWjlYem9MNGxud01VUENkTkdu?=
 =?utf-8?B?YWtNQ3ZmbzZxVE5VUVRYclBqZHhJc1dlZjRSalRyNDdpT3lYQU1IVGw5S1N4?=
 =?utf-8?B?RGYzMFAwWXozYjRKNFpBSUo0elhjWWprcGhxVWxkUTQ2eGZ3SnE2WEk4SkRq?=
 =?utf-8?B?NTlzVkdlOW9rR0JDRjRWQjZnbzRnaW9TSXR1a3VNSWtGbGZhSnZjSnNmVXc4?=
 =?utf-8?B?ZVBxVXZxN2ZKMnQ2RFdRLzVCbHU4SVovaEZYckozTElYVGIyajc5UW1LYXUw?=
 =?utf-8?B?YklFeXF5ckdxL3ZoK1FMb2I1ZDUweWduUzQvelNtTWxwazF5bW1wTDRQM21H?=
 =?utf-8?B?enI2NC94UTBvVFlIQ3JmL25IeU9pYmdvQXVPbWhTc0tBWTVCc1FJRm9ONVds?=
 =?utf-8?B?TGEzb0hVdnhacVVBancrSWhmY3d1cmk0L0NYdEFYa3dhNURzSnA4bGVpMC9r?=
 =?utf-8?B?NzNDRnNrbk9jUjdibC9LQ0xTUDJtdWhlQ2lhekFIcFlmZFJjM29mejFrbGVX?=
 =?utf-8?B?U2xCMkFxZTV5cGozN3dxcFhrb1VUNDg3NzVKRlNUcnVlWE4xdklkV3JMdWY5?=
 =?utf-8?B?WVZncHRmcXAxalkxVDNKMWJYZVBOTkZZMUtmWEE2SnpkUWpIOHU1by9aeVpn?=
 =?utf-8?B?bHAxTUpFTkxQSzl5VFpmaFlIdWdGZysxajBQa1dkejRFMlE0VHFSMk5xeVlI?=
 =?utf-8?B?d3dUUlpDd1hnblQxSFhxOGpBb2hrbk9yRmloa1V2QXRaNWthVkk4V2hBdXd0?=
 =?utf-8?B?UUNZSGVyKzlMR0dGZEpEeDkwb2JhLytFNGxBMXEvb2hQMWhzL290U2t5Vjdw?=
 =?utf-8?B?VlJnMjYrd0hCSm9TakUxRWN6MGNuZmtyeEFaK1pLOHVTL2VnYndUM2RKVER0?=
 =?utf-8?B?ZklSQWdQeGc3Sm8wZWRmNGNoYlpBVTVILzBud0dLbEl4Nk05cXh6Sy9VOVhK?=
 =?utf-8?B?M2ZTRGxWM2dDODhEamZLRGdSbUp2UTNvZ1BtVHk5KzlTcHJybkpQV3duSE1l?=
 =?utf-8?Q?hfoAvFkASGE6tiK6mvvFQEOum?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37459a4-5ce7-490c-b4ad-08de0cb867cc
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 13:32:09.0763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5cDk1bgHOfmRhRe2HpVQt+Yoo74oRA04DxEFxTIcPie/j3C4JZQM7MInGksmRFkWWR+wKJZW19bQVGuDQe7jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6074



On 09/10/2025 21:02, Jason Gunthorpe wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Oct 09, 2025 at 10:23:20PM +0800, Jian Wen wrote:
>> --- a/drivers/infiniband/hw/mlx5/umr.c
>> +++ b/drivers/infiniband/hw/mlx5/umr.c
>> @@ -254,7 +254,7 @@ static int mlx5r_umr_post_send(struct ib_qp *ibqp, u32 mkey, struct ib_cqe *cqe,
>>        unsigned int idx;
>>        int size, err;
>>
>> -     if (unlikely(mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR))
>> +     if (unlikely(mlx5_cmd_is_down(mdev)))
>>                return -EIO;
> 
> I feel like this is just changing the race around..
> 
> The removal flow for the device is different if the HW is working than
> if it isn't.
> 
> If it isn't working then the removal should disable and cancel all the
> UMRs, using the umrc->lock. Otherwise there will be dead threads
> floating around. It should also be setting
> MLX5_DEVICE_STATE_INTERNAL_ERROR way at the start of removal.
> 
> So IDK, maybe check mlx5_cmd_is_down() and trigger the flow to
> activate INTERNAL_ERROR befor doing anything else?
> 
> Jason
> 

I agree with Jason concern. While this may serve as a workaround for 
certain cases, the race condition still exists. We’re aware of this 
issue and are working on a proper fix. The intended solution is that 
when the device enters an error state, the UMR state should transition 
directly to error as well, preventing any new UMRs from being posted.

Maher

