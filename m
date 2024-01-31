Return-Path: <linux-rdma+bounces-838-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 045728441F6
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 15:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7791F26145
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 14:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8093369D2A;
	Wed, 31 Jan 2024 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jefo5j3b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2E541AAB
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jan 2024 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711733; cv=fail; b=dphyFpAV9UGISlwRewRVh3dnwwsXNTNvxbh7Vx8RNw6bRDRKiyBNY6wiaOH/uvTsF1QCYisHPOfpy8zhOEEhhppsmbog8+cNomaXR5joHhj+ZM+o8vjQDdmMVmJBMczddF2iaSi7GrhMQYkGINShms/dJ5/xgOW3uJ3YBs4yUAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711733; c=relaxed/simple;
	bh=IMqZbq2b5Q9UyNsFfaE1Gb4wpKWfs83HxzDchmiNkq4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e9RurAyMxB76773h6R0BPxgrWXKbWxIY/Veg4qZFfPeJfeVRLyIE3ryrIg/C9V+EOzUbOiTbdGR0aKJJA7RV4jrzJyLcfwvnlYq/U2/erbZv1AnhDlPFJqcULkyM4P/u3ZavSKcH4mmNYxmi1qa4j2KJRsYxEkWkeVY+jhEWeuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jefo5j3b; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/Lz0sBsweBzvIiXoQWgIHhq1i5s1NRBMLPoCqp+LyYHbaU+MPQ8V8ikwPhV0bWxxxpX9GrSzC8/OCNw28M1dh6LAPzdwzF7qIcXzJauI5rMG1KurBmdFOe7cyZ1+eY72ymUAGQQ8OhrKEONlsQ38y93PnfuLlpBOKxCaESNHgSIMRXcYBIp+w38EwVVqJT+hXuhnYRxFAaCA0aubL4T6M83DqVpBqbCIJxMfiGMgPDNgUIaa2MVrtle2KTDooSE7nbH34uFGLtByiqdNio4vH5AILgkJPfC7fpEgE6n5+cznclEW/7hK+hGBInrs9QrZAIgYv96gNZYmc8LUXyDUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMqZbq2b5Q9UyNsFfaE1Gb4wpKWfs83HxzDchmiNkq4=;
 b=ZQqNi1+/qOMeNAdIe9DzSX6VlcuU27MJKo7yBTb2wDk5FZmAqjIBLNlBIV84VQNxb8k4Y1DRfP673oFjEtfvqdmTnAj/hPdlDB6DGQKc8cOp1Qzj4uy3k+2i4397PWurMB+vuta80JsXbCidntIgFAuScAChNDaPX2sNLT7WTUtUb0o1jDYcicZkkgakVAMQN16/7hp5M+L3zw+Iob1yGEEh/dDV/2dch+dzZMiu4hnf9qs+ZXxAAcQxBcb95yiYyhuazN4BXb8AFhNA3aVwCLMvP0fNx07uFNKHl+cX0imfg6SHTa7SgeUQBggI3W/Pv37F3pfCh1dd6ArT5bboMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMqZbq2b5Q9UyNsFfaE1Gb4wpKWfs83HxzDchmiNkq4=;
 b=jefo5j3bMvW5+cqt6LQfRW7OAoSraE6pCrl9LoYX1A8n+xsRooxJ+igajZlbaDk4Tg47E3Gws8hHZxu5IP9fXhlkrs+CnIyIb7BAcvowXqM4ICb/dLhEvB2EmkpJSo1IVW6AG+n1nROePT4IjyiEMK8xe57bL7sFhscTcE8b9G6dpusKefI6osU8VM/IGowDfQ1a+Wh4k7VoIWF6WiEhawm//rtrHScG/2s+i7lPeAhl+v4UL81myiz1gKQAXL6OLIIeQUY83rUhM32eJTY6Ac8jQc6YZYqfcoK0XZ1NsegRqQ6H1QQTYuMYBEsJmj/KsMGjziGiqk3im9xoRd/bDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7)
 by PH7PR12MB7965.namprd12.prod.outlook.com (2603:10b6:510:270::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 14:35:25 +0000
Received: from CY5PR12MB6084.namprd12.prod.outlook.com
 ([fe80::3e6e:c7c3:2618:2b68]) by CY5PR12MB6084.namprd12.prod.outlook.com
 ([fe80::3e6e:c7c3:2618:2b68%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 14:35:25 +0000
Message-ID: <25276919-9544-5af0-51ed-7ce5e6b8edad@nvidia.com>
Date: Wed, 31 Jan 2024 16:35:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH rdma-next v1 5/6] RDMA/mlx5: Change check for cacheable
 user mkeys
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org,
 Maor Gottlieb <maorg@nvidia.com>, Mark Zhang <markzhang@nvidia.com>,
 Tamar Mashiah <tmashiah@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 Or Har-Toov <ohartoov@nvidia.com>
References: <7429abbc-5400-b034-c26a-cdc587689904@nvidia.com>
 <5e04d7a1-5382-179b-968f-97820e376129@nvidia.com>
 <20240131141810.GH1455070@nvidia.com>
Content-Language: en-US
From: Michael Guralnik <michaelgur@nvidia.com>
In-Reply-To: <20240131141810.GH1455070@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0363.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::8) To CY5PR12MB6084.namprd12.prod.outlook.com
 (2603:10b6:930:28::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6084:EE_|PH7PR12MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f483c92-32ce-43c4-557a-08dc2269dc94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SpUPE7X/DD/Ww8wG6C/rfNL7SU+ZJvtY9YQg87SgRMWh/TlfPCS4c5PIFImHo7uLs2ezhNbxq0+jkNpuPNVX0GyEpC38sTrYYEpJj6lYpwo3PKxw7fs2iNtEfHQSoa56zKYsl7cR2eBXttJsdrUbt4mZKzxock71KnEkry6MPE20C0QTQKqnz1mpMBG8QljNfCxhfzUR5w3dPvLI0eYtw6oVP2arHGj8M5NPgbrvcGLpA5/st7P0OWa8IW51vyQ2hz0jeoupwfYmmcuEGmCXdUF070+FnrqP92BUjyb9o3SKTpgK4V/Py+2ugyjuxVAzuuBnfivJ/kSrFuGKgiEiFW2yHTFJ0uQAElgetLHp3ej/TNcSl/7YySdFkNsdM00mADIW7aQ+QYBmyDMfFzdU419McJ8yFeWj5ubwhfJ9698i8cFFPJ2GUVoOooqIr0t9dOjZND+WBsj4G4VdS+skf+8ciN0zV+3HgY8xd62N1hFMIv4ybtTnYhl6kIrJa7ghP17V8mY/8L4Hd2ZJXlM4ZdsTpBulInAf823ND9DhKjjixecKuQCTCQ3WmbxSp8HGG2uYnv6jM11TlTxt6UCNqsl9Debt2Rg3v0q9QxQLQhI2r6gMDMKZhmWCwBZEqjp/IgwtS416KpkpodltO6o71w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6084.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(346002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(36756003)(66899024)(8676002)(8936002)(4326008)(2906002)(31696002)(5660300002)(316002)(86362001)(6486002)(6862004)(66476007)(6636002)(54906003)(37006003)(66556008)(66946007)(38100700002)(53546011)(6666004)(6506007)(478600001)(6512007)(2616005)(26005)(107886003)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1NzOUQ5Uis1cnpkNVBDY3BXSkdvbXJOYk9DT0prbGYxbmhCV0NKaG44Vkkx?=
 =?utf-8?B?enV2TmMzQVJ5eFB0Y3doNFliZ2tKbUp2ZnBXakVodnppQyt0RHpOTmFpRW5I?=
 =?utf-8?B?SXBKM3BiaEpVOWxka1BmUXgwMm9jSEw4cVplcUQrUml4T0NOdDNwVGJtNEtU?=
 =?utf-8?B?aEVkeHRnRmpTMGozZ0YxQnZNa01rVkhqOG1wQkVtVWpXUTlXY0tMSDJGMUx1?=
 =?utf-8?B?R1BYQ1g2TkZSeGVOZ1JEbHROSjNmb3ZLdTFlK0YrNUkwSXhoZTROUk1jSk0v?=
 =?utf-8?B?V0pTQk1ualJicjNLVEo5cVVDbnVad05rZ241RU1IQ2M2OTk3WW1TaDd5ajB3?=
 =?utf-8?B?Y0Voc2FjZlFkYjZkcVF0V3lPejBLbDVhbHNxY0t3MTcwVGQ5L0FITmM3djJk?=
 =?utf-8?B?cXhyUHZTYm1yUXJxaXNPZlJsUEF5TjZUSmU2U3FpdWhROFBlUURvNDlzczNy?=
 =?utf-8?B?MWVKSjlPYUUwRGt5Ym8wOWxNMUFDeHhPZG5leHlrcTAvTjRBYjl1azJiYkJL?=
 =?utf-8?B?WGV0VHFHZURRNHVzaGJnaC9DL1FtZVVoek5KNGM1VjhZb0MvKzgrdEV6WlZK?=
 =?utf-8?B?UFFUMGJUajZBS2J3MDZsZlR3Tkc3T0ZLWFhwbml5dXE3RWpqZHhFSnBrcTMw?=
 =?utf-8?B?VEd0SWNUbXZTL0hmMUlTMURvVmtJbFFUQW1tMHRaMHBvYmNxbEpqd21pSEtN?=
 =?utf-8?B?MmVVd2tIZFBHOFhWL2RjTTd3dWtUNVNRSUZZL1hGK1RseG0ybWcxYWFqOXRn?=
 =?utf-8?B?RmgwZ1JsSUR3aHNjSVVTMTR5NjRMTStqOTFVbCs5S1MwK3ZPZXhiamdyY2hp?=
 =?utf-8?B?K21NYTh2Z2M0Vm0xbWdTVGJpUVNhSm1mekhOVnBnU2plR0wxUmhaM2VYVmRq?=
 =?utf-8?B?aDVxRURHR2VZYzJreS94RU9KOHZ2QnFkeGticEZ1SWx2R250T0d5c0M5RkQ3?=
 =?utf-8?B?QWx3U1JIV2V0a1ZqYTdOTlBtdmhhcUZRQy9mOXhuQ3g1VGpXcEtBb2NpbWNq?=
 =?utf-8?B?cXF2YjRFNEIxR0VLd3hMUmZFSjc0c3JmcEhPclQzVUFXMzUxUkFESjdGRzZC?=
 =?utf-8?B?R2ZFWXZhU1ROMUROWWRMOUQrODBMTXZhanB1NTVUa3NWak1EV2t1T1ZHV3dR?=
 =?utf-8?B?TkVDNHNyVnZpWThKMklKb1ppZkNFblJERmZtQVNEZzdic04yTy9qMzlxdEl2?=
 =?utf-8?B?cGt5c01XQlZCaWkraGtHV0xrM0VKNFlsdXpNTGdBbDZYS0t3TXA0RklzKzlY?=
 =?utf-8?B?R3BlaHJQNTB5WU10bmt5MDZyaVhZTk5HWlpYU3NwbUlGb2xGbDMwdDNLZmMw?=
 =?utf-8?B?RERCWkFXUW1OK1BhNURiWHRnMW1rcmRLUFFUbmV4SGRTUUY1Rk5DcnV2Q1dK?=
 =?utf-8?B?bGtZaFczS0RvRElpOEt2am0ydyt1NkhhVTRsN1RFeDRaUTFCMGhmWjV1cTc4?=
 =?utf-8?B?ei81TngzaUJoV3Q4OFpUSmQ5dXhIbE9wY3FTejVRcDU3amVSOXl5YThoVmp3?=
 =?utf-8?B?MFBHZC9Jck5PRy9mY2NjU1prbXYxbXc3QlFwVVpJanFtVXJpbEhmU00zWDM1?=
 =?utf-8?B?UEVIM0g2b1FvRXdlcWd5RkdiektFbWlmR01TcldiMFJNK3YyZDhKbFdKMmdt?=
 =?utf-8?B?a0lteEZENkpHdmZvd1hQMHpBWkx3SFVrcXpXdk1ldDVqRXlVOUFkYU8vUEF2?=
 =?utf-8?B?TzdGUlZIOEp2L1dreC9XYVJ0RVNwOXB5cnZHUmFyL0VmaXpta3pHeG1HUlhk?=
 =?utf-8?B?UFNnRmdvakcvWkZMNUFteUlwcTRCTVVGY2ZRdDVFZmdWb3IraHJCeE5iVjl3?=
 =?utf-8?B?Y2VNNlV1ZENmRjVBUExTMUw3UTNJYThiOHZpSXYyRFJUNU5DTU11em1yTW1k?=
 =?utf-8?B?cjluWHkzUDhYZXZKa3k5V1lPc05iVHlUaU1CRlU3aTcySWdUZ1FjZVJyZ0hX?=
 =?utf-8?B?SGJsV1kwZk14ZXRUWkoxTEhiZ3VEN2FFUkRRdW5tZlRYMlo0Z2t1aEtiNjgx?=
 =?utf-8?B?b1NMbzRwcll2RE4yYU0xZlVFdndlVExNTktjOWlOMHhpbUJuNW1IcDluUWJj?=
 =?utf-8?B?K21ZMWdGV2Iyb0FnUDNjdmNzZFpqVHVEZjJHU0IwKzNjZWVtWjk1VzZuRlhM?=
 =?utf-8?Q?KFFoP2NWWDv6Lz+KONFUU5vj/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f483c92-32ce-43c4-557a-08dc2269dc94
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6084.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 14:35:24.9662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yASNu9cJHzFDbfxjvFxdBrZhwaJ01h8imO4xZ0GgtywPpXxLEVlKok2yZeoNEdZ69i40/Er0Tw7OV7G2sEFJeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7965


On 31/01/2024 16:18, Jason Gunthorpe wrote:
> On Wed, Jan 31, 2024 at 02:50:03PM +0200, Michael Guralnik wrote:
>> On 29/01/2024 19:52, Jason Gunthorpe wrote:
>>> On Sun, Jan 28, 2024 at 11:29:15AM +0200, Leon Romanovsky wrote:
>>>> From: Or Har-Toov <ohartoov@nvidia.com>
>>>>
>>>> In the dereg flow, UMEM is not a good enough indication whether an MR
>>>> is from userspace since in mlx5_ib_rereg_user_mr there are some cases
>>>> when a new MR is created and the UMEM of the old MR is set to NULL.
>>> Why is this a problem though? The only thing the umem has to do is to
>>> trigger the UMR optimization. If UMR is not triggered then the mkey is
>>> destroyed and it shouldn't be part of the cache at all.
>> The problem is that it doesn't trigger the UMR on mkeys that are dereged
>> from the rereg flow.
>> Optimally, we'd want them to return to the cache, if possible.
> Right, so you suggest changing the umem and umr_can_load into
> is_cacheable_mkey() and carefully ensuring the rb_key.ndescs is
> zero for non-umrable?

Yes. The code is already written trying to ensure this and we've rephrased
a comment in the previous patch to describe this more accurately.

>> We can keep relying on the UMEM to decide whether we want to try to return
>> them to cache, as you suggested in the revoke_mr() below, but that way those
>> mkeys will not return to the cache and we have to deal with the in_use in
>> the revoke flow.
> I don't know what this in_use means? in_use should be only an issue if
> the cache_ent is set? Are we really having in_use be set and cache_ent
> bet NULL? That seems like a different bug that should be fixed by
> keeping cache_ent and in_use consistent.

in_use should be handled only if mkey has a cache_ent.

I take back what I wrote previously, in_use should be handled in revoke_mr
no matter how we choose to implement this, since we're not guaranteed to
succeed in UMR and might end up dereging mkeys from the cache.


