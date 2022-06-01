Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D31053AC12
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jun 2022 19:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349218AbiFARiA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Jun 2022 13:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbiFARh6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Jun 2022 13:37:58 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D328721E
        for <linux-rdma@vger.kernel.org>; Wed,  1 Jun 2022 10:37:57 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-f2a4c51c45so3623233fac.9
        for <linux-rdma@vger.kernel.org>; Wed, 01 Jun 2022 10:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eJE05p0bJDBvd3yZHTsIH/nWZSLbHpICei9B9RhG5aw=;
        b=jvOuVAjEdeCTK7MQBLpdLlE44H4dBQiWUBfZyJBFGfruyS5gTgXPvBGNYevWfmlPue
         RGynn7Ez7EcIJTxVFTLaa7TXy7sF7XCf7uJudeYrSm1snmvDHqOj2lB94X7CSj15L9+5
         vZTgVofSchz2TcCG6rvXYLP48GLERJN1UeJ8Tjq3L/YHc7JuQzQmViJcnUX+AoC7RO5d
         BPSrRmDDl9XEYJie52SIjLMHVoknNxjI1Y1VK6ea0dUQe3ajUIBSYE+hqSroHyerWZ32
         r8D1caMgIdHkkz3bxiiH8GzsnB+DjP6GND4CB3CinXvf2ArrL/sRXFaadxhKq0iGN/sz
         QKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eJE05p0bJDBvd3yZHTsIH/nWZSLbHpICei9B9RhG5aw=;
        b=mLQZ+mcLjh9XsaDFjUgcFnrhn2nX0cQm8iJgNCawFrbC7WOikOtXzMICRFFEVbybVi
         6oBxtOL0EwM5JUKgjKtB34E772yHAF6mGuZF4JcOgoczn/mUG7K7U4+U9bqhAI70iJ94
         g84ipDoTfUCzeTn9O47F2Slvs0yrlnqDyq8dK5/GtOJBIA63SYEO7LZ1GvXIjOooYT0a
         IVsGeDiBAeQFTiDwRE7+uagt3l46nEL2n67Ov2ApHAnLcbw9I1CUQ1z4FoaWsNJjLnR4
         Rq3L8Cladqo9PABawjUwT0jKyuPNVMu9x7Vyc1pneymbjwFGCNB0g/suXGyMakuVBLL6
         zBMg==
X-Gm-Message-State: AOAM531BEAh87KwTaupQgB9emzMoU5MFSNxQRgfz39rKx+En2Vc+EadU
        t5NITZCq0C2kkNuIgYw74b9CJK0DQqM=
X-Google-Smtp-Source: ABdhPJysmswNm+gN9z83B51+0pM4DuxrqUZkBtWraIkxsBqmHg5bcEULLFs8wErhkbF7j6/SzGsBiA==
X-Received: by 2002:a05:6870:a68e:b0:f2:bc5e:1ab7 with SMTP id i14-20020a056870a68e00b000f2bc5e1ab7mr18500172oam.193.1654105075935;
        Wed, 01 Jun 2022 10:37:55 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:bd76:6a87:66a:a88b? (2603-8081-140c-1a00-bd76-6a87-066a-a88b.res6.spectrum.com. [2603:8081:140c:1a00:bd76:6a87:66a:a88b])
        by smtp.gmail.com with ESMTPSA id c16-20020a544e90000000b0032b1b84f4e3sm1178304oiy.22.2022.06.01.10.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 10:37:55 -0700 (PDT)
Message-ID: <3fb832ea-5933-690d-5b81-ae3cc7ffe2c7@gmail.com>
Date:   Wed, 1 Jun 2022 12:37:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: RDME/rxe: Fast reg with local access rights and invalidation for
 that MR
Content-Language: en-US
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aleksei Marov <aleksei.marov@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>
References: <CAJpMwyjL4iWSSLh_pgWEqLT7oCLgMAFCAdZTJ0w1Rv-gkDNDFQ@mail.gmail.com>
 <bb958406-14a1-e785-a525-9c1d5132f10e@gmail.com>
 <CAJpMwyj2YFyPqHprFUHvGHMBDgT7fFu72WSdXU0KZM8BMgm_7Q@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAJpMwyj2YFyPqHprFUHvGHMBDgT7fFu72WSdXU0KZM8BMgm_7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/1/22 11:15, Haris Iqbal wrote:
