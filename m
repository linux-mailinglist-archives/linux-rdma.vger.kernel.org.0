Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4544578486
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 15:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbiGRN45 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 09:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiGRN44 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 09:56:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CD927CE1;
        Mon, 18 Jul 2022 06:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7Kyh/zewmud2KO8wUekLRoqxEks9TpT38OYjGHc2OEtNMOIF0VbOBHWVMg/ckb5GmHGkfXGEXHkU0W5DvZLalhoNDcqh2hYaGsmnZ38aZBH3xG1BaHWIOc4z//R20MIsOfB7UMSgXFLUAlkzgkqoPPqfMAS8jh+ND1mo5+pfL1gA0sKdrArr+Fb69iyQ9RgkjfaW0EMm68RyrfBgZUGBe7vbEaWJBb4zwXcm6ENIHo4BiIBbXHliLqGdZ8Ga84SPbaFckmO6SXJPp19OrA6l0M0y4/sClpAZ1nWsgg6MKcIBiKUnH65Jf8YIwhf9uj2tHn3dLC/xWv+CWZ/S3bUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgVl+nmPogjaddr8F3uwXa7+aFkiDl8+Cvema/RSMoc=;
 b=kN3qN9Ckfzx887gOC5Y4lBA0asXpq86mag+cfZxBioWG8ce1i2hqgjorUcGbXVuNAEPwQBoBkuPjAuvYlU/SIrzB7ycdctfRbq3wn0D3hNRJNJg62sGw3DCAXHF0tHfd+vyHpgbEoKJEqWU9DVPVM8mVzL/23OuqXQrzd0pznz4CteQ/HJ21X24A98ACrzqlNP4b/OUOGILgJ6/sqyfmQe3iDo1MjdM113HdxLBBInKMEjB9EKSbviyPmzXi3j8Ok6gWvP0nKupbbB4d8a9T/tmY4AEZ8TGUnUWQvK9Dfj05PwS+gAWOxZgsRvQcFQvguzPksaFkrRoqZyfnok8g+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgVl+nmPogjaddr8F3uwXa7+aFkiDl8+Cvema/RSMoc=;
 b=dOqCQwWcsf0CKYGaftnpxzN32n4eM1h5ecAfBy54JZZI2Rq/KdXyp2YpGMxjaUjJZIWomVzv484f4CJHSf/viLCJjBWscSiF9K6MH8YPxHWB+3D/f0htH/xkERv/hKKg1Qo3RtTtKvfIrQ6PCt47SlUTKEg1Cq25GyxmjHs9gWP89Hof0XTsgzmxeNhQ5erMO6SpJv5HC6jCIofTDPs4bYNs4hrdQ+pgVH6JZg+ds76aOzNk8VQFtYOh2WSt8Lwz3yjZTSGLYPSXTsiSm/nbqE7gSMASYnLHVuMHi2Ee0DXW5L9e4wfm+51w254pk1AsbEHd+pUM7QxcjTivbeVTuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 DM6PR01MB3772.prod.exchangelabs.com (2603:10b6:5:8f::11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.22; Mon, 18 Jul 2022 13:56:51 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4000:7ba9:d4a:c339]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4000:7ba9:d4a:c339%7]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 13:56:51 +0000
Message-ID: <62c8d684-6587-e560-6029-18fbe76ad8c4@cornelisnetworks.com>
Date:   Mon, 18 Jul 2022 09:56:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/hfi1: fix potential memory leak in setup_base_ctxt()
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jianglei Nie <niejianglei2021@163.com>, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220711070718.2318320-1-niejianglei2021@163.com>
 <1038e814-5f0d-17a3-1331-8ed24a64d597@cornelisnetworks.com>
 <YtU4eXQCVEPGnh9b@unreal>
 <be437471-0080-8e9c-978a-6029c7826335@cornelisnetworks.com>
 <YtVSc7aazgxVFHRa@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <YtVSc7aazgxVFHRa@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::24) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ea14b4b-5ea4-4845-dbfa-08da68c55d70
