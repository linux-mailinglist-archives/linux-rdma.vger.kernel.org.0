Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB74D3A09BC
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 03:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhFICBO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 22:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbhFICBN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 22:01:13 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120DBC061574
        for <linux-rdma@vger.kernel.org>; Tue,  8 Jun 2021 18:59:04 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso22338116otu.10
        for <linux-rdma@vger.kernel.org>; Tue, 08 Jun 2021 18:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vAX5D6ql26yz5hTsB+Y8ll6yci1BH8puVYaFBq6p8GA=;
        b=iQSCdpXaJxPAwyFA4RJQrjM+pfZC1soAHPcHyEry/E9R682B4PlMS1ZH1I8+pTtP4c
         X6Xf/a+TgKxarPfABJEsmhK3DQFp6HTBrFTBtElWjGY9xgyFwrGnaHmB7tjYuqWd/7KY
         LMv6xJNKF8/k5fawhJp9luhItQogn84xjaoWHCOcBJPlxyHDC1n3BBdAg3AZumwxE6GN
         ThSskH5S/qmpkqH4N+4HkO/a3eBiReFFdIY5Fi3oHKGvYYT1+NR4Gcz6WIVCUzTSkGXL
         JG4qOfhuVzpL4uzS7a07h2xpRP/3TLAzW4+uWW2vIhcUJiYLAOIixmf0GB1VY35228+t
         BK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vAX5D6ql26yz5hTsB+Y8ll6yci1BH8puVYaFBq6p8GA=;
        b=az3EzcUiAIuLivJ03mihwly8DUCylXWE8JLybNpmo3owqJcGiZiId+kBiR7lRbOT2r
         DVCQSkQ+7kcQ3fOihK+lDB+xmL7ZLgzwCMYnu+fvo4wLlaIJmVZQ3yp9VXtuM3vi0pJm
         0LlkPeyDJ0pA1Lxer0jg4YGJXmuNfsKOcUzSa7MNaHe5/ZntPkv6frfsu9MzigT098vc
         oxLFMiRkk30Wb1MZpGaTPB5sgthOpkr74PbUFsfJUN3NxFZuWHr8+Hw9/gJU2QYoaqYY
         tbCqTXITF50Q197Ap0SwdPVJkuJutPBjrEXFapAYQ73IeBzwwF8x4dtl9li8lKFLH6hV
         LsMA==
X-Gm-Message-State: AOAM5320bXBiBduVFdE2bvIAeZeXhh1p0TnRljNBpLc6sJyYnfYyayUf
        S0kbcSZ8COg9WyBb3SoAxyZPu7l66yg=
