Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B9170C589
	for <lists+linux-rdma@lfdr.de>; Mon, 22 May 2023 20:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjEVSth (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 May 2023 14:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjEVStg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 May 2023 14:49:36 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C59E9;
        Mon, 22 May 2023 11:49:34 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-546ee6030e5so3162372eaf.3;
        Mon, 22 May 2023 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684781373; x=1687373373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPnh0GSbi1dq7uAWP5m2L0+IfeMa+LjsQJWktiIr+ME=;
        b=Q4xsD+MS+hGClA+44HAYaJ6HwnWDJaOjtxi3hPhQPBd3ezUrVg1RWULVFBI8Yjn9Ro
         BKAHaWhU+KdfVOu8NOjQnC2F/OwhayYvEcfPisXJ26ILOA5Djfe0r9waKwoaeKPcUVk+
         0plJ8yQZA4gVchhCvV7RGwdQAyZ63FXBm4NJasbBe25aPTiReoRb/2lyDrFJB4ow403z
         HbMegnpCcMgmlqrWfXebNy9+UFOFb0VMGVl/zv9klwP4f/wWIX4jCnSREOHgWjEV1w14
         opWNynAQ0lbp0bN9SR7YgcPSjBg+sWTveWNXz1D4+sJxcaqULY/c8bZVsLkXKAvBZspf
         F8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684781373; x=1687373373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPnh0GSbi1dq7uAWP5m2L0+IfeMa+LjsQJWktiIr+ME=;
        b=kThTZLLhPEnUbjmMJHR92zumIU4FiOkssm1bkxyaacci0j42F12/44S9kJrtLbsoLB
         FtdoxQ5scXpyPdX/mip6Oxi+/7+IMQ3AiQykI969gEeF0+9pEJCibhAOSZdJp4Ncw0dm
         yq7LgA1/2a+NL1m2rJiSOxieVD0GXsOEuqYsZ5KcUT3AVoXFqQOGzz+ReDcdUUU1qiu8
         +FaGNPMcsC5/272FAkuYwiDPEEnqhpD0+dU+bCs7QcAHEXlt1n8Vsm3GxNmxH/CddVbG
         WwdVY7MCchCtobAwb/Z0Ghmpi5eQXhzDgXeOzVQiRjQE+KzH85OlNegulgNvqgaencVt
         /+Kg==
X-Gm-Message-State: AC+VfDyb+tsUG3X4NwNTMhZy9S7FUU90JDPWGihCAHU3tbC2GxYfgSsl
        5QTdSB+3uZr8OSjt+M/Tz44LPuHkCW8ttQ==
X-Google-Smtp-Source: ACHHUZ5tF1GkdvqA6wyObI+k5g1uDTlNWrn8pA+WE6C6RNdTvF1kIKHvfNkgnOpQFdX+zzB8/i9ZFA==
X-Received: by 2002:a4a:6101:0:b0:547:6a79:18cb with SMTP id n1-20020a4a6101000000b005476a7918cbmr4842602ooc.9.1684781373241;
        Mon, 22 May 2023 11:49:33 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:738:17c9:f946:babd? (2603-8081-140c-1a00-0738-17c9-f946-babd.res6.spectrum.com. [2603:8081:140c:1a00:738:17c9:f946:babd])
        by smtp.gmail.com with ESMTPSA id q9-20020acaf209000000b003941dfbf924sm3052754oih.35.2023.05.22.11.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 11:49:32 -0700 (PDT)
Message-ID: <edad669f-e84e-a9ba-9554-87ae1d571931@gmail.com>
Date:   Mon, 22 May 2023 13:49:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-next v5 7/7] RDMA/rxe: Add support for the traditional
 Atomic operations with ODP
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, yangx.jy@fujitsu.com,
        lizhijian@fujitsu.com, y-goto@fujitsu.com
References: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
 <2841b1a86987564f14f15ec5b59f6a8bead86b30.1684397037.git.matsuda-daisuke@fujitsu.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <2841b1a86987564f14f15ec5b59f6a8bead86b30.1684397037.git.matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/18/23 03:21, Daisuke Matsuda wrote:
> Enable 'fetch and add' and 'compare and swap' operations to manipulate
> data in an ODP-enabled MR. This is comprised of the following steps:
>  1. Check the driver page table(umem_odp->dma_list) to see if the target
>     page is both readable and writable.
>  2. If not, then trigger page fault to map the page.
>  3. Update the entry in the MR xarray.
>  4. Execute the operation.
> 
> umem_mutex is used to ensure that dma_list (an array of addresses of an MR)
> is not changed while it is being checked and that the target page is not
> invalidated before data access completes.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c      |  1 +
>  drivers/infiniband/sw/rxe/rxe_loc.h  |  9 +++++++++
>  drivers/infiniband/sw/rxe/rxe_odp.c  | 26 ++++++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_resp.c |  5 ++++-
>  4 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index 207a022156f0..abd3267c2873 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -88,6 +88,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
>  		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_RECV;
>  		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_WRITE;
>  		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_READ;
> +		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_ATOMIC;
>  		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
>  	}
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 4b95c8c46bdc..b9d2985774ee 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -208,6 +208,9 @@ int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
>  			 u64 iova, int access_flags, struct rxe_mr *mr);
>  int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
>  		    enum rxe_mr_copy_dir dir);
> +int rxe_odp_mr_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
> +			 u64 compare, u64 swap_add, u64 *orig_val);
> +
>  #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
>  static inline int
>  rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
> @@ -221,6 +224,12 @@ rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int
> +rxe_odp_mr_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
> +		     u64 compare, u64 swap_add, u64 *orig_val)
> +{
> +	return RESPST_ERR_UNSUPPORTED_OPCODE;
> +}
>  
>  #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
>  
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index cbe5d0c3fcc4..194b1fab98b7 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -283,3 +283,29 @@ int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
>  
>  	return err;
>  }
> +
> +int rxe_odp_mr_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
> +			 u64 compare, u64 swap_add, u64 *orig_val)
> +{
> +	int err;
> +	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> +
> +	/* If pagefault is not required, umem mutex will be held until the
> +	 * atomic operation completes. Otherwise, it is released and locked
> +	 * again in rxe_odp_map_range() to let invalidation handler do its
> +	 * work meanwhile.
> +	 */
> +	mutex_lock(&umem_odp->umem_mutex);
> +
> +	/* Atomic operations manipulate a single char. */
> +	err = rxe_odp_map_range(mr, iova, sizeof(char), 0);
> +	if (err)
> +		return err;
> +
> +	err = rxe_mr_do_atomic_op(mr, iova, opcode, compare,
> +				  swap_add, orig_val);
> +
> +	mutex_unlock(&umem_odp->umem_mutex);
> +
> +	return err;
> +}
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 90c31c4f2944..0a918145dc07 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -684,7 +684,10 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
>  		u64 iova = qp->resp.va + qp->resp.offset;
>  
>  		if (mr->odp_enabled)
> -			err = RESPST_ERR_UNSUPPORTED_OPCODE;
> +			err = rxe_odp_mr_atomic_op(mr, iova, pkt->opcode,
> +						   atmeth_comp(pkt),
> +						   atmeth_swap_add(pkt),
> +						   &res->atomic.orig_val);
>  		else
>  			err = rxe_mr_do_atomic_op(mr, iova, pkt->opcode,
>  						  atmeth_comp(pkt),

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
