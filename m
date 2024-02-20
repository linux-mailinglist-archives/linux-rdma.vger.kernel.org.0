Return-Path: <linux-rdma+bounces-1049-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 027EA85B349
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27DA71C210FE
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 06:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9515A119;
	Tue, 20 Feb 2024 06:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bubLqgMq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369535A0F3;
	Tue, 20 Feb 2024 06:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412288; cv=fail; b=dwvL2TyqIL9HgaKoL+Nygtnel2PMVc2kJw+FCSlet17OsaOKTHTrW3kfP6/T1bySpEkc5/4B4J5T/oEXGteNNWYoaVPLcr0UELQwnTbPxzm9MdKjAHZfNDt7SWpQ/MxjTqn5V0DIekMSeEXC8/7q6+eSXuGzkik+U97ftLJyHEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412288; c=relaxed/simple;
	bh=kvGN8nhtGZoTVTwcyir86xRcMghgRdBi0xGMnOTxRWE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ak31283BkoF0LcWGcyDzFuzvimY1RkWylCGlq2PGqnowcVh334RLxtYq9R/jEmEms98tKJ2dFIfM4iva0pZ7g6DuBfNT2Zm1X3eDOISfhHgAADkMtqevxy5LvsnjKTKUZxG+XtBzuXL1ECNYZUIBkerqiyJI7P0lTxuTqwT5+18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bubLqgMq; arc=fail smtp.client-ip=40.107.95.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArqJVCCktDG7X8H/WM7OaxvdBv6EEJXHaoERFA9+5iK/VOYLxdKAYJLm4EU2r5KVnUoxVIHH3hfxJJ3BqSrvx+zEMOBqxO7WvbLgoLZdIxb2hY5ibZS17TTH6DGalIDg1G9tT+J82AhuJIDyuskm9m9ZjcVraI6MEdLjli3abzDe/AjW1fmr40Lzx0JcpRXh1ejswOzQXoM3ztcbSpWu7RGtyNX04OHDo+Z3VXZ9z5l6Gmch4KXMCtnfb11Vp/70EDEkDqhIy/EvWMK474aDHo/Y/DpuQOAeoEBTW3Ab1Zz7UGVOONh7cpw8jipiYEckSWHnj+XkjvIJUCZkqvvcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCppe5nKRMKWIkG9s7NiGAy7fBjMltr7ENb5oY/iZy4=;
 b=WYcBl53yve0caamOYErJMaROutBWv1i4hO9umPcC3An7en3puaary3msNZCYy9XiPsrrFWHxkahQQJiQM6ZCTpXo9YAW0ldU0gQB+4b7L+3m3p+gw2Uxq9OQj8QBiLDmk+uWidBB19OiYp86TRPG4k8GN48rfw+BcqWiW5ArESUUtw58yQZHYTnI4hMr8HyeNuL8/dF3FX8WrRRgh8nVnUjL5aCeierD2AvBURhDiRRCpziAFlWfgUrxjfuhbUrurrmFKXxbgJL9mJhInpmgqwj2nMcwvMvIXEFM6Uf1UbJmOGUY0/CTqlsPhOsYGyxIOgX6b1AA2WX63FNmSN16xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCppe5nKRMKWIkG9s7NiGAy7fBjMltr7ENb5oY/iZy4=;
 b=bubLqgMqMcpfLNciGXCb5zv4g7NdomxMLWSpKC5y8YMdNVK29gzQl0c4CPHB/KAMXej663OWTMeOTLUcE3ulBVtnn7gswUwYyYyCsJyPPmh8Wuu4TcYZBHkR7VwukDuWUS2iEGy+EcpF8VkI5AYJlm7zJ/odOl89mWHDhpZ6q7HXd7HF65oJAkECI8Fdoj6tUoO+i1iUtvGKvqXLh5UHgMNX8/aaYSr4ro90SFgR75Y9XXL3vH72YNJq9hOCOSmdO0PcwqgOezhYxbHiG0v4wpHcynnVou+XUCZ2tW5jWmBeQ+7Ze47vmVJgACtI4mxCjKiFT/r5/EGFw4LHhxHHZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7)
 by CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 06:58:04 +0000
