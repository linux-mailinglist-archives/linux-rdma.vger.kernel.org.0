Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9EA587CED
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Aug 2022 15:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiHBNST (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Aug 2022 09:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiHBNSS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Aug 2022 09:18:18 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6876A12D19;
        Tue,  2 Aug 2022 06:18:10 -0700 (PDT)
Message-ID: <0a073674-cb3b-96f5-8af6-779f681a05d0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1659446288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=px8ybqGB8lVsEkoR1fXo4n81yqEsz0zAAzD8kDgD+zQ=;
        b=EOOlHjuSyES/QjQ7KnBPtt9XSjJayho7izkNJitc9wYxDWVl343ZJlV9qAK4T+2ZfBMLDl
        Owsn0cgAzaGPMI4Ff5TXFkaix03MekSxvSbHpJkWbVeewNP6BdvZM7QIWkrXqykuwhE62p
        hXOWDF+bHu3yqADCns87C2qfg1cfyfM=
Date:   Tue, 2 Aug 2022 21:17:57 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/RXE: Add send_common_ack() helper
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1659335010-2-1-git-send-email-lizhijian@fujitsu.com>
 <CAD=hENfqCKs3jk7pUNJq0Urqx1ZCSU2KpDcipgz_ORJs_43C=g@mail.gmail.com>
 <b47219be-b6e0-9a18-5d84-5546c08d721e@fujitsu.com>
 <CAD=hENfZN43c4ZBmXwdru61=341bZgfYa8VJeKaBQYF5KKFA2A@mail.gmail.com>
 <02c52efa-61fd-5e27-9f98-46e0384d81e7@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <02c52efa-61fd-5e27-9f98-46e0384d81e7@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/8/2 13:52, lizhijian@fujitsu.com 写道:
> 
> 
> On 01/08/2022 15:47, Zhu Yanjun wrote:
>> On Mon, Aug 1, 2022 at 3:28 PM lizhijian@fujitsu.com
>> <lizhijian@fujitsu.com> wrote:
>>>
>>>
>>> On 01/08/2022 15:11, Zhu Yanjun wrote:
>>>> On Mon, Aug 1, 2022 at 2:16 PM Li Zhijian <lizhijian@fujitsu.com> wrote:
>>>>> Most code in send_ack() and send_atomic_ack() are duplicate, move them
>>>>> to a new helper send_common_ack().
>>>>>
>>>>> In newer IBA SPEC, some opcodes require acknowledge with a zero-length read
>>>>> response, with this new helper, we can easily implement it later.
>>>>>
>>>>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>>>>> ---
>>>>>     drivers/infiniband/sw/rxe/rxe_resp.c | 43 ++++++++++++++----------------------
>>>>>     1 file changed, 17 insertions(+), 26 deletions(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>>>>> index b36ec5c4d5e0..4c398fa220fa 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>>>>> @@ -1028,50 +1028,41 @@ static enum resp_states do_complete(struct rxe_qp *qp,
>>>>>                    return RESPST_CLEANUP;
>>>>>     }
>>>>>
>>>>> -static int send_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
>>>>> +
>>>>> +static int send_common_ack(struct rxe_qp *qp, u8 syndrome, u32 psn,
>>>> The function is better with rxe_send_common_ack?
>>> I'm not clear the exact rule about the naming prefix. if it has, please let me know :)
>>>
>>> IMHO, if a function is either a public API(export function) or a callback to a upper layer,  it's a good idea to a fixed prefix.
>>> Instead, if they are just static, no prefix is not too bad.
>> When debug, a rxe_ prefix can help us filter the functions whatever
>> the function static or public.
>>
>>> BTW, current RXE are mixing the two rules, it should be another standalone patch to do the cleanup if needed.
>> Yes. Please make this standalone patch to complete this.
> 
> i tried to do a rough statistic.
> 
> all functions:
> $ git grep -E '^[a-z].*\(' drivers/infiniband/sw/rxe | awk -F'(' '{print $1}' | awk '{print $NF}' | tr -d '\*' | grep -E ^[a-z]+ | wc -l
> 474
> 
> without rxe_ prefix:
> git grep -E '^[a-z].*\(' drivers/infiniband/sw/rxe | awk -F'(' '{print $1}' | awk '{print $NF}' | tr -d '\*' | grep -E ^[a-z]+ | grep -v -e ^rxe | wc -l
> 199
The followings are the no rxe_ prefix functions. About 22 functions.

do_complete
retransmit_timer
next_opcode
rnr_nak_timer
find_resource
send_data_in
prepare_ack_packet
send_ack
check_keys
check_type_state
resize_finish
do_mmap_info
parent_show
post_one_recv
free_rd_atomic_resources
free_rd_atomic_resource
lookup_iova
mr_check_range
iova_to_vaddr
advance_dma_data
lookup_mr
copy_data

Zhu Yanjun

> 
> Similarly, the mlx5 have the same situations.
> $ git grep -h -E '^[a-z].*\(' drivers/infiniband/hw/mlx5 | awk -F'(' '{print $1}' | awk '{print $NF}' | tr -d '\*' | grep -E ^[a-z]+ | wc -l
> 1083
> $ git grep -h -E '^[a-z].*\(' drivers/infiniband/hw/mlx5 | awk -F'(' '{print $1}' | awk '{print $NF}' | tr -d '\*' | grep -E ^[a-z]+ | grep -v -e ^mlx5 | wc -l
> 476
> 
> TBH, i have no strong stomach to do such cleanup so far :)
> 
> Thanks
> Zhijian
> 
> 
>>
>> Thanks and Regards,
>> Zhu Yanjun
>>
>>> Thanks
>>> Zhijian
>>>
>>>
>>>> So when debug, rxe_ prefix can help us.
>>>>
>>>>> +                                 int opcode, const char *msg)
>>>>>     {
>>>>> -       int err = 0;
>>>>> +       int err;
>>>>>            struct rxe_pkt_info ack_pkt;
>>>>>            struct sk_buff *skb;
>>>>>
>>>>> -       skb = prepare_ack_packet(qp, &ack_pkt, IB_OPCODE_RC_ACKNOWLEDGE,
>>>>> -                                0, psn, syndrome);
>>>>> -       if (!skb) {
>>>>> -               err = -ENOMEM;
>>>>> -               goto err1;
>>>>> -       }
>>>>> +       skb = prepare_ack_packet(qp, &ack_pkt, opcode, 0, psn, syndrome);
>>>>> +       if (!skb)
>>>>> +               return -ENOMEM;
>>>>>
>>>>>            err = rxe_xmit_packet(qp, &ack_pkt, skb);
>>>>>            if (err)
>>>>> -               pr_err_ratelimited("Failed sending ack\n");
>>>>> +               pr_err_ratelimited("Failed sending %s\n", msg);
>>>>>
>>>>> -err1:
>>>>>            return err;
>>>>>     }
>>>>>
>>>>> -static int send_atomic_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
>>>>> +static int send_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
>>>> rxe_send_ack
>>>>
>>>>>     {
>>>>> -       int err = 0;
>>>>> -       struct rxe_pkt_info ack_pkt;
>>>>> -       struct sk_buff *skb;
>>>>> -
>>>>> -       skb = prepare_ack_packet(qp, &ack_pkt, IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE,
>>>>> -                                0, psn, syndrome);
>>>>> -       if (!skb) {
>>>>> -               err = -ENOMEM;
>>>>> -               goto out;
>>>>> -       }
>>>>> +       return send_common_ack(qp, syndrome, psn,
>>>>> +                       IB_OPCODE_RC_ACKNOWLEDGE, "ACK");
>>>>> +}
>>>>>
>>>>> -       err = rxe_xmit_packet(qp, &ack_pkt, skb);
>>>>> -       if (err)
>>>>> -               pr_err_ratelimited("Failed sending atomic ack\n");
>>>>> +static int send_atomic_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
>>>> rxe_send_atomic_ack
>>>>
>>>> Thanks and Regards,
>>>> Zhu Yanjun
>>>>> +{
>>>>> +       int ret = send_common_ack(qp, syndrome, psn,
>>>>> +                       IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE, "ATOMIC ACK");
>>>>>
>>>>>            /* have to clear this since it is used to trigger
>>>>>             * long read replies
>>>>>             */
>>>>>            qp->resp.res = NULL;
>>>>> -out:
>>>>> -       return err;
>>>>> +       return ret;
>>>>>     }
>>>>>
>>>>>     static enum resp_states acknowledge(struct rxe_qp *qp,
>>>>> --
>>>>> 1.8.3.1
>>>>>

