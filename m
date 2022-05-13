Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4B55268AD
	for <lists+linux-rdma@lfdr.de>; Fri, 13 May 2022 19:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353043AbiEMRne (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 13:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349689AbiEMRnd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 13:43:33 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712506160F
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 10:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSsV+5T3ushlBeEgO2sYjZiMXCMhK9Txb8Svev6hnx53Iu3hKpJj/OdiF9gY2PjdgEUUehEMKEnNsq7g0StVFwtaxvRXig+eznq04YOERIhbmKliqevZtDJz5/3LStOzVrlAorgyk8Ro6YlHMgnglXNt5sQDBRVFj4vt0nbH6Dn41LPz8b+Kprq1GQGL8GpDBst4RPfNZs2ilRiKzjJBOOJOfSthhasY4WNOutvYdtT7X511G04/WT4Sa+Io06tZqF7eCgYpzPW4z+NvFWru4xTf6z4B8x7L3JLkPMv2zeRp34VNh0UCm7NkAv4CTQmWCXwhrPSEdQk/4xKaD+dydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67/Q0oNI0fxIg0Bzap4sbNcb8mLXKVm57sSiT/IPoBI=;
 b=TaHst81iF55wopWc01MEmhd7h9w5MHvEaYVbUzYiP0mlZj/D9qoY8dWeDFUl2Z89s6BHZCzJEAUbfwKcmg4IfDaID/4DZ3cx8jOLrJZedObk4lKdCz48dpuoiScz2mvn49ZVXJB1+MW/XIBcm3eO3j5yPWJksRPjlYwsJn00N6N0wdTnDOwttaFMf5zIIE4xlgVm10RJS1mR5jVp7ZVjx1Ed7QShE7DgHSP0geEX/X+erCgA706pI14p3/2aDZDza+fqHqk0Wx5vde5s10mzhEYRSCfvAiQziwjUt+yXBq/TpyZE4FwjQXXqiVlOIPIkZcd2lRoKXaTupzOX1mGvDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 BYAPR01MB5015.prod.exchangelabs.com (2603:10b6:a03:7b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.23; Fri, 13 May 2022 17:43:27 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::d41:91cf:552e:b16b]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::d41:91cf:552e:b16b%7]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 17:43:26 +0000
Message-ID: <249855a1-867e-606e-56f9-6f99a79c828d@talpey.com>
Date:   Fri, 13 May 2022 13:43:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix rnr retry behavior
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220512194901.76696-1-rpearsonhpe@gmail.com>
 <ca817696-530e-f94f-dcfa-68f1980d31eb@talpey.com>
 <d3ac03f3-f11f-59e1-5dec-d0670b214e72@gmail.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <d3ac03f3-f11f-59e1-5dec-d0670b214e72@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAP220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::27) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f80b50d5-0770-4f9a-6fdd-08da3508156d
