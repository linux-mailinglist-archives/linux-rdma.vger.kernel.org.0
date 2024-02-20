Return-Path: <linux-rdma+bounces-1074-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDD185B4E9
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 09:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 970A3B21FE7
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE295CDEE;
	Tue, 20 Feb 2024 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VxI8K2E0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6035C912;
	Tue, 20 Feb 2024 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417307; cv=fail; b=WFXLH9BH/9TndIk4aVbvpQ2aVDMKSUE52HbnX6gYrAJljbr1TPX7pRU8gG8XM/sZPCRPmAaEf85NZcoExbDWwSNPaetl8N5bne9ky2j2aRCnDLOKtQIv/WhIN8uvtcqI50fMWPWJDWVB48OD/QdmX2Ago1OtomkkjQr3vhVXyKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417307; c=relaxed/simple;
	bh=vMN4BDenooxF4F9jTIU5k0jR/3Bxi8eybTqWsF0fNHg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DJ2uUv5j2xyfTwgPfjpWH8zTD0SlqrwN3HpDZJhGbuhV3vLmp1HY2ptR+VgbAWnrIMZiqI1IE8sl1HK6L71ESHKaslV7ZpE4/ZqaNhKZNGU49Uh/vOLkSyblotINdOgFRqjq2BF1LfMprdaKfb21H8e1oG5gInFYWjkzhn8ZXEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VxI8K2E0; arc=fail smtp.client-ip=40.107.95.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYSoImGktxinhyMmQc0Y/1UGdnbAEM1CyzkYYj9NRvXmdnBtQuz5Q4/auT9dqEV8QHvnCVNvIzs08Nr4d5nPNmVo9WLFWq8QWS8WThUz6fBTWLRHyzg7nIiLxTHDowdys7QXsBgJVWm6VggFn3B42N3SPGn5DY1no5GeFSZtyy+6bZfMIRtnuI1i9kUBzPJqY2MQ0/FVKLdfIM5yuEMs4xet07SG6ABS6IjeKgQlDy7vJyCMYjpjBnL9VXlwgPpVFeN2yVg9yJx/2z4miHHTdtMcit3GqB6wU11485qyeWlvYpz323BJSVhKnz6O2XJYD9Fb/l/nbfh/lJ1eaHIIUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJyVz2MVEaZcX1HnFZWy8YVOvUv2Bsi/G/yQUcrtozQ=;
 b=TgrhnQ15d7AjMekqhyq01rkacW1Doh0QJ/gecr0lLLQR9w6G+MKv1aXwP0lj4jBxEUQ/FtD2GMXv9jG8vRKOYtPCzLeLVWv9bN3WDk/dInHGx/4FoDjSE1KHvI6/PihDTaqsOe4Nm/V+q5FiDvQcLBqRDwuxJAXDFGOxAOfAm2DGI4Ycem3vs4kg0pwzOz+b3LfQYR2AWy/z462ifxGr7K5mkYLvuLGDb0sovzR+noro4AkYk6tSiT3BF+VQBBH9tfg8wjg9qoqrMLys3ePLo8kmJaGq+4SMwx392A5FE4Hq59aE+DQ4jE3NW9CEWGw318p+MZFfOY6OtgPthSczVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJyVz2MVEaZcX1HnFZWy8YVOvUv2Bsi/G/yQUcrtozQ=;
 b=VxI8K2E08LXa63GUmuhyNYq/QMXUJtWQCx6zaTvxZRwmr1ko+I1+RfU1wwx+thn8Rf1zHfJRxtAUBKJcZChEvSuGYU6GyHCOh+j4nzLXBWEK10pL6BNBoS4Jw0xpd7gjv3PsFgN9POIxDdqOYBf9uDrxvxma1/2xP8z7DPTTXKAlsvWf4QROZ3GT24w7SJhuC+fFuFxDSg3ELckpONN30gtYRNveKyBVukM6tYUz3sYL3XK/JdIdrvnmdCSm/xvQKq/TNQz/PlOm2lWvDHxjIp/0AX2gMN67hVQVkAZPq+4euVCJAkJJAh9z0EfOfMU3y983+DPqUIMR6U5Besv2Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 08:21:42 +0000