Received: from IA0PR12MB8086.namprd12.prod.outlook.com
 ([fe80::9987:3f37:9a25:b0e7]) by IA0PR12MB8086.namprd12.prod.outlook.com
 ([fe80::9987:3f37:9a25:b0e7%2]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 06:58:04 +0000
Message-ID: <2abe3279-ccba-4e1d-a04c-fd724e1660b6@nvidia.com>
Date: Tue, 20 Feb 2024 08:57:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net/mlx5: pre-initialize sprintf buffers
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Arnd Bergmann <arnd@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alex Vesker <valex@nvidia.com>,
 Erez Shitrit <erezsh@nvidia.com>, Hamdan Igbaria <hamdani@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240219100506.648089-1-arnd@kernel.org>
 <bbef7014-5059-405d-a27a-a379431a3fcf@linux.dev>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <bbef7014-5059-405d-a27a-a379431a3fcf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To IA0PR12MB8086.namprd12.prod.outlook.com
 (2603:10b6:208:403::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8086:EE_|CYYPR12MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6e7b3b-00c0-47a9-5918-08dc31e1491c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3O0T/U0oaSWdqV1ULVzWzSj0RogC+w2Y2r/PQ37zIuU70+vhw1XIxQ2AKvH0fzTx8M/FyUMwIIdiQw6EBx8/uumltLH2F6XF/vxt9EpchQaIABaIniWem5uK0NkUQT0H3VVW91/yOVduu5NSZkWkMYoCyT2GEmPaZx7eSkPzJPcfc3JJZzNoYAy6CTMMteMFqeRSOoVT0DN1djilcNUBqqYOoxbVUHwXcHenN2g5uHVppZ0H1Anpb9HPSLdoYbVQI5iWdMJ8fE396ziE+sqq1+lKh1e9JQR2YJJj1QbqbC2BESVeypMvJJhjRYplMVoFy9JwtCr7pk6BvLz+4DHzAVdDj6olDm04DtEGXvQpmt0jtSeek4iKU6U1DNtpDXVhcqXtbVdL3wu3HXS9qYNmHrN6nwP2f+UOEEGlYLlZaRExGNtsYjOp4MtqP2Eb5zqeWyueobrDwP3fOlQt5khWK5x9Oz9d6OwtBRSLhSepufBKMpXut2Z3CYafAQiBDm6zvAPs7vm7Tg3f6vthHJUfIyD6SYH7d+6voRH/oWlzVBrv8kpB+N/+/CkKOf2v7vyb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8086.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk5vb3dIaHZMNFhxMUM2ZHJxVVhWVERkMmRIWjB3TWwwdHNibGF3eU42Mk5O?=
 =?utf-8?B?bGwzT3ArSTlZS24yWGdJNUZHT1dZWGQyRTU2UzNMdU14NlgxWk9ZbFBqM2M3?=
 =?utf-8?B?Q2M5SGlpQmozdm55TFZvMmZ1ejV4WC9WaDgrRGhySGFJdkc0RXlDcjFHRnNy?=
 =?utf-8?B?MWYvY0dkSk1VdFlZNDQ4dVNzeHE2S3FhK0Y0ZTN0R04vSjdpTy9sNjYycktN?=
 =?utf-8?B?dHd1Y1VjWjRtcTZhdk1ya1lybEd1NG1jZmRtN01kbCt3c3YwZzZaSkhURi9v?=
 =?utf-8?B?Zjh1cXVtZlI1b0MySkErVExUcWpLY0FUcm16cjlOdlQ2cDFpZlg3SE1mcjRm?=
 =?utf-8?B?WlRGaHV6R1A5SU12N0pEUjlZOFYrYWtqc0ZsZjJPd25wYnpqR2RuVlpnYzc5?=
 =?utf-8?B?Nm9hM2N3VUhaQXVndHM5NmRDcUc2emM0VkxCYUJNeXN2MUgyRDBpc0xhZkJs?=
 =?utf-8?B?NVVXdnphWGJaN3NxaU5uRmZHV2xsK0lJWmtBNXB6U2JnR1U3TytqNVNNNE55?=
 =?utf-8?B?ZTlEa1Q3MjRDVlByODE5aXAyOXdzOFBBUzVoRXU1TWdjVklneXdoWHB1ZXFJ?=
 =?utf-8?B?ajJWVGEyb3lUb3JxQkhmdktkRnZndEFpNFVOQ1VDaGJ5ZlBYVktLUnpVclY4?=
 =?utf-8?B?YWtNU2x3SzZKWUczay9pQXM3OXBFOVJWaGpXaE9KMjBGOWpwbGp1SXFhSjl3?=
 =?utf-8?B?emhuSFYyNHQwb09jeDE1VytJU0U0RjBhaWd0OWZsV1c5MDJUU2xlS2MzQXM3?=
 =?utf-8?B?K2VndXpSWWM5TDFYQndtNGh3WlFXSE5JeWszYUNTaHU5UFV2UmwxdnNuTDh6?=
 =?utf-8?B?S2JxMUdmMHVObDRham54NGg4UzBrZXNJNGtnTXc1czBkZzE1VlNrK3dBQ0Fs?=
 =?utf-8?B?eHRmQXhDZGFmMUpQTnQ4ZXFyUWxlT0NoZzJVMjVxbnVKRktFUTcwQ0lBQWN1?=
 =?utf-8?B?ODRkNVovVjdxbnV4N2t6OHdTN0hldHFnUlFzWHBlTEUrUWdpLzZhQVBTTVh4?=
 =?utf-8?B?Q2QxRVZUcnN1MWptaVdGc1E2YkgwSTJCRWVETjlqSEdtb0pPTElSZzdxWjRa?=
 =?utf-8?B?UEFtbXMyM2VDN25vU2ViZ3NDVzE1SFBKaDBrWjFhbmhrWWt2TkJhUmVvNG9D?=
 =?utf-8?B?WkVaZHZCTHIvOE9MSFVCWkRtaXU2VzhhNkdtRzR4N3VYTjQ5SjNrdXRORi9I?=
 =?utf-8?B?OFRRN3NNckFyT3Z5dWdTdXNuc2FLcXd6cjFwZHlBN0ZtZTdCcXZRY0RFZUhS?=
 =?utf-8?B?T29YN1N0S1FBUkF0R0lRRFNIV090NFRnZ2pjOURydDUxakVMMDBQUGNLVk9R?=
 =?utf-8?B?dUxheTN6Wlo1T3JLcU53UVZCT2hpY1pnNjBnNGQyNHFGc2ZySjB2bWNwZDdZ?=
 =?utf-8?B?VzJVQ0FZeU9ZbHR1RWpROVpVRitnTDJoOStVS0lQWXhwQ0NNMUlJdld5Ti9Y?=
 =?utf-8?B?UHE4VmEvcUtESXM4ZjdkWEJVZXBIM3E4VVkrZENOZlJ1bFM5VzZ4ZHBNbU81?=
 =?utf-8?B?TGFTQ0c1U2lRRWNPUkhQWHM4VHRMcmh0MHM4TXRVS3JFVUNOQTNZUGRmTXlT?=
 =?utf-8?B?SjRiZ2gzWDVCYmZGdFdzaHljREtVWFVWYXpvUWh6aEo0UGpFRnkxbEpEMytQ?=
 =?utf-8?B?TnRaTHRlZGRWQitEWnZrTm8rUk42U205ZEo3SWhHeDB3UGxBS0pwdC9NMHdx?=
 =?utf-8?B?YkRNN0h2MGJZclJNTWVYb3YrRlZuWjBzcmpQNmJabmExMGswNE5KNlRkZHlz?=
 =?utf-8?B?SWFQOGtsb3RrOWN3TUtDSS9EMHdsTDhyQ0FIcy9KQ3AwbVlBQWFJZkZJQ0k3?=
 =?utf-8?B?NHFSVFRvY1FRd3FUNEdFaktpQTc4d2hQNmh6M1VXVEluajlYaGxyVUpzVHY1?=
 =?utf-8?B?T2xhdUwxTnp0UGNzUisvM3lmMWtycG5PdnJyN3MwbkdFaEwzWTNqVG00YzBx?=
 =?utf-8?B?Y2tNZHdwV1pXZW92ZTlNckVWb1lyeWF0aE5iNStlMlFkN1NlZlY0SHNtRmJa?=
 =?utf-8?B?bmxzT1J4RDVIb3NwaG5sVXUrY2FjUTdNcUZDQzhraS9lTGw5bFZMUG5wbnlP?=
 =?utf-8?B?UnlDMU5VU3RmT24wdDRYRDQrL1Zta2ZsZUpYSW93WTdUa3VRNTU4WFV6NnRE?=
 =?utf-8?Q?hnv1Fw4y3H+dZqw0qJmBsq7Hb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6e7b3b-00c0-47a9-5918-08dc31e1491c
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8086.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 06:58:04.5847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDrE0lq38wlAUPLXdotdlbOOD3/NFfFd70VbDz7cIxHelY/2DvKSiYD6DPHHWr0rPrJs/frHtIe0rtSQhRZ2Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871

On 20-Feb-24 07:50, Zhu Yanjun wrote:
> External email: Use caution opening links or attachments
> 
> 
> 在 2024/2/19 18:04, Arnd Bergmann 写道:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The debugfs files always in this driver all use an extra round-trip
>> through an snprintf() before getting put into a mlx5dr_dbg_dump_buff()
>> rather than the normal seq_printf().
>>
>> Zhu Yanjun noticed that the buffers are not initialized before being
>> filled or reused and requested them to always be zeroed as a
>> preparation for having more reused between the buffers.
> 
> I think that you are the first to find this.

The buffers are not initialized intentionally.
The content is overwritten from the buffer's beginning.
Initializing is not needed as it will only cause perf degradation.

-- YK



