Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A2166D332
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 00:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjAPXec (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Jan 2023 18:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbjAPXdQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Jan 2023 18:33:16 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23BC2F783
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 15:24:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naCwXwUwwc2Nmpa0zdZjCqoVVkOdIPDhf/11jTHBavLHc0+DKddTapIvTKw/uoobzyqnjUv89E/gW3ik5wa/xSWPkHHrs8Id+W5Ct7AGVBL1dH8P8yHxkgINPNIiM5jZXNu9pGQey6AppSRDZPUYy8FBYjJo7D5n4VyaePoQHmaPs9HGlmUqcob95GMxEALi+12g1vWY17SIWqYUW7jeP979TMfYeWQ7qEgDON2fUalxbMpzkVON4cnEH0pCjxClzIizI5xpkPzkkR+rThJ6HXZjSLgL9OD9kbOZvtf8eLmiVgKk/ByjsTdEiHn805J1uiybsgg+hopekk1k1BQEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUQT+SgJIjMhVHOz7ODVCIZQoV8vashSNb61cVPqS4Y=;
 b=jIBugKGV6TKduTU/jJf6Y/tG1AM+mLLjeqz63TAoFdSF8WOgUd4UXkjUW5m7WHVCR/gh3evADHEdif2Xh3nqw0UMDr5vbLC2yLFQRfOgnL6jsCgU9HVN+lMy5fcVKcwuzVvrZ7VAN58dWNZzlpkumi9D3lr0iGcH1YUb1DL7c2CATkbIEV34BqAFoJYJt73XA1iTZ7g0+Kr8ukX+KudD667l/thNDDNEP19Clf4G6kld6c7XuCVs/mIiOn/WArbV030DKjsrycYarD6xvcd5tAQM+Z+mEk17Mojdb2IzND8Uzb4Rd626hKOvjIt/wdUK1dS1hvLRzQqYtZ8znTbzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUQT+SgJIjMhVHOz7ODVCIZQoV8vashSNb61cVPqS4Y=;
 b=t5ZZ1L/wlV1mKkxn3WxwLJ10QNWa41+7lKqyqln1NvmRol2KlywNdKp0nn5NA+wZy4+3XRNJB2tv6ru6SyBZcsdBY+ffx+5KQySZcF0+4o0iMBPxbiXmf+rKumQzsHZTjJ+6u4BF/X+gzOqnonWQo1bfePfu+W3BiroSNZ044rzZPWksvqdsc4Ut2pS38CxU+HaZ3VCI87Ik0DQS+SKN96OZDgJpJZ6jdQhHdHq2Hi8OqWzYdvO3M3dZLgvQDyCLkTZcLDOdbEeoUsA1S+fiTywMann9NI+89fyLFqcg8lm22Z5opRi4dW3l0BTWQ1kSkZjvOdSclwmjQaTP7WMMJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7)
 by BL1PR12MB5224.namprd12.prod.outlook.com (2603:10b6:208:319::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 16 Jan
 2023 23:24:40 +0000
Received: from CY5PR12MB6084.namprd12.prod.outlook.com
 ([fe80::c267:a84f:50aa:6645]) by CY5PR12MB6084.namprd12.prod.outlook.com
 ([fe80::c267:a84f:50aa:6645%8]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 23:24:40 +0000
Message-ID: <5b3e0314-5e60-eb4b-9fcf-7a4e6061eeaf@nvidia.com>
Date:   Tue, 17 Jan 2023 01:24:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 rdma-next 2/6] RDMA/mlx5: Remove explicit ODP cache
 entry
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leonro@nvidia.com, linux-rdma@vger.kernel.org, maorg@nvidia.com,
        aharonl@nvidia.com
References: <20230115133454.29000-1-michaelgur@nvidia.com>
 <20230115133454.29000-3-michaelgur@nvidia.com> <Y8WCetXDkjH3Au1W@nvidia.com>
Content-Language: en-US
From:   Michael Guralnik <michaelgur@nvidia.com>
In-Reply-To: <Y8WCetXDkjH3Au1W@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::23) To CY5PR12MB6084.namprd12.prod.outlook.com
 (2603:10b6:930:28::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6084:EE_|BL1PR12MB5224:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d47dd3-e3b6-491e-8adb-08daf818d6f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y86VcHsikYqGayAcRvbPDNB3k4A64XBBlUnl+1dEFHnaYGQlckzTQKgNJWepqh++ColiOVGt4kuiB741NgMFy5vn788uZIMzq9D++cjuoDxuvPmO680Ypo1lqlBX+hMPtJGrk7bAa8zZcBGBpGSkH+DlA9v4OzMhUTKYRZDyaLRaq9E59De+xePIiL0KBqQV0aPHbnX3heo3g8Ms9aQrbyXpiqbWwhN3y0xUOJHDAo24GLqltt27AR6XjHTWgF5Y53CzqyxOtYun+e6IjtnIX2EHwrjjyElq5cPErMlM70PsSwZCly+jaXEBbJl3Wx2I2LtZPtbTsqEiFwJl7uPambZfxC8/rwZNALT0EMFNgkFzpOleSBMK++iBeVOgYRQ9oEhmWSFZftLOJQS1qIh/T653l6dMuysVfRNTZQ5QMaEbxy+HyMFBv2+0Eqnq0oWDYCa+ZTxSPOHWhFBgx9hKXJEUzkqHdJRwb24j5oLneEI2JdhBdirRvOWH5/2jaCP24vL4p1x58LD+grK2TeyFmPxBqeAKB5/2Cy2fEe6/+vswgt7QQno+RvkTSl/9PYnnIh0C5nH6WRJGsgKwGe1ND1TvLarIQUMAzi6ZFg8tGpvEAUSRT0eJ82ATdRWF8LFJ6WCfLrg9lxvMYLKq3AFrOJpBxZ7m8prDo8/3dvwL/gGHx/L57AVx3TmQxNvem5ABwgucm+8k5BuUqaKns9zyHhUgYtvMqNeXMx/2LtMAlO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6084.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199015)(8936002)(6862004)(5660300002)(41300700001)(38100700002)(83380400001)(31696002)(36756003)(2906002)(86362001)(6486002)(26005)(186003)(6512007)(6636002)(107886003)(53546011)(66899015)(2616005)(6506007)(478600001)(6666004)(31686004)(66476007)(316002)(37006003)(66556008)(4326008)(8676002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1VoZVRSVFduaDArejljNngwbVVSdWFFRmhFeVVHbnhoTjM5UngzM3NheFVE?=
 =?utf-8?B?MDFTVUFYZ09sMTl6NGlaS2l0eUp4VGhvUk5Pc202cm1DYm1JTGt1dE1FTU9G?=
 =?utf-8?B?K2xEdGRLSXBZT0lseW1GK1FBOEczZWpXdVQ4K0RKVmdkdkYzZEtkb2FQa0pR?=
 =?utf-8?B?T1doMHhIOEc0dlNaWVFvZzVaV1VjM2xvZzhTUUU5MG4rVnltZUUyVkFUT3FS?=
 =?utf-8?B?UWdVSUlBWGdRWDJxa0NwR2ZOanpwMHRLdGdtNkxQMDBIaDhBYkpIWGlldEdK?=
 =?utf-8?B?RHhVWDhaWlgrVThnZ21uZjA4WHl2aG5tWDl2UGF5ZXFSQTM0MVBhNkNRdENP?=
 =?utf-8?B?U0hQY3ViQ1lFanQ5RUlIRTluY1Jabkdqd1FWS0MxdVNNNTBWOEFaWmt6RUpF?=
 =?utf-8?B?ODR2STVyYWMzMEZ6OW0yZlhQM0QzdkdsaGczNEpvUUxnZzVwa0xrYlVYUmFW?=
 =?utf-8?B?RXlRYkRxU0p4S2VTQjkxTzA2dXpXd3Q2MS8vU1FJNTZpTkdyUVRFaWZSUmlS?=
 =?utf-8?B?MmdsOTJlYzdRdG1Ja3RsbEFLL3Q0bGp4V3hMRnRncDRJS0V1bTh6MWFuTVNT?=
 =?utf-8?B?NjE0QmVKK0psY0gxd0x6R1BIMHVGTDBiR3RaUEh1SWh0MkQyWlZvRzRueTJ4?=
 =?utf-8?B?V3lHWnJ3V3RRSWVRR0hDcHdsbWljaHN1TTU3RTRVb0h2UmRFNG1MRlM3V3Nh?=
 =?utf-8?B?MEgybXcwNDREc1hnU2d2cng0ZHMzS0FKeCtwNW1tYXNXcWg5VG1VTWlmVmpx?=
 =?utf-8?B?QUdwNXc5ckFVWVBVWkwyOWpyTHBTTERnWklZQnNhNVlpODFrMCtaSkJ2ODB4?=
 =?utf-8?B?WDllTGEremtXd1JqbVdFd0h4SThNeXZ2OElhdzhiZmlLc2ZhZFpYMVJsV3Ux?=
 =?utf-8?B?ZDkybzZxRkFQQUxEUE9NMENKYUcybE1LblpLY1FFNmhJK1k3Z0wxaGx3eTlN?=
 =?utf-8?B?bGkrdm5SVEkxZkI2alZYdllISnhSVWpRTEdyb2hUUEdLenF0MHBaelAvNWZO?=
 =?utf-8?B?dkthZm9ldjNvcEEyaDJZWERDT2I3SzNnVi9ldHZCczZQL2RmazYzWUF1VWZV?=
 =?utf-8?B?SmZzdDV3OFRMMW9xUlRPOEpiWnNNeTVYMy8vQ2Y2azJTZFR1b0NCMHh5OEQ1?=
 =?utf-8?B?OUNNYllMMHZQb3g5N3l6bStwd2pFWGs4VHJZaVh5cDRBa0E2alIrY1Axei9t?=
 =?utf-8?B?enNKd3QxdUVUZk4xWnBmRkVHTThZNHQvZlNEV21hMTk2dHlqeHZxcGluS1dn?=
 =?utf-8?B?VmFmbWhCWEc1TDRveE5IbHpBNVlTeVlqcng0bHNDb3N1aDA4aWZSM3BDeTZa?=
 =?utf-8?B?ckQyOWUwWEdVUkY2ZW44RlU1RlNmNTVkRXJXNUszL05ueXRWRmRHYXdjM21L?=
 =?utf-8?B?Z3JZT3RLUVFpdExvVS85U3hSUSt4VjZjSjJrMlBRS1Fqai9CMXJCdjUyUXE0?=
 =?utf-8?B?QmZueWdEekpROE1NdmhHL1MrS2R0UWpLUVVDQXdJdUJVbTFBd29XYSsvanNC?=
 =?utf-8?B?YStVRkJQbkVsZVh2Q2p6SkEyNVFONGtITnJ1NGpETWxYOTFaSnV6MGdZT1Rw?=
 =?utf-8?B?OWlXYjN1QytMcGVBczltVTd4WXRNbDV5Qm5semhNWXZoRmxzWlgwaTIvQUdV?=
 =?utf-8?B?T25yRXdaTGZkcm5BSzZDenZRSTVKRXJ0d2NqdnZkWVFEYm9ScjVNRUE3YnRD?=
 =?utf-8?B?SWduUDVyUThCRkVDcGdUTDgvUU1Sd1VTWHg0cVhmTFd0ZEpGYTFRRGlLLzk0?=
 =?utf-8?B?RlBncHprd1RJaElqOFMvNndna20vYmwwKzBZNEt1Q01pcllYRnNuSGFPYXFH?=
 =?utf-8?B?UFBLMUtiNzRaVlQ5UkFLUHNVWFZ2WnlrUVJEMjJuMzhFZTlRUnRiNkNGbVhy?=
 =?utf-8?B?Vjg1c1pnenUrU3MrdFpOMGxiKzA5Q0l0Y3daOTlEaXBhWDFGNXpsbWppUlZx?=
 =?utf-8?B?clRwTlpUVGRkNlB0MDJWcjhmWmtMKzU4VDF5alZBN05aU0cxZW9VNDlYYXVJ?=
 =?utf-8?B?WllZeFJlODlJU3hwZlM5SWtCQWpKbEtpYmJBbVFPKzB5M2s2dWJqekRLZ3ph?=
 =?utf-8?B?L0cxbExZbjdSNndMUEtTTHRzSXRhVjhoR0cvSnVzUy9XckRxYWJzOFNnM2x3?=
 =?utf-8?Q?Fo22zAZNXAx3r0IJ62asCKJME?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d47dd3-e3b6-491e-8adb-08daf818d6f6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6084.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 23:24:39.8543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UAcFIAnXsMHrt4Is5S+CmQrH6XUP2jCvdhwwqEALMAO2/rximofIapUGszZDhaoN2E7oF5G6UM1zW4MTN8l4JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5224
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 1/16/2023 6:59 PM, Jason Gunthorpe wrote:
> On Sun, Jan 15, 2023 at 03:34:50PM +0200, Michael Guralnik wrote:
>> From: Aharon Landau <aharonl@nvidia.com>
>>
>> Explicit ODP mkey doesn't have unique properties. It shares the same
>> properties as the order 18 cache entry. There is no need to devote a special
>> entry for that.
> IMR is "implicit mr" for implicit ODP, the commit message is wrong

Yes. I'll change to: "IMR MTT mkeys don't have unique properties..."

>> @@ -1591,20 +1593,8 @@ void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent)
>>   {
>>   	if (!(ent->dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
>>   		return;
>> -
>> -	switch (ent->order - 2) {
>> -	case MLX5_IMR_MTT_CACHE_ENTRY:
>> -		ent->ndescs = MLX5_IMR_MTT_ENTRIES;
>> -		ent->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
>> -		ent->limit = 0;
>> -		break;
>> -
>> -	case MLX5_IMR_KSM_CACHE_ENTRY:
>> -		ent->ndescs = mlx5_imr_ksm_entries;
>> -		ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;
>> -		ent->limit = 0;
>> -		break;
>> -	}
>> +	ent->ndescs = mlx5_imr_ksm_entries;
>> +	ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;
> And you didn't answer my question, is this URMable?
Yes, we can UMR between access modes.
> Because I don't quite understand how this can work at this point, for
> lower orders the access_mode is assumed to be MTT, a KLM cannot be put
> in a low order entry at this point.

In our current code, the only non-MTT mkeys using the cache are the IMR 
KSM that this patch doesn't change.

> Ideally you'd teach UMR to switch between MTT/KSM and then the cache
> is fine, size the amount of space required based on the number of
> bytes in the memory.
>
> Jason

Agreed, access_mode and ndescs can be dropped from the rb_key that this 
series introduces and instead we'll add the size of the descriptors as a 
cache entry property.
Doing this will reduce number of entries in the RB tree but will add 
complexity to the dereg and rereg flows .

I'd prefer to look into this in a later stage.

Michael

