Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7823737B32
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jun 2023 08:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjFUGVZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jun 2023 02:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjFUGVZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jun 2023 02:21:25 -0400
Received: from out-61.mta0.migadu.com (out-61.mta0.migadu.com [91.218.175.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE5C9D
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 23:21:23 -0700 (PDT)
Message-ID: <40ea68ce-90f3-e9c6-1dd3-1ff6bb9fc2b2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687328481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5AHvfbBY/NQ+C5S7CmlvocJgXwUKbIA0ycHJ3LAS+Tk=;
        b=TSWqq40grGp0OldWAbFwseDMhvMTdwM1eqWu8POjtEl/c6QizycPpFJzyJ0XHQ6SV8eaio
        rATzQ8SwODufW6xl61P3CFj2o9Oc5eHfhEVbdUSsVS8xAZCOcp7Ba1ZuF75UfYgxziDv72
        /4GTWJin2Wsy+zkOlbssLlyqQDVrT6s=
Date:   Wed, 21 Jun 2023 14:21:15 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next v2 1/3] RDMA/rxe: Move work queue code to
 subroutines
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org
References: <20230620135519.9365-1-rpearsonhpe@gmail.com>
 <20230620135519.9365-2-rpearsonhpe@gmail.com>
 <CAD=hENcibyPP9e8BAotUVqc1TcgD1Yym2KA3a9k4V3BWTFn6bw@mail.gmail.com>
 <ebe9541f-ee4a-02e2-1a13-684f2c20a959@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <ebe9541f-ee4a-02e2-1a13-684f2c20a959@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/6/20 23:02, Bob Pearson 写道:
> On 6/20/23 09:49, Zhu Yanjun wrote:
>> On Tue, Jun 20, 2023 at 9:55 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>>
>>> This patch:
>>>          - Moves code to initialize a qp send work queue to a
>>>            subroutine named rxe_init_sq.
>>>          - Moves code to initialize a qp recv work queue to a
>>>            subroutine named rxe_init_rq.
>>
>> This is a use-before-initialization problem. It is better to
>> initialize the sq/rq queues before the queues are used.
>> These 3 commits are complicated. It is easy to introduce some risks
>> just like in the first version. A compact fix is preferred.
>> But these commits seems to fix the problem.
>>
>> Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> 
> The fix to the reported problem is in patch 2/3 which is very simple.
> Patch 1/3 mainly just cuts and pastes the code to init the queues into a
> subroutine without any functional change. But it fixes another potential
> use before setting issue with the packet queues simply by initializing
> them first.
> 
> I am planning on spending today looking at the namespace patches.

Thanks, Bob

Zhu Yanjun

> 
> Thanks for looking - Bob
>>
>>
>>
>>>          - Moves initialization of qp request and response packet
>>>            queues ahead of work queue initialization so that cleanup
>>>            of a qp if it is not fully completed can successfully
>>>            attempt to drain the packet queues without a seg fault.
>>>          - Makes minor whitespace cleanups.
>>>
>>> Fixes: 8700e3e7c485 ("Soft RoCE driver")
>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>> ---
>>>   drivers/infiniband/sw/rxe/rxe_qp.c | 163 +++++++++++++++++++----------
>>>   1 file changed, 108 insertions(+), 55 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>>> index 95d4a6760c33..9dbb16699c36 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>>> @@ -180,13 +180,63 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
>>>          atomic_set(&qp->skb_out, 0);
>>>   }
>>>
>>> +static int rxe_init_sq(struct rxe_qp *qp, struct ib_qp_init_attr *init,
>>> +                      struct ib_udata *udata,
>>> +                      struct rxe_create_qp_resp __user *uresp)
>>> +{
>>> +       struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
>>> +       int wqe_size;
>>> +       int err;
>>> +
>>> +       qp->sq.max_wr = init->cap.max_send_wr;
>>> +       wqe_size = max_t(int, init->cap.max_send_sge * sizeof(struct ib_sge),
>>> +                        init->cap.max_inline_data);
>>> +       qp->sq.max_sge = wqe_size / sizeof(struct ib_sge);
>>> +       qp->sq.max_inline = wqe_size;
>>> +       wqe_size += sizeof(struct rxe_send_wqe);
>>> +
>>> +       qp->sq.queue = rxe_queue_init(rxe, &qp->sq.max_wr, wqe_size,
>>> +                                     QUEUE_TYPE_FROM_CLIENT);
>>> +       if (!qp->sq.queue) {
>>> +               rxe_err_qp(qp, "Unable to allocate send queue");
>>> +               err = -ENOMEM;
>>> +               goto err_out;
>>> +       }
>>> +
>>> +       /* prepare info for caller to mmap send queue if user space qp */
>>> +       err = do_mmap_info(rxe, uresp ? &uresp->sq_mi : NULL, udata,
>>> +                          qp->sq.queue->buf, qp->sq.queue->buf_size,
>>> +                          &qp->sq.queue->ip);
>>> +       if (err) {
>>> +               rxe_err_qp(qp, "do_mmap_info failed, err = %d", err);
>>> +               goto err_free;
>>> +       }
>>> +
>>> +       /* return actual capabilities to caller which may be larger
>>> +        * than requested
>>> +        */
>>> +       init->cap.max_send_wr = qp->sq.max_wr;
>>> +       init->cap.max_send_sge = qp->sq.max_sge;
>>> +       init->cap.max_inline_data = qp->sq.max_inline;
>>> +
>>> +       return 0;
>>> +
>>> +err_free:
>>> +       vfree(qp->sq.queue->buf);
>>> +       kfree(qp->sq.queue);
>>> +       qp->sq.queue = NULL;
>>> +err_out:
>>> +       return err;
>>> +}
>>> +
>>>   static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>>>                             struct ib_qp_init_attr *init, struct ib_udata *udata,
>>>                             struct rxe_create_qp_resp __user *uresp)
>>>   {
>>>          int err;
>>> -       int wqe_size;
>>> -       enum queue_type type;
>>> +
>>> +       /* if we don't finish qp create make sure queue is valid */
>>> +       skb_queue_head_init(&qp->req_pkts);
>>>
>>>          err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
>>>          if (err < 0)
>>> @@ -201,32 +251,10 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>>>           * (0xc000 - 0xffff).
>>>           */
>>>          qp->src_port = RXE_ROCE_V2_SPORT + (hash_32(qp_num(qp), 14) & 0x3fff);
>>> -       qp->sq.max_wr           = init->cap.max_send_wr;
>>> -
>>> -       /* These caps are limited by rxe_qp_chk_cap() done by the caller */
>>> -       wqe_size = max_t(int, init->cap.max_send_sge * sizeof(struct ib_sge),
>>> -                        init->cap.max_inline_data);
>>> -       qp->sq.max_sge = init->cap.max_send_sge =
>>> -               wqe_size / sizeof(struct ib_sge);
>>> -       qp->sq.max_inline = init->cap.max_inline_data = wqe_size;
>>> -       wqe_size += sizeof(struct rxe_send_wqe);
>>> -
>>> -       type = QUEUE_TYPE_FROM_CLIENT;
>>> -       qp->sq.queue = rxe_queue_init(rxe, &qp->sq.max_wr,
>>> -                               wqe_size, type);
>>> -       if (!qp->sq.queue)
>>> -               return -ENOMEM;
>>>
>>> -       err = do_mmap_info(rxe, uresp ? &uresp->sq_mi : NULL, udata,
>>> -                          qp->sq.queue->buf, qp->sq.queue->buf_size,
>>> -                          &qp->sq.queue->ip);
>>> -
>>> -       if (err) {
>>> -               vfree(qp->sq.queue->buf);
>>> -               kfree(qp->sq.queue);
>>> -               qp->sq.queue = NULL;
>>> +       err = rxe_init_sq(qp, init, udata, uresp);
>>> +       if (err)
>>>                  return err;
>>> -       }
>>>
>>>          qp->req.wqe_index = queue_get_producer(qp->sq.queue,
>>>                                                 QUEUE_TYPE_FROM_CLIENT);
>>> @@ -234,8 +262,6 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>>>          qp->req.opcode          = -1;
>>>          qp->comp.opcode         = -1;
>>>
>>> -       skb_queue_head_init(&qp->req_pkts);
>>> -
>>>          rxe_init_task(&qp->req.task, qp, rxe_requester);
>>>          rxe_init_task(&qp->comp.task, qp, rxe_completer);
>>>
>>> @@ -247,40 +273,67 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>>>          return 0;
>>>   }
>>>
>>> +static int rxe_init_rq(struct rxe_qp *qp, struct ib_qp_init_attr *init,
>>> +                      struct ib_udata *udata,
>>> +                      struct rxe_create_qp_resp __user *uresp)
>>> +{
>>> +       struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
>>> +       int wqe_size;
>>> +       int err;
>>> +
>>> +       qp->rq.max_wr = init->cap.max_recv_wr;
>>> +       qp->rq.max_sge = init->cap.max_recv_sge;
>>> +       wqe_size = sizeof(struct rxe_recv_wqe) +
>>> +                               qp->rq.max_sge*sizeof(struct ib_sge);
>>> +
>>> +       qp->rq.queue = rxe_queue_init(rxe, &qp->rq.max_wr, wqe_size,
>>> +                                     QUEUE_TYPE_FROM_CLIENT);
>>> +       if (!qp->rq.queue) {
>>> +               rxe_err_qp(qp, "Unable to allocate recv queue");
>>> +               err = -ENOMEM;
>>> +               goto err_out;
>>> +       }
>>> +
>>> +       /* prepare info for caller to mmap recv queue if user space qp */
>>> +       err = do_mmap_info(rxe, uresp ? &uresp->rq_mi : NULL, udata,
>>> +                          qp->rq.queue->buf, qp->rq.queue->buf_size,
>>> +                          &qp->rq.queue->ip);
>>> +       if (err) {
>>> +               rxe_err_qp(qp, "do_mmap_info failed, err = %d", err);
>>> +               goto err_free;
>>> +       }
>>> +
>>> +       /* return actual capabilities to caller which may be larger
>>> +        * than requested
>>> +        */
>>> +       init->cap.max_recv_wr = qp->rq.max_wr;
>>> +
>>> +       return 0;
>>> +
>>> +err_free:
>>> +       vfree(qp->rq.queue->buf);
>>> +       kfree(qp->rq.queue);
>>> +       qp->rq.queue = NULL;
>>> +err_out:
>>> +       return err;
>>> +}
>>> +
>>>   static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
>>>                              struct ib_qp_init_attr *init,
>>>                              struct ib_udata *udata,
>>>                              struct rxe_create_qp_resp __user *uresp)
>>>   {
>>>          int err;
>>> -       int wqe_size;
>>> -       enum queue_type type;
>>> +
>>> +       /* if we don't finish qp create make sure queue is valid */
>>> +       skb_queue_head_init(&qp->resp_pkts);
>>>
>>>          if (!qp->srq) {
>>> -               qp->rq.max_wr           = init->cap.max_recv_wr;
>>> -               qp->rq.max_sge          = init->cap.max_recv_sge;
>>> -
>>> -               wqe_size = rcv_wqe_size(qp->rq.max_sge);
>>> -
>>> -               type = QUEUE_TYPE_FROM_CLIENT;
>>> -               qp->rq.queue = rxe_queue_init(rxe, &qp->rq.max_wr,
>>> -                                       wqe_size, type);
>>> -               if (!qp->rq.queue)
>>> -                       return -ENOMEM;
>>> -
>>> -               err = do_mmap_info(rxe, uresp ? &uresp->rq_mi : NULL, udata,
>>> -                                  qp->rq.queue->buf, qp->rq.queue->buf_size,
>>> -                                  &qp->rq.queue->ip);
>>> -               if (err) {
>>> -                       vfree(qp->rq.queue->buf);
>>> -                       kfree(qp->rq.queue);
>>> -                       qp->rq.queue = NULL;
>>> +               err = rxe_init_rq(qp, init, udata, uresp);
>>> +               if (err)
>>>                          return err;
>>> -               }
>>>          }
>>>
>>> -       skb_queue_head_init(&qp->resp_pkts);
>>> -
>>>          rxe_init_task(&qp->resp.task, qp, rxe_responder);
>>>
>>>          qp->resp.opcode         = OPCODE_NONE;
>>> @@ -307,10 +360,10 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
>>>          if (srq)
>>>                  rxe_get(srq);
>>>
>>> -       qp->pd                  = pd;
>>> -       qp->rcq                 = rcq;
>>> -       qp->scq                 = scq;
>>> -       qp->srq                 = srq;
>>> +       qp->pd = pd;
>>> +       qp->rcq = rcq;
>>> +       qp->scq = scq;
>>> +       qp->srq = srq;
>>>
>>>          atomic_inc(&rcq->num_wq);
>>>          atomic_inc(&scq->num_wq);
>>> --
>>> 2.39.2
>>>
> 

