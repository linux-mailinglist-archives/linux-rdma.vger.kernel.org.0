Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF137708B92
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 00:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjERW2k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 May 2023 18:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjERW2j (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 May 2023 18:28:39 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1D6E50;
        Thu, 18 May 2023 15:28:38 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ab362d7401so2250107a34.2;
        Thu, 18 May 2023 15:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684448917; x=1687040917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KoAnS0334pHa55UnDLIrApfFGnSZeLuLWfYXXTwayDw=;
        b=BCMFq2vl1oe0ecC6BADlEazlwI3s31Dewh+ePz6se+PjnYC12BLZfUChvj8iN0cP2k
         FGnCyqRiS0n79mYZnTnjYBn7/JeE7T33trbXcBm+7UsBRrPZAy4MJEkuK9V+uuyJsv/f
         dYH3dUo6I158MVsIhPFWVSQuEGqbDbl2Xs3gjTY2mOJ7EsR5PJqISj2gRcYpZ2PCUs7k
         P8XuRH7RDK+DKev6KmVoGLlAEhQMwAfmdYKZbJexsd5bBaDSdwG+yMD1EDMp1Da02HkU
         6iuUD2GQkNwMRouIeeNK/FSeTQ2GBrwMtBP29i0a7jaZ4Bnw+WBTqaV5CjYXaSMnHrXh
         rbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684448917; x=1687040917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KoAnS0334pHa55UnDLIrApfFGnSZeLuLWfYXXTwayDw=;
        b=XrkCl3qQnlB9eWQOvzItq6SJL/1v+/o+F7xN94ePgjawzrkWd4iTG4Tfxt4AkiFd+L
         jW8q+v5QZQHrvLom4tuWau60U/CUJzffrYnfScHFcLQcLaszMncocgWVjbr6j5UPwLMn
         5Iz9ukVYUa0U4XrxYkdSfpp5wf7skVUGfUm4VmSEID823AvyEzzH57wf9235AfLi6sC5
         78BPCPjAwvz54ZKvxs9H3NhVTKGCJZTbdRMsq6vMCAsLfsh/w6ZyyE1ihEYUH8+GuxZt
         UBhrO0zoF3E3XLJnB50/8zwKhbaoLSfxwB0mZ2e51lXRAtccdIQF5ksQvuq0NLKCywYn
         CCZQ==
X-Gm-Message-State: AC+VfDxROSRw/pBxOQS/Y64n/23coGmUNaBHUAKoefFdRRbGbsUZZCYY
        xOa2r7+WyYnMvmqw1Wt6StE=
X-Google-Smtp-Source: ACHHUZ7R7XRRWTPHhIGSF2IWt8c+RU+FP4K3X4yA2YCrymRV67DjZORWDjQSUa1vGlNSIH+AG/Yr/A==
X-Received: by 2002:a05:6830:1352:b0:6ad:ed25:3caf with SMTP id r18-20020a056830135200b006aded253cafmr53923otq.9.1684448917618;
        Thu, 18 May 2023 15:28:37 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:1b3d:4b6b:e581:f922? (2603-8081-140c-1a00-1b3d-4b6b-e581-f922.res6.spectrum.com. [2603:8081:140c:1a00:1b3d:4b6b:e581:f922])
        by smtp.gmail.com with ESMTPSA id a5-20020a9d6e85000000b0069f0a85fa36sm1095846otr.57.2023.05.18.15.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 15:28:37 -0700 (PDT)
Message-ID: <a91d00eb-babc-de12-2413-c0d6a3b4dce6@gmail.com>
Date:   Thu, 18 May 2023 17:28:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-next v5 2/7] RDMA/rxe: Make MR functions accessible
 from other rxe source code
Content-Language: en-US
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, yangx.jy@fujitsu.com,
        lizhijian@fujitsu.com, y-goto@fujitsu.com
References: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
 <412a29df988820ba9b7f0e8b4198ecae5b3dc79e.1684397037.git.matsuda-daisuke@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <412a29df988820ba9b7f0e8b4198ecae5b3dc79e.1684397037.git.matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/18/23 03:21, Daisuke Matsuda wrote:
