Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D136C66D390
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 01:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjAQAI6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Jan 2023 19:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbjAQAIn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Jan 2023 19:08:43 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC98241D9
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 16:08:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5Ra+e5Vey2KC1ZaVquXuud8rTtZuYzJ07v70jBI7P4TY1C2p7mr+VuYmwgpLWNIc8SCHl5ocIGdm7Dgw84QPxyU5RnauuAYI0yV+l3yX/L65EekiKwc60HHlWDxrRY+4B9L3bIV1JjtcRLPoUd+PiSkXq06Kx7xHXY6uykRarCUcxbQsWsCdFhDqusxrBebO0olKqzt1LDK3v5BHLkPpkITsMfTl+iZPlC12MJvHGDU3X5nIgT5cnyhjEF64d5VK1DfZky5FLlVzafsZ1oDCXvC1aR+A3SrkSjFOTkTmbXFBBAwg2xvffGjwJxiKLN/s37Ta9rSSfk2ljeMpyHSQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuqr65vKtlTqP2yWc4X9cWJcRp/OCPUwkp5CzVuVJLc=;
 b=KSLzuhImVyWSCZplqCAebg3uldUaVBgrDNANYb1AIupxynp6VteWmJ3+6Xiw/WMqgTZhiMR6I/Dvb+YW0wm0qiimIcxw14yNdVTgfMCQCongGMkQYK5JYdcY/sqahPaxOLnQIqusgOBOidzg1WsRMRv8qlZY/V1oj88FaR6Qqhzzu6j2Pvw53qLKduJqN477+2+3kSEvXwqJDXUngPXG5pZZb4dEPzukkXEg0YTHeCMriBiowCxXwQ5SmLN/tq9po74IevWs7KSjhPF0frMkWL65RvkCSe4d8L3xIYkiApqQrY7mBc5FB0HiRwBym+qaz8hG8c6mFRxq9xeJDUr0KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuqr65vKtlTqP2yWc4X9cWJcRp/OCPUwkp5CzVuVJLc=;
 b=PWG7SnStyMSq6q2pFWZHgvUm+ffr9FhIVSXihnRD6OLPNdgDUeEjsB/BfLJF8hewyvGK+cPcGX4tmceX65dQeGu+CzYpaNCaUVCiZv4FVV7xhR1NTYKvzGGQ2DAyThMCd/moQib/lSH7bXaN5N4H/xaXVDdC7qECHncs5ZBCJqKSbZcbvPYTypZaK5PHQLcWWJLDIUWK7w1LM/Qk8M6yH2F3pdratNNjsS5ikhn7wm0qPLP8D4VKAVPjE78zCNEUSuEU+CYbW1ohacNUBhAn+Alqe1kF4//4ii7S9SJ5KOgaSkc9whcIDKTjHPIdhlQ1ffRNZ0hilZ4HAa0NyeDScw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7)
 by BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 00:08:40 +0000
Received: from CY5PR12MB6084.namprd12.prod.outlook.com
 ([fe80::c267:a84f:50aa:6645]) by CY5PR12MB6084.namprd12.prod.outlook.com
 ([fe80::c267:a84f:50aa:6645%8]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 00:08:40 +0000
Message-ID: <04b75e85-dcc4-b012-06e3-77a298a7d0e2@nvidia.com>
Date:   Tue, 17 Jan 2023 02:08:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 rdma-next 2/6] RDMA/mlx5: Remove explicit ODP cache
 entry
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leonro@nvidia.com, linux-rdma@vger.kernel.org, maorg@nvidia.com,
        aharonl@nvidia.com
References: <20230115133454.29000-1-michaelgur@nvidia.com>
 <20230115133454.29000-3-michaelgur@nvidia.com> <Y8WCetXDkjH3Au1W@nvidia.com>
 <5b3e0314-5e60-eb4b-9fcf-7a4e6061eeaf@nvidia.com>
 <Y8Xhg5OY6sJDXfm6@nvidia.com>
