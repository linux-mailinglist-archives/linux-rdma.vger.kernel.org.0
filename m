Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD917D6A21
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 13:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjJYL3T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 07:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbjJYL3S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 07:29:18 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C756B132
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 04:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6BApWXx80q/BiA/MPbPiW8y8qXAb55L3p1L1GvCrYGL/rq6axk4arSeeNIyR5uUV53YDDgvHsO8zXWsme91TERw1RHSwoZtiDl9YIj3QywfAOEgJdRgPWZE/Ld6EDKPbB+lBTTHGHhvmRzQCKsb69TVmGz+IdAXDAgsZpRPjj0sOEuk4jMPF8ztgzqnKH24kMiBi5Bkjs62rh162cpqC81s2UVuzEsxxvpupxsqpm8thw0Gr967H6lG33cJZtH+M+QglNCWDDR+x2HPzkzBq8clYc5DIRAHdpDyuRpWaV3eGgNZsPgJO31j1knQF7V0e11DVeo3nQ6Wy2OkMRIBTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1sBYh4isTXA99G5UIWel6Bb1SWUybpnCW2fLoQLnz0=;
 b=BCNPpMYpX/17ZVt6CP/Sez1d36QOfjaxUgy7Gm8HN2iMNEF5JD/WJtHu2umYChgnzBhrdxd2Rxt9l5LKkIUoatGq2KMd1Bl/XH9npU6rd8GYn5o/f2qYQ8sRTuO2EJS8lZXjZBfg8uzZx2YIOQQ2g9H0ptPmLT+y4XrhU8QdIycPFwj0L2KRBamew/SU6DzRVSGjC4YeclmldyDnuDlHVw3qWDjClVaTUyFcaq8UUfbcykm7g8vumNotcfsj8xnSrCfWYbOvDLev2GT4u2JfHJ3Atk+Z/47AYOWBCAZ6D6vE0QwOtk/Z9gzSLcauhhHGKT6HbckcoBd9M7QtZTuTAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1sBYh4isTXA99G5UIWel6Bb1SWUybpnCW2fLoQLnz0=;
 b=aBetbj39x2pUiVhe4uQhB50t6FPCoCUHD7wW1S0H2iZku+2NUHfCMJ+3U5kbTkAnsBGyA1QnaGKCD4f/NSaUKKgg8SqEXf6kqxIEu+qJVQzdj5hL2Pk8H5OYw81IkbAyVi8k1oYMMKMCiijeVbzjbYamXO+3ZF7i+92KSZF5538Bs7AL5I/l3CjgDkvGpSop1qVNKbgUw/XW/jBCd9zKAsyjVtx86pzUAOlzHZnpTxw2DqQT7p4xxckY6kN6B2e0eXZfoAuj24QXBulg6qLSVf6rSsRYwWxfif04d9kA8gnPRIQJ8nEhkudHVzR+ZH2rXs1ztPYt/8Whlhmv763+4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) by
 LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 11:29:14 +0000
Received: from DM4PR12MB6592.namprd12.prod.outlook.com
 ([fe80::7f75:97ea:fe9:3935]) by DM4PR12MB6592.namprd12.prod.outlook.com
 ([fe80::7f75:97ea:fe9:3935%2]) with mapi id 15.20.6907.030; Wed, 25 Oct 2023
 11:29:14 +0000
Message-ID: <b4ee7c64-720e-5580-ce25-5d7c7991fca4@nvidia.com>
Date:   Wed, 25 Oct 2023 14:29:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: modify srq pyverbs test (new?) failing for the rxe driver
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        linux-rdma@vger.kernel.org
References: <401221fd-b41d-4db9-be22-b1af17b0d456@gmail.com>
 <99cafadf-a7c5-4217-9162-38fb6f8b56bf@gmail.com>
