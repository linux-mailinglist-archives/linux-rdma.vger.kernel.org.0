Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307395269DD
	for <lists+linux-rdma@lfdr.de>; Fri, 13 May 2022 21:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383547AbiEMTI3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 15:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355664AbiEMTI3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 15:08:29 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB1934BA2
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 12:08:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iG8rZu3iD2eHVTcrBjWjatJXKkmOoqEdLj52NffsXFGXV1dQVnIJpjJmbxX7hrnlOBZHzWKrYT7j8ueEPFtl/9ubepBszThSPZ+yz4LTF3zNsUt3raNAcbV4EncdHtOB7UemdUenheIFy0MSyqiCNTImsOASlmqtMy6pul/oLK3XoJVBPFeiqHgV/n7YhNhCG0eEmAWiXmpKkNq6K2UbifIEJCR6ZExAtgUxYmxWaAHtWrI2LregiQt+Ve1UTRdny2oAm9TSeovnir/snuMifH2h7zB6zmzmxugfCGwC2r9QG18kxWVesJpVEOxjzB8wtfRlB3THmVID1OeNijUDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvpjwbkEY3EOnr2PlId5EkAU6we0axFoD82aS/Wz3Ak=;
 b=C/VKtUFdW3UJmLoRe8U2q0hAiPnBDu1BJNXR+9QX3ZfCBYPqJzy8x51s4/w7WT5YXBrdnGjpWnmDI50jobgNcSYfIIU3PUFfcDZuQy6enM7jcj4Oa4ZzSqerYt5qzu0oJYh+lpbcyP/SuZS/HiDUONPnPbHrTS3BEwBF5Tx+I4Kr2AIaCQz/f6jQSFuCiLKJChA6cthp/CQrFcM//Z4i/VPFjW/91bQYGT9TsMLE/7i0Og5BkzRZaxip1VvHDR88NCFwrpLPn3aWJ4xCqKvdbbpnYBkL5Qcs0iQujXj+0W6hSAxcH2kowl3a/7PFcdtEdvjTNUuOGqgfZ0jbOKg4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 CH0PR01MB7020.prod.exchangelabs.com (2603:10b6:610:109::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.14; Fri, 13 May 2022 19:08:25 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::d41:91cf:552e:b16b]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::d41:91cf:552e:b16b%7]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 19:08:25 +0000
Message-ID: <2bafda9e-2bb6-186d-12a1-179e8f6a2678@talpey.com>
Date:   Fri, 13 May 2022 15:08:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix rnr retry behavior
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220512194901.76696-1-rpearsonhpe@gmail.com>
 <ca817696-530e-f94f-dcfa-68f1980d31eb@talpey.com>
 <d3ac03f3-f11f-59e1-5dec-d0670b214e72@gmail.com>
 <249855a1-867e-606e-56f9-6f99a79c828d@talpey.com>
 <9e94d77b-af2c-b647-a12b-77da5c363337@gmail.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <9e94d77b-af2c-b647-a12b-77da5c363337@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:208:32b::22) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98b42b0e-21b0-48c7-7fbb-08da3513f486
