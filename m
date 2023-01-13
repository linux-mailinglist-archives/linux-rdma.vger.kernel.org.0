Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3CC669187
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jan 2023 09:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbjAMIrs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Jan 2023 03:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240048AbjAMIra (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Jan 2023 03:47:30 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB62FBE15;
        Fri, 13 Jan 2023 00:47:28 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id w3so22807922ply.3;
        Fri, 13 Jan 2023 00:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqfRlgunNZQ9zixZj5B6GFm8+Cty6xSAj9iP8ODfDXo=;
        b=KBFkcRGy65xjVRdg6XdkMgea7v/++MNW3YwtWjMhPoD64Ms+eZihiw84Gtf8XpDaV+
         YbVB/pjBw7d5JmMpsVlsCALOhI7E8SILWex+kSZvHCR1d1iRAYVK1CJjb3MjDnjgz93S
         QV511fOz+Yw50KASJ6TJ2chuznj4pqcb9DkgNCWpaFEf4qeVMwQ3kpkaVjd4rclc9pB4
         EwIqWaiUJOgLDInUsntgEEl8g60t3fItH9GMVXJmJTUzOqweHtz6/0x4Xw3dCAbrLCmn
         xyy99pqER+QwK6dSrRUPRrjFzHa2JSvnlUjils+rxlrV2UwKAbHlc6426VyI5T6ODDQc
         z98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lqfRlgunNZQ9zixZj5B6GFm8+Cty6xSAj9iP8ODfDXo=;
        b=Qz01TH2sNwCr+odnBxXB4HjNKNocYgByXpjD1CCLBPx1mfbcgLXO15+t1o4VokKFwq
         TcoUq5hOFd1qg7IxukBoAbvF90wHoWg2b2Kl/ezSjUNGFh6KUfoYDt+PtoH74kjywsGX
         yimYt9+/ysGhku/wlSE9mSRK4QuXzZ4uoEIoKwlDNk8c6D+NKTPe1HKSthmGmIaAlSMj
         4Sc+rLHP9ZByIn4k85msRLYC5whCS/219ws0nXrMycOnz3VO6/+kzh/yY7E3dV2jWERL
         HAMStd17VZ2fPB3jyKjNVRvqvjRCzhRBP8wQ0v6n7EAGApfsP3iejWcBBrzfyr5JXOez
         OZ3g==
X-Gm-Message-State: AFqh2ko7Bpf4vEgMerpXWZFMAkUwjzsIDpaMIoCd/NsRfPW3RVy+upuj
        bA6+bM5bErijEOn8JGLlZ9A=
X-Google-Smtp-Source: AMrXdXssYB0jvFNyeo4qxRlhenYO+J1Jr4ZKxWTMIt1Mxp2az77OmZ+KAy+fQF4TfTWzUeujaJdCaQ==
X-Received: by 2002:a17:903:292:b0:188:bd82:2b7c with SMTP id j18-20020a170903029200b00188bd822b7cmr56814077plr.5.1673599648318;
        Fri, 13 Jan 2023 00:47:28 -0800 (PST)
Received: from [192.168.1.101] ([166.111.139.111])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902bb8a00b0019324fbec59sm1877877pls.41.2023.01.13.00.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 00:47:27 -0800 (PST)
Subject: Re: [PATCH] infiniband: sw: rxe: Add NULL checks for qp->resp.mr
To:     Zhu Yanjun <yanjun.zhu@linux.dev>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        TOTE Robot <oslab@tsinghua.edu.cn>
References: <20230113023527.728725-1-baijiaju1990@gmail.com>
 <ec0e983b-15fb-e43f-90e2-d4f79d27298a@linux.dev>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <c7748a2b-2c27-d171-810c-f3eb56120944@gmail.com>
Date:   Fri, 13 Jan 2023 16:47:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <ec0e983b-15fb-e43f-90e2-d4f79d27298a@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks for the reply :)

I checked the commit 3282a549cf9b, and it said:
"If responder get a zero-byte RDMA Read request, qp->resp.mr is not set 
in check_rkey() (see IBA C9-88)."
Thus, this commit added a NULL check for mr (aliased with qp->resp.mr) 
in read_reply().

The buggy call trace of the commit 3282a549cf9b is rxe_responder() -> 
read_reply(qp).
In the code, there are some possible call traces from rxe_responder():

rxe_responder()
   execute(qp)
     write_data_in(qp)
       err = rxe_mr_copy(qp->resp.mr)

rxe_responder()
   process_flush(qp)
     mr = qp->resp.mr
     start = mr->ibmr.iova;
     length = mr->ibmr.length
     rxe_flush_pmem_iova(mr)

rxe_responder()
   atomic_reply(qp)
     mr = qp->resp.mr
     if (mr->state != RXE_MR_STATE_VALID)

rxe_responder()
   atomic_write_reply(qp)
     do_atomic_write(qp)
       mr = qp->resp.mr
       if (mr->state != RXE_MR_STATE_VALID)
       dst = iova_to_vaddr(mr)

