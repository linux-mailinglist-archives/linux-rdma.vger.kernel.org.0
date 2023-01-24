Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36F367A551
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jan 2023 23:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbjAXWDu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Jan 2023 17:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjAXWDt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Jan 2023 17:03:49 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036B750840
        for <linux-rdma@vger.kernel.org>; Tue, 24 Jan 2023 14:03:37 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id a1-20020a056830008100b006864df3b1f8so10071555oto.3
        for <linux-rdma@vger.kernel.org>; Tue, 24 Jan 2023 14:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=302EhWcun9cjkPe3g6G8Pw38phqe+WzcOdhKkQgC8l8=;
        b=Cb2AgKX6lSgdjL3XbtWovJNtYdUSIIK5MAkI3AkQA8jHdokmZqr/4jL6nlEC9OGzkn
         IRrlYYhF+pynRDjbNjLloxfY0hGixYAl/JNpIXTglFdPaORVu+ilUX5DqrMUKBwRDzcB
         33qd/dRO7APiDxsXMMMW5ZdLX42Cm4eNB//XYV95b/QLJYqmGO5ZWPGcbhmyR2Q8AEbt
         o+QDaVupXuy3izjQk3HipROOj0Pp92FILBYffZhuChLEv3QPGkFaXjiqyut116aVwfIC
         Qb+2xiumCGBM2s2h5Mk/zKi+y0NQ5y5mABnyx0lrnO5IpM7O+sNFXpFtsRum5me5gjJt
         5m1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=302EhWcun9cjkPe3g6G8Pw38phqe+WzcOdhKkQgC8l8=;
        b=CeguPBMHKL/itJErjM73E+vVQ4/iuUaiE3GtjVV1lgdSwu8tROQ7ihbZAc75lEl1YZ
         Il2jcV6cMHDxrD68NVMism4miR8Ht06cNLhRLIE2wx7SlAYvxr1W4qZAaSfWXrony98o
         ZWCPbCB4GGUSgt7AAgXk85blrH+lPeV81093Bu/6szMBTZSxT+PzeZ6hxdPqnP5qHbBx
         SDi3KKbTzUI/8xQTDArh5D3l8ZldYe/mnDeRx/Gl1qIJCPplFbCPfKZaz3rTttYq3y3z
         sETK3KCnW1FivyFq6D3A0001Kg4lP8QE3ecOvR7P9YnGfnmedVTszNmb/Gh2qhpqgogO
         wYYg==
X-Gm-Message-State: AFqh2koARpwdrGjNlfUEMolY89acOGQOH8LbbeODjbgSO3yeGM+bFmLP
        B09zJNRvE0r1JjR2O9gfpDG/R9n0sv7YIA==
X-Google-Smtp-Source: AMrXdXszRrMxvTgozgLoq0e/mhTnrnK4ar2OUJdpDdm5GlpTLWpboDhLJCbvD9R0NaaJNWv1bkjtvg==
X-Received: by 2002:a9d:1b7:0:b0:685:134:b743 with SMTP id e52-20020a9d01b7000000b006850134b743mr13338726ote.11.1674597816113;
        Tue, 24 Jan 2023 14:03:36 -0800 (PST)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id f2-20020a9d6c02000000b00684c9c77754sm1404411otq.69.2023.01.24.14.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 14:03:35 -0800 (PST)
Message-ID: <eb7ce00d-7fea-7b5e-9af6-b8ebbb5592df@gmail.com>
Date:   Tue, 24 Jan 2023 16:03:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH for-next] RDMA/rxe: Handle zero length cases correctly
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Zhu Yanjun' <zyjzyj2000@gmail.com>
Cc:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20230119190653.6363-1-rpearsonhpe@gmail.com>
 <CAD=hENcdkWchRrvH+KXLXZoaQcZPpnCdV9V9T9mmzkJ13DJKUA@mail.gmail.com>
 <20809b59-0d7f-b6b0-e51c-026a78f07a86@gmail.com>
 <CAD=hENd0HiapsN-iTkAamdy+diFYf4GhP+hnSsfOSwMvMjxY1A@mail.gmail.com>
 <TYCPR01MB8455A47C60CB11ACCB111A2AE5C89@TYCPR01MB8455.jpnprd01.prod.outlook.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <TYCPR01MB8455A47C60CB11ACCB111A2AE5C89@TYCPR01MB8455.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/23/23 04:20, Daisuke Matsuda (Fujitsu) wrote:
