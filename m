Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8ED687E3A
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 14:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjBBNDU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 08:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjBBNDR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 08:03:17 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757C610A9D
        for <linux-rdma@vger.kernel.org>; Thu,  2 Feb 2023 05:03:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlTl7gDHvAnySr1aLIhBm0fB42hS+Ie3xumuy1BR6A8zNdAwKD+CLjtgd18FixKQv/SrJhsxL27dLd+aNiUwpVpdH6joVQd4oRDrD+ccBvEIIaH7+boDolLfBoLpvfq0+P6P+Z7E64AtP1ZJp/9oU5Tb/RDRDUwLt99NBg78A9F8h1y4vmfWCkHNsD1MM5WU0bdWMx3SI63F3mwnOnAETYpyq0xV/kFJVK6wcmWvwTvzUhe2o6she8C7BG2fa23PD+BP3ucxZU8y/3UFO9YpHeH+E2fp9cbWhcFPut+3HzojQb+Tsqn8sRHEEbF8mGDH0xu1kyHRuf2ur9I6SA4RXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbMTKOoviS3auucsdkGwsMgVVi8xU2QtB2J2fWr8KNI=;
 b=QTkurKeSbesipa/D2w9ZGUJmmR8Lrwu6KWpkT5XTAj4/pjhTpQHCZBsjNQSABuQGT2gsl9GCxVJVLU0ypWkUtFWN/7is028kVBgOXnI2ceZn6Z/cDPHChXUmjv7Lpjj21jaPWKvztrHsFGhy/t58fYeL2cHW/1vfDexB+jZ0/0I/N4+0LWWIdpcLdjsA+NZjZOZHK3ZM78K3a+6QCfXWERRAAmPeD2TtnvVnWxqB1WFSVA0znAgHlAY6mTViiGUWnpmIREmO/61GfmXFr4Q+okmxxOmZ23ou3YCVs7DLNCicGf6RGd8jrWSmiVn290woSNSe3Qh64Zzb+xTYlkIxBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 BN8PR01MB5668.prod.exchangelabs.com (2603:10b6:408:ba::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.22; Thu, 2 Feb 2023 13:02:53 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::d8d6:449f:967:ccb5]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::d8d6:449f:967:ccb5%7]) with mapi id 15.20.6043.036; Thu, 2 Feb 2023
 13:02:53 +0000