X-MS-TrafficTypeDiagnostic: CH0PR01MB7020:EE_
X-Microsoft-Antispam-PRVS: <CH0PR01MB7020E2BCEE7F876E216873B7D6CA9@CH0PR01MB7020.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vdPNsp1MBH+pId1DCOfZU93LzoXoi5iLdfU3lozufp/G6suuZHF/M/D6vGQzwIje+eche+Bm6IEehNRMmttZeTOqB7Kvmr50kbozgT4PQAHow0Fb51U66yj68W07NXSe808zVOUYH0zkEBr6y4bwFnwiclRt880et31cAcGh4pn1/ME5+TrVzPRDtxFJim0CAQFjKXQbdc7wRVvcW2qn3o6dwXVxH9gPqUvHVKOVGICqO+qEd6GheawpJPcRm8DU8EgG7XDwwjL/iCNd6BlqFCGAHDl4xdmYruh5VodXdT8By8zPu4y4Ds61NcVJLzKkxMSkBruRRgGPtAEm0/4jOlTeRZezRBQFDclGxfS/rF6ew4erLw9yMfjALjyOT4xON1uld55ECNvfbRyPf4erR36KhRuzdbdJM+OUF3gvKXq+P0U0GNgcOy2GkhpoQOSAuDSU5SkprUhqPAwBC3hZ2HO4FsMKvQDXYBOc+YPjGVCNDe/uo3wzTEO1U2DIC0az5C/8BRuW/Z5iDD81TL9qBQGG2jsIdsqiAlOcZdhakJRD9E9ujbTMWq9Kf0UpyeEkZBpLRaJ40cALKt7YCsmLBIMwrcZojZuZB35ZyraKIidRq/Ujh25TSgirbS3NiWmCVkA8j1IgN6OmclMSE6h1FIsg01d05j5gqO615/In2KQS7bm/XMZsP7B49i8adnfAzISSPhU2xF0kucuPAqOumF9R+ga0ATJyhcpQq2gHIbho681p9N0tbKvmxLFS4mnytxUfvlEmMvNEGPlTB8/057GNpfVeIb/TtBckvGPwsVPjNTrmmzfLOgJY4ph+mvE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(346002)(396003)(366004)(376002)(136003)(316002)(26005)(2616005)(6512007)(66556008)(86362001)(31686004)(8676002)(36756003)(53546011)(66946007)(66476007)(6506007)(31696002)(45080400002)(83380400001)(508600001)(5660300002)(186003)(2906002)(38100700002)(8936002)(38350700002)(966005)(6486002)(6666004)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW5jdkJUaHFrREE1MlAwcUpta2NQSVVkK21lUFdwYlFtVWw1ZmtXRmxTRnl3?=
 =?utf-8?B?aVFHdjNYeGM5bVpwZGRrZWlGR1Nlb1d0dlJDL09MR0laWlV5dkVqMGV1UnJk?=
 =?utf-8?B?VUFSd2JuU1ovUUdVZjQ1bjh5WlZRTDAwR0RBd0l3V0tUcTJIK3hJVklEUnZv?=
 =?utf-8?B?azhodG5kejBYeWdUME9KTDdoUWc4YlRLdWNEb1lKYlhCeVFSNWxQeURUQWo5?=
 =?utf-8?B?Y1V1TFRXbjBsSU1pMzFNR2tXdlFpbE5JRlV0WGpkQnhDZUNrUi9yNUc4UzM1?=
 =?utf-8?B?QnhCaTNGQ3lJblFtWkJobEc0TGJ5Tk4ybW5aSms0UTFCSTlZbE5iemt2M1BI?=
 =?utf-8?B?SUx5alg0cGEzOTdKSy9LanRuMXdGNDloV2VCVUxWcmFFd2g3R0JPSjkwWnNR?=
 =?utf-8?B?Tkc3Q3RTY3lBQmtVV2RBeDBIZFhsNXdFdGZja0Z5RTBGYmhCT0o4SEVsdVNL?=
 =?utf-8?B?d2ZQQTBEcGNsb1JXTVl3YXdsZktuY2pkdkxzWFE1U2pmK1J6cy9tVzNsVUdU?=
 =?utf-8?B?MWNGMzZwQWpISGRLVXM0cFNjWlpTRmo4SWs4aW1rYm5FdHdZdDFON2QvdVhV?=
 =?utf-8?B?N1hIUVVlTjhLZFRueGpEZGJQOHdFWitmcjdyWEUvWTVIV05CdmJLMllIUmcy?=
 =?utf-8?B?TUNmYllIT2VZc2g1VlFZRmx3eTFtSVpqV0g0RG5MdFhFVTlTR0w0bUxkaXhw?=
 =?utf-8?B?TTB5VUkxdkJOVUV0RDhmOURRN0huN3BOS2JudHFrR0NUblg4eGYxQ2lCMjhU?=
 =?utf-8?B?NUhHS2JrTnRsMFVxMWJHWEZYdkcxZHBXYk1ES2NCN0pQRWxtYTJrYWhNaDZR?=
 =?utf-8?B?WmZxOHZGTGFESkFWZjduM2tING0vR1dqaGpsOVNJalBiQ3NpK2hRRTlaQTUw?=
 =?utf-8?B?ODhza2FydTVXZHNJbHhHRGhqSjRESS8rTW5Xd0dkY1J2UHQwWnJyWGpmRVhE?=
 =?utf-8?B?ZWF6REs0bnRDbjQ5L3c0YW1YbE5mNys0Z2xzUGdEaGZRNkxRakZwYmVoWXp5?=
 =?utf-8?B?cENBaE5oNm1WNHFNS050a0ZHU21KMXZFa0JHNE9mUmNpQXRhTkQva1VBdFRL?=
 =?utf-8?B?Nkk5RkxCUHlMVGhCbDFvellhd0RXOXVNZjlleFlVaVVDbUZoNjVRZFMzRWdx?=
 =?utf-8?B?YWtFUXJEb3ZjczY1Y01wamNrT2p5bk5SMEVqZWpqVG9CY2E5WFlUbFdTQUdq?=
 =?utf-8?B?UVBBTkJxWWNnd1VmVmVSUDNzSldDbGhkQ2NiV2xpOTJUanRkTk5GVEI3VHBV?=
 =?utf-8?B?UERDTUN2RTlUVk9wOS8rTmt4QVVVR2RJZHV0Q2hEL0FDaGRPZnRWQ2JBbk1B?=
 =?utf-8?B?VisrdUpybmxlQVNNTFVZeFYraEdadjdnZkk1Rm93Sy9ISkJoejJCNlZxc1c2?=
 =?utf-8?B?OVp3WU9lZkhZNkNiS3hIaWdCalU2ZWRORjRLY1QwVEUwcUl3OXdCYk91V3Ju?=
 =?utf-8?B?UWp2YjZLMzlGbXBiNFloQ0UyVmorT1NDSDhNYjVmRmFPMFEyZ01KNkJvUzly?=
 =?utf-8?B?dEhiVFI4aGNRZzR6dVdNWmcvekVhU3BiaFZubmNEaEM1NkhCQlpwNnEwczB4?=
 =?utf-8?B?c2xrdmJsVUVOaXFuV3ZwOHRNR245UnNxWUtUS1RNWVlheStFWUR5VFpTNVBR?=
 =?utf-8?B?L2FCTGh5UDFxWjRzK09pVHViS0RkcmNxekR1VVdMSmxkN1oxakhySGNqOEdp?=
 =?utf-8?B?TE5ZRFBkdHMxaURRNkM4M1MyVlk2ZGF1RmFxTk4ybjNWYmg4djZxK0lyYXBX?=
 =?utf-8?B?RnBpOWE1NkFxOFF0VUk2WkloK0d4REF4Mi9NS0lrTk0xbTlkSEU3czVxZ0tB?=
 =?utf-8?B?cEk3dkV6NktYeFJhOWJtcFY4ZVBhN1VWaE12VTE4Qk9UNWg2RUZ4UlBzRzFy?=
 =?utf-8?B?Nm45Rm1PUER4YWppS3pNTnZUT3JWb2hLTUdUaHM1TThoU1d5ZXI2NWoydGFN?=
 =?utf-8?B?Qy9tTmVIQitxL2ZTd2dGbHo1a0paNlVFSlgybmVKZnVwdFpCcVB4V3U4eVk5?=
 =?utf-8?B?M1ZGKzVaRzlDOHhaRzJlbEZHUk1oRldpYVZFU2ZmVVFsTHFNaGpvcVY3NDNV?=
 =?utf-8?B?WHV1a2FpTUdteHYrZXRNSlBFRDFhSHNVczlSRXYrTm1yYWlURVB4eFBhdFN0?=
 =?utf-8?B?RFF0ZkUvaVpKc004V2R1czRpVXp2dU9sbE1HMk8rOHA0aVloNjBSeDZrV2pJ?=
 =?utf-8?B?cDdTN084NDByUWNZNFVwUVpNZENaS3MzZktWbFZWWDhsUEJRblJnazRMV255?=
 =?utf-8?B?Tjl2dENTaGJSRUVpVEJTcmg2UlBpYjZ2MHpRSldNVGVWK0tYKzdTN25oNlpH?=
 =?utf-8?Q?Ei1zgQacq71tqUPUkG?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b42b0e-21b0-48c7-7fbb-08da3513f486
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 19:08:25.0546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6JmIt5AgvDxLzyAaZobuiMVRGRWVXvK5JAaerO7hGhHZNhIUfKLAni5HWE2d2cn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7020
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/13/2022 2:32 PM, Bob Pearson wrote:
> On 5/13/22 12:43, Tom Talpey wrote:
>> On 5/13/2022 11:33 AM, Bob Pearson wrote:
>>> On 5/13/22 08:04, Tom Talpey wrote:
>>>>
>>>> On 5/12/2022 3:49 PM, Bob Pearson wrote:
>>>>> Currently the completer tasklet when it sets the retransmit timer or the
>>>>> nak timer sets the same flag (qp->req.need_retry) so that if either
>>>>> timer fires it will attempt to perform a retry flow on the send queue.
>>>>> This has the effect of responding to an RNR NAK at the first retransmit
>>>>> timer event which does not allow for the requested rnr timeout.
>>>>>
>>>>> This patch adds a new flag (qp->req.need_rnr_timeout) which, if set,
>>>>> prevents a retry flow until the rnr nak timer fires.
>>>>
>>>> The new name is a little confusing, nobody "needs" an RNR timeout. :)
>>>> But it seems really odd (and maybe fragile) to have two flags. To me,
>>>> setting need_retry to "-1", or anything but 0 or 1, would be better.
>>>> After all, if the RNR NAK timer goes off, the code will generally retry, right? So it seems more logical to merge these.
>>> I am trying to cleanup pyverbs runs which sometimes fail with rnr retry errors.
>>> In this specific case the rnr timeout value is set a lot longer than the retry timeout.
>>
>> Interesting. I was not aware that was possible, and I'm skeptical.
>> But perhaps that's another matter.
> 
> It would make sense. The retry timer handles NIC to NIC failures which are fast.
> Basically a network transit time or two. RNR recovery requires software to intervene
> and post a recv WR.
>   
>>
>>> As discussed earlier the retry timer is never cleared so it continuously fires at about
>>> 40 times a second. The failing test is intentionally setting up a situation where the
>>> receiver is not ready and then it is. The retry timeout usually acts as though it
>>> were the rnr retry and 'fixes' the problem and the test passes. Since the retry timer
>>> is just randomly firing it sometimes happens too soon and the receiver isn't ready yet
>>> which leads to the failed test.
>>>
>>> Logic says that if you receive an rnr nak the target is waiting for that specific send
>>> packet to be resent and no other so we shouldn't be responding to a spurious retry
>>> timeout.
>>>
>>> You are correct that the retry sequence can be shared but it shouldn't start until the
>>> rnr timer has fired once an rnr nak is seen. This patch does exactly that by blocking
>>> the retry sequence until the rnr timer fires.
>>>
>>> If you don't like 'need_rnr_timeout' perhaps you would accept 'wait_rnr_timeout' instead.
>>> Overloading need_retry is less clear IMHO. You don't need the retry until the rnr timer
>>> has fired then you do. If you really want to just use one variable we are basically
>>> implementing a state machine with 3 states and it should get an enum to define the states.
>>
>> I guess I do prefer the latter enum approach. To elaborate on what I
>> meant by fragile, it appears that with the two-field approach, only
>> three states are valid. It can never be the case that both are set,
>> yet here is your hunk in rxe_requester:
>>
>>    if (unlikely(qp->req.need_retry && !qp->req.need_rnr_timeout)) {
>>
>> The part after the && will always evaluate to true, right? The code
>> clears need_rnr_timeout wherever it sets need_retry. So this is testing
>> for an impossible case.
> 
> Wrong. In the RNR path things are as you say but if the retry timer fires,
> independently of receiving an RNR NAK, need_retry is set and need_rnr_timeout
> may or may not be true. If we did receive an RNR NAK then we should ignore
> the state of the retry timer until the rnr timer goes off.

Ok, you're correct that it's possible that need_retry may be determined,
and at just that moment before the retry happens, an RNR NAK arrives and
starts the second timer. These fields aren't protected by locks so it
all seems super-racy. But anyway...

This really screams for clarity in the code, and again, I'll suggest
that the new field name is confusing.

Another name suggestion might be "need_retry_after_delay", which rhymes
with the existing "need_retry".

Tom.

> Bob
>>
>> That said, if you don't agree, the name needs to be less confusing.
>> I guess I'd suggest "rnr_timer_running".
>>
>>> Once this issue is resolved I will fix the spurious retries to make them a lot less likely.
>>
>> Excellent. RoCE suffers from congestion enough without pouring
>> gasoline on the fire.
>>
>> Tom.
>>
>>>>
>>>>> This patch fixes rnr retry errors which can be observed by running the
>>>>> pyverbs test suite 50-100X. With this patch applied they do not occur.
>>>>>
>>>>> Link: https://lore.kernel.org/linux-rdma/a8287823-1408-4273-bc22-99a0678db640@gmail.com/
>>>>> Fixes: 8700e3e7c485 ("Soft RoCE (RXE) - The software RoCE driver")
>>>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>>>> ---
>>>>>     drivers/infiniband/sw/rxe/rxe_comp.c  | 4 +---
>>>>>     drivers/infiniband/sw/rxe/rxe_qp.c    | 1 +
>>>>>     drivers/infiniband/sw/rxe/rxe_req.c   | 6 ++++--
>>>>>     drivers/infiniband/sw/rxe/rxe_verbs.h | 1 +
>>>>>     4 files changed, 7 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
>>>>> index 138b3e7d3a5f..bc668cb211b1 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
>>>>> @@ -733,9 +733,7 @@ int rxe_completer(void *arg)
>>>>>                     if (qp->comp.rnr_retry != 7)
>>>>>                         qp->comp.rnr_retry--;
>>>>>     -                qp->req.need_retry = 1;
>>>>> -                pr_debug("qp#%d set rnr nak timer\n",
>>>>> -                     qp_num(qp));
>>>>> +                qp->req.need_rnr_timeout = 1;
>>>>
>>>> Suggest req.need_rnr_retry = -1  (and keep the useful pr_debug!)
>>>>
>>>>>                     mod_timer(&qp->rnr_nak_timer,
>>>>>                           jiffies + rnrnak_jiffies(aeth_syn(pkt)
>>>>>                             & ~AETH_TYPE_MASK));
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>>>>> index 62acf890af6c..1c962468714e 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>>>>> @@ -513,6 +513,7 @@ static void rxe_qp_reset(struct rxe_qp *qp)
>>>>>         atomic_set(&qp->ssn, 0);
>>>>>         qp->req.opcode = -1;
>>>>>         qp->req.need_retry = 0;
>>>>> +    qp->req.need_rnr_timeout = 0;
>>>>>         qp->req.noack_pkts = 0;
>>>>>         qp->resp.msn = 0;
>>>>>         qp->resp.opcode = -1;
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
>>>>> index ae5fbc79dd5c..770ae4279f73 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_req.c
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
>>>>> @@ -103,7 +103,8 @@ void rnr_nak_timer(struct timer_list *t)
>>>>>     {
>>>>>         struct rxe_qp *qp = from_timer(qp, t, rnr_nak_timer);
>>>>>     -    pr_debug("qp#%d rnr nak timer fired\n", qp_num(qp));
>>>>> +    qp->req.need_retry = 1;
>>>>> +    qp->req.need_rnr_timeout = 0;
>>>>
>>>> Simply setting need_retry = 1 would suffice, if suggestion accepted.
>>>>
>>>>>         rxe_run_task(&qp->req.task, 1);
>>>>>     }
>>>>>     @@ -624,10 +625,11 @@ int rxe_requester(void *arg)
>>>>>             qp->req.need_rd_atomic = 0;
>>>>>             qp->req.wait_psn = 0;
>>>>>             qp->req.need_retry = 0;
>>>>> +        qp->req.need_rnr_timeout = 0;
>>>>>             goto exit;
>>>>>         }
>>>>>     -    if (unlikely(qp->req.need_retry)) {
>>>>> +    if (unlikely(qp->req.need_retry && !qp->req.need_rnr_timeout)) {
>>>>
>>>> This would become (unlikely (qp->req.rnr_retry > 0)) ...
>>>>
>>>>>             req_retry(qp);
>>>>>             qp->req.need_retry = 0;
>>>>>         }
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>>> index e7eff1ca75e9..ab3186478c3f 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>>> @@ -123,6 +123,7 @@ struct rxe_req_info {
>>>>>         int            need_rd_atomic;
>>>>>         int            wait_psn;
>>>>>         int            need_retry;
>>>>> +    int            need_rnr_timeout;
>>>>
>>>> Drop
>>>>
>>>>>         int            noack_pkts;
>>>>>         struct rxe_task        task;
>>>>>     };
>>>>>
>>>>> base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
>>>>
>>>>
>>>> Tom.
>>>
>>>
> 
> 