X-MS-TrafficTypeDiagnostic: BYAPR01MB5015:EE_
X-Microsoft-Antispam-PRVS: <BYAPR01MB5015A9C68B4758380DC887CAD6CA9@BYAPR01MB5015.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cdQPP5mE0l92aBR+MO1QliHH8/GzwmjAbMbQBYO5rvKXIcHoK46Z8aqEeTkj/bdx40vnToQJOjzNfTIJ96DSeGPlZW9c9CrnAs9D7ce+b/r581TXHczre1UQF81f9GRb0iVMPVemALq3iQKfoluxnFaRGpPDUt6pt7kAq8WijmunEVVKJs8cUNj3uZ3RCgmUniNIF8Xkj9vOxM28MX+/uabC4OmJpiKNDR0GuoefSbKKJren4XhsBLcUSzajkFHjfczBi1Rqr0JNcm1QrpNZh27GJ7NXiiNpFGn+ACr0ZlLNWdU/a/JhK1CE62hvCnRC+59BcRIlJ34biSB6J7vLA7SsrAaI1P/xcB0E4CeJ3Ksuoe4Plmb4lGD2hy7N0pLh9C7g162fKtzKIgBI06mgizcVJQl5AERJzcQMnS/Mjb7i7A4nbszXHhv8+dItfeUPMKiKw5fdIAW31FPnfoyotrD4uVcfbgnncqYHroK4Rd0tPeU3WTZuH9ogiBofc1YeocStqemA1ej6L5ifFi8pFZ7zMGPKTAr6es6s1aNg5OnXt2SmVsQ5B4OOVYuGCIa8R7wMpTyZiowT+yS6M+t2wbgZBQ9EosXMzvlloIfjYUfQ+LB/2Z/XLRTqRonCGE3JLIW3//kxO3NK7Lmh7fdMwvLzjITKxfnRHe06wlxOdhwmnP2DKLXD5Sv8MB2/IU3izu3r+d5hHn7CHaRBpXA9muAnzsGE606eyInXplDQpYzpToMeDdXw+kWDXcjqRgWrAvRaPT3W/3PALAOLs9CSLRtf8cA2OWqVYWtcONzfzgu+obA0QHb4ehRGYBgcetBd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(396003)(376002)(136003)(366004)(346002)(38100700002)(45080400002)(38350700002)(36756003)(508600001)(31686004)(8936002)(8676002)(66476007)(66946007)(66556008)(6666004)(83380400001)(2906002)(6512007)(26005)(316002)(966005)(6486002)(2616005)(86362001)(6506007)(53546011)(31696002)(186003)(52116002)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T083Y09weDdVR2ZkejVrWmUyNzBudU1uL2tZdktYeVZITks2a3VoYlIyY0JZ?=
 =?utf-8?B?MDJxc2svTlF2aXVYSzFrQXdVYW5kdTliQ0NlbjdyZlFzc05YQkRoRjdSK0FE?=
 =?utf-8?B?Q2NCVEFHQTBXWWVabXByQlRMM0dUQWNNdFZ1dnNwSFpWajVoY2JNME45d0No?=
 =?utf-8?B?LzJGdm5uc2lic2w1VTJsb1FIc0dvS1NMV004WWVscjlMUUpXK0N3S1BVb2NL?=
 =?utf-8?B?RGtpSXZuUEx5QjRpZno0YmFxSkpkdzNGTlpnc2pSNnJUemVOa0EvaHJYakMr?=
 =?utf-8?B?R2w5VHpZa0xodElxRUNyR05vcHYya096YlUxWnVkSHF3UVVxcFVnaXlJdGhr?=
 =?utf-8?B?WFpyelJtZzl5cTlBY0hWQlhKNFdabVlWTllIL0F6Zlp6LzZGbk9VQWlmYkN2?=
 =?utf-8?B?VjJPb0pwYWJoVm9tNDA1SVlZVE9RVElNMjRFMS9Ddmc1OHVjTmtVM1FMQ1Rl?=
 =?utf-8?B?aUpWMTBsWnF6L0t6UTFoSlZpcjFsNDFRM1RTMDhrMEFoczg4Ukl6YXF0cUlY?=
 =?utf-8?B?L3BnK2MyS1lJc0ZkKzZjSkpEYXRLSWVmZzhab2lQNUFlRTZRdGQ2bDh4S0g2?=
 =?utf-8?B?WW5UTHF4UUZCalNBcmg5RkFBcTFTb1RUTS9WMjBsTENtV1YvdUxscHUxNTly?=
 =?utf-8?B?UUNFWEt6d3FHanhObFJPM0gyVFZGR3FvTFg4TnY5OXgyYW5EcVN0SlRxa0t1?=
 =?utf-8?B?ZzRST0M5QjBRNGhCVGJQSHBHY1kvcFRzYUZjZkt0clVsZTJlKytsWGxNSTFO?=
 =?utf-8?B?Q2lVdlNGTFNtUXlTcWFnNzFNcTZSN3RCMDhONmNucTNqREVlb04yRnhXbEV3?=
 =?utf-8?B?NnVtZUNRYVJvOFozQ3hudm4wWXp2VXVpQi9ia2ZXQ096T2RGOGJvLytVZmIz?=
 =?utf-8?B?cUJQMG5WK2k4MFZ2Z2ZmZk9SdC9lSW16WitWOEpNbnI4aTViZVFkbmZRZWRw?=
 =?utf-8?B?WnVWcUVEa3RMMXpEdG0vK0NGSmxvZDI3VzZmNmhudlJiUEZSVXZPQU84a0My?=
 =?utf-8?B?NXRzMW1wQzVuVVpPZXFpbG9WdGVOeS92cXBpYnBxbk1uOGFLUHRuQk52c0cx?=
 =?utf-8?B?RmRHVUFGMnFoNlZyTEtHajVQdFpaUUllQnRXL0FOUG5FN1VLdVJaSk8yQTN2?=
 =?utf-8?B?OU5Nc2ZhaTRCa2xuZG9JeXd2ODlWb0pEZlVjZTZvVWdjMmFvdVlBQUdlaVJy?=
 =?utf-8?B?d1luUXlWcXlCdy9Fa2kycGdvaXlCZGFtMzdmS0Q0eWNWSGEzNW8xVmtHRUo3?=
 =?utf-8?B?dC93dlFKejNGZ2tNSHJmR0p0NUNJU1dIaHZTcU8vUHIyRXQxU3FjN2RMWWQ2?=
 =?utf-8?B?VnY2akJWVDArcmhuWlVkbXgwUUlaZFJFZ2VOa2FGWXJJdituMEM5b2duZldU?=
 =?utf-8?B?L05rWVMzMWUrRFpEWW1JQ1VCUEFqUDdQVmh5U2tpNXVBblNKNEhPL2pNeXdN?=
 =?utf-8?B?eVRyMGJJYmIwOE1lR283ZUFQUGFjRlplRHN1d25ycGxha0ozcWRlQmhJYlRv?=
 =?utf-8?B?SVdyT2wyeWZ1N2NyQ3NvQkpQZFErYS9UQmk0ZzFsNVdZei82MW9Oc3JJenZE?=
 =?utf-8?B?RDFxQ1RFVlM3L0g4T3dlMUVMQlFUbnRlUDdlL3JkOTZ2UXE2NnBGcjZWRnBp?=
 =?utf-8?B?YVZlS0hUVEZjQmVqanQ5Q09WUXdMLzJMSEJwWE1sUzFHWFJJdUVxa1BYM1Q4?=
 =?utf-8?B?Nmlkam1XT0ZVNTJLU3ZhMitDRkk0M0xjelpCM09laGh6OGE2THhYVnBJUzhM?=
 =?utf-8?B?cnhPYUZLbytDQWxzcXY2NWc1RWkrNUJ5VVVndzhLaTNkTEJMQlI2OGVNWlZt?=
 =?utf-8?B?TlhHK1d1OTlaTlk2eHZyVklwWUlzRGV0UDgwMEtUWEVjYXFERXJFNUtxaS9L?=
 =?utf-8?B?L0FEZkl0bnJJOGhZTXZYV3ZLSUNycXFENVh3RlRQUStWcXMrTTUxUXMyMm5R?=
 =?utf-8?B?UGY1MDRvcnRaRW9IUXAyOCtmOGc5aHZ1MStuQlo5elhCaDhPYXZyMzlLa2dl?=
 =?utf-8?B?YzVnenNDL3VWaUNKbDlFOW1raUJ0dVhDR3EzbFZaVENtOTFZTVgxNk91dXJV?=
 =?utf-8?B?VzhSNzdUMkdCSFNkcGRNMmtUblByZDFVRUluSUlYbDVlSmVVT3k0ckVZbEcx?=
 =?utf-8?B?K2ZPTGFoUW9UdHE3TEl4VjFIVExabWw5UG04UmZRWm12UTFsRVl5SDJyRmFh?=
 =?utf-8?B?UDZLYXFheFN0dGJVcW5LOXNtcnhiSkFLaFNIVWFveXhrLzU5d0hkYWtwMG8w?=
 =?utf-8?B?NGR5aTU3NTIwOEtKTUxxenJVdk04eGpkTU9YVHExZlVoYjlKVEJuVHVpYlpT?=
 =?utf-8?Q?YywURTnjnMnof93OFX?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80b50d5-0770-4f9a-6fdd-08da3508156d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 17:43:26.5912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28i3TwwLYvJXOSrZBudP/SCXmCXhgxcsKcqkU1NSTYAkpsB6QPFHg0AuMxuJSzMU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5015
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/13/2022 11:33 AM, Bob Pearson wrote:
> On 5/13/22 08:04, Tom Talpey wrote:
>>
>> On 5/12/2022 3:49 PM, Bob Pearson wrote:
>>> Currently the completer tasklet when it sets the retransmit timer or the
>>> nak timer sets the same flag (qp->req.need_retry) so that if either
>>> timer fires it will attempt to perform a retry flow on the send queue.
>>> This has the effect of responding to an RNR NAK at the first retransmit
>>> timer event which does not allow for the requested rnr timeout.
>>>
>>> This patch adds a new flag (qp->req.need_rnr_timeout) which, if set,
>>> prevents a retry flow until the rnr nak timer fires.
>>
>> The new name is a little confusing, nobody "needs" an RNR timeout. :)
>> But it seems really odd (and maybe fragile) to have two flags. To me,
>> setting need_retry to "-1", or anything but 0 or 1, would be better.
>> After all, if the RNR NAK timer goes off, the code will generally retry, right? So it seems more logical to merge these.
> I am trying to cleanup pyverbs runs which sometimes fail with rnr retry errors.
> In this specific case the rnr timeout value is set a lot longer than the retry timeout.

