Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0619736FB0
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 17:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjFTPDp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 11:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjFTPD2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 11:03:28 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4622F1BF9
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 08:02:28 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1acfce1fc0bso306916fac.2
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 08:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687273347; x=1689865347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BOoYXXMjtPuXJ3NkEGdCmjRbTXxXdBB7rLGK3JA8fDM=;
        b=JV96NlY7EiUpYFlNUqO33z0yH0YWe9QDr5BZv0Zf/xJ6KeVJxIbb0WA1aEbhlc40Dl
         igmTrcYbERElTfptomw+HB/b9bdgLPNxrzgAgYDAoxdtrEW6/Rtafn8yIDRYrqGAQDI4
         LrPkUS4AELEv46A6l77z7TYa+xHy/dyVNBCs4G4MoijtVNV6OcR5nK/DKrKBLWtR4tWN
         tBytcIxSqTbDPIfEY5+DR9wj9t1WvKJdKakWY03IiXK9buzz4YTW7/5kscaGc3+8Y7xI
         RVqdGj+EQB7eEnNOkkKkcxOGD0wnPP14yFp5Nn0eFz/DaBjVJFNA1zCOEmaQlIt5243G
         v/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687273347; x=1689865347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOoYXXMjtPuXJ3NkEGdCmjRbTXxXdBB7rLGK3JA8fDM=;
        b=XXFZvCTqFut2QFbNeYKCjDhtZgLjvRHAhMUOTlxMKFxH7XX6GqscF+Xq3Roptxp7Js
         N+pYORqTdb53hHBeoW6mjGYZW/fyWMQLrut4h7PT6E+630F3ofm4MH0E6HRPbr9CPibZ
         ls79PgTTD1yJJOb7+jfgRwn33V9HVR2rlZlrOWuajfppFPDT6DAXb4GmrfEvSCSzpisV
         HX+37OJ7i1oJ29flkIqkbPsE1ZmYjw5/opoBhXicHleK7+hWei09PmDbl1yGf34V28qo
         Q9+JS8O9q3vQ2bi/fmqdxEjvTxP5PS5BSHOurFvQueaGsGLI08VExJ003M2FX6RMa/x+
         2ZHQ==
X-Gm-Message-State: AC+VfDxGhxT5yUZaLMa8yrh9flB3/+Xj/WScP33cNuYyBT2YkLworsOQ
        NcN8NfYyCsydlM2o0JyACrYQtCuv9wc=
X-Google-Smtp-Source: ACHHUZ6CJTH1cDeOPMhGxhcm/Dm2rXT9DTz2imm9aUPIclwZUWwcR4/Qlq5iBue3fT9MTgNeQdY6Rg==
X-Received: by 2002:a05:6870:1986:b0:1a9:8c0f:7a5 with SMTP id v6-20020a056870198600b001a98c0f07a5mr3282276oam.3.1687273347169;
        Tue, 20 Jun 2023 08:02:27 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:ba53:355d:2a89:4598? (2603-8081-140c-1a00-ba53-355d-2a89-4598.res6.spectrum.com. [2603:8081:140c:1a00:ba53:355d:2a89:4598])
        by smtp.gmail.com with ESMTPSA id lx23-20020a0568704b9700b001a6c1fcf1d6sm1411892oab.18.2023.06.20.08.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 08:02:26 -0700 (PDT)
Message-ID: <ebe9541f-ee4a-02e2-1a13-684f2c20a959@gmail.com>
Date:   Tue, 20 Jun 2023 10:02:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-next v2 1/3] RDMA/rxe: Move work queue code to
 subroutines
Content-Language: en-US
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org
References: <20230620135519.9365-1-rpearsonhpe@gmail.com>
 <20230620135519.9365-2-rpearsonhpe@gmail.com>
 <CAD=hENcibyPP9e8BAotUVqc1TcgD1Yym2KA3a9k4V3BWTFn6bw@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAD=hENcibyPP9e8BAotUVqc1TcgD1Yym2KA3a9k4V3BWTFn6bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/23 09:49, Zhu Yanjun wrote:
> On Tue, Jun 20, 2023 at 9:55 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> This patch:
>>         - Moves code to initialize a qp send work queue to a
>>           subroutine named rxe_init_sq.
>>         - Moves code to initialize a qp recv work queue to a
>>           subroutine named rxe_init_rq.
> 
> This is a use-before-initialization problem. It is better to
> initialize the sq/rq queues before the queues are used.
> These 3 commits are complicated. It is easy to introduce some risks
> just like in the first version. A compact fix is preferred.
> But these commits seems to fix the problem.
> 
> Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

The fix to the reported problem is in patch 2/3 which is very simple.
Patch 1/3 mainly just cuts and pastes the code to init the queues into a
subroutine without any functional change. But it fixes another potential
use before setting issue with the packet queues simply by initializing
them first.

I am planning on spending today looking at the namespace patches.