Received: from IA0PR12MB8086.namprd12.prod.outlook.com
 ([fe80::9987:3f37:9a25:b0e7]) by IA0PR12MB8086.namprd12.prod.outlook.com
 ([fe80::9987:3f37:9a25:b0e7%2]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 08:21:42 +0000
Message-ID: <461d3ede-5d34-449e-8115-1c4558ae31a2@nvidia.com>
Date: Tue, 20 Feb 2024 10:21:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] [v2] net/mlx5: fix possible stack overflows
To: Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>,
 Arnd Bergmann <arnd@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Zhu Yanjun <yanjun.zhu@linux.dev>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alex Vesker <valex@nvidia.com>,
 Hamdan Igbaria <hamdani@nvidia.com>, Netdev <netdev@vger.kernel.org>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240219100506.648089-1-arnd@kernel.org>
 <20240219100506.648089-2-arnd@kernel.org> <20240220080624.GQ40273@kernel.org>
 <726459a9-c549-4fec-9a4d-61ae1da04f0a@app.fastmail.com>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <726459a9-c549-4fec-9a4d-61ae1da04f0a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0080.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::13) To IA0PR12MB8086.namprd12.prod.outlook.com
 (2603:10b6:208:403::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8086:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e3c035-ca24-40c3-6e1d-08dc31ecf812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v6klzMVMvoXLEQC1wVVU1ua7fT2PhYfTyOIBK6lMYraq9MfJxbcBZl8EGp3HzFzzk14lQmXk+4NlDDRQ4V9Hh+J8yT7S4mucy9HylKiusFGpn0cVRvroAh4ZakYqVoQuuJeLLf98LnlyT7VAjwE+6CQA1PwAWqUvUFNihH1yrDGfy/ILqUezVT3RJjCrI2YXIYCDRGAybllgvxsf7/II9l4+3Mvjn/C0jt/ljDucuyj6SUGJ3U5N6NFSs162znIDl2rUXg57YSmG6FqqDdsKWphW14L42o6iOMrltjVopjeIn7ED/ms9LtEdUlA7Zlu6urtXXlXEFF6ngAIWdqoJGtbhfgBDqhR+IcIb5KZZA7GxNZ9dDBwDiTzssXhtivor8JL4SmFiXzffzl9WSmjP2wuuZxe1Xlx4p5bgsLigE49+vzceYQtXNmXgEBwM5lkLttZ0/RWL/E87tcVoKYU+EsJKrtUe9B3f4jRp0gOAbfFZVXdH4s8i6YQti6snm4J8t/zJ6fF0HRoKvX3sb4oCRxEtsl+Bkm9f29Xrm/EpZLcrsdsLRT7bnUk0nvksPFrQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8086.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWFGaXNUUDVwVjNHbW5SYzFnSm5FOGxCb2lqOG5pVk5aaUJURlJtYU03RVZE?=
 =?utf-8?B?bkJzS3RoSFhPMkRleHZmanNBSGVjNEpZRUpoNzYvUFhTUlVCRG8vNlh4Smd1?=
 =?utf-8?B?QkhhTE5JOWJnSWRSUzBMWFREUE02bUlFdVZucDE1c0FaVGRzMFVuKzJWVmlM?=
 =?utf-8?B?TU4rdE1FdzI2T1IyR2V2Y0laMEsyak9PcHdBMllLM3FwQm4yczJ3OS9Oek9V?=
 =?utf-8?B?WDlXV0VsR09GZFA0NTY5R1A3cDhhcHQwTFZackMzTmFMUGtwNENYZ3o0V0hL?=
 =?utf-8?B?UHdIZXRzdC9ERTU2OHlNVVlBNVJIZmdlaEhTUHFSdk5nZHNNSmtXdmEzeEpn?=
 =?utf-8?B?NFZ6Umc4Z1hwMThTblorcCtKeEh4ZW5oakFiSUI2T2Q2eGpHUVFCL3VPaWdn?=
 =?utf-8?B?RmlEcWJxMldTbDB4ZlF5cXg5OWMwMVhoQzg5RzR3RGlPWG1jYnVyNW1xTTk2?=
 =?utf-8?B?ZzB0WUUxcTcrOWRDY0FuVkY4eWk5bnVwNFJHdWpBQ2lDcldZTE5pWUFtUXRz?=
 =?utf-8?B?TXRidVZBT2lqYm85eklRbU8xN1ZMOVBXQWEwcE9uN2I4TEU4c2ExdVExWS9n?=
 =?utf-8?B?Q0kvYzFlajVDNG0yZTByUEpmVi9FMC9vbzN5R0V0YWlyZElCQnNRZlZ0WCt6?=
 =?utf-8?B?c3FVY2dMMnZpZGZzUGJGT1JydjNSZ2sxdEpqdUh4ZmZuNVVycFgrb0hzSlp5?=
 =?utf-8?B?czRaTzl0ZndtSWJMTDVLbGVkTm1MQTFHYUtTeUtaQkNyQnVLa3NQb1p0MnZt?=
 =?utf-8?B?MTRJTnU5VFI3UlJxRFNGSUNlaHlyVHRuK0h5alFScy83c2ZXUmh1dEpvOWRm?=
 =?utf-8?B?QlNOdXJnVUxVWEQ2MVNCMEtPRDhoMVdzdEJQMmJSRlJjK1JkOEZjcXBoekRW?=
 =?utf-8?B?Q2NaeTFyeENneWZDcVlzeXJHWTBvT3dDZXdldmJmUHptQUNQVDNsQUxOUVMw?=
 =?utf-8?B?RmxSenpoY0VTSlRoRUN2a2Z1aWZvOWsyNW5LeHo2amtGcDJQKzI1TC81YTBH?=
 =?utf-8?B?bWZTTkNDMWgySW9xTXkzbWtvL0kxM05GWjkyN1JGWG5Fbld4eEhhQ2dKb0c3?=
 =?utf-8?B?L3JpcldXZUIydGp4eFRXaFVxMnV4STRTZVB4QTVJbmZPanNuRVhUWlZ3WWxt?=
 =?utf-8?B?K2JaRDlFRXJZNTg1TzVpKzE1L0kxaDREZ0E5K2F6OVNQQjdiNVpwa2pRV0FS?=
 =?utf-8?B?dkRXMzNyWThneUtYRktacTMyRlhvSVVnQjdvNVVTc3ExbGR2TnpYQTYwZ1Vw?=
 =?utf-8?B?a3hCcVVFTnBTTVdnQnpVS1hReGk5YkZxRGVaWGthb3lDcTdYSU9JSEtIVkM2?=
 =?utf-8?B?TUVUN05iSWRDWEZvZXloZzJnVDUvc1ZaN1ZBTmIxeXhBbEdlR3ZDTTZ4NXpZ?=
 =?utf-8?B?QlVFcGpWZDFIUk9RUk5WZGs3NW1VZFhJa2ZPWWtFNjQ2Q21QOGMrZnpubFJt?=
 =?utf-8?B?RGVBYmJ3enM1UUdPWjBIck9Xak00QUd1bS9ycU9WMWJkT3ljUGpaRHAwREo4?=
 =?utf-8?B?YkY2cTRqTTFFcjViaGcvMzh0cjJod3R0alpsK3N3OXhWWjJFdWVtSjhkNXZ0?=
 =?utf-8?B?aGtqQ0lUcWdJaWFhZC9QRFVpcFV0SnZBbmFnaUpYaG1VL2oxcVBnSnRrYnRp?=
 =?utf-8?B?Y3RlZjlqVytXblAzMTJ0T2E3a0liQmJRNGQyTXhhbnhRVjdwZDNFYVNZUExM?=
 =?utf-8?B?emdhcEFsOURKVTluL2ZEeWJtcHdyeVlNckRGc3RzUURZSE9vaFNvNTZFNGxa?=
 =?utf-8?B?V2tJSnBzU3ZnVGFzUlBYYVFUbzJOQXJzNkRzQ0g4SzJFVC9yTGZyN0tmcjNF?=
 =?utf-8?B?WWFnNjVUM1NrcDNyQ3haN0UxbTNLVVF4dWRYTWNCaU54RVREYjdST0xGQm1D?=
 =?utf-8?B?c24zdVU3TlNRdlpwMDlrb21lUFRqQzJ5QlcyLy9HTDJmcTRMNEQrOUYxbDdN?=
 =?utf-8?B?OTVGY1c1dTU3aVBaNzMwQU04UFRITURSYkNLQzk1UlYzV0l0WnEvUFFDbUpO?=
 =?utf-8?B?VVFSZmRWRlJkNHg3M1FaOGs5d1FxTE5VUlJaWDBYMTBOYzhRUEFydUVaK0o3?=
 =?utf-8?B?QjhCQlJyNEt5SCsxdHpHSkE1UTB1d3VseEt2ZlhxMmthdnlWUkJ1VFhmTU9X?=
 =?utf-8?Q?80kwo/26zNkJvpTDNflzvPWbF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e3c035-ca24-40c3-6e1d-08dc31ecf812
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8086.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 08:21:42.5547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +D0hMwyA0sTFJ3TN0qcaoukaAZ/XHBpjT4kqt2sUvi+hx3fZaBs3I0ckA0+p4aaD6lggUPKsixGgLxRBbIvs/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970

On 20-Feb-24 10:11, Arnd Bergmann wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Feb 20, 2024, at 09:06, Simon Horman wrote:
>> On Mon, Feb 19, 2024 at 11:04:56AM +0100, Arnd Bergmann wrote:
> 
>> Hi Arnd,
>>
>> With patch 1/2 in place this code goes on as:
>>
>>        switch (action->action_type) {
>>        case DR_ACTION_TYP_DROP:
>>                memset(buff, 0, sizeof(buff));
>>
>> buff is now a char * rather than an array of char.
>> siceof(buff) doesn't seem right here anymore.
>>
>> Flagged by Coccinelle.
> 
> Rihgt, that would be bad. It sounds like we won't use patch 1/2
> after all though, so I think it's going to be fine after all.
> If the mlx5 maintainers still want both patches, I'll rework
> it to use the fixed size.

No need for the first patch, so only the stack frame limit
fix is needed.

Thanks,

-- YK

>       Arnd