Interesting. I was not aware that was possible, and I'm skeptical.
But perhaps that's another matter.

> As discussed earlier the retry timer is never cleared so it continuously fires at about
> 40 times a second. The failing test is intentionally setting up a situation where the
> receiver is not ready and then it is. The retry timeout usually acts as though it
> were the rnr retry and 'fixes' the problem and the test passes. Since the retry timer
> is just randomly firing it sometimes happens too soon and the receiver isn't ready yet
> which leads to the failed test.
> 
> Logic says that if you receive an rnr nak the target is waiting for that specific send
> packet to be resent and no other so we shouldn't be responding to a spurious retry
> timeout.
> 
> You are correct that the retry sequence can be shared but it shouldn't start until the
> rnr timer has fired once an rnr nak is seen. This patch does exactly that by blocking
> the retry sequence until the rnr timer fires.
> 
> If you don't like 'need_rnr_timeout' perhaps you would accept 'wait_rnr_timeout' instead.
> Overloading need_retry is less clear IMHO. You don't need the retry until the rnr timer
> has fired then you do. If you really want to just use one variable we are basically
> implementing a state machine with 3 states and it should get an enum to define the states.

I guess I do prefer the latter enum approach. To elaborate on what I
meant by fragile, it appears that with the two-field approach, only
three states are valid. It can never be the case that both are set,
yet here is your hunk in rxe_requester:

   if (unlikely(qp->req.need_retry && !qp->req.need_rnr_timeout)) {

The part after the && will always evaluate to true, right? The code
clears need_rnr_timeout wherever it sets need_retry. So this is testing
for an impossible case.

That said, if you don't agree, the name needs to be less confusing.
I guess I'd suggest "rnr_timer_running".

> Once this issue is resolved I will fix the spurious retries to make them a lot less likely.

Excellent. RoCE suffers from congestion enough without pouring
gasoline on the fire.

Tom.

>>
>>> This patch fixes rnr retry errors which can be observed by running the
>>> pyverbs test suite 50-100X. With this patch applied they do not occur.
>>>
>>> Link: https://lore.kernel.org/linux-rdma/a8287823-1408-4273-bc22-99a0678db640@gmail.com/
>>> Fixes: 8700e3e7c485 ("Soft RoCE (RXE) - The software RoCE driver")
>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>> ---
>>>    drivers/infiniband/sw/rxe/rxe_comp.c  | 4 +---
>>>    drivers/infiniband/sw/rxe/rxe_qp.c    | 1 +
>>>    drivers/infiniband/sw/rxe/rxe_req.c   | 6 ++++--
>>>    drivers/infiniband/sw/rxe/rxe_verbs.h | 1 +
>>>    4 files changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
>>> index 138b3e7d3a5f..bc668cb211b1 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
>>> @@ -733,9 +733,7 @@ int rxe_completer(void *arg)
>>>                    if (qp->comp.rnr_retry != 7)
>>>                        qp->comp.rnr_retry--;
>>>    -                qp->req.need_retry = 1;
>>> -                pr_debug("qp#%d set rnr nak timer\n",
>>> -                     qp_num(qp));
>>> +                qp->req.need_rnr_timeout = 1;
>>
>> Suggest req.need_rnr_retry = -1  (and keep the useful pr_debug!)
>>
>>>                    mod_timer(&qp->rnr_nak_timer,
>>>                          jiffies + rnrnak_jiffies(aeth_syn(pkt)
>>>                            & ~AETH_TYPE_MASK));
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>>> index 62acf890af6c..1c962468714e 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>>> @@ -513,6 +513,7 @@ static void rxe_qp_reset(struct rxe_qp *qp)
>>>        atomic_set(&qp->ssn, 0);
>>>        qp->req.opcode = -1;
>>>        qp->req.need_retry = 0;
>>> +    qp->req.need_rnr_timeout = 0;
>>>        qp->req.noack_pkts = 0;
>>>        qp->resp.msn = 0;
>>>        qp->resp.opcode = -1;
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
>>> index ae5fbc79dd5c..770ae4279f73 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_req.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
>>> @@ -103,7 +103,8 @@ void rnr_nak_timer(struct timer_list *t)
>>>    {
>>>        struct rxe_qp *qp = from_timer(qp, t, rnr_nak_timer);
>>>    -    pr_debug("qp#%d rnr nak timer fired\n", qp_num(qp));
>>> +    qp->req.need_retry = 1;
>>> +    qp->req.need_rnr_timeout = 0;
>>
>> Simply setting need_retry = 1 would suffice, if suggestion accepted.
>>
>>>        rxe_run_task(&qp->req.task, 1);
>>>    }
>>>    @@ -624,10 +625,11 @@ int rxe_requester(void *arg)
>>>            qp->req.need_rd_atomic = 0;
>>>            qp->req.wait_psn = 0;
>>>            qp->req.need_retry = 0;
>>> +        qp->req.need_rnr_timeout = 0;
>>>            goto exit;
>>>        }
>>>    -    if (unlikely(qp->req.need_retry)) {
>>> +    if (unlikely(qp->req.need_retry && !qp->req.need_rnr_timeout)) {
>>
>> This would become (unlikely (qp->req.rnr_retry > 0)) ...
>>
>>>            req_retry(qp);
>>>            qp->req.need_retry = 0;
>>>        }
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>> index e7eff1ca75e9..ab3186478c3f 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>> @@ -123,6 +123,7 @@ struct rxe_req_info {
>>>        int            need_rd_atomic;
>>>        int            wait_psn;
>>>        int            need_retry;
>>> +    int            need_rnr_timeout;
>>
>> Drop
>>
>>>        int            noack_pkts;
>>>        struct rxe_task        task;
>>>    };
>>>
>>> base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
>>
>>
>> Tom.
> 
> 