Thanks for looking - Bob
> 
> 
> 
>>         - Moves initialization of qp request and response packet
>>           queues ahead of work queue initialization so that cleanup
>>           of a qp if it is not fully completed can successfully
>>           attempt to drain the packet queues without a seg fault.
>>         - Makes minor whitespace cleanups.
>>
>> Fixes: 8700e3e7c485 ("Soft RoCE driver")
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_qp.c | 163 +++++++++++++++++++----------
>>  1 file changed, 108 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>> index 95d4a6760c33..9dbb16699c36 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>> @@ -180,13 +180,63 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
>>         atomic_set(&qp->skb_out, 0);
>>  }
>>
>> +static int rxe_init_sq(struct rxe_qp *qp, struct ib_qp_init_attr *init,
>> +                      struct ib_udata *udata,
>> +                      struct rxe_create_qp_resp __user *uresp)
>> +{
>> +       struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
>> +       int wqe_size;
>> +       int err;
>> +
>> +       qp->sq.max_wr = init->cap.max_send_wr;
>> +       wqe_size = max_t(int, init->cap.max_send_sge * sizeof(struct ib_sge),
>> +                        init->cap.max_inline_data);
>> +       qp->sq.max_sge = wqe_size / sizeof(struct ib_sge);
>> +       qp->sq.max_inline = wqe_size;
>> +       wqe_size += sizeof(struct rxe_send_wqe);
>> +
>> +       qp->sq.queue = rxe_queue_init(rxe, &qp->sq.max_wr, wqe_size,
>> +                                     QUEUE_TYPE_FROM_CLIENT);
>> +       if (!qp->sq.queue) {
>> +               rxe_err_qp(qp, "Unable to allocate send queue");
>> +               err = -ENOMEM;
>> +               goto err_out;
>> +       }
>> +
>> +       /* prepare info for caller to mmap send queue if user space qp */
>> +       err = do_mmap_info(rxe, uresp ? &uresp->sq_mi : NULL, udata,
>> +                          qp->sq.queue->buf, qp->sq.queue->buf_size,
>> +                          &qp->sq.queue->ip);
>> +       if (err) {
>> +               rxe_err_qp(qp, "do_mmap_info failed, err = %d", err);
>> +               goto err_free;
>> +       }
>> +
>> +       /* return actual capabilities to caller which may be larger
>> +        * than requested
>> +        */
>> +       init->cap.max_send_wr = qp->sq.max_wr;
>> +       init->cap.max_send_sge = qp->sq.max_sge;
>> +       init->cap.max_inline_data = qp->sq.max_inline;
>> +
>> +       return 0;
>> +
>> +err_free:
>> +       vfree(qp->sq.queue->buf);
>> +       kfree(qp->sq.queue);
>> +       qp->sq.queue = NULL;
>> +err_out:
>> +       return err;
>> +}
>> +
>>  static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>>                            struct ib_qp_init_attr *init, struct ib_udata *udata,
>>                            struct rxe_create_qp_resp __user *uresp)
>>  {
>>         int err;
>> -       int wqe_size;
>> -       enum queue_type type;
>> +
>> +       /* if we don't finish qp create make sure queue is valid */
>> +       skb_queue_head_init(&qp->req_pkts);
>>
>>         err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
>>         if (err < 0)
>> @@ -201,32 +251,10 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>>          * (0xc000 - 0xffff).
>>          */
>>         qp->src_port = RXE_ROCE_V2_SPORT + (hash_32(qp_num(qp), 14) & 0x3fff);
>> -       qp->sq.max_wr           = init->cap.max_send_wr;
>> -
>> -       /* These caps are limited by rxe_qp_chk_cap() done by the caller */
>> -       wqe_size = max_t(int, init->cap.max_send_sge * sizeof(struct ib_sge),
>> -                        init->cap.max_inline_data);
>> -       qp->sq.max_sge = init->cap.max_send_sge =
>> -               wqe_size / sizeof(struct ib_sge);
>> -       qp->sq.max_inline = init->cap.max_inline_data = wqe_size;
>> -       wqe_size += sizeof(struct rxe_send_wqe);
>> -
>> -       type = QUEUE_TYPE_FROM_CLIENT;
>> -       qp->sq.queue = rxe_queue_init(rxe, &qp->sq.max_wr,
>> -                               wqe_size, type);
>> -       if (!qp->sq.queue)
>> -               return -ENOMEM;
>>
>> -       err = do_mmap_info(rxe, uresp ? &uresp->sq_mi : NULL, udata,
>> -                          qp->sq.queue->buf, qp->sq.queue->buf_size,
>> -                          &qp->sq.queue->ip);
>> -
>> -       if (err) {
>> -               vfree(qp->sq.queue->buf);
>> -               kfree(qp->sq.queue);
>> -               qp->sq.queue = NULL;
>> +       err = rxe_init_sq(qp, init, udata, uresp);
>> +       if (err)
>>                 return err;
>> -       }
>>
>>         qp->req.wqe_index = queue_get_producer(qp->sq.queue,
>>                                                QUEUE_TYPE_FROM_CLIENT);
>> @@ -234,8 +262,6 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>>         qp->req.opcode          = -1;
>>         qp->comp.opcode         = -1;
>>
>> -       skb_queue_head_init(&qp->req_pkts);
>> -
>>         rxe_init_task(&qp->req.task, qp, rxe_requester);
>>         rxe_init_task(&qp->comp.task, qp, rxe_completer);
>>
>> @@ -247,40 +273,67 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>>         return 0;
>>  }
>>
>> +static int rxe_init_rq(struct rxe_qp *qp, struct ib_qp_init_attr *init,
>> +                      struct ib_udata *udata,
>> +                      struct rxe_create_qp_resp __user *uresp)
>> +{
>> +       struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
>> +       int wqe_size;
>> +       int err;
>> +
>> +       qp->rq.max_wr = init->cap.max_recv_wr;
>> +       qp->rq.max_sge = init->cap.max_recv_sge;
>> +       wqe_size = sizeof(struct rxe_recv_wqe) +
>> +                               qp->rq.max_sge*sizeof(struct ib_sge);
>> +
>> +       qp->rq.queue = rxe_queue_init(rxe, &qp->rq.max_wr, wqe_size,
>> +                                     QUEUE_TYPE_FROM_CLIENT);
>> +       if (!qp->rq.queue) {
>> +               rxe_err_qp(qp, "Unable to allocate recv queue");
>> +               err = -ENOMEM;
>> +               goto err_out;
>> +       }
>> +
>> +       /* prepare info for caller to mmap recv queue if user space qp */
>> +       err = do_mmap_info(rxe, uresp ? &uresp->rq_mi : NULL, udata,
>> +                          qp->rq.queue->buf, qp->rq.queue->buf_size,
>> +                          &qp->rq.queue->ip);
>> +       if (err) {
>> +               rxe_err_qp(qp, "do_mmap_info failed, err = %d", err);
>> +               goto err_free;
>> +       }
>> +
>> +       /* return actual capabilities to caller which may be larger
>> +        * than requested
>> +        */
>> +       init->cap.max_recv_wr = qp->rq.max_wr;
>> +
>> +       return 0;
>> +
>> +err_free:
>> +       vfree(qp->rq.queue->buf);
>> +       kfree(qp->rq.queue);
>> +       qp->rq.queue = NULL;
>> +err_out:
>> +       return err;
>> +}
>> +
>>  static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
>>                             struct ib_qp_init_attr *init,
>>                             struct ib_udata *udata,
>>                             struct rxe_create_qp_resp __user *uresp)
>>  {
>>         int err;
>> -       int wqe_size;
>> -       enum queue_type type;
>> +
>> +       /* if we don't finish qp create make sure queue is valid */
>> +       skb_queue_head_init(&qp->resp_pkts);
>>
>>         if (!qp->srq) {
>> -               qp->rq.max_wr           = init->cap.max_recv_wr;
>> -               qp->rq.max_sge          = init->cap.max_recv_sge;
>> -
>> -               wqe_size = rcv_wqe_size(qp->rq.max_sge);
>> -
>> -               type = QUEUE_TYPE_FROM_CLIENT;
>> -               qp->rq.queue = rxe_queue_init(rxe, &qp->rq.max_wr,
>> -                                       wqe_size, type);
>> -               if (!qp->rq.queue)
>> -                       return -ENOMEM;
>> -
>> -               err = do_mmap_info(rxe, uresp ? &uresp->rq_mi : NULL, udata,
>> -                                  qp->rq.queue->buf, qp->rq.queue->buf_size,
>> -                                  &qp->rq.queue->ip);
>> -               if (err) {
>> -                       vfree(qp->rq.queue->buf);
>> -                       kfree(qp->rq.queue);
>> -                       qp->rq.queue = NULL;
>> +               err = rxe_init_rq(qp, init, udata, uresp);
>> +               if (err)
>>                         return err;
>> -               }
>>         }
>>
>> -       skb_queue_head_init(&qp->resp_pkts);
>> -
>>         rxe_init_task(&qp->resp.task, qp, rxe_responder);
>>
>>         qp->resp.opcode         = OPCODE_NONE;
>> @@ -307,10 +360,10 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
>>         if (srq)
>>                 rxe_get(srq);
>>
>> -       qp->pd                  = pd;
>> -       qp->rcq                 = rcq;
>> -       qp->scq                 = scq;
>> -       qp->srq                 = srq;
>> +       qp->pd = pd;
>> +       qp->rcq = rcq;
>> +       qp->scq = scq;
>> +       qp->srq = srq;
>>
>>         atomic_inc(&rcq->num_wq);
>>         atomic_inc(&scq->num_wq);
>> --
>> 2.39.2
>>