> Some functions in rxe_mr.c are going to be used in rxe_odp.c, which is to
> be created in the subsequent patch. List the declarations of the functions
> in rxe_loc.h.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h | 14 ++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_mr.c  | 18 ++++--------------
>  2 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 804b15e929dd..00fedd1a4980 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -60,7 +60,9 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
>  
>  /* rxe_mr.c */
>  u8 rxe_get_next_key(u32 last_key);
> +void rxe_mr_init(int access, struct rxe_mr *mr);
>  void rxe_mr_init_dma(int access, struct rxe_mr *mr);
> +int rxe_mr_fill_pages_from_sgt(struct rxe_mr *mr, struct sg_table *sgt);
>  int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>  		     int access, struct rxe_mr *mr);
>  int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
> @@ -71,6 +73,8 @@ int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
>  	      void *addr, int length, enum rxe_mr_copy_dir dir);
>  int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
>  		  int sg_nents, unsigned int *sg_offset);
> +int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
> +		       unsigned int length, enum rxe_mr_copy_dir dir);
>  int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>  			u64 compare, u64 swap_add, u64 *orig_val);
>  int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
> @@ -82,6 +86,16 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 key);
>  int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
>  void rxe_mr_cleanup(struct rxe_pool_elem *elem);
>  
> +static inline unsigned long rxe_mr_iova_to_index(struct rxe_mr *mr, u64 iova)
> +{
> +	return (iova >> mr->page_shift) - (mr->ibmr.iova >> mr->page_shift);
> +}
> +
> +static inline unsigned long rxe_mr_iova_to_page_offset(struct rxe_mr *mr, u64 iova)
> +{
> +	return iova & (mr_page_size(mr) - 1);
> +}
> +
>  /* rxe_mw.c */
>  int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
>  int rxe_dealloc_mw(struct ib_mw *ibmw);
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 0e538fafcc20..ffbac6f5e828 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -49,7 +49,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
>  				| IB_ACCESS_REMOTE_WRITE	\
>  				| IB_ACCESS_REMOTE_ATOMIC)
>  
> -static void rxe_mr_init(int access, struct rxe_mr *mr)
> +void rxe_mr_init(int access, struct rxe_mr *mr)
>  {
>  	u32 lkey = mr->elem.index << 8 | rxe_get_next_key(-1);
>  	u32 rkey = (access & IB_ACCESS_REMOTE) ? lkey : 0;
> @@ -77,16 +77,6 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr)
>  	mr->ibmr.type = IB_MR_TYPE_DMA;
>  }
>  
> -static unsigned long rxe_mr_iova_to_index(struct rxe_mr *mr, u64 iova)
> -{
> -	return (iova >> mr->page_shift) - (mr->ibmr.iova >> mr->page_shift);
> -}
> -
> -static unsigned long rxe_mr_iova_to_page_offset(struct rxe_mr *mr, u64 iova)
> -{
> -	return iova & (mr_page_size(mr) - 1);
> -}
> -
>  static bool is_pmem_page(struct page *pg)
>  {
>  	unsigned long paddr = page_to_phys(pg);
> @@ -96,7 +86,7 @@ static bool is_pmem_page(struct page *pg)
>  				 IORES_DESC_PERSISTENT_MEMORY);
>  }
>  
> -static int rxe_mr_fill_pages_from_sgt(struct rxe_mr *mr, struct sg_table *sgt)
> +int rxe_mr_fill_pages_from_sgt(struct rxe_mr *mr, struct sg_table *sgt)
>  {
>  	XA_STATE(xas, &mr->page_list, 0);
>  	struct sg_page_iter sg_iter;
> @@ -247,8 +237,8 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
>  	return ib_sg_to_pages(ibmr, sgl, sg_nents, sg_offset, rxe_set_page);
>  }
>  
> -static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
> -			      unsigned int length, enum rxe_mr_copy_dir dir)
> +int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
> +		       unsigned int length, enum rxe_mr_copy_dir dir)
>  {
>  	unsigned int page_offset = rxe_mr_iova_to_page_offset(mr, iova);
>  	unsigned long index = rxe_mr_iova_to_index(mr, iova);

Looks good.

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>