Message-ID: <b91a0013-272b-8f8d-7421-43287bd63b72@talpey.com>
Date:   Thu, 2 Feb 2023 08:02:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH for-next v3] Subject: RDMA/rxe: Handle zero length rdma
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20230127210938.30051-1-rpearsonhpe@gmail.com>
 <TYCPR01MB845509B0DBC0BBCF1CC8DB73E5D19@TYCPR01MB8455.jpnprd01.prod.outlook.com>
 <24a30a4b-ab51-b24a-7976-eeefabb99619@talpey.com>
 <0cb0e3e1-de90-3267-5a84-082321a10d9d@gmail.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <0cb0e3e1-de90-3267-5a84-082321a10d9d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0004.prod.exchangelabs.com (2603:10b6:208:10c::17)
 To SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|BN8PR01MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 13373511-f890-4085-6a58-08db051dcb76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3CVZBeb3aGnCewGpKt3rKsaBoXZCWo7atX7IDF/VST1EmE4JR4w4rXhLqAGYDCGh4KXy2y1YHz2Kd+NP17vaXIhWo0dLNkCfu4YFLX58Of3q8FyiOMRma4FTZgZFeTD2iZJ+9SeGGXTo2T7Y2JBxZ2rBOVlduJjvxCxsAHEkuod/yc2Do7wkpoqX1JblnNQmecnEgesQXlJMvmxSTtkUS1nLBVizypLUKbyrmGodTspboZqG8xMb/Er86vIq8hJFQiaw72hTUFDiS/lXC+8ImRmV1bRvHmng7mrEbQEv9I9UbqEf7cHMs9BSunYey1oeBii+LH0rm+IGfL3jd+3osOcuCtRX75v4NcDfN6Y9KcGel6M2BkGPT7tXHdmgsx1T4BwLb1FhYV3Agq1/YJGgApkt635Fhqr9bFfzzH4qMgEBX9kP0zkoZKDUq6dGYrWS7eui3w6Or89dlnkcZTWWQa98/iWiG5/J1HxbZW7QAScXn3U9+L7b2I3QHxjhhrbUXy9+gMaX7KdRMf6k6/T2K0iNJ+VS1MN9CJIxjXPBputY3qwHtplbMrsvDpMKrY2AH1m3g58QI6Qffx2FSEXCpBd/Yq1nqBXe3/R/+LuOyUnpJltOlbMRyxzaKCWpmVsLCs39SEz/yNV5B0w4PwtupEq6r6NLjeuv9DW0f2sBXm8XE644rvNAw57EO/vUYgc1r3zTtjC+WXwC+5EO0KqjQWmNeLqjkTIx1DhlIC+OmSQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39830400003)(136003)(396003)(376002)(451199018)(52116002)(186003)(2616005)(6506007)(6512007)(53546011)(26005)(478600001)(31686004)(6486002)(83380400001)(8676002)(66476007)(66946007)(66556008)(110136005)(316002)(31696002)(86362001)(5660300002)(41300700001)(36756003)(8936002)(2906002)(38350700002)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djJiSnpRTExpMnFKVitIV3VtRUFKMXJNZDl5eVVZWUw3NzdPdWhiMVlaNlpO?=
 =?utf-8?B?aTJWZjlncitGclBLNEZPREV1eWtqTEM1N3R2dHdITG1WamhzN2hmTGhocGVX?=
 =?utf-8?B?THJRVExyemVaVGYrV0c2VWw0Z1ZlWVZpM0ZhMXNXWDlVQkZmeDJ3ek9TRzdH?=
 =?utf-8?B?Vmc1bGl6UVdKSy8wMTh2bUp4TmVBRVVZN0ozd3dya3MzR0c1VTVmRWlNVXR6?=
 =?utf-8?B?cXlaVkUwaGdWRzRkeUJ4aGNVLzFQcHBoU0NCT1JFdGlac3M1dkhvTFpXNEEy?=
 =?utf-8?B?TGE5KzYwKzRTUmhIMG5HdWZKVFAxMEoya25lY2xwNHBOUVdkQnhPSFZKeVNt?=
 =?utf-8?B?Nmp4RkdaOUltaWFkdVRZZ253UlpBcjdvN0dlajVKVER6L2IvSkI1R1U5SThj?=
 =?utf-8?B?bll1UmUrVDQ0MzJYY21IWnpGczc3aFJQQ1ZXRlpmZnp5UmlWK0dvbVFZVU5N?=
 =?utf-8?B?RnNqSTFWS2NRWmM5elBseW04dlFNSkw1d3dvQzliS051bm02SUJOYnRnV3FN?=
 =?utf-8?B?bkhUMFNQbzl1NlZLOWs4bnBJeXNpVlljOFdBenpTcUNOMHBNd1I2YUk1V1Bs?=
 =?utf-8?B?eTF2SFlkSzJpV1lKc1BHRWtVcHdmN3F5V1lZd0ZFVHRYYUd3MWQrQkR5Qyth?=
 =?utf-8?B?RjlNbitjcnhVZEN6VXpUSUZ4bWExaEIxbitxZGhseGRicm5NQlZKN0dKWXU3?=
 =?utf-8?B?OWxWUWY2Qld2T1VTb0R1Z2tDc1NZbXB4d0lIVzh3eFIraUt6WXFmRzQ5MnRt?=
 =?utf-8?B?QTVIYjljWng0ZGNiZ0ttWmFNQ0NPS3ppN3diUlNUM0M0TFN1cVZadTFjSm9C?=
 =?utf-8?B?czBSZkl4TGs0N3lldElHVStjMmdxZ2Zab2R0UWhPL2lvcW5hMFQ1NWh2YWd1?=
 =?utf-8?B?QnBFclN2NUhUejFSQm1ZeVkrbGVaTkVWQmo4Mm1YOUV4ZjBLUVhsMzJEVXNG?=
 =?utf-8?B?VURjT0FYTy9ZbWxaQmgzc0MrMlVybmUwNXNPdzVRL0ZFYWZNRzViWkt5ZFAx?=
 =?utf-8?B?MzFyeEliRXRTdXhWMGh2OEI3czBFeXV0OTVXR0FlQXZNeSt4SkpLcVdTV3c3?=
 =?utf-8?B?bUJSZzJzbHd5N0J5ZXFpS2VVbGxzdkhwRGNhUUNOcFRyRVFpdHJsc3dtL3Vn?=
 =?utf-8?B?SDNWYU9IeHN4UWhEYUNiTU5uM2tHUjhFdTZxRXducGM2b24vWTZ5bjFMcHVr?=
 =?utf-8?B?VlBTbGEzVWMxdSthbFBMMUo3QlU5Q3hBUklncm9ZUGdPdjRZeDh4dm9uekh2?=
 =?utf-8?B?SmFHNS9ybGpMRGwvL0VyYmEvMmh6SmpHaGc3TndKaHc2NzUySi9MYWFiYTFr?=
 =?utf-8?B?UnRnQVcwNThuKytPSndpN1J4OVdKUHFteXZZODVKRGQ3bC9pWVRhZDVSaTdL?=
 =?utf-8?B?aDIvdXdybFp0Y1dsaDhNY2l0Nnp3ejRuc1BuRUxiVDVPSXY4c2hEVHIvOGhh?=
 =?utf-8?B?WXNYSXJYQXE2Z3dnMGhOczNpZUNGTHo3THp3MFR4ZmVJazdNM283SHAzWC9C?=
 =?utf-8?B?RjRjeVE0aGg1VjdYRENaNTZSaWNHUmNuT2tmYzdTMGVuVFUyRW1xazcvaEFn?=
 =?utf-8?B?bmNwT3d6aE5DK2RHWWlaNEE3MkY5OUEzZm1CM1dHdU9zQytBQW1KaExYUjUv?=
 =?utf-8?B?UVFPT0FFb09nUVdVdDQxSnJ3QVpEclRZNTZDODRCc21iOVExdkVqRkJEY2cz?=
 =?utf-8?B?ZFpzeC8wME1IQVEybHI0Q0RQMjlPTGdlN0ExdTdjeXlxbTRQQ0tENCsybjZT?=
 =?utf-8?B?UThrbVR0MnpLUTNSdldQb0V6WFJoSW1Jc1FNNTFLR0U2ZlAyQmRSSHUwdnlP?=
 =?utf-8?B?V3M0MEpXaXUyZjg1V2w0MEx2QWtpMnU3b0FkUTNLTVFQY0RoU25BZmZCWFR2?=
 =?utf-8?B?aGlySG43U3JzeG1Ud0J0S1lwblFwd2lHVUtTc2lCVXNJYTJvb2pKblVoWWZy?=
 =?utf-8?B?aTVwUlh3VUgzRGRHdWY5M29RdndiM3Z0aUpXcmxDOXEzdlA3OTN4cFBhYVFo?=
 =?utf-8?B?MXN0RktvMXV0U2RaeThtWFExM3ZVMWtVZ3VBV2xsQmxra2o2OUI1Rlc3elhl?=
 =?utf-8?B?RVZ5WUN6eGNhU3VnaEJKTjRoaVRORDg1L1daTW9XZW81cUxXUDA2cEY2N0J3?=
 =?utf-8?Q?XTdWS3biphn1rkiLbanD0KgD6?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13373511-f890-4085-6a58-08db051dcb76
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 13:02:53.1282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KRHlQ1OqH5ZMZww30ekF2Xljl8i25OoiE4x2B9Muyf7ruJQTVLnBWBg0XMo6+/5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR01MB5668
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/1/2023 10:45 PM, Bob Pearson wrote:
> On 2/1/23 09:38, Tom Talpey wrote:
>> On 2/1/2023 6:06 AM, Daisuke Matsuda (Fujitsu) wrote:
>>> On Sat, Jan 28, 2023 6:10 AM Bob Pearson wrote:
>>>>
>>>> Currently the rxe driver does not handle all cases of zero length
>>>> rdma operations correctly. The client does not have to provide an
>>>> rkey for zero length RDMA operations so the rkey provided may be
>>>> invalid and should not be used to lookup an mr.
>>>>
>>>> This patch corrects the driver to ignore the provided rkey if the
>>>> reth length is zero and make sure to set the mr to NULL. In read_reply()
>>>> if length is zero rxe_recheck_mr() is not called. Warnings are added in
>>>> the routines in rxe_mr.c to catch NULL MRs when the length is non-zero.
>>>>
>>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>>> ---
>>>
>>> When I applied this change, a testcase in rdma-core failed as shown below:
>>> ======================================================================
>>> ERROR: test_qp_ex_rc_flush (tests.test_qpex.QpExTestCase)
>>> ----------------------------------------------------------------------
>>> Traceback (most recent call last):
>>>     File "/root/rdma-core/tests/test_qpex.py", line 258, in test_qp_ex_rc_flush
>>>       raise PyverbsError(f'Unexpected {wc_status_to_str(wcs[0].status)}')
>>> pyverbs.pyverbs_error.PyverbsError: Unexpected Remote access error
>>>
>>> ----------------------------------------------------------------------
>>>
>>> In my opinion, your change makes sense within the range of traditional
>>> RDMA operations, but conflicts with the new RDMA FLUSH operation.
>>> Responder cannot access the target MR because of invalid rkey. The
>>> root cause is written in IBA Annex A19, especially 'oA19-2'.
>>> We thus cannot set qp->resp.rkey to 0 in qp_resp_from_reth().
>>>
>>> Do you have anything to say about this? > Li Zhijian
>>>
>>> Thanks,
>>> Daisuke Matsuda
>>
>> I'm confused too, Bob can you point to the section of the spec
>> that allows the rkey to be zero? It's my understanding that
>> a zero-length RDMA Read must always check for access, even
>> though no data is actually fetched. That would not be possible
>> without an rkey.
>>
>> Tom.
>>
> Tom, Daisuke,
> 
> C9-88: For an HCA responder using Reliable Connection service, for
> each zero-length RDMA READ or WRITE request, the R_Key shall not be
> validated, even if the request includes Immediate data.

Interesting, thanks. I'm pretty certain I recall HCAs not allowing it
in the past. Also note that the iWARP protocol does not have this
exception, and always requires validation.

> Further I have seen the pyverbs test suite sending a totally bogus rkey on a zero length rdma read. That was the impetus for me looking at this.
> 
> Daisuke has a different issue since flush is a different operation than read or write.
> I need to look into what a zero length flush means.

Yes, RDMA Flush has a flag which allows flushing the entire region,
and the length is ignored in that case. oA19-13 always requires
validation of the region.

The IBTA Link Working Group may need to clarify this language.
I suspect the existing text in 9.7.4.1.5 may be correct strictly
speaking, but the RDMA Flush and RDMA Verify operations aren't
mentioned there. And the Annex A19 processing text is different.
I'll bring it up for discussion in an upcoming LWG meeting.

Thanks!
Tom.