From:   Michael Guralnik <michaelgur@nvidia.com>
In-Reply-To: <Y8Xhg5OY6sJDXfm6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::16) To CY5PR12MB6084.namprd12.prod.outlook.com
 (2603:10b6:930:28::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6084:EE_|BL1PR12MB5269:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f6fc1f-7747-4494-a14c-08daf81efcd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c6KIdz8rUj/O7+uTfYmMlUqhyc+QOuiMftJ+68rahWlV4zW8dilq94UpjFlt+trNs8YkTrZNuRu42q7aLkcU904aj36kk+lkj865r+j2RhG3AqSDXK2BD4tLgsqS2rbJj3r3TN5dm4XEvGBUURPT4HdsYchgxjhoKi+VhQVffGdBeJkx3LgLzyz1QnQIMN9ZY4pT4snZeFRG+YFFPn/HM6QxyeD9mhPNNZH/JpDKBsMVv4xGgAS2hTxmQ7pn8PEMgXDkPeo/t6LR1uvjap3t5RI5eHTvkL0BXWWkzYU1BC8qiLQ7qvnt4EUrn8pDRX4l7O02hSVaScws6EzjCHuhXDuji4V0Fl/wDUnOAm4cc7Su19UkoeJnKhlGujDKr6ZJPzJO/nYPGExResY3K3R6/oDkJK+dvLdvCo1/saehUgjRSoDPqYfqQMFVd2AAeSPR9eCa42m9yIMfBnKY/zAkUdUsuTI2gPHfkKmmOv8M/IqNSfb4EHleK2RDjqk1m9kX54E1aYz6aCMI1AV2weuYqyHRCXoHhsm5MIXtwM1nf3evr6uwhT0e70I4d/gM6vbUzrg+TvKIBaOYWx26LsSlaKaDuH8lvgtPyVTWpqBLokBpuiaWmgbiD4zvFkPtnwhSmRQOfTC+G6UkkOAVdWidVLcXI7H3J2W/8H8/zNeYBSGcm3UVEP2RhcVEQCGUp5LCojst7idvUGRFjlk4pWDqfkdFL0TGkaAB6y9Q8RIAP34=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6084.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199015)(38100700002)(36756003)(31696002)(86362001)(6486002)(37006003)(66556008)(66946007)(4326008)(26005)(66476007)(8676002)(186003)(6512007)(478600001)(31686004)(6636002)(2616005)(53546011)(83380400001)(316002)(6506007)(6862004)(8936002)(66899015)(41300700001)(6666004)(107886003)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWZQaWdEV0hmdS9kdDVPNlB6RDFZdmpTZFA5bUkrUVFUVEVCZlB4NWtzbDRF?=
 =?utf-8?B?QTlUZk9kK0tOd20vZjRoUGhjWDlseHdiSnJTRGUxM0xtd0hDTFBiWWhFbUVm?=
 =?utf-8?B?R3dud0NVMnZ4MGJ6WVNMeUtiWGxTTDlPL3FYclk2bVYxdC82cjZTVWs0N3Vj?=
 =?utf-8?B?VTJOVmdXb2lmYXVHRDMwc0J4YzhtSmJJbGltWm8zelJtQmhnZFM5SUJIdnEr?=
 =?utf-8?B?R1czckFFTFI1S3ptOHorRzA2ZTlEVHRYRlhEUmxMQ09teGkreXA1L3VaNXhF?=
 =?utf-8?B?c0FZdGZqOWF3ejVUTkhkZkJ4WUxscW10em9pQ1BZTWZFT2RBSHMydE9LcXRQ?=
 =?utf-8?B?V1hsbWZON3RFNmxqMy9yWncxQXNhcVZtYVREalNETWE0dElMZ1FEeTYzOEJJ?=
 =?utf-8?B?clptQUZmRXhBMTdpM3hlTEd6bXExRHBjYm5OekZHSzZhMjJRRE15ckZhdEUv?=
 =?utf-8?B?SDlaWDZOcHFUQXlWcGY0ZHNic3RyajZFVWdSU0xVb0NsNnozaTFFMk5ZQTQx?=
 =?utf-8?B?SDBYT1llZ2p5Y2Z3UzExc1ZabE9wTDZJSXJIcXVXbk9iaU9nMTNyNFQ2bnhZ?=
 =?utf-8?B?YkVTdndqeEZUeDF1a2twQTYwR3hVM3JReXFIN3g5UHZNNXVndzRWLzRwMnVC?=
 =?utf-8?B?SFVyU050ZE0weXlUeURGbXIzOW5OWWx6c0JMcHUrYkdCT3hob2hNRjkwWEZ0?=
 =?utf-8?B?NGNLUFRTNVBMNjRpM29OTjU0Wit2L2hONThQUWdxNS9BQUpjdEVEaWdweWxh?=
 =?utf-8?B?NFZhZTRMbXZaZkF1NXVQZVBsTG1vRWltMUREekpvR2lqMkMzNGlIK01FVDJp?=
 =?utf-8?B?MElDdmdkYmRBcmFWTjNoWllQMDArWE41OUwveFZCdnYzOElRb0tiQTU1Q2hN?=
 =?utf-8?B?NlhRQ0FuN3MybVhjd0piVWkzdHB3R1VjQmh4L21ZY3U2SlFLNkkzblQzb2Zx?=
 =?utf-8?B?U0Q5d0s0ZmVYWjBkTWc1SEJGM1dTc3dqMVVOVFpNVXZ1WWdEZWMxc3ZLRXVt?=
 =?utf-8?B?WUx4b25HMFVQdkkwZlpYZFRKQW1pVGVBRE1uT2M5WHZ1bTNiVk9zZml1dEEr?=
 =?utf-8?B?UXQ5d1hrcjVNSkhtNnppc3dHQU5qYXlSN1NwS283aTU0dTZJSTQzd1FUQS8v?=
 =?utf-8?B?anh6OE9aejMvbCt2RlFvMjBLUThjRWRCM1dRWFRSOGtUSzh0cURLbGpUV1Mx?=
 =?utf-8?B?R3NHdUNMUEhTcEpIUEJ1SVM0dk0wQXZFbUZFMVRYZFZZRVVnZFZ6ZkNEaHV5?=
 =?utf-8?B?NXhUNXNpWFBxNzhiTWtidEU2aEZsMEo4a01LMmZUbjI1c3dsRndLYzQvTk1D?=
 =?utf-8?B?Z3F4aG5tV1NwaU9UNGh6VmVGc09PaFBnMzJOODBrTFhNNXdFSFFjVmZMVWhY?=
 =?utf-8?B?YTlJYjZaSGtSYWN0bSswY09NWmNmUnRGN21YR3p1VzJYRE4vZTR6VDJTUUNs?=
 =?utf-8?B?c2d0VXpUZHIvbCtDQVQybkZqOUZsUXVSbnR5ZDRmRmdhbFNrVEFTWVVhWjRs?=
 =?utf-8?B?R0xoNlpJMjdycUZzU3kzV05XQzBZWDB6ZXBHeE4vekZBNm84Z0FPWkJTdk9O?=
 =?utf-8?B?UjRDbWZmNElEVWhkUFFxMnRQYlZHTTlJSWhyYlhXdUVLODN1Q2JETlNqcUlT?=
 =?utf-8?B?U2tZa3I3TEtEY09wVE02REpYcFpUcVF5MTUxVzU0TFlnWGJRT0xvSmF5cVh6?=
 =?utf-8?B?T3hMaExGTUhXYmVLRVdIa2ZYMWJBUzBTNUN1a0grZmJ6YWE2U09vMzVxcmVG?=
 =?utf-8?B?WlZmNGEzdW1hQjd5NW5HaVRTalJHNmh1aFV2UWxTc24zMGRaaDdEZG4rL0VZ?=
 =?utf-8?B?VnRTcFFqMFVpVzRXNnhRU2Z3LzMyYnlrT09JczVUbVA3MTA3R2dpaGxrWmov?=
 =?utf-8?B?b1NDeHZKaFpNNjB0c01mcFl1Y3lEbXJWTGFQN0dEaVZReFBmOExKWFpoSVBm?=
 =?utf-8?B?TTRCcXpCUFVlaDRUWWF4aDFoME1hZkh6dGpzbVVma0RFNHVxQnU3OStuWUww?=
 =?utf-8?B?SWoxZXZ0UlJ0TDllMkNYT1VpTmdZWDZ4cXJhOVVmT2tNUmV4YlJRVGZtUUpk?=
 =?utf-8?B?MjBLclNBNVFuTGdXbUl5elpTcmJ0aW9RYUNwaGMrMjJ4MnlIRmhTeFJ5TWd3?=
 =?utf-8?Q?v1NPK5xvD1OeZJBtGmENzaiB7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f6fc1f-7747-4494-a14c-08daf81efcd8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6084.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 00:08:40.4078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCn2VaNbJzrULMl36KDmbJj2lPXa9GBp5ewNGLwNaLDumpUpyIjVLWmK7gA9zvPwRXVHOyxss/Kis+IgWzmI7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5269
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 1/17/2023 1:45 AM, Jason Gunthorpe wrote:
> On Tue, Jan 17, 2023 at 01:24:34AM +0200, Michael Guralnik wrote:
>> On 1/16/2023 6:59 PM, Jason Gunthorpe wrote:
>>> On Sun, Jan 15, 2023 at 03:34:50PM +0200, Michael Guralnik wrote:
>>>> From: Aharon Landau <aharonl@nvidia.com>
>>>>
>>>> Explicit ODP mkey doesn't have unique properties. It shares the same
>>>> properties as the order 18 cache entry. There is no need to devote a special
>>>> entry for that.
>>> IMR is "implicit mr" for implicit ODP, the commit message is wrong
>> Yes. I'll change to: "IMR MTT mkeys don't have unique properties..."
>>
>>>> @@ -1591,20 +1593,8 @@ void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent)
>>>>    {
>>>>    	if (!(ent->dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
>>>>    		return;
>>>> -
>>>> -	switch (ent->order - 2) {
>>>> -	case MLX5_IMR_MTT_CACHE_ENTRY:
>>>> -		ent->ndescs = MLX5_IMR_MTT_ENTRIES;
>>>> -		ent->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
>>>> -		ent->limit = 0;
>>>> -		break;
>>>> -
>>>> -	case MLX5_IMR_KSM_CACHE_ENTRY:
>>>> -		ent->ndescs = mlx5_imr_ksm_entries;
>>>> -		ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;
>>>> -		ent->limit = 0;
>>>> -		break;
>>>> -	}
>>>> +	ent->ndescs = mlx5_imr_ksm_entries;
>>>> +	ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;
>>> And you didn't answer my question, is this URMable?
>> Yes, we can UMR between access modes.
>>> Because I don't quite understand how this can work at this point, for
>>> lower orders the access_mode is assumed to be MTT, a KLM cannot be put
>>> in a low order entry at this point.
>> In our current code, the only non-MTT mkeys using the cache are the IMR KSM
>> that this patch doesn't change.
> It does change it, the isolation between the special IMR and the
> normal MTT order is removed right here.
>
> Now it is broken

How do IMR MTT mkeys sharing a cache entry with other MTT mkeys break 
anything?

>>> Ideally you'd teach UMR to switch between MTT/KSM and then the cache
>>> is fine, size the amount of space required based on the number of
>>> bytes in the memory.
>> Agreed, access_mode and ndescs can be dropped from the rb_key that this
>> series introduces and instead we'll add the size of the descriptors as a
>> cache entry property.
>> Doing this will reduce number of entries in the RB tree but will add
>> complexity to the dereg and rereg flows .
> Not really, you just always set the access mode in the UMR like
> everything else.
>
> Jason

ok, I'll give this a second look. if it's really only this, I can 
probably push this quickly.
BTW, this will mean that IMR KSM mkeys will also share an entry with 
other MTT mkeys

