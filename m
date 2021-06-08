Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D7B39EF30
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 09:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhFHHEE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 03:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFHHEB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 03:04:01 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8D8C061574
        for <linux-rdma@vger.kernel.org>; Tue,  8 Jun 2021 00:01:55 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id u11so20638882oiv.1
        for <linux-rdma@vger.kernel.org>; Tue, 08 Jun 2021 00:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ztK+SACp6wzt/zLpxX94ZLsWT9Mb6NNfN1Ap0mf3xrA=;
        b=sqXttuq/qXV6+48o44LgZgwZNdA1ChpWVtLgJFcLo5AaoRp+bb7dhYPddkZ+2YFozQ
         VG5GywFPuC4iBs9AlvtTGLPMB+dK6ZtVA82WLfGKj42nnXkzRR6RVRw+biYjWjqUoCa6
         csE00cBk3QSasM7r0GrNpUpp6xhId7nl+m0NpWPC5cBJPLHvXyPRkkyKhrmrGuQlsmWx
         LdsoiYSF5rUWtJgr6qU2CfKykOe385XV6ypi5Cv4tfRwXHcjb+6E3LFah5MxgF35Y8rI
         xopc3x+pwg2VYrTpgS5a19oRszXvWYH/hR1d181ULw/NfqBunzbxdMdv3jnGens9879a
         V4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ztK+SACp6wzt/zLpxX94ZLsWT9Mb6NNfN1Ap0mf3xrA=;
        b=A/2PNT4gUljrBytoi8FBQ0ehCAmXK5/yVK6U/8HUiyhGVkLE9Oemjf/2g4s4a8tToY
         dTwHTS6JFTkcLpe99mga714eigjQMykWzDYryl0z6UliKIGUwpILAOw0+j57BtAZ3cD3
         XtwNF5tQaiabjBQAciXSER8T3Re/5pjRa2h/ApPmk+NYcMR3N/K091/CA9+ZhsA9JPuo
         q5AlU7UD9WbkqZHoTeP0abrnPbd0InwW0q/MN9J0HsvXBlSjBOawgou2K6owiUqDFMog
         xSYs7fYPyy0Qm3NKcrS8AHONZlRbANo6oCbBnDRDhErgf8tTn6x0iveqIU3C3iJ9CR6Y
         xbqA==
X-Gm-Message-State: AOAM530YR9CNkz0tBp+EZGHewkW+IXl2C7DDu5CeMaTJ22qODQaqzatb
        T2Z9gUdkZt+FkJXv+y1Bc6tUsJy23JA=
X-Google-Smtp-Source: ABdhPJwq5Q8y6/boqWO4f5uMn7iup5uoQ1XfSugFMCDbKM1p+lKncJ9YgaW3RwEGGeVJMQQ0DZP8TQ==
X-Received: by 2002:a54:4e81:: with SMTP id c1mr1932333oiy.119.1623135714736;
        Tue, 08 Jun 2021 00:01:54 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:cb25:4f27:965:41cc? (2603-8081-140c-1a00-cb25-4f27-0965-41cc.res6.spectrum.com. [2603:8081:140c:1a00:cb25:4f27:965:41cc])
        by smtp.gmail.com with ESMTPSA id v19sm2957451otk.22.2021.06.08.00.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 00:01:54 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] Providers/rxe: Implement memory windows
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Moni Shoua <monis@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210608042802.33419-1-rpearsonhpe@gmail.com>
 <20210608042802.33419-3-rpearsonhpe@gmail.com>
 <CAD=hENc53Loz3vF3xDQNQcrorS_gHtjE0psGODuctDn6c+pAMw@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <d9eae5b5-8866-b932-9b63-b76b670d52a2@gmail.com>