> On Fri, Jan 20, 2023 3:04 PM Zhu Yanjun wrote:
>>
>> On Fri, Jan 20, 2023 at 12:27 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>>
>>> On 1/19/23 19:38, Zhu Yanjun wrote:
>>>> On Fri, Jan 20, 2023 at 3:09 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>>>>
>>>>> Currently the rxe driver, in rare situations, can respond incorrectly
>>>>> to zero length operations which are retried. The client does not
>>>>> have to provide an rkey for zero length RDMA operations so the rkey
>>>>> may be invalid. The driver saves this rkey in the responder resources
>>>>> to replay the rdma operation if a retry is required so the second pass
>>>>> will use this (potentially) invalid rkey which may result in memory
>>>>> faults.
> 
> A zero-byte Read request results in one reply packet (RDMA Read Only). 
> In that case, the responder resource (I interpreted this as qp->resp.res.)
> is set to NULL soon after sending the reply packet.
> ~~~~~
>         err = rxe_xmit_packet(qp, &ack_pkt, skb);
>         if (err)
>                 return RESPST_ERR_RNR;
> 
>         res->read.va += payload;
>         res->read.resid -= payload;
>         res->cur_psn = (res->cur_psn + 1) & BTH_PSN_MASK;
> 
>         if (res->read.resid > 0) {
>                 state = RESPST_DONE;
>         } else {
>                 qp->resp.res = NULL;
>                 if (!res->replay)
>                         qp->resp.opcode = -1;
>                 if (psn_compare(res->cur_psn, qp->resp.psn) >= 0)
>                         qp->resp.psn = res->cur_psn;
>                 state = RESPST_CLEANUP;
>         }
> 
>         return state;
> }
> ~~~~~
> 
> According to the code above, the resource is not saved in case responder replies
> RDMA Read Only packet, so it seems to me that the replay he mentioned is not
> likely to occur. In my understanding, the replay in read_reply() is used in handling
> multi-packet Read responses. Please correct me if I am missing anything.
> 
> Daisuke
> 
>>
>> In this link:
>> https://lore.kernel.org/lkml/TYCPR01MB8455FC418FD61CAEE85D0D9FE5C19@TYCPR01MB8455.jpnprd01.prod.outlo
>> ok.com/T/#m9ea28d1465dc2fb3469c21659e6b6c7349fc984f
>>
>> Daisuke Matsuda (Fujitsu) made further investigations about this problem.
>>
>> And Daisuke Matsuda (Fujitsu) has delved into this problem.
>>
>> Let us wait for his comments.
>>
>> Zhu Yanjun
>>
>>>>>
>>>>> This patch corrects the driver to ignore the provided rkey if the
>>>>> reth length is zero and make sure to set the mr to NULL. In read_reply()
>>>>> if the length is zero the MR is set to NULL. Warnings are added in
>>>>> the routines in rxe_mr.c to catch NULL MRs when the length is non-zero.
>>>>>
>>>>
>>>> There is a patch in the following link:
>>>>
>>>> https://patchwork.kernel.org/project/linux-rdma/patch/20230113023527.728725-1-baijiaju1990@gmail.com/
>>>>
>>>> Not sure whether it is similar or not.
>>>>
>>>> Zhu Yanjun
>>>>
>>>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>>>> ---
>>>>>  drivers/infiniband/sw/rxe/rxe_mr.c   |  9 +++++++
>>>>>  drivers/infiniband/sw/rxe/rxe_resp.c | 36 +++++++++++++++++++++-------
>>>>>  2 files changed, 36 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
>>>>> index 072eac4b65d2..134a74f315c2 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
>>>>> @@ -267,6 +267,9 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
>>>>>         int m, n;
>>>>>         void *addr;
>>>>>
>>>>> +       if (WARN_ON(!mr))
>>>>> +               return NULL;
>>>>> +
>>>>>         if (mr->state != RXE_MR_STATE_VALID) {
>>>>>                 rxe_dbg_mr(mr, "Not in valid state\n");
>>>>>                 addr = NULL;
>>>>> @@ -305,6 +308,9 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, int length)
>>>>>         if (length == 0)
>>>>>                 return 0;
>>>>>
>>>>> +       if (WARN_ON(!mr))
>>>>> +               return -EINVAL;
>>>>> +
>>>>>         if (mr->ibmr.type == IB_MR_TYPE_DMA)
>>>>>                 return -EFAULT;
>>>>>
>>>>> @@ -349,6 +355,9 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
>>>>>         if (length == 0)
>>>>>                 return 0;
>>>>>
>>>>> +       if (WARN_ON(!mr))
>>>>> +               return -EINVAL;
>>>>> +
>>>>>         if (mr->ibmr.type == IB_MR_TYPE_DMA) {
>>>>>                 u8 *src, *dest;
>>>>>
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>>>>> index c74972244f08..a528dc25d389 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>>>>> @@ -457,13 +457,23 @@ static enum resp_states rxe_resp_check_length(struct rxe_qp *qp,
>>>>>         return RESPST_CHK_RKEY;
>>>>>  }
>>>>>
>>>>> +/* if the reth length field is zero we can assume nothing
>>>>> + * about the rkey value and should not validate or use it.
>>>>> + * Instead set qp->resp.rkey to 0 which is an invalid rkey
>>>>> + * value since the minimum index part is 1.
>>>>> + */
>>>>>  static void qp_resp_from_reth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
>>>>>  {
>>>>> +       unsigned int length = reth_len(pkt);
>>>>> +
>>>>>         qp->resp.va = reth_va(pkt);
>>>>>         qp->resp.offset = 0;
>>>>> -       qp->resp.rkey = reth_rkey(pkt);
>>>>> -       qp->resp.resid = reth_len(pkt);
>>>>> -       qp->resp.length = reth_len(pkt);
>>>>> +       qp->resp.resid = length;
>>>>> +       qp->resp.length = length;
>>>>> +       if (length)
>>>>> +               qp->resp.rkey = reth_rkey(pkt);
>>>>> +       else
>>>>> +               qp->resp.rkey = 0;
>>>>>  }
>>>>>
>>>>>  static void qp_resp_from_atmeth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
>>>>> @@ -512,8 +522,8 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>>>>>
>>>>>         /* A zero-byte op is not required to set an addr or rkey. See C9-88 */
>>>>>         if ((pkt->mask & RXE_READ_OR_WRITE_MASK) &&
>>>>> -           (pkt->mask & RXE_RETH_MASK) &&
>>>>> -           reth_len(pkt) == 0) {
>>>>> +           (pkt->mask & RXE_RETH_MASK) && reth_len(pkt) == 0) {
>>>>> +               qp->resp.mr = NULL;
>>>>>                 return RESPST_EXECUTE;
>>>>>         }
>>>>>
>>>>> @@ -592,6 +602,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>>>>>         return RESPST_EXECUTE;
>>>>>
>>>>>  err:
>>>>> +       qp->resp.mr = NULL;
>>>>>         if (mr)
>>>>>                 rxe_put(mr);
>>>>>         if (mw)
>>>>> @@ -966,7 +977,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>>>>         }
>>>>>
>>>>>         if (res->state == rdatm_res_state_new) {
>>>>> -               if (!res->replay) {
>>>>> +               if (qp->resp.length == 0) {
>>>>> +                       mr = NULL;
>>>>> +                       qp->resp.mr = NULL;
>>>>> +               } else if (!res->replay) {
>>>>>                         mr = qp->resp.mr;
>>>>>                         qp->resp.mr = NULL;
>>>>>                 } else {
>>>>> @@ -980,9 +994,13 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>>>>                 else
>>>>>                         opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST;
>>>>>         } else {
>>>>> -               mr = rxe_recheck_mr(qp, res->read.rkey);
>>>>> -               if (!mr)
>>>>> -                       return RESPST_ERR_RKEY_VIOLATION;
>>>>> +               if (qp->resp.length == 0) {
>>>>> +                       mr = NULL;
>>>>> +               } else {
>>>>> +                       mr = rxe_recheck_mr(qp, res->read.rkey);
>>>>> +                       if (!mr)
>>>>> +                               return RESPST_ERR_RKEY_VIOLATION;
>>>>> +               }
>>>>>
>>>>>                 if (res->read.resid > mtu)
>>>>>                         opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE;
>>>>> --
>>>>> 2.37.2
>>>>>
>>>
>>> Zhu,
>>>
>>> It relates since he is checking for NULL MRs. But I don't think it addresses the root
>>> causes. The patch I sent should eliminate NULL MRs together with length != 0 in
>>> the copy routines. I added WARN_ON's in case someone changes things later and
>>> we hit this again. (A warning is more useful than a fault which can be very hard
>>> to diagnose.)
>>>
>>> The two changes I made that attack the cause of problems are
>>> (1) clearing qp->resp.mr in check_rkey() in the alternate paths. The primary
>>> path demands that it get set with a valid mr. But on the alternate paths it isn't
>>> set at all and can leave with a stale, invalid or wrong mr value.
>>> (2) in read_reply() there is an error path where a zero length read fails to get
>>> acked and the requester retries the operation and sends a second request. This
>>> will end up in read_reply and as currently written attempt to lookup the rkey and
>>> turn it into an MR but no valid rkey is required in a zero length operation so this
>>> is likely to fail. The fixes treats length == 0 as a special case and force a NULL mr.
>>> This should not trigger a fault in the mr copy/etc. routines since they always
>>> check for length == 0 and return or require a non zero length.
>>>
>>> Thanks,
>>>
>>> Bob
>>>
>>>

Thanks Daisuke,

This reduces the odds of something bad happening but I still like the patch as it is.
I wrote this because the pyverbs test suite has a test case for a zero length read
and I saw the test providing an invalid rkey (0x00000020 which is out of range for
MR indices) and the test failed but that may have been for other reasons.

There are three changes in the patch:

1) check for MR == NULL AND length != 0 in the mr copy/atomic/etc. routines. These
should not happen unless there is a bug elsewhere in the driver so WARN_ON is
appropriate.

2) Always set qp->resp.mr in check_rkey. The main purpose of this subroutine is to
lookup the rkey and find the matching MR by setting qp->resp.mr. But in the alternate
paths out of the routine it wasn't set. By setting qp->resp.mr = NULL in those paths
we get predictable behavior which is easy to understand. It may be that mr always
defaults to NULL but why depend on that when it may change in the future and lead to
a difficult bug to find. Same for qp_resp_from_reth() since it can legally pass random
junk in if length == 0.

3) In read_reply don't call rxe_recheck_mr() unless you know rkey is good. The purpose
of rxe_recheck_mr() is, like check_rkey(), to convert rkey to an MR but this time
without the length to make sure the rkey should be checked. If the length is zero then
by spec no rkey is required and it may be invalid (as in pyverbs) so it makes sense
to handle this case separately.

All of them are obvious and make the code easier to understand and not going to cause
more bugs. One or two more unlikely if statements isn't going to impact performance.

Depending on what Jason does with the xarray based mr change this patch may have to
be sent in again since it doesn't commute with that patch set. I have a newer version
that applies after the zarray patches and will send it if they get accepted.

Bob