From:   Edward Srouji <edwards@nvidia.com>
In-Reply-To: <99cafadf-a7c5-4217-9162-38fb6f8b56bf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0046.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::8) To DM4PR12MB6592.namprd12.prod.outlook.com
 (2603:10b6:8:8a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6592:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aff66e3-b192-43cd-3c48-08dbd54d9deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vK+jldReunOd/AVROfYHfLKqMjZICWpZJWM39jFk4rCSUhpdfLYDz0JUQZ6JjaZxWpbd2erBZ4ynOLbY0Faa8vIGNV0hIXQ90RymDLN4d3tbkGiQuyUfJ2qq4niAlhFxpCsiEE/aY46hMbZWzab3qEqVdJK/p90j5hFYKXKdx6my4WCwiIvj0eonTvy+KGeikkA45/lJUUaaVQWXmY/c4XFludFRFQskRwEN/QZ/XUmHkbn4RZBX5tvPizItJ+l9X0orp7DkIl179KSZreWQyhu02ixY2EXC7ciG8/GxgiJpSZzh3tNhXvo5b2IaGRuNm5YLHIEIw0OmhzrVk51x2fXBRRDFSYGc4WTXgUM9Abe7vhv40Z4HalYK3B4URAgQZkzNnB7fmmfX/44b885v3/GXZnb/gbLEuqcQw0lvCuUpA1R/wrNdOOJfByknuDUAWXuhyjFcbCloYi+xI0vm4QORIwCbBTv8YELynUlp74B13ARy9cHt/S3dJJUqx8NG6TMTQkz3UwmRfpRKDK6W2+Z5ceu6qwXfxWZMZ/g/v4kGoxowWGw39o4vrCbMyt/RVv/lReyBIq6xpkA6QU5fVuoTGIq77IeUs1acXeEfYNmVCtATaY6JWM9qaR8Ctig7UQ6XJxhgR2/Pt1CiShDVg3wf3q/L2eHrcDDVrTlNL1ctGsg8Ae+me4Da6xJTELwI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6592.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(86362001)(31696002)(66946007)(6486002)(66476007)(83380400001)(966005)(31686004)(5660300002)(66556008)(38100700002)(2906002)(41300700001)(8676002)(478600001)(26005)(316002)(6512007)(2616005)(6666004)(8936002)(36756003)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFQwSjc4Ti9nUHBnbHBFVFljQVRMUjB6NXUyNWdsN3dHRkxrd2Q1dmI1T3pL?=
 =?utf-8?B?WksxclVKNnFvUHVwb0ZhRmdKRVFma0tJVUh3bDBOcVhnaXF1MmMyN3Izd1FF?=
 =?utf-8?B?Wkk3eHRjNjJpYjBlWm9RYk5xM1lsVmg3Y0trMnRYUm91TmczMHBTTEJhWWJ6?=
 =?utf-8?B?dVFoZmhvL0R0QU1ibVBaNkxibWJWdDdHTzFGQ0hWZXVlblBGQXUyRGFBb2pS?=
 =?utf-8?B?MGhKcTBsSk53QUxmSnNRWFhkK3V5bDNoblpHc0YvRWxLL1RIbndBOVdRaDZD?=
 =?utf-8?B?a0NWYzR2QTVmamhXWnhGaVhCdTZRcUhpRlBGOExmY2FaQnlud0k5RlBzV0Jq?=
 =?utf-8?B?bW5HNHlOZkpTZklDejFhMndWcmFZWllpZWZOUHJaY2x1R29DYy9uQVJ2aWZK?=
 =?utf-8?B?S21DZUtwYy9kdjdoSmxNRitVQ3lYRm5sSkpPR1NtdzQyY1cwRFJrUUVicWM0?=
 =?utf-8?B?TVRFUThiS0FDTk5TR2pFYkpqSVlYdFBiV1FyYVhDeGxiS2gwUEpCUUJ4SnBs?=
 =?utf-8?B?eTJJUmNMdFAyZU8rbGZmTjhCV2t2TmNsd2Jjak90ZXA0Y0hWNUY5K2RkMHFN?=
 =?utf-8?B?UkRnS0tKeTdDV3B6Ymg0Rm43MVdTQ1NIanBJamlEV01JOW56UnJwSEp0MXBX?=
 =?utf-8?B?WjdLR3AxTXpDMW5OL0ZzNnQvYkcrQXpVMGo4Z08rQk5pem40clJFZ0loVGhT?=
 =?utf-8?B?Mi9sSFJPeHRBamhtbDFVV3ZtYnlycVV0MGVpenloWE1ad0tGTzI5NlF1aU1h?=
 =?utf-8?B?MWZxMWpTQkxZZTFpeVVhMFpuK0g5QjFTWDM4Qi83SkdzTmVmcXg1eHo4WW5I?=
 =?utf-8?B?T0xZSmxoSnFaSGdYZjIzUDU3eUFnK211b3lVQkM5WHY0alBSSlYrN3ZTYTB1?=
 =?utf-8?B?K041WTFaZzRhQWVqYUhoZnI1UVZVV0tyTFJRN1NHVkFreitYUnBsVFg3dVZk?=
 =?utf-8?B?YmdST0xSVWtZbTM2eW1DUzZDTFlLRFpLdzBmcjRRTFNoQ29POW0vVlM4UTRO?=
 =?utf-8?B?ZUlMUjZXZkVQOGMrdDg1NWJ0Q3pvLy9rdXA3QzEzSERWKzBCRjVSbk5mYTZI?=
 =?utf-8?B?YWhQOVdKNDRPblJTSVg0ZVZkUUVZLzQycVV4UlRjT0ZDR2h4NndFU09UN1V1?=
 =?utf-8?B?Z0xVK0EwRDFLbHhHYXZGUnFvYTloVUt4d2xycVFpRTk5Tzh5UjBFT0hJZlZj?=
 =?utf-8?B?Ui9UZlFTeU1Ncng5L2t1aEwyNVl3TEJScUl3TzVkUG83MmkreWVDTWhnZ3lS?=
 =?utf-8?B?VzgrV25TL2NPTmo1OHhIcHhoYkxjSHRaMzZXcjgwaEZQVFhWUGNpbXVZVkRD?=
 =?utf-8?B?Y3gvSzhQODBZOW8yUEhZVkRudGhKUW9NSE5CQVlwei8zMG44TWZtVE9jUWN4?=
 =?utf-8?B?Wk5iS3hPbWdyZFpoRnRoZi9BN05KZDYyb2YxckF5d0xVd3pDSG80aE5vNTFx?=
 =?utf-8?B?MFk3UlIyMmd5ZEt0RnNaZ05XWkFBWWVQeHlGZXIvOGxVeHRPUFVPNXFaNkxG?=
 =?utf-8?B?Wi8rekg2OFRYNkdieUJlYlJBTFJ1eUdxNmhHTE1uUU02bXlKNkt6NnorUjgx?=
 =?utf-8?B?eWlrRCsydjBBQlZaMkUxei9xc09DUnE3NHBkcEEyQUFoNS9GellaRzFWanRy?=
 =?utf-8?B?NzNpV3U1VnVSS2UzaHN3OEpEQW5iU1dDQXh3Q2s0UDBHZDNLOVlOWEUyc3Ew?=
 =?utf-8?B?RDE0MERnSU12QlJHYWEyN2NVZzhIUHFVN3BkRGU1T3BCSmFXd0haejBRcGZF?=
 =?utf-8?B?MHNXdHVxM2Nra1piVzF5QVp2NmJKWlhCd1FLak5Rc0kwWExQOVJjNkxRUUc5?=
 =?utf-8?B?M2w2QjZJUS9uaHBxNmdqUGU1OTZBL296T0ZldXZHazh3MlBxTUtjNDdQUnRB?=
 =?utf-8?B?U2tNWUhjdEo5WW1FbDBKRmJQNldMODJWOHJEMkNiOEVDSVBleDZUZ0NqbzJG?=
 =?utf-8?B?by9ZZGViMTZRck9OSHE2WjFZMWc3OTdXaDJ4TFRKK0FrSVAzNmY4Yzlqa1VR?=
 =?utf-8?B?Tll3VVdHNmpROWFCdHB3Zld1RHdoaTJ0bmpkR24wQURLMllnWW5icDErQU9t?=
 =?utf-8?B?dTZyZ1VCaFdPR1JvNWowZjU5VUFydVEzZlEyMjlIajY3UFpkQ0Izd1oxVXFP?=
 =?utf-8?Q?ol7mp9rWVg30hM+AFY/DevTPX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aff66e3-b192-43cd-3c48-08dbd54d9deb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6592.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 11:29:14.3949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VM5hjHKMayhc0/6Mf41jFFTzbfxlLhoNmon214bUcMOUU2VA96l9GYBXaN7tT3Vwmm83p0Snl6H6/QSLd8B0mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

You're right.
I've patched the test and pushed it Upstream (see PR link below [1]).
Please notify me if you're still having an issue after applying the patch.

On 10/24/2023 8:47 PM, Bob Pearson wrote:
> External email: Use caution opening links or attachments
>
>
> On 10/23/23 17:47, Bob Pearson wrote:
>> Edward,
>>
>> There is a test which may be new since this failure didn't happen
>> before. Modify srq tries to set max_wr to 4094 but the rxe driver
>> rounds this up to 2^n-1 or 4095. My understanding of the IBA
>> spec is that queue sizes can be set larger than requested.
>> Also this same test tries to change max_sge using the same
>> MAX_WR mask bit. There is no mention (as far as I can recall)
>> in the IBA spec of being able to change the max_sge setting.
>>
>> Is this really the correct behavior?
>>
>> Bob Pearson
>
> Just for reference
>
> 11.2.3.3 MODIFY SHARED RECEIVE QUEUE
> Description:
>   Modifies the attributes of an SRQ for the specified HCA.
>   If any of the modify attributes are invalid, none of the attributes
>   shall be modified.
>   Input Modifiers:
>     •HCA handle.
>     •SRQ handle.
>     •The SRQ attributes to modify and their new values. The SRQ at-
>     tributes that can be modified after the SRQ has been created are:
>       •The maximum number of outstanding Work Requests the
>       Consumer expects to submit to the Shared Receive Queue, if
>       resizing of the SRQ is supported by the HCA.
>
> [It does *not* include max_sge.]
>
>       •SRQ Limit. If the SRQ Limit is greater than zero, then it shall
>       be armed upon returning from this verb.
>   Output Modifiers:
>     •The actual number of outstanding Work Requests supported on
>     the Shared Receive Queue. If an error is not returned, this is
>     guaranteed to be greater than or equal to the number requested.
>     (This may require the Consumer to increase the size of the CQ.)
>
> [Unfortunately the rdma verbs API does not support returning the
> new value of max_wr. You have to call ib_query_srq to get the new
> value which does *not* have to equal the requested size.]
>
>     •Verb Results:
>     •Operation completed successfully.
>     •Insufficient resources to complete request.
>     •Invalid HCA handle.
>     •Invalid SRQ handle.
>     •SRQ is in the Error State.
>     •HCA does not support resizing SRQ.
>     •Maximum number of Work Requests requested exceeds HCA
>     capability.
>     •SRQ Limit exceeds maximum number of Work Requests al-
>     lowed on the SRQ.
>     •More outstanding entries on WQ than size specified.
>     •HCA does not support SRQ.
>
> [The test_modify_srq just seems incorrect.]

[1] https://github.com/linux-rdma/rdma-core/pull/1402

Thanks.