Date:   Tue, 8 Jun 2021 02:01:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAD=hENc53Loz3vF3xDQNQcrorS_gHtjE0psGODuctDn6c+pAMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/8/21 1:54 AM, Zhu Yanjun wrote:
> On Tue, Jun 8, 2021 at 12:28 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> This patch makes the required changes to the rxe provider to support the
>> kernel memory windows patches to the rxe driver.
>>
>> The following changes are made:
>>   - Add ibv_alloc_mw verb
>>   - Add ibv_dealloc_mw verb
>>   - Add ibv_bind_mw verb for type 1 MWs
>>   - Add support for bind MW send work requests through the traditional
>>     QP API and the extended QP API.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>> v2:
>>   Added support for extended QP bind MW work requests.
> 
> I got the following errors.
> Is it a known issue?
> 
> # ./bin/run_tests.py --dev rxe0
> .............sssssssss.............ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss........sssssssssssssssssss....ssss.........s...s.....E.......ssssssssss..ss
> ======================================================================
> ERROR: test_qp_ex_rc_bind_mw (tests.test_qpex.QpExTestCase)
> Verify bind memory window operation using the new post_send API.
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>   File "/root/rdma-core/tests/test_qpex.py", line 292, in test_qp_ex_rc_bind_mw
>     u.poll_cq(server.cq)
>   File "/root/rdma-core/tests/utils.py", line 538, in poll_cq
>     raise PyverbsRDMAError('Completion status is {s}'.
> pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Memory
> window bind error. Errno: 6, No such device or address
> 
> ----------------------------------------------------------------------
> Ran 193 tests in 2.544s
> 
> FAILED (errors=1, skipped=128)
> 
> Zhu Yanjun
Yes. It is because the test is not setting the BIND_MW access for the MR. It is not permitted to bind an MW to a MR that does not have the BIND_MW access flag set. But this test mistakenly thinks it is going to work. The other MW tests in test_mr.py do set the BIND_MW access flag.
Bob
> 
>> ---
>>  providers/rxe/rxe.c | 157 +++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 155 insertions(+), 2 deletions(-)
>>
>> diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
>> index a68656ae..bb39ef04 100644
>> --- a/providers/rxe/rxe.c
>> +++ b/providers/rxe/rxe.c
>> @@ -128,6 +128,95 @@ static int rxe_dealloc_pd(struct ibv_pd *pd)
>>         return ret;
>>  }
>>
>> +static struct ibv_mw *rxe_alloc_mw(struct ibv_pd *ibpd, enum ibv_mw_type type)
>> +{
>> +       int ret;
>> +       struct ibv_mw *ibmw;
>> +       struct ibv_alloc_mw cmd = {};
>> +       struct ib_uverbs_alloc_mw_resp resp = {};
>> +
>> +       ibmw = calloc(1, sizeof(*ibmw));
>> +       if (!ibmw)
>> +               return NULL;
>> +
>> +       ret = ibv_cmd_alloc_mw(ibpd, type, ibmw, &cmd, sizeof(cmd),
>> +                                               &resp, sizeof(resp));
>> +       if (ret) {
>> +               free(ibmw);
>> +               return NULL;
>> +       }
>> +
>> +       return ibmw;
>> +}
>> +
>> +static int rxe_dealloc_mw(struct ibv_mw *ibmw)
>> +{
>> +       int ret;
>> +
>> +       ret = ibv_cmd_dealloc_mw(ibmw);
>> +       if (ret)
>> +               return ret;
>> +
>> +       free(ibmw);
>> +       return 0;
>> +}
>> +
>> +static int next_rkey(int rkey)
>> +{
>> +       return (rkey & 0xffffff00) | ((rkey + 1) & 0x000000ff);
>> +}
>> +
>> +static int rxe_post_send(struct ibv_qp *ibqp, struct ibv_send_wr *wr_list,
>> +                        struct ibv_send_wr **bad_wr);
>> +
>> +static int rxe_bind_mw(struct ibv_qp *ibqp, struct ibv_mw *ibmw,
>> +                       struct ibv_mw_bind *mw_bind)
>> +{
>> +       int ret;
>> +       struct ibv_mw_bind_info *bind_info = &mw_bind->bind_info;
>> +       struct ibv_send_wr ibwr;
>> +       struct ibv_send_wr *bad_wr;
>> +
>> +       if (!bind_info->mr && (bind_info->addr || bind_info->length)) {
>> +               ret = EINVAL;
>> +               goto err;
>> +       }
>> +
>> +       if (bind_info->mw_access_flags & IBV_ACCESS_ZERO_BASED) {
>> +               ret = EINVAL;
>> +               goto err;
>> +       }
>> +
>> +       if (bind_info->mr) {
>> +               if (ibmw->pd != bind_info->mr->pd) {
>> +                       ret = EPERM;
>> +                       goto err;
>> +               }
>> +       }
>> +
>> +       memset(&ibwr, 0, sizeof(ibwr));
>> +
>> +       ibwr.opcode             = IBV_WR_BIND_MW;
>> +       ibwr.next               = NULL;
>> +       ibwr.wr_id              = mw_bind->wr_id;
>> +       ibwr.send_flags         = mw_bind->send_flags;
>> +       ibwr.bind_mw.bind_info  = mw_bind->bind_info;
>> +       ibwr.bind_mw.mw         = ibmw;
>> +       ibwr.bind_mw.rkey       = next_rkey(ibmw->rkey);
>> +
>> +       ret = rxe_post_send(ibqp, &ibwr, &bad_wr);
>> +       if (ret)
>> +               goto err;
>> +
>> +       /* user has to undo this if he gets an error wc */
>> +       ibmw->rkey = ibwr.bind_mw.rkey;
>> +
>> +       return 0;
>> +err:
>> +       errno = ret;
>> +       return errno;
>> +}
>> +
>>  static struct ibv_mr *rxe_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
>>                                  uint64_t hca_va, int access)
>>  {
>> @@ -715,6 +804,31 @@ static void wr_atomic_fetch_add(struct ibv_qp_ex *ibqp, uint32_t rkey,
>>         advance_qp_cur_index(qp);
>>  }
>>
>> +static void wr_bind_mw(struct ibv_qp_ex *ibqp, struct ibv_mw *ibmw,
>> +                      uint32_t rkey, const struct ibv_mw_bind_info *info)
>> +{
>> +       struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
>> +       struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
>> +
>> +       if (check_qp_queue_full(qp))
>> +               return;
>> +
>> +       memset(wqe, 0, sizeof(*wqe));
>> +
>> +       wqe->wr.wr_id = ibqp->wr_id;
>> +       wqe->wr.opcode = IBV_WR_BIND_MW;
>> +       wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
>> +       wqe->wr.wr.mw.addr = info->addr;
>> +       wqe->wr.wr.mw.length = info->length;
>> +       wqe->wr.wr.mw.mr_lkey = info->mr->lkey;
>> +       wqe->wr.wr.mw.mw_rkey = ibmw->rkey;
>> +       wqe->wr.wr.mw.rkey = rkey;
>> +       wqe->wr.wr.mw.access = info->mw_access_flags;
>> +       wqe->ssn = qp->ssn++;
>> +
>> +       advance_qp_cur_index(qp);
>> +}
>> +
>>  static void wr_local_inv(struct ibv_qp_ex *ibqp, uint32_t invalidate_rkey)
>>  {
>>         struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
>> @@ -1106,6 +1220,7 @@ enum {
>>                 | IBV_QP_EX_WITH_ATOMIC_CMP_AND_SWP
>>                 | IBV_QP_EX_WITH_ATOMIC_FETCH_AND_ADD
>>                 | IBV_QP_EX_WITH_LOCAL_INV
>> +               | IBV_QP_EX_WITH_BIND_MW
>>                 | IBV_QP_EX_WITH_SEND_WITH_INV,
>>
>>         RXE_SUP_UC_QP_SEND_OPS_FLAGS =
>> @@ -1113,6 +1228,7 @@ enum {
>>                 | IBV_QP_EX_WITH_RDMA_WRITE_WITH_IMM
>>                 | IBV_QP_EX_WITH_SEND
>>                 | IBV_QP_EX_WITH_SEND_WITH_IMM
>> +               | IBV_QP_EX_WITH_BIND_MW
>>                 | IBV_QP_EX_WITH_SEND_WITH_INV,
>>
>>         RXE_SUP_UD_QP_SEND_OPS_FLAGS =
>> @@ -1162,6 +1278,9 @@ static void set_qp_send_ops(struct rxe_qp *qp, uint64_t flags)
>>         if (flags & IBV_QP_EX_WITH_ATOMIC_FETCH_AND_ADD)
>>                 qp->vqp.qp_ex.wr_atomic_fetch_add = wr_atomic_fetch_add;
>>
>> +       if (flags & IBV_QP_EX_WITH_BIND_MW)
>> +               qp->vqp.qp_ex.wr_bind_mw = wr_bind_mw;
>> +
>>         if (flags & IBV_QP_EX_WITH_LOCAL_INV)
>>                 qp->vqp.qp_ex.wr_local_inv = wr_local_inv;
>>
>> @@ -1275,9 +1394,10 @@ static int rxe_destroy_qp(struct ibv_qp *ibqp)
>>  }
>>
>>  /* basic sanity checks for send work request */
>> -static int validate_send_wr(struct rxe_wq *sq, struct ibv_send_wr *ibwr,
>> +static int validate_send_wr(struct rxe_qp *qp, struct ibv_send_wr *ibwr,
>>                             unsigned int length)
>>  {
>> +       struct rxe_wq *sq = &qp->sq;
>>         enum ibv_wr_opcode opcode = ibwr->opcode;
>>
>>         if (ibwr->num_sge > sq->max_sge)
>> @@ -1291,11 +1411,26 @@ static int validate_send_wr(struct rxe_wq *sq, struct ibv_send_wr *ibwr,
>>         if ((ibwr->send_flags & IBV_SEND_INLINE) && (length > sq->max_inline))
>>                 return -EINVAL;
>>
>> +       if (ibwr->opcode == IBV_WR_BIND_MW) {
>> +               if (length)
>> +                       return -EINVAL;
>> +               if (ibwr->num_sge)
>> +                       return -EINVAL;
>> +               if (ibwr->imm_data)
>> +                       return -EINVAL;
>> +               if ((qp_type(qp) != IBV_QPT_RC) &&
>> +                   (qp_type(qp) != IBV_QPT_UC))
>> +                       return -EINVAL;
>> +       }
>> +
>>         return 0;
>>  }
>>
>>  static void convert_send_wr(struct rxe_send_wr *kwr, struct ibv_send_wr *uwr)
>>  {
>> +       struct ibv_mw *ibmw;
>> +       struct ibv_mr *ibmr;
>> +
>>         memset(kwr, 0, sizeof(*kwr));
>>
>>         kwr->wr_id              = uwr->wr_id;
>> @@ -1326,6 +1461,18 @@ static void convert_send_wr(struct rxe_send_wr *kwr, struct ibv_send_wr *uwr)
>>                 kwr->wr.atomic.rkey             = uwr->wr.atomic.rkey;
>>                 break;
>>
>> +       case IBV_WR_BIND_MW:
>> +               ibmr = uwr->bind_mw.bind_info.mr;
>> +               ibmw = uwr->bind_mw.mw;
>> +
>> +               kwr->wr.mw.addr = uwr->bind_mw.bind_info.addr;
>> +               kwr->wr.mw.length = uwr->bind_mw.bind_info.length;
>> +               kwr->wr.mw.mr_lkey = ibmr->lkey;
>> +               kwr->wr.mw.mw_rkey = ibmw->rkey;
>> +               kwr->wr.mw.rkey = uwr->bind_mw.rkey;
>> +               kwr->wr.mw.access = uwr->bind_mw.bind_info.mw_access_flags;
>> +               break;
>> +
>>         default:
>>                 break;
>>         }
>> @@ -1348,6 +1495,8 @@ static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
>>         if (ibwr->send_flags & IBV_SEND_INLINE) {
>>                 uint8_t *inline_data = wqe->dma.inline_data;
>>
>> +               wqe->dma.resid = 0;
>> +
>>                 for (i = 0; i < num_sge; i++) {
>>                         memcpy(inline_data,
>>                                (uint8_t *)(long)ibwr->sg_list[i].addr,
>> @@ -1363,6 +1512,7 @@ static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
>>                 wqe->iova       = ibwr->wr.atomic.remote_addr;
>>         else
>>                 wqe->iova       = ibwr->wr.rdma.remote_addr;
>> +
>>         wqe->dma.length         = length;
>>         wqe->dma.resid          = length;
>>         wqe->dma.num_sge        = num_sge;
>> @@ -1385,7 +1535,7 @@ static int post_one_send(struct rxe_qp *qp, struct rxe_wq *sq,
>>         for (i = 0; i < ibwr->num_sge; i++)
>>                 length += ibwr->sg_list[i].length;
>>
>> -       err = validate_send_wr(sq, ibwr, length);
>> +       err = validate_send_wr(qp, ibwr, length);
>>         if (err) {
>>                 printf("validate send failed\n");
>>                 return err;
>> @@ -1579,6 +1729,9 @@ static const struct verbs_context_ops rxe_ctx_ops = {
>>         .dealloc_pd = rxe_dealloc_pd,
>>         .reg_mr = rxe_reg_mr,
>>         .dereg_mr = rxe_dereg_mr,
>> +       .alloc_mw = rxe_alloc_mw,
>> +       .dealloc_mw = rxe_dealloc_mw,
>> +       .bind_mw = rxe_bind_mw,
>>         .create_cq = rxe_create_cq,
>>         .create_cq_ex = rxe_create_cq_ex,
>>         .poll_cq = rxe_poll_cq,
>> --
>> 2.30.2
>>