X-MS-TrafficTypeDiagnostic: DM6PR01MB3772:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVdmXW8Tt9yT6kE4OUN7D9skI8+sepxM76x+u6enKUeVcIpZITTpITnrheC7tW65LijPgAVklMCwTtqw9qN7sQtY9lM2rbecstBzhsSWfO+lU9devGifUViwPqaIhR2WAZ7jn/CSl/I8FDqz1fagjpfAnX04I1dnQ3Tuot2OsTH0Pnrrztf74GN3wM5ThtkHexN4MsZYiDrgkavFOc9sspPM0oLB6TAL9si67jhyIWVwWfRxSnx8sv0/eEnJGRylXcznmqqtXLUPL5P1JlkdGn7wfm+ZDCsrd2VoVGHL1t6YHE7f5opoPF+kw5EkXfHZAh9+stiuGV7mCZRG3WFRKyd7n+ytZmokXaqLM7ytpGH+0pk45YJ8LbCReJSRECVqxwPxaSkqwVVETb39D1w135uzWz1jWM62OIWa9GCuNfBGgb1DfbKMDndC0RWFu7cSacBjABrvnmB5Wv8IvCKz5Kf4778obqWxnlLfcotRn4Gy7uNuh3DSSkQ0imrMP5UNDDUY+jc3TVJ3nCpJIKG08fGgwN1H4P5owkW9z3dlsw5ePoZM+w/OX/BpOnGbNDCU91tTsUQlQxD+pMxlfWEltxL00PM0QLX/OANUf5sLPKdwT380oO4ZC1tvePBf+LbPOpUgrFWkNUcbKR38DLRtfsVawYr38QiROQlePHiB8PwQ5DWi+uyy1kOoi/vYdVgOL0lzc6VkLICpQ4tbCCz9U0n8w7+DhhRJB8ZbeJICVdQbjz9ArFZLVm2xNzCUV3NoIKH670ReMMVkuUDesY1lxJz8GogAO/nHgaBgbgtHwIB85O9ZAbLxqgyj49XEFp7PHLjw2UKiitZmudFziu+lgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39830400003)(396003)(366004)(31686004)(36756003)(6916009)(316002)(83380400001)(186003)(38350700002)(38100700002)(5660300002)(6666004)(2616005)(4326008)(2906002)(66556008)(66476007)(41300700001)(66946007)(8676002)(26005)(6512007)(86362001)(6506007)(6486002)(53546011)(52116002)(31696002)(478600001)(8936002)(44832011)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S01tOVptcDNOMXJybHA1OFgyQk9EVEFmTURtaVlHVzJuV3hLa29Ra1l0aU1E?=
 =?utf-8?B?cnlwVGQ2Vk5ydVNXdmI5bWI5bWhmZ2VwbnQ4bkMzbU9Sd3AzUDhMUWtsNTd6?=
 =?utf-8?B?ekVTRlFYQWErMkpLUWRLa1RlUk5hZWRWc0U0WitIUXV6ZlhOUDZ0N0NUalZK?=
 =?utf-8?B?RUtkSU1VbzUzZzJCelJkZXk1c3pvMEhhSUt1Z1Ywak5Ub3NiZThoM0FBbXdJ?=
 =?utf-8?B?WHBJU0lMam5wTFlEaytpOTM0MHd0TlFLU0g1UU5KNUlRb3ZkZlhnTE9xR29N?=
 =?utf-8?B?OGFXc0hyVHlLdldnUTN2dExFR1czMUxnam5wVWhrd285Nm1qZHRsNnlzWFVu?=
 =?utf-8?B?bm4zQ0w0VHVaRER1TWE0QzMyeEtCV3BFcVp5RVczeXNObnNDd2h2L1VQcjhY?=
 =?utf-8?B?NGZDeTFxeUk2WnZLREEzcGNVN2VFQkRrcFVwNERtRkdYd3hsYmN2ZEZZVDdn?=
 =?utf-8?B?bElQMm9GSDdjVmJFTXE4WmFrSk1wWElNK05GeGllN3gwSUxDZmpzbTlZZklH?=
 =?utf-8?B?YlV2RnJDUTZuaTFheWpDOWcwemFiQUtEU2d0emtaZmxOSE9lUjlNeGRPamdL?=
 =?utf-8?B?TVAxcHU5U0w5Qzg1UzR4VThHS1MrSks2OUpDT1VTQnNQeUtZWGZBMldlcVlk?=
 =?utf-8?B?SnZlL1QwYWNMSjJRaFI3WmxBWEkzM3A1cDZ3Z29idE0zb2NsWHBaWmNWMlgw?=
 =?utf-8?B?QjRZVHc1Y3l5aWdPcDJDTFY4SUxMZXlzUFBvSWZ6V0NsRFR3QzlBTlVEeVNB?=
 =?utf-8?B?T0ZCckczN0ZyaHpZdVUzQ0JHdXUxT2FNdERJQXBveGpiZVBvMFNSRHF0aVBp?=
 =?utf-8?B?dHdtOWFMdDdpTUgrdzVYR0IzZjRrL05KeVZNazNlZlo4WUg5ckkvQ1pYSjVk?=
 =?utf-8?B?amlZL0MzSU1DSkpDSG1EL2p3dlhvWVMzU3lxeFFzRGw2d0pFWmhBSnNZSVBH?=
 =?utf-8?B?d2xocWRKeU9WNFJDRUQ4VzZhRlNSTlEvUUV2K3hyM1AxWWVOVUhUVEhOanNF?=
 =?utf-8?B?Ynh1Nnp0MGdqWFVMN2hYR3lXVUJLRmJ5Q25zdzBPMDg0b01tYmZiTEZia0lq?=
 =?utf-8?B?RDlmU2lBaXJCZnlEdE9iNjIyd0RFU2h3UHl0dGszVGUvVEZNbmtEOWx6OHVq?=
 =?utf-8?B?R0NuZlZPZFNYV0tWdytOVnhRZ3d2clJxNmZVWW5xOGUvOThxYy84RW5wOThz?=
 =?utf-8?B?eXNLd1BRcE05ZU9CSWNjamR5dGp3TWI4UDlVclhxTlBJb3lhL2V3MVBKZS9P?=
 =?utf-8?B?bWpCdXZFQ0xLVVU0WnVlaTdnM0pEQkpydnhiejZKMWNwZjlaMzhZVGFsK0ta?=
 =?utf-8?B?U3FSUnNLQ21aMS92ejlsM1NZeXRiQmRzZmVKUVdUaFE3YWtvMDVDaFVmRkRD?=
 =?utf-8?B?Z29SL3Bva2V1WlhXVFNmdmk3QzhpRnExbDNLanE5S3ROeGhLc0EreHFPY3RR?=
 =?utf-8?B?REZpNzFSdHM2b3FYWkFObFZsODRvbWNtYitlZTdGVUoveWVRYWJQV1RFYXh5?=
 =?utf-8?B?ZHZIL2lZZE9pNjN4bWJRVmpGMnUzcERLSFR4QS9vTGpxUW9NZHZmYS9EeGky?=
 =?utf-8?B?bHRyQlJGRHFJQnFYSzMyQmlQTTZHZWVSazI3emxkUDhxOEYwSVEvaDdvY2VH?=
 =?utf-8?B?NGVVeU1RTE1YTnFFVkwwVHVSNmgzNitmZCsrRFMvMEs5TGlKYndYWHZ1eGdt?=
 =?utf-8?B?NUxwMmRjaGJkUEVsWC8wRlkwWlBXTGxnTXhQbitLanV3d1hXOWJmRC9peW9L?=
 =?utf-8?B?cGNaQk9tc1NJQk4vNGx3VW9jUTR1dEpxT28rSEgwWE1mcUU0OHdzazNPeXBB?=
 =?utf-8?B?cmxQc0h0UnFyeUc0Q1hwd0xNdmZrRXZWT2lPQmFnZ0Rrb1lXSHpZNGZSM2hx?=
 =?utf-8?B?K1IzUkhpcWdpekYyOUJPNlljVGQ2S3BQSzlEeDJ0S3FtMHdDbWtnTTNSQ0dR?=
 =?utf-8?B?ZmlYb1B6K1hNWEM0dVZwQjIrZ0NDQ3M0anh6c0Nyc1pwUlErQW1IbTlOUjBD?=
 =?utf-8?B?ZTdGd3hzR0dJQXJBUkg4aVk2ajFDbmc4aGV2OTlFNDNJdDRJbkM1UU1paXJ2?=
 =?utf-8?B?WktpTXd6M0ljV3RGaFlTcTg2Qmd2ei9teGpaRXJjL1VsKzdaMGhBSUoxWWls?=
 =?utf-8?B?KzloVDRwOGQwZzNTVHRSZ1AyQjdmS0NPOW1jNDVvdFZRMGZaUUh1TzZ6T1Ba?=
 =?utf-8?Q?zWppw0G9j5vagTHpVxZidhM=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea14b4b-5ea4-4845-dbfa-08da68c55d70
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 13:56:51.3432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QG05yxeLMcviL/i7V8lSse+HzL5AcOMNrJ3tiBCWJ1PiDVvapOCzY0G0zVPueSTopqpXvjnUqHTyv2KqjW/mzZP33dO+q/lC8gx+ACwulPuusCmEyKpvTzqY/vrKX03Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB3772
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/18/22 8:30 AM, Leon Romanovsky wrote:
> On Mon, Jul 18, 2022 at 08:11:59AM -0400, Dennis Dalessandro wrote:
>> On 7/18/22 6:39 AM, Leon Romanovsky wrote:
>>> On Mon, Jul 11, 2022 at 07:52:25AM -0400, Dennis Dalessandro wrote:
>>>> On 7/11/22 3:07 AM, Jianglei Nie wrote:
>>>>> setup_base_ctxt() allocates a memory chunk for uctxt->groups with
>>>>> hfi1_alloc_ctxt_rcv_groups(). When init_user_ctxt() fails, uctxt->groups
>>>>> is not released, which will lead to a memory leak.
>>>>>
>>>>> We should release the uctxt->groups with hfi1_free_ctxt_rcv_groups()
>>>>> when init_user_ctxt() fails.
>>>>>
>>>>> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
>>>>> ---
>>>>>  drivers/infiniband/hw/hfi1/file_ops.c | 4 +++-
>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
>>>>> index 2e4cf2b11653..629beff053ad 100644
>>>>> --- a/drivers/infiniband/hw/hfi1/file_ops.c
>>>>> +++ b/drivers/infiniband/hw/hfi1/file_ops.c
>>>>> @@ -1179,8 +1179,10 @@ static int setup_base_ctxt(struct hfi1_filedata *fd,
>>>>>  		goto done;
>>>>>  
>>>>>  	ret = init_user_ctxt(fd, uctxt);
>>>>> -	if (ret)
>>>>> +	if (ret) {
>>>>> +		hfi1_free_ctxt_rcv_groups(uctxt);
>>>>>  		goto done;
>>>>> +	}
>>>>>  
>>>>>  	user_init(uctxt);
>>>>>  
>>>>
>>>> Doesn't seem like this patch is correct. The free is done when the file is
>>>> closed, along with other clean up stuff. See hfi1_file_close().
>>>
>>> Can setup_base_ctxt() be called twice for same uctxt?
>>> You are allocating rcd->groups and not releasing.
>>
>> The first thing assign_ctxt() does is a check of the fd->uctxt and it bails with
>> -EINVAL. So effectively only once.
> 
> I'm slightly confused. How will you release rcd->groups?
> 
> assign_ctxt()
>  -> setup_base_ctxt()
>    -> hfi1_alloc_ctxt_rcv_groups()
>       ,,,
>       rcd->groups = kzalloc...
>       ...
>    -> init_user_ctxt() <-- fails and leaves fd->uctx == NULL
> 
> 
> ...
> hfi1_file_close()
>   struct hfi1_ctxtdata *uctxt = fdata->uctxt;
>   ...
>   if (!uctxt)             <-- This is our case
>      goto done; 
>   ...
> 
> done:
>   if (refcount_dec_and_test(&dd->user_refcount))
>      complete(&dd->user_comp);
> 
>   cleanup_srcu_struct(&fdata->pq_srcu);
>   kfree(fdata);
>   return 0;
> 

Looks like this may have been broken with:

e87473bc1b6c ("IB/hfi1: Only set fd pointer when base context is completely
initialized")

The question is does it make more sense to just move the fd->uctxt assignment
up, or call the free directly. I think that might be opening a bigger can of
worms though, as this was part of a larger patch set. Maybe it is best after all
to go with this patch.

Let's add the above as a fixes line and tack on:

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

It's been like this since 4.14, so no rush to get it in for the ultra late RC.
I'll get it tested as part of the next cycle.

-Denny
