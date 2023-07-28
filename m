Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7669776617C
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jul 2023 03:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjG1BtZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 21:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjG1BtY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 21:49:24 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908282723
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 18:49:21 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1bba1816960so1203072fac.3
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 18:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690508961; x=1691113761;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ppjPMItIwUOD07K8bq/Qon9XcEMTzGdCdAnV2mwtmI=;
        b=C0lres+3d6GphoPNN/nc0Lts8MCM282pjbovZbwcKpAq5W9Kho5Kq5tu4ZRgG3mJ6V
         h66GbjaGxkq6wC3Np/0dKuET/Uzt5mJEPgbnMriFl5smHBN2886KwIfoGxKTJZhrdfkm
         HZWHlTKpP2JatToSL3abcNQIn0AG7oP7PQ35lIo7QtI+CCGlHId1N5ry1xOb+IQ7rVNR
         ZZNzwv7U/XM38RlwAcfetfHLWfCXrPjgNPtbG+d2SNpkxhELgXsS0w//XYrxOiBUf9wq
         JUGQvl4Lc/typeYcSsjUnTKnyUEsCZLf+oF73alKpQPunlF+v2WIIUWjU3MYn/KO3Nxl
         +TIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690508961; x=1691113761;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ppjPMItIwUOD07K8bq/Qon9XcEMTzGdCdAnV2mwtmI=;
        b=WjvpQhschJGXRcWunAtZzXv6aDWV013e9MHYHsxBxLmpKtJIUHn6IyJqrOVtRtoSAB
         8nrmEnrobS/YoCowASgqxl3T5O3waOZ0kUvlLPG3xU0cxotkHD+c94IVayoV9UZhgb1k
         vaN7rug+uofK67+Bfe/cww1o/dEMRs4mt1M4DGO6kkcRm9qoC/CuKpeTD8uK85hBz7uy
         8e6PiSmJWkkFAX3b9g0QMIB9ZfjYLj3dQfHQtSYSu8b7vDFaUzfjAKP6RGwPzjIMTMoh
         B8MUFZ/4+sq3zm/3JcwJWpvFFL9YmlOOH3kJ6bgi7ibVlmSDxm7uXFdn4RCZpAJdl5af
         t/qw==
X-Gm-Message-State: ABy/qLZ7spRhljJw2d1nq2CKb3saU9FoGuwBoRcd+qycWFOTeoxD4a5J
        9xDctI7H//e0QvcFuu5c/PkoInbNQFw=
X-Google-Smtp-Source: APBJJlE3JrB1m1ETxUhGgDUzEYkc9XiqnYKvbJG98Qm+FC3VgsT0z3m94dgbbSN3tDMiAfCuR+LSAA==
X-Received: by 2002:a05:6870:b50b:b0:1bb:8abf:4a80 with SMTP id v11-20020a056870b50b00b001bb8abf4a80mr1545695oap.9.1690508960760;
        Thu, 27 Jul 2023 18:49:20 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:af49:6f67:7a95:d734? (2603-8081-140c-1a00-af49-6f67-7a95-d734.res6.spectrum.com. [2603:8081:140c:1a00:af49:6f67:7a95:d734])
        by smtp.gmail.com with ESMTPSA id c19-20020a4a2853000000b00569c240e398sm1202680oof.30.2023.07.27.18.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 18:49:20 -0700 (PDT)
Message-ID: <e9fe24b3-be37-d14f-d601-fdda8937eac9@gmail.com>
Date:   Thu, 27 Jul 2023 20:49:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-next v3 01/10] RDMA/rxe: Add sg fragment ops
Content-Language: en-US
To:     Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org, jhack@hpe.com
References: <20230727200128.65947-1-rpearsonhpe@gmail.com>
 <20230727200128.65947-2-rpearsonhpe@gmail.com>
 <31d17c66-17fb-0d95-b64d-6f5bd3a3c123@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <31d17c66-17fb-0d95-b64d-6f5bd3a3c123@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/27/23 20:07, Zhu Yanjun wrote:
> 在 2023/7/28 4:01, Bob Pearson 写道:
>> Rename rxe_mr_copy_dir to rxe_mr_copy_op. This allows
>> adding new fragment operations later.
> 
> In this commit, only renaming a enum from rxe_mr_copy_dir to rxe_mr_copy_op. And no bug fix and performance enhancing. I am not sure if it is good or not. Please Jason and Leon also check it.
> 
> Zhu Yanjun
> 
>>
>> This is in preparation for supporting fragmented skbs.

Read the next one.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_comp.c  |  4 ++--
>>   drivers/infiniband/sw/rxe/rxe_loc.h   |  4 ++--
>>   drivers/infiniband/sw/rxe/rxe_mr.c    | 22 +++++++++++-----------
>>   drivers/infiniband/sw/rxe/rxe_req.c   |  2 +-
>>   drivers/infiniband/sw/rxe/rxe_resp.c  |  6 +++---
>>   drivers/infiniband/sw/rxe/rxe_verbs.h |  6 +++---
>>   6 files changed, 22 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
>> index 5111735aafae..e3f8dfc9b8bf 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
>> @@ -368,7 +368,7 @@ static inline enum comp_state do_read(struct rxe_qp *qp,
>>         ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
>>               &wqe->dma, payload_addr(pkt),
>> -            payload_size(pkt), RXE_TO_MR_OBJ);
>> +            payload_size(pkt), RXE_COPY_TO_MR);
>>       if (ret) {
>>           wqe->status = IB_WC_LOC_PROT_ERR;
>>           return COMPST_ERROR;
>> @@ -390,7 +390,7 @@ static inline enum comp_state do_atomic(struct rxe_qp *qp,
>>         ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
>>               &wqe->dma, &atomic_orig,
>> -            sizeof(u64), RXE_TO_MR_OBJ);
>> +            sizeof(u64), RXE_COPY_TO_MR);
>>       if (ret) {
>>           wqe->status = IB_WC_LOC_PROT_ERR;
>>           return COMPST_ERROR;
>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
>> index cf38f4dcff78..532026cdd49e 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>> @@ -64,9 +64,9 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>>   int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
>>   int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length);
>>   int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
>> -        unsigned int length, enum rxe_mr_copy_dir dir);
>> +        unsigned int length, enum rxe_mr_copy_op op);
>>   int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
>> -          void *addr, int length, enum rxe_mr_copy_dir dir);
>> +          void *addr, int length, enum rxe_mr_copy_op op);
>>   int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
>>             int sg_nents, unsigned int *sg_offset);
>>   int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
>> index f54042e9aeb2..812c85cad463 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
>> @@ -243,7 +243,7 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
>>   }
>>     static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
>> -                  unsigned int length, enum rxe_mr_copy_dir dir)
>> +                  unsigned int length, enum rxe_mr_copy_op op)
>>   {
>>       unsigned int page_offset = rxe_mr_iova_to_page_offset(mr, iova);
>>       unsigned long index = rxe_mr_iova_to_index(mr, iova);
>> @@ -259,7 +259,7 @@ static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
>>           bytes = min_t(unsigned int, length,
>>                   mr_page_size(mr) - page_offset);
>>           va = kmap_local_page(page);
>> -        if (dir == RXE_FROM_MR_OBJ)
>> +        if (op == RXE_COPY_FROM_MR)
>>               memcpy(addr, va + page_offset, bytes);
>>           else
>>               memcpy(va + page_offset, addr, bytes);
>> @@ -275,7 +275,7 @@ static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
>>   }
>>     static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 dma_addr, void *addr,
>> -                unsigned int length, enum rxe_mr_copy_dir dir)
>> +                unsigned int length, enum rxe_mr_copy_op op)
>>   {
>>       unsigned int page_offset = dma_addr & (PAGE_SIZE - 1);
>>       unsigned int bytes;
>> @@ -288,10 +288,10 @@ static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 dma_addr, void *addr,
>>                   PAGE_SIZE - page_offset);
>>           va = kmap_local_page(page);
>>   -        if (dir == RXE_TO_MR_OBJ)
>> -            memcpy(va + page_offset, addr, bytes);
>> -        else
>> +        if (op == RXE_COPY_FROM_MR)
>>               memcpy(addr, va + page_offset, bytes);
>> +        else
>> +            memcpy(va + page_offset, addr, bytes);
>>             kunmap_local(va);
>>           page_offset = 0;
>> @@ -302,7 +302,7 @@ static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 dma_addr, void *addr,
>>   }
>>     int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
>> -        unsigned int length, enum rxe_mr_copy_dir dir)
>> +        unsigned int length, enum rxe_mr_copy_op op)
>>   {
>>       int err;
>>   @@ -313,7 +313,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
>>           return -EINVAL;
>>         if (mr->ibmr.type == IB_MR_TYPE_DMA) {
>> -        rxe_mr_copy_dma(mr, iova, addr, length, dir);
>> +        rxe_mr_copy_dma(mr, iova, addr, length, op);
>>           return 0;
>>       }
>>   @@ -323,7 +323,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
>>           return err;
>>       }
>>   -    return rxe_mr_copy_xarray(mr, iova, addr, length, dir);
>> +    return rxe_mr_copy_xarray(mr, iova, addr, length, op);
>>   }
>>     /* copy data in or out of a wqe, i.e. sg list
>> @@ -335,7 +335,7 @@ int copy_data(
>>       struct rxe_dma_info    *dma,
>>       void            *addr,
>>       int            length,
>> -    enum rxe_mr_copy_dir    dir)
>> +    enum rxe_mr_copy_op    op)
>>   {
>>       int            bytes;
>>       struct rxe_sge        *sge    = &dma->sge[dma->cur_sge];
>> @@ -395,7 +395,7 @@ int copy_data(
>>             if (bytes > 0) {
>>               iova = sge->addr + offset;
>> -            err = rxe_mr_copy(mr, iova, addr, bytes, dir);
>> +            err = rxe_mr_copy(mr, iova, addr, bytes, op);
>>               if (err)
>>                   goto err2;
>>   diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
>> index 51b781ac2844..f3653234cf32 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_req.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
>> @@ -327,7 +327,7 @@ static int rxe_init_payload(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
>>           wqe->dma.sge_offset += payload;
>>       } else {
>>           err = copy_data(qp->pd, 0, &wqe->dma, payload_addr(pkt),
>> -                payload, RXE_FROM_MR_OBJ);
>> +                payload, RXE_COPY_FROM_MR);
>>       }
>>         return err;
>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>> index 8a25c56dfd86..596615c515ad 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>> @@ -565,7 +565,7 @@ static enum resp_states send_data_in(struct rxe_qp *qp, void *data_addr,
>>       int err;
>>         err = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE, &qp->resp.wqe->dma,
>> -            data_addr, data_len, RXE_TO_MR_OBJ);
>> +            data_addr, data_len, RXE_COPY_TO_MR);
>>       if (unlikely(err))
>>           return (err == -ENOSPC) ? RESPST_ERR_LENGTH
>>                       : RESPST_ERR_MALFORMED_WQE;
>> @@ -581,7 +581,7 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
>>       int data_len = payload_size(pkt);
>>         err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
>> -              payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
>> +              payload_addr(pkt), data_len, RXE_COPY_TO_MR);
>>       if (err) {
>>           rc = RESPST_ERR_RKEY_VIOLATION;
>>           goto out;
>> @@ -928,7 +928,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>       }
>>         err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>> -              payload, RXE_FROM_MR_OBJ);
>> +              payload, RXE_COPY_FROM_MR);
>>       if (err) {
>>           kfree_skb(skb);
>>           state = RESPST_ERR_RKEY_VIOLATION;
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> index ccb9d19ffe8a..d9c44bd30da4 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> @@ -275,9 +275,9 @@ enum rxe_mr_state {
>>       RXE_MR_STATE_VALID,
>>   };
>>   -enum rxe_mr_copy_dir {
>> -    RXE_TO_MR_OBJ,
>> -    RXE_FROM_MR_OBJ,
>> +enum rxe_mr_copy_op {
>> +    RXE_COPY_TO_MR,
>> +    RXE_COPY_FROM_MR,
>>   };
>>     enum rxe_mr_lookup_type {
> 