> On Tue, May 31, 2022 at 7:12 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> On 5/30/22 06:05, Haris Iqbal wrote:
>>> Hi Bob,
>>>
>>> I have a query. After the following patch,
>>>
>>> https://marc.info/?l=linux-rdma&m=163163776430842&w=2
>>>
>>> If I send a IB_WR_REG_MR wr with flag set to IB_ACCESS_LOCAL_WRITE,
>>> rxe will set the mr->rkey to 0 (mr->lkey will be set to the key I send
>>> in wr).
>>>
>>> Afterwards, If I have to invalidate that mr with IB_WR_LOCAL_INV,
>>> setting the .ex.invalidate_rkey to the key I sent previously in the
>>> IB_WR_REG_MR wr, the invalidate would fail with the following error.
>>>
>>> rkey (%#x) doesn't match mr->rkey
>>> (function rxe_invalidate_mr)
>>>
>>> Is this desired behaviour? If so, how would I go about invalidating
>>> the above MR?
>>>
>>> Regards
>>> -Haris
>>
>> I think that the first behavior is correct. If you don't do this then the
>> MR is open for RDMA operations which you didn't allow.
>>
>> The second behavior is more interesting. If you are doing a send_with_invalidate
>> from a remote node then no reason you should allow the remote node to do
>> anything to the MR since it didn't have access to begin with. For a local invalidate MR
>> If you read the IBA it claims that local invalidate operations should provide
>> the lkey, rkey and memory handle as parameters to the operation and that the
>> lkey should be invalidated and the rkey if there is one should be invalidated. But
>> ib_verbs.h only has one parameter labeled rkey.
>>
>> The rxe driver follows most other providers and always makes the lkey and rkey the same
>> if there is an rkey else the rkey is set to zero. So rxe_invalidate_mr should compare
>> to the lkey and not the rkey for local invalidate. And then move the MR to the FREE state.
>>
>> This is a bug. Fortunately the majority of use cases for physical memory regions are
>> for RDMA access.
> 
> Thanks for the response Bob. I understand now.
> 
>>
>> Feel free to submit a patch or I will if you don't care to. The rxe_invalidate_mr() subroutine
>> needs have a new parameter since it is shared by local and remote invalidate operations and
>> they need to behave differently. Easiest is to have an lkey and rkey parameter. The local
>> operation would set the lkey and the remote operation the rkey.
> 
> Do you mean something like this?
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h
> b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 0e022ae1b8a5..1e6a6d8d330b 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -77,7 +77,7 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int
> access, u32 key,
>                          enum rxe_mr_lookup_type type);
>  int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
>  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
> -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
> +int rxe_invalidate_mr(struct rxe_qp *qp, u32 lkey, u32 rkey);
>  int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
>  int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
>  int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c
> b/drivers/infiniband/sw/rxe/rxe_mr.c
> index fc3942e04a1f..cbdb8fa9a08e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -576,20 +576,27 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int
> access, u32 key,
>         return mr;
>  }
> 
> -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
> +int rxe_invalidate_mr(struct rxe_qp *qp, u32 lkey, u32 rkey)
>  {
>         struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
>         struct rxe_mr *mr;
>         int ret;
> 
> -       mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
> +       mr = rxe_pool_get_index(&rxe->mr_pool, (lkey ? lkey : rkey) >> 8);
>         if (!mr) {
> -               pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
> +               pr_err("%s: No MR for key %#x\n", __func__, (lkey ?
> lkey : rkey));
>                 ret = -EINVAL;
>                 goto err;
>         }
> 
> -       if (rkey != mr->rkey) {
> +       if (lkey && lkey != mr->lkey) {
> +               pr_err("%s: lkey (%#x) doesn't match mr->lkey (%#x)\n",
> +                       __func__, lkey, mr->lkey);
> +               ret = -EINVAL;
> +               goto err_drop_ref;
> +       }
> +
> +       if (rkey && rkey != mr->rkey) {
>                 pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
>                         __func__, rkey, mr->rkey);
>                 ret = -EINVAL;
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c
> b/drivers/infiniband/sw/rxe/rxe_req.c
> index 9d98237389cf..478b86f59f6c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -550,7 +550,7 @@ static int rxe_do_local_ops(struct rxe_qp *qp,
> struct rxe_send_wqe *wqe)
>                 if (rkey_is_mw(rkey))
>                         ret = rxe_invalidate_mw(qp, rkey);
>                 else
> -                       ret = rxe_invalidate_mr(qp, rkey);
> +                       ret = rxe_invalidate_mr(qp, rkey, 0);
> 
>                 if (unlikely(ret)) {
>                         wqe->status = IB_WC_LOC_QP_OP_ERR;
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c
> b/drivers/infiniband/sw/rxe/rxe_resp.c
> index d995ddbe23a0..48b474703aa7 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -803,7 +803,7 @@ static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
>         if (rkey_is_mw(rkey))
>                 return rxe_invalidate_mw(qp, rkey);
>         else
> -               return rxe_invalidate_mr(qp, rkey);
> +               return rxe_invalidate_mr(qp, 0, rkey);
>  }
> 
> Another alternate way would be to separate the invalidate into 2
> functions. One for local and the other for remote.
> That way it will be clearer and we avoid the weird use of ternary
> operator in rxe_pool_get_index and the print afterwards.
> Something like this?
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h
> b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 0e022ae1b8a5..4da57abbbc8c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -77,7 +77,8 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int
> access, u32 key,
>                          enum rxe_mr_lookup_type type);
>  int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
>  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
> -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
> +int rxe_invalidate_mr_local(struct rxe_qp *qp, u32 lkey);
> +int rxe_invalidate_mr_remote(struct rxe_qp *qp, u32 rkey);
>  int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
>  int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
>  int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c
> b/drivers/infiniband/sw/rxe/rxe_mr.c
> index fc3942e04a1f..1c7179dd92eb 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -576,41 +576,72 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int
> access, u32 key,
>         return mr;
>  }
> 
> -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
> +static int rxe_invalidate_mr(struct rxe_mr *mr)
> +{
> +       if (atomic_read(&mr->num_mw) > 0) {
> +               pr_warn("%s: Attempt to invalidate an MR while bound to MWs\n",
> +                       __func__);
> +               return -EINVAL;
> +       }
> +
> +       if (unlikely(mr->type != IB_MR_TYPE_MEM_REG)) {
> +               pr_warn("%s: mr->type (%d) is wrong type\n", __func__,
> mr->type);
> +               return -EINVAL;
> +       }
> +
> +       mr->state = RXE_MR_STATE_FREE;
> +       return 0;
> +}
> +
> +int rxe_invalidate_mr_local(struct rxe_qp *qp, u32 lkey)
>  {
>         struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
>         struct rxe_mr *mr;
>         int ret;
> 
> -       mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
> +       mr = rxe_pool_get_index(&rxe->mr_pool, lkey >> 8);
>         if (!mr) {
> -               pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
> +               pr_err("%s: No MR for lkey %#x\n", __func__, lkey);
>                 ret = -EINVAL;
>                 goto err;
>         }
> 
> -       if (rkey != mr->rkey) {
> -               pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
> -                       __func__, rkey, mr->rkey);
> +       if (lkey != mr->lkey) {
> +               pr_err("%s: lkey (%#x) doesn't match mr->lkey (%#x)\n",
> +                       __func__, lkey, mr->lkey);
>                 ret = -EINVAL;
>                 goto err_drop_ref;
>         }
> 
> -       if (atomic_read(&mr->num_mw) > 0) {
> -               pr_warn("%s: Attempt to invalidate an MR while bound to MWs\n",
> -                       __func__);
> +       ret = rxe_invalidate_mr(mr);
> +
> +err_drop_ref:
> +       rxe_put(mr);
> +err:
> +       return ret;
> +}
> +
> +int rxe_invalidate_mr_remote(struct rxe_qp *qp, u32 rkey)
> +{
> +       struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> +       struct rxe_mr *mr;
> +       int ret;
> +
> +       mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
> +       if (!mr) {
> +               pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
>                 ret = -EINVAL;
> -               goto err_drop_ref;
> +               goto err;
>         }
> 
> -       if (unlikely(mr->type != IB_MR_TYPE_MEM_REG)) {
> -               pr_warn("%s: mr->type (%d) is wrong type\n", __func__,
> mr->type);
> +       if (rkey != mr->rkey) {
> +               pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
> +                       __func__, rkey, mr->rkey);
>                 ret = -EINVAL;
>                 goto err_drop_ref;
>         }
> 
> -       mr->state = RXE_MR_STATE_FREE;
> -       ret = 0;
> +       ret = rxe_invalidate_mr(mr);
> 
>  err_drop_ref:
>         rxe_put(mr);
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c
> b/drivers/infiniband/sw/rxe/rxe_req.c
> index 9d98237389cf..e7dd9738a255 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -550,7 +550,7 @@ static int rxe_do_local_ops(struct rxe_qp *qp,
> struct rxe_send_wqe *wqe)
>                 if (rkey_is_mw(rkey))
>                         ret = rxe_invalidate_mw(qp, rkey);
>                 else
> -                       ret = rxe_invalidate_mr(qp, rkey);
> +                       ret = rxe_invalidate_mr_local(qp, rkey);
> 
>                 if (unlikely(ret)) {
>                         wqe->status = IB_WC_LOC_QP_OP_ERR;
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c
> b/drivers/infiniband/sw/rxe/rxe_resp.c
> index d995ddbe23a0..234e7858fb12 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -803,7 +803,7 @@ static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
>         if (rkey_is_mw(rkey))
>                 return rxe_invalidate_mw(qp, rkey);
>         else
> -               return rxe_invalidate_mr(qp, rkey);
> +               return rxe_invalidate_mr_remote(qp, rkey);
>  }
> 
> I tested both with rnbd/rtrs and both works fine.
> Let me know which one looks better. I will send that one as a patch.

I like the second one better. May want to hold off until the merge window closes
to send it.

Zhu is the rxe maintainer so be sure to copy him and Jason.

Bob
> 
>>
>> Bob