X-Google-Smtp-Source: ABdhPJziFU0O5azcwfUQroLPejc9RlgP7l2xabHFoHTuqgqrioZ6TTtQoAYmGaeNzwKXPyTKIj9P1A==
X-Received: by 2002:a05:6830:1b6e:: with SMTP id d14mr21018462ote.186.1623203943179;
        Tue, 08 Jun 2021 18:59:03 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:3153:d893:2a95:a8dc? (2603-8081-140c-1a00-3153-d893-2a95-a8dc.res6.spectrum.com. [2603:8081:140c:1a00:3153:d893:2a95:a8dc])
        by smtp.gmail.com with ESMTPSA id 21sm2877475otd.21.2021.06.08.18.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 18:59:02 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] Providers/rxe: Implement memory windows
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Moni Shoua <monis@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210608042802.33419-1-rpearsonhpe@gmail.com>
 <20210608042802.33419-3-rpearsonhpe@gmail.com>
 <CAD=hENc53Loz3vF3xDQNQcrorS_gHtjE0psGODuctDn6c+pAMw@mail.gmail.com>
 <d9eae5b5-8866-b932-9b63-b76b670d52a2@gmail.com>
 <CAD=hENc06piOhuGPA=WTWqk6prhCa0VyorP1JHRh7+uDpjCGtw@mail.gmail.com>
 <bed5deb9-e2d2-ad23-f96b-4952d98c421f@gmail.com>
 <CAD=hENeAHdeUVKF=4AW59nF0Y8Gdkp_-PJgKQq94XnW_0itNeg@mail.gmail.com>
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Message-ID: <f5524a12-47a9-35ca-4bd6-9a447a0e997e@gmail.com>
Date:   Tue, 8 Jun 2021 20:59:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAD=hENeAHdeUVKF=4AW59nF0Y8Gdkp_-PJgKQq94XnW_0itNeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/8/2021 8:51 PM, Zhu Yanjun wrote:
> On Wed, Jun 9, 2021 at 7:18 AM Pearson, Robert B <rpearsonhpe@gmail.com> wrote:
>>
>> On 6/8/2021 2:17 AM, Zhu Yanjun wrote:
>>> On Tue, Jun 8, 2021 at 3:01 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>>> On 6/8/21 1:54 AM, Zhu Yanjun wrote:
>>>>> On Tue, Jun 8, 2021 at 12:28 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>>>>> This patch makes the required changes to the rxe provider to support the
>>>>>> kernel memory windows patches to the rxe driver.
>>>>>>
>>>>>> The following changes are made:
>>>>>>     - Add ibv_alloc_mw verb
>>>>>>     - Add ibv_dealloc_mw verb
>>>>>>     - Add ibv_bind_mw verb for type 1 MWs
>>>>>>     - Add support for bind MW send work requests through the traditional
>>>>>>       QP API and the extended QP API.
>>>>>>
>>>>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>>>>> ---
>>>>>> v2:
>>>>>>     Added support for extended QP bind MW work requests.
>>>>> I got the following errors.
>>>>> Is it a known issue?
>>>>>
>>>>> # ./bin/run_tests.py --dev rxe0
>>>>> .............sssssssss.............ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss........sssssssssssssssssss....ssss.........s...s.....E.......ssssssssss..ss
>>>>> ======================================================================
>>>>> ERROR: test_qp_ex_rc_bind_mw (tests.test_qpex.QpExTestCase)
>>>>> Verify bind memory window operation using the new post_send API.
>>>>> ----------------------------------------------------------------------
>>>>> Traceback (most recent call last):
>>>>>     File "/root/rdma-core/tests/test_qpex.py", line 292, in test_qp_ex_rc_bind_mw
>>>>>       u.poll_cq(server.cq)
>>>>>     File "/root/rdma-core/tests/utils.py", line 538, in poll_cq
>>>>>       raise PyverbsRDMAError('Completion status is {s}'.
>>>>> pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Memory
>>>>> window bind error. Errno: 6, No such device or address
>>>>>
>>>>> ----------------------------------------------------------------------
>>>>> Ran 193 tests in 2.544s
>>>>>
>>>>> FAILED (errors=1, skipped=128)
>>>>>
>>>>> Zhu Yanjun
>>>> Yes. It is because the test is not setting the BIND_MW access for the MR. It is not permitted to bind an MW to a MR that does not have the BIND_MW access flag set. But this test mistakenly thinks it is going to work. The other MW tests in test_mr.py do set the BIND_MW access flag.
>>> Thanks a lot.
>>> If the root cause to this problem is correct, and setting the BIND_MW
>>> access for the MR can fix this problem,
>>>
>>> Please file a commit to fix this problem.
>>>
>>> I am fine with this MW patch series if all the problems (including
>>> rdma-core and rxe in kernel) are fixed.
>>>
>>> Thanks for your effort.
>>>
>>> Zhu Yanjun
>> Zhu,
>>
>> There was a second test bug, now fixed. And all the python tests are
>> passing or skipped. No errors. There is a message to the liux-rdma list
>> from Edward Srouji indicating that the patch is upstream at github or
>> you can use the one in my email to him. It will be a while until his PR
>> goes up stream I would guess.
>>
>> I sent a fresh set of patches last night for both the kernel and user
>> space provider.
> Thanks a lot for your effort.
>
> I applied your commits for rdma-core and rxe in kernel, and the following diff.
>
>   All the python tests in rdma-core pass or skipped. No errors
>
> Thanks again.

Thanks to you for your patience.

Bob

>
> "
> diff --git a/tests/test_qpex.py b/tests/test_qpex.py
> index 20288d45..41028e2d 100644
> --- a/tests/test_qpex.py
> +++ b/tests/test_qpex.py
> @@ -146,10 +146,10 @@ class QpExRCAtomicFetchAdd(RCResources):
>
>   class QpExRCBindMw(RCResources):
>       def create_qps(self):
> -        create_qp_ex(self, e.IBV_QPT_RC, e.IBV_QP_EX_WITH_BIND_MW)
> +        create_qp_ex(self, e.IBV_QPT_RC,
> e.IBV_QP_EX_WITH_BIND_MW|e.IBV_QP_EX_WITH_RDMA_WRITE)
>
>       def create_mr(self):
> -        self.mr = u.create_custom_mr(self, e.IBV_ACCESS_REMOTE_WRITE)
> +        self.mr = u.create_custom_mr(self,
> e.IBV_ACCESS_REMOTE_WRITE|e.IBV_ACCESS_MW_BIND)
> "
>
> Zhu Yanjun
>
>> Bob
>>
>>>> Bob
>>>>>> ---
>>>>>>    providers/rxe/rxe.c | 157 +++++++++++++++++++++++++++++++++++++++++++-
>>>>>>    1 file changed, 155 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
>>>>>> index a68656ae..bb39ef04 100644
>>>>>> --- a/providers/rxe/rxe.c
>>>>>> +++ b/providers/rxe/rxe.c
>>>>>> @@ -128,6 +128,95 @@ static int rxe_dealloc_pd(struct ibv_pd *pd)
>>>>>>           return ret;
>>>>>>    }
>>>>>>
>>>>>> +static struct ibv_mw *rxe_alloc_mw(struct ibv_pd *ibpd, enum ibv_mw_type type)
>>>>>> +{
>>>>>> +       int ret;
>>>>>> +       struct ibv_mw *ibmw;
>>>>>> +       struct ibv_alloc_mw cmd = {};
>>>>>> +       struct ib_uverbs_alloc_mw_resp resp = {};
>>>>>> +
>>>>>> +       ibmw = calloc(1, sizeof(*ibmw));
>>>>>> +       if (!ibmw)
>>>>>> +               return NULL;
>>>>>> +
>>>>>> +       ret = ibv_cmd_alloc_mw(ibpd, type, ibmw, &cmd, sizeof(cmd),
>>>>>> +                                               &resp, sizeof(resp));
>>>>>> +       if (ret) {
>>>>>> +               free(ibmw);
>>>>>> +               return NULL;
>>>>>> +       }
>>>>>> +
>>>>>> +       return ibmw;
>>>>>> +}
>>>>>> +
>>>>>> +static int rxe_dealloc_mw(struct ibv_mw *ibmw)
>>>>>> +{
>>>>>> +       int ret;
>>>>>> +
>>>>>> +       ret = ibv_cmd_dealloc_mw(ibmw);
>>>>>> +       if (ret)
>>>>>> +               return ret;
>>>>>> +
>>>>>> +       free(ibmw);
>>>>>> +       return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int next_rkey(int rkey)
>>>>>> +{
>>>>>> +       return (rkey & 0xffffff00) | ((rkey + 1) & 0x000000ff);
>>>>>> +}
>>>>>> +
>>>>>> +static int rxe_post_send(struct ibv_qp *ibqp, struct ibv_send_wr *wr_list,
>>>>>> +                        struct ibv_send_wr **bad_wr);
>>>>>> +
>>>>>> +static int rxe_bind_mw(struct ibv_qp *ibqp, struct ibv_mw *ibmw,
>>>>>> +                       struct ibv_mw_bind *mw_bind)
>>>>>> +{
>>>>>> +       int ret;
>>>>>> +       struct ibv_mw_bind_info *bind_info = &mw_bind->bind_info;
>>>>>> +       struct ibv_send_wr ibwr;
>>>>>> +       struct ibv_send_wr *bad_wr;
>>>>>> +
>>>>>> +       if (!bind_info->mr && (bind_info->addr || bind_info->length)) {
>>>>>> +               ret = EINVAL;
>>>>>> +               goto err;
>>>>>> +       }
>>>>>> +
>>>>>> +       if (bind_info->mw_access_flags & IBV_ACCESS_ZERO_BASED) {
>>>>>> +               ret = EINVAL;
>>>>>> +               goto err;
>>>>>> +       }
>>>>>> +
>>>>>> +       if (bind_info->mr) {
>>>>>> +               if (ibmw->pd != bind_info->mr->pd) {
>>>>>> +                       ret = EPERM;
>>>>>> +                       goto err;
>>>>>> +               }
>>>>>> +       }
>>>>>> +
>>>>>> +       memset(&ibwr, 0, sizeof(ibwr));
>>>>>> +
>>>>>> +       ibwr.opcode             = IBV_WR_BIND_MW;
>>>>>> +       ibwr.next               = NULL;
>>>>>> +       ibwr.wr_id              = mw_bind->wr_id;
>>>>>> +       ibwr.send_flags         = mw_bind->send_flags;
>>>>>> +       ibwr.bind_mw.bind_info  = mw_bind->bind_info;
>>>>>> +       ibwr.bind_mw.mw         = ibmw;
>>>>>> +       ibwr.bind_mw.rkey       = next_rkey(ibmw->rkey);
>>>>>> +
>>>>>> +       ret = rxe_post_send(ibqp, &ibwr, &bad_wr);
>>>>>> +       if (ret)
>>>>>> +               goto err;
>>>>>> +
>>>>>> +       /* user has to undo this if he gets an error wc */
>>>>>> +       ibmw->rkey = ibwr.bind_mw.rkey;
>>>>>> +
>>>>>> +       return 0;
>>>>>> +err:
>>>>>> +       errno = ret;
>>>>>> +       return errno;
>>>>>> +}
>>>>>> +
>>>>>>    static struct ibv_mr *rxe_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
>>>>>>                                    uint64_t hca_va, int access)
>>>>>>    {
>>>>>> @@ -715,6 +804,31 @@ static void wr_atomic_fetch_add(struct ibv_qp_ex *ibqp, uint32_t rkey,
>>>>>>           advance_qp_cur_index(qp);
>>>>>>    }
>>>>>>
>>>>>> +static void wr_bind_mw(struct ibv_qp_ex *ibqp, struct ibv_mw *ibmw,
>>>>>> +                      uint32_t rkey, const struct ibv_mw_bind_info *info)
>>>>>> +{
>>>>>> +       struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
>>>>>> +       struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
>>>>>> +
>>>>>> +       if (check_qp_queue_full(qp))
>>>>>> +               return;
>>>>>> +
>>>>>> +       memset(wqe, 0, sizeof(*wqe));
>>>>>> +
>>>>>> +       wqe->wr.wr_id = ibqp->wr_id;
>>>>>> +       wqe->wr.opcode = IBV_WR_BIND_MW;
>>>>>> +       wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
>>>>>> +       wqe->wr.wr.mw.addr = info->addr;
>>>>>> +       wqe->wr.wr.mw.length = info->length;
>>>>>> +       wqe->wr.wr.mw.mr_lkey = info->mr->lkey;
>>>>>> +       wqe->wr.wr.mw.mw_rkey = ibmw->rkey;
>>>>>> +       wqe->wr.wr.mw.rkey = rkey;
>>>>>> +       wqe->wr.wr.mw.access = info->mw_access_flags;
>>>>>> +       wqe->ssn = qp->ssn++;
>>>>>> +
>>>>>> +       advance_qp_cur_index(qp);
>>>>>> +}
>>>>>> +
>>>>>>    static void wr_local_inv(struct ibv_qp_ex *ibqp, uint32_t invalidate_rkey)
>>>>>>    {
>>>>>>           struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
>>>>>> @@ -1106,6 +1220,7 @@ enum {
>>>>>>                   | IBV_QP_EX_WITH_ATOMIC_CMP_AND_SWP
>>>>>>                   | IBV_QP_EX_WITH_ATOMIC_FETCH_AND_ADD
>>>>>>                   | IBV_QP_EX_WITH_LOCAL_INV
>>>>>> +               | IBV_QP_EX_WITH_BIND_MW
>>>>>>                   | IBV_QP_EX_WITH_SEND_WITH_INV,
>>>>>>
>>>>>>           RXE_SUP_UC_QP_SEND_OPS_FLAGS =
>>>>>> @@ -1113,6 +1228,7 @@ enum {
>>>>>>                   | IBV_QP_EX_WITH_RDMA_WRITE_WITH_IMM
>>>>>>                   | IBV_QP_EX_WITH_SEND
>>>>>>                   | IBV_QP_EX_WITH_SEND_WITH_IMM
>>>>>> +               | IBV_QP_EX_WITH_BIND_MW
>>>>>>                   | IBV_QP_EX_WITH_SEND_WITH_INV,
>>>>>>
>>>>>>           RXE_SUP_UD_QP_SEND_OPS_FLAGS =
>>>>>> @@ -1162,6 +1278,9 @@ static void set_qp_send_ops(struct rxe_qp *qp, uint64_t flags)
>>>>>>           if (flags & IBV_QP_EX_WITH_ATOMIC_FETCH_AND_ADD)
>>>>>>                   qp->vqp.qp_ex.wr_atomic_fetch_add = wr_atomic_fetch_add;
>>>>>>
>>>>>> +       if (flags & IBV_QP_EX_WITH_BIND_MW)
>>>>>> +               qp->vqp.qp_ex.wr_bind_mw = wr_bind_mw;
>>>>>> +
>>>>>>           if (flags & IBV_QP_EX_WITH_LOCAL_INV)
>>>>>>                   qp->vqp.qp_ex.wr_local_inv = wr_local_inv;
>>>>>>
>>>>>> @@ -1275,9 +1394,10 @@ static int rxe_destroy_qp(struct ibv_qp *ibqp)
>>>>>>    }
>>>>>>
>>>>>>    /* basic sanity checks for send work request */
>>>>>> -static int validate_send_wr(struct rxe_wq *sq, struct ibv_send_wr *ibwr,
>>>>>> +static int validate_send_wr(struct rxe_qp *qp, struct ibv_send_wr *ibwr,
>>>>>>                               unsigned int length)
>>>>>>    {
>>>>>> +       struct rxe_wq *sq = &qp->sq;
>>>>>>           enum ibv_wr_opcode opcode = ibwr->opcode;
>>>>>>
>>>>>>           if (ibwr->num_sge > sq->max_sge)
>>>>>> @@ -1291,11 +1411,26 @@ static int validate_send_wr(struct rxe_wq *sq, struct ibv_send_wr *ibwr,
>>>>>>           if ((ibwr->send_flags & IBV_SEND_INLINE) && (length > sq->max_inline))
>>>>>>                   return -EINVAL;
>>>>>>
>>>>>> +       if (ibwr->opcode == IBV_WR_BIND_MW) {
>>>>>> +               if (length)
>>>>>> +                       return -EINVAL;
>>>>>> +               if (ibwr->num_sge)
>>>>>> +                       return -EINVAL;
>>>>>> +               if (ibwr->imm_data)
>>>>>> +                       return -EINVAL;
>>>>>> +               if ((qp_type(qp) != IBV_QPT_RC) &&
>>>>>> +                   (qp_type(qp) != IBV_QPT_UC))
>>>>>> +                       return -EINVAL;
>>>>>> +       }
>>>>>> +
>>>>>>           return 0;
>>>>>>    }
>>>>>>
>>>>>>    static void convert_send_wr(struct rxe_send_wr *kwr, struct ibv_send_wr *uwr)
>>>>>>    {
>>>>>> +       struct ibv_mw *ibmw;
>>>>>> +       struct ibv_mr *ibmr;
>>>>>> +
>>>>>>           memset(kwr, 0, sizeof(*kwr));
>>>>>>
>>>>>>           kwr->wr_id              = uwr->wr_id;
>>>>>> @@ -1326,6 +1461,18 @@ static void convert_send_wr(struct rxe_send_wr *kwr, struct ibv_send_wr *uwr)
>>>>>>                   kwr->wr.atomic.rkey             = uwr->wr.atomic.rkey;
>>>>>>                   break;
>>>>>>
>>>>>> +       case IBV_WR_BIND_MW:
>>>>>> +               ibmr = uwr->bind_mw.bind_info.mr;
>>>>>> +               ibmw = uwr->bind_mw.mw;
>>>>>> +
>>>>>> +               kwr->wr.mw.addr = uwr->bind_mw.bind_info.addr;
>>>>>> +               kwr->wr.mw.length = uwr->bind_mw.bind_info.length;
>>>>>> +               kwr->wr.mw.mr_lkey = ibmr->lkey;
>>>>>> +               kwr->wr.mw.mw_rkey = ibmw->rkey;
>>>>>> +               kwr->wr.mw.rkey = uwr->bind_mw.rkey;
>>>>>> +               kwr->wr.mw.access = uwr->bind_mw.bind_info.mw_access_flags;
>>>>>> +               break;
>>>>>> +
>>>>>>           default:
>>>>>>                   break;
>>>>>>           }
>>>>>> @@ -1348,6 +1495,8 @@ static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
>>>>>>           if (ibwr->send_flags & IBV_SEND_INLINE) {
>>>>>>                   uint8_t *inline_data = wqe->dma.inline_data;
>>>>>>
>>>>>> +               wqe->dma.resid = 0;
>>>>>> +
>>>>>>                   for (i = 0; i < num_sge; i++) {
>>>>>>                           memcpy(inline_data,
>>>>>>                                  (uint8_t *)(long)ibwr->sg_list[i].addr,
>>>>>> @@ -1363,6 +1512,7 @@ static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
>>>>>>                   wqe->iova       = ibwr->wr.atomic.remote_addr;
>>>>>>           else
>>>>>>                   wqe->iova       = ibwr->wr.rdma.remote_addr;
>>>>>> +
>>>>>>           wqe->dma.length         = length;
>>>>>>           wqe->dma.resid          = length;
>>>>>>           wqe->dma.num_sge        = num_sge;
>>>>>> @@ -1385,7 +1535,7 @@ static int post_one_send(struct rxe_qp *qp, struct rxe_wq *sq,
>>>>>>           for (i = 0; i < ibwr->num_sge; i++)
>>>>>>                   length += ibwr->sg_list[i].length;
>>>>>>
>>>>>> -       err = validate_send_wr(sq, ibwr, length);
>>>>>> +       err = validate_send_wr(qp, ibwr, length);
>>>>>>           if (err) {
>>>>>>                   printf("validate send failed\n");
>>>>>>                   return err;
>>>>>> @@ -1579,6 +1729,9 @@ static const struct verbs_context_ops rxe_ctx_ops = {
>>>>>>           .dealloc_pd = rxe_dealloc_pd,
>>>>>>           .reg_mr = rxe_reg_mr,
>>>>>>           .dereg_mr = rxe_dereg_mr,
>>>>>> +       .alloc_mw = rxe_alloc_mw,
>>>>>> +       .dealloc_mw = rxe_dealloc_mw,
>>>>>> +       .bind_mw = rxe_bind_mw,
>>>>>>           .create_cq = rxe_create_cq,
>>>>>>           .create_cq_ex = rxe_create_cq_ex,
>>>>>>           .poll_cq = rxe_poll_cq,
>>>>>> --
>>>>>> 2.30.2
>>>>>>