rxe_responder()
   read_reply(qp)
     mr = qp->resp.mr
     err = rxe_mr_copy(mr)

For these possible call traces, they may share the same qp->resp.mr in 
the commit 3282a549cf9b.
Thus, qp->resp.mr should be checked in these call traces.
I am not quite sure of this, so I am looking forward to your opinions, 
thanks :)


Best wishes,
Jia-Ju Bai


On 2023/1/13 15:53, Zhu Yanjun wrote:
> 在 2023/1/13 10:35, Jia-Ju Bai 写道:
>> In a previous commit 3282a549cf9b, qp->resp.mr could be NULL. Moreover,
>> in many functions, qp->resp.mr is checked before its dereferences.
>> However, in some functions, this variable is not checked, and thus NULL
>> checks should be added.
>
> IMO， we should analyze the code snippet one by one.
> And it is not good to add "NULL check" without futher investigations.
>
> Zhu Yanjun
>>
>> These results are reported by a static tool written by myself.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_resp.c | 47 ++++++++++++++++------------
>>   1 file changed, 27 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c 
>> b/drivers/infiniband/sw/rxe/rxe_resp.c
>> index c74972244f08..2eafa1667a9e 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>> @@ -621,11 +621,13 @@ static enum resp_states write_data_in(struct 
>> rxe_qp *qp,
>>       int    err;
>>       int data_len = payload_size(pkt);
>>   -    err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
>> -              payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
>> -    if (err) {
>> -        rc = RESPST_ERR_RKEY_VIOLATION;
>> -        goto out;
>> +    if (qp->resp.mr) {
>> +        err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
>> +                  payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
>> +        if (err) {
>> +            rc = RESPST_ERR_RKEY_VIOLATION;
>> +            goto out;
>> +        }
>>       }
>>         qp->resp.va += data_len;
>> @@ -699,11 +701,13 @@ static enum resp_states process_flush(struct 
>> rxe_qp *qp,
>>           start = res->flush.va;
>>           length = res->flush.length;
>>       } else { /* level == IB_FLUSH_MR */
>> -        start = mr->ibmr.iova;
>> -        length = mr->ibmr.length;
>> +        if (mr) {
>> +            start = mr->ibmr.iova;
>> +            length = mr->ibmr.length;
>> +        }
>>       }
>>   -    if (res->flush.type & IB_FLUSH_PERSISTENT) {
>> +    if (mr && res->flush.type & IB_FLUSH_PERSISTENT) {
>>           if (rxe_flush_pmem_iova(mr, start, length))
>>               return RESPST_ERR_RKEY_VIOLATION;
>>           /* Make data persistent. */
>> @@ -742,7 +746,7 @@ static enum resp_states atomic_reply(struct 
>> rxe_qp *qp,
>>           qp->resp.res = res;
>>       }
>>   -    if (!res->replay) {
>> +    if (!res->replay && mr) {
>>           if (mr->state != RXE_MR_STATE_VALID) {
>>               ret = RESPST_ERR_RKEY_VIOLATION;
>>               goto out;
>> @@ -793,15 +797,17 @@ static enum resp_states do_atomic_write(struct 
>> rxe_qp *qp,
>>       int payload = payload_size(pkt);
>>       u64 src, *dst;
>>   -    if (mr->state != RXE_MR_STATE_VALID)
>> +    if (mr && mr->state != RXE_MR_STATE_VALID)
>>           return RESPST_ERR_RKEY_VIOLATION;
>>         memcpy(&src, payload_addr(pkt), payload);
>>   -    dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
>> -    /* check vaddr is 8 bytes aligned. */
>> -    if (!dst || (uintptr_t)dst & 7)
>> -        return RESPST_ERR_MISALIGNED_ATOMIC;
>> +    if (mr) {
>> +        dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, 
>> payload);
>> +        /* check vaddr is 8 bytes aligned. */
>> +        if (!dst || (uintptr_t)dst & 7)
>> +            return RESPST_ERR_MISALIGNED_ATOMIC;
>> +    }
>>         /* Do atomic write after all prior operations have completed */
>>       smp_store_release(dst, src);
>> @@ -1002,13 +1008,14 @@ static enum resp_states read_reply(struct 
>> rxe_qp *qp,
>>           return RESPST_ERR_RNR;
>>       }
>>   -    err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>> -              payload, RXE_FROM_MR_OBJ);
>> -    if (mr)
>> +    if (mr) {
>> +        err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>> +                  payload, RXE_FROM_MR_OBJ);
>>           rxe_put(mr);
>> -    if (err) {
>> -        kfree_skb(skb);
>> -        return RESPST_ERR_RKEY_VIOLATION;
>> +        if (err) {
>> +            kfree_skb(skb);
>> +            return RESPST_ERR_RKEY_VIOLATION;
>> +        }
>>       }
>>         if (bth_pad(&ack_pkt)) {
>

