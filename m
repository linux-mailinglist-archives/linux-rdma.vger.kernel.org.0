Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54537660FC
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jul 2023 03:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjG1BH4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 21:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjG1BHy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 21:07:54 -0400
Received: from out-88.mta0.migadu.com (out-88.mta0.migadu.com [91.218.175.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B70030DC
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 18:07:52 -0700 (PDT)
Message-ID: <31d17c66-17fb-0d95-b64d-6f5bd3a3c123@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690506470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+/OWp9EOGfZFeS20WRq5sTFHV4XIL44gZFxnO9oxrjk=;
        b=dneGj7Us+6FRMzOsaePxyGRTN+Sx/7giXNeVWZPmW1oPFuE8mWM3+ryb0K3kbkRbQEcf4Y
        p06qQrLIjdXAmQpDLov1dd/UoJrSYsvKW1nH8ighAj70kmCI8XPzvXpfmRfDxd/5Kmb6IH
        b6isCIrThA6YhfiQBMnq3LtvKBt3Gkg=
Date:   Fri, 28 Jul 2023 09:07:40 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next v3 01/10] RDMA/rxe: Add sg fragment ops
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org, jhack@hpe.com
References: <20230727200128.65947-1-rpearsonhpe@gmail.com>
 <20230727200128.65947-2-rpearsonhpe@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230727200128.65947-2-rpearsonhpe@gmail.com>
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

在 2023/7/28 4:01, Bob Pearson 写道:
> Rename rxe_mr_copy_dir to rxe_mr_copy_op. This allows
> adding new fragment operations later.

In this commit, only renaming a enum from rxe_mr_copy_dir to 
rxe_mr_copy_op. And no bug fix and performance enhancing. I am not sure 
if it is good or not. Please Jason and Leon also check it.

Zhu Yanjun

> 
> This is in preparation for supporting fragmented skbs.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_comp.c  |  4 ++--
>   drivers/infiniband/sw/rxe/rxe_loc.h   |  4 ++--
>   drivers/infiniband/sw/rxe/rxe_mr.c    | 22 +++++++++++-----------
>   drivers/infiniband/sw/rxe/rxe_req.c   |  2 +-
>   drivers/infiniband/sw/rxe/rxe_resp.c  |  6 +++---
>   drivers/infiniband/sw/rxe/rxe_verbs.h |  6 +++---
>   6 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
> index 5111735aafae..e3f8dfc9b8bf 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -368,7 +368,7 @@ static inline enum comp_state do_read(struct rxe_qp *qp,
>   
>   	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
>   			&wqe->dma, payload_addr(pkt),
> -			payload_size(pkt), RXE_TO_MR_OBJ);
> +			payload_size(pkt), RXE_COPY_TO_MR);
>   	if (ret) {
>   		wqe->status = IB_WC_LOC_PROT_ERR;
>   		return COMPST_ERROR;
> @@ -390,7 +390,7 @@ static inline enum comp_state do_atomic(struct rxe_qp *qp,
>   
>   	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
>   			&wqe->dma, &atomic_orig,
> -			sizeof(u64), RXE_TO_MR_OBJ);
> +			sizeof(u64), RXE_COPY_TO_MR);
>   	if (ret) {
>   		wqe->status = IB_WC_LOC_PROT_ERR;
>   		return COMPST_ERROR;
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index cf38f4dcff78..532026cdd49e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -64,9 +64,9 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>   int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
>   int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length);
>   int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
> -		unsigned int length, enum rxe_mr_copy_dir dir);
> +		unsigned int length, enum rxe_mr_copy_op op);
>   int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
> -	      void *addr, int length, enum rxe_mr_copy_dir dir);
> +	      void *addr, int length, enum rxe_mr_copy_op op);
>   int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
>   		  int sg_nents, unsigned int *sg_offset);
>   int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index f54042e9aeb2..812c85cad463 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -243,7 +243,7 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
>   }
>   
>   static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
> -			      unsigned int length, enum rxe_mr_copy_dir dir)
> +			      unsigned int length, enum rxe_mr_copy_op op)
>   {
>   	unsigned int page_offset = rxe_mr_iova_to_page_offset(mr, iova);
>   	unsigned long index = rxe_mr_iova_to_index(mr, iova);
> @@ -259,7 +259,7 @@ static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
>   		bytes = min_t(unsigned int, length,
>   				mr_page_size(mr) - page_offset);
>   		va = kmap_local_page(page);
> -		if (dir == RXE_FROM_MR_OBJ)
> +		if (op == RXE_COPY_FROM_MR)
>   			memcpy(addr, va + page_offset, bytes);
>   		else
>   			memcpy(va + page_offset, addr, bytes);
> @@ -275,7 +275,7 @@ static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
>   }
>   
>   static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 dma_addr, void *addr,
> -			    unsigned int length, enum rxe_mr_copy_dir dir)
> +			    unsigned int length, enum rxe_mr_copy_op op)
>   {
>   	unsigned int page_offset = dma_addr & (PAGE_SIZE - 1);
>   	unsigned int bytes;
> @@ -288,10 +288,10 @@ static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 dma_addr, void *addr,
>   				PAGE_SIZE - page_offset);
>   		va = kmap_local_page(page);
>   
> -		if (dir == RXE_TO_MR_OBJ)
> -			memcpy(va + page_offset, addr, bytes);
> -		else
> +		if (op == RXE_COPY_FROM_MR)
>   			memcpy(addr, va + page_offset, bytes);
> +		else
> +			memcpy(va + page_offset, addr, bytes);
>   
>   		kunmap_local(va);
>   		page_offset = 0;
> @@ -302,7 +302,7 @@ static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 dma_addr, void *addr,
>   }
>   
>   int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
> -		unsigned int length, enum rxe_mr_copy_dir dir)
> +		unsigned int length, enum rxe_mr_copy_op op)
>   {
>   	int err;
>   
> @@ -313,7 +313,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
>   		return -EINVAL;
>   
>   	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
> -		rxe_mr_copy_dma(mr, iova, addr, length, dir);
> +		rxe_mr_copy_dma(mr, iova, addr, length, op);
>   		return 0;
>   	}
>   
> @@ -323,7 +323,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
>   		return err;
>   	}
>   
> -	return rxe_mr_copy_xarray(mr, iova, addr, length, dir);
> +	return rxe_mr_copy_xarray(mr, iova, addr, length, op);
>   }
>   
>   /* copy data in or out of a wqe, i.e. sg list
> @@ -335,7 +335,7 @@ int copy_data(
>   	struct rxe_dma_info	*dma,
>   	void			*addr,
>   	int			length,
> -	enum rxe_mr_copy_dir	dir)
> +	enum rxe_mr_copy_op	op)
>   {
>   	int			bytes;
>   	struct rxe_sge		*sge	= &dma->sge[dma->cur_sge];
> @@ -395,7 +395,7 @@ int copy_data(
>   
>   		if (bytes > 0) {
>   			iova = sge->addr + offset;
> -			err = rxe_mr_copy(mr, iova, addr, bytes, dir);
> +			err = rxe_mr_copy(mr, iova, addr, bytes, op);
>   			if (err)
>   				goto err2;
>   
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 51b781ac2844..f3653234cf32 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -327,7 +327,7 @@ static int rxe_init_payload(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
>   		wqe->dma.sge_offset += payload;
>   	} else {
>   		err = copy_data(qp->pd, 0, &wqe->dma, payload_addr(pkt),
> -				payload, RXE_FROM_MR_OBJ);
> +				payload, RXE_COPY_FROM_MR);
>   	}
>   
>   	return err;
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 8a25c56dfd86..596615c515ad 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -565,7 +565,7 @@ static enum resp_states send_data_in(struct rxe_qp *qp, void *data_addr,
>   	int err;
>   
>   	err = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE, &qp->resp.wqe->dma,
> -			data_addr, data_len, RXE_TO_MR_OBJ);
> +			data_addr, data_len, RXE_COPY_TO_MR);
>   	if (unlikely(err))
>   		return (err == -ENOSPC) ? RESPST_ERR_LENGTH
>   					: RESPST_ERR_MALFORMED_WQE;
> @@ -581,7 +581,7 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
>   	int data_len = payload_size(pkt);
>   
>   	err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
> -			  payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
> +			  payload_addr(pkt), data_len, RXE_COPY_TO_MR);
>   	if (err) {
>   		rc = RESPST_ERR_RKEY_VIOLATION;
>   		goto out;
> @@ -928,7 +928,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>   	}
>   
>   	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
> -			  payload, RXE_FROM_MR_OBJ);
> +			  payload, RXE_COPY_FROM_MR);
>   	if (err) {
>   		kfree_skb(skb);
>   		state = RESPST_ERR_RKEY_VIOLATION;
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index ccb9d19ffe8a..d9c44bd30da4 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -275,9 +275,9 @@ enum rxe_mr_state {
>   	RXE_MR_STATE_VALID,
>   };
>   
> -enum rxe_mr_copy_dir {
> -	RXE_TO_MR_OBJ,
> -	RXE_FROM_MR_OBJ,
> +enum rxe_mr_copy_op {
> +	RXE_COPY_TO_MR,
> +	RXE_COPY_FROM_MR,
>   };
>   
>   enum rxe_mr_lookup_type {

