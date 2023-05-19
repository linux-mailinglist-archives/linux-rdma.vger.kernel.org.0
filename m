Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C299709D99
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 19:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjESRKm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 May 2023 13:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjESRKh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 May 2023 13:10:37 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C130019A;
        Fri, 19 May 2023 10:10:33 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6ab02aeac3fso1392057a34.3;
        Fri, 19 May 2023 10:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684516233; x=1687108233;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uVYfVRtF/9FsZ8Q0W/f/n8Om/0lCEChbc6RynKt9GeQ=;
        b=C3jfxItjG5O0R+5Mf397mUWl+SBLUedzBUqCiSaF6QYFi/SdNAdelKUPiySGO0EqSo
         xLcRwHTv1j+lH7mglywB5LVxBUncW4l5xgE29EdjUU1VnlNGuEVIJg6RsRF2l+eGnnjE
         ip/ZWhmEF8Uz1HXtxzEdHW9WvlXkgUS1p9uShCq39T/eUMbw55MY70lsirqKcaN8Dn1F
         5nleTyB2+1bgz3nQbCMx1XJ531VP1y1ZNwCrsCT+h+JXADnptsew9Hunsge2qdubOcxE
         cQ0cY6D/yWFuMyulz2F5z9JPZFUJlntrwVLM3ZwUUDZKmAOYtEbc3ptC3IzDLWI/tXF8
         4ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516233; x=1687108233;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVYfVRtF/9FsZ8Q0W/f/n8Om/0lCEChbc6RynKt9GeQ=;
        b=LGNoYYebOUxl6M03pIfnJbMrRznRjh2USYFRHjfOKy34baIDyNkIqfkxnZmxcGOEeZ
         UfOaWQF+4SD/KbHHjQ0XXx6cEIN00/Et+HHllPKUwe64zK1q1sjBYeHt7CtmF7sbbbyK
         GHOL4DDeV+zc4YeNYo/JD+eK0FZY5DoGc1oklgV0hXzLkZKKXoC/0gaFTAXZ7bA3sUtJ
         D4eyfZXJlNCavO7qXUzLnNpIO1D0jjWJ1jT8A7EYae1EJhfNoxSUzCkDtInpwU4Isi9q
         f9ymlqDl9xcnx2P67FzYAzul4MdfvJVqkjOeRy56xc5WvEx2IOlMhYJfkTGK2dYKhQR+
         nAxA==
X-Gm-Message-State: AC+VfDwtEoHzw0+N4tE6hB2kR4RaDGC639WeZH1411EzTgr7p7OEyoFN
        draEm1QjZ4xMaQ3AHuUJzRc=
X-Google-Smtp-Source: ACHHUZ65NMUZm8MATKX4S4eDxCvT3Uky8e5qNWqNGWQ+fzBsZMYmQmN90iL0rlqFEc3CZnh6GA5fiw==
X-Received: by 2002:a05:6830:4c7:b0:6ab:25e0:81b6 with SMTP id s7-20020a05683004c700b006ab25e081b6mr1260120otd.14.1684516232830;
        Fri, 19 May 2023 10:10:32 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:1b3d:4b6b:e581:f922? (2603-8081-140c-1a00-1b3d-4b6b-e581-f922.res6.spectrum.com. [2603:8081:140c:1a00:1b3d:4b6b:e581:f922])
        by smtp.gmail.com with ESMTPSA id q6-20020a05683022c600b0069fa883c738sm1831005otc.35.2023.05.19.10.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 10:10:31 -0700 (PDT)
Message-ID: <30470158-1354-b80c-45b5-34faadac7073@gmail.com>
Date:   Fri, 19 May 2023 12:10:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-next v5 6/7] RDMA/rxe: Add support for
 Send/Recv/Write/Read with ODP
Content-Language: en-US
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, yangx.jy@fujitsu.com,
        lizhijian@fujitsu.com, y-goto@fujitsu.com
References: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
 <25d903e0136ea1e65c612d8f6b8c18c1f010add7.1684397037.git.matsuda-daisuke@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <25d903e0136ea1e65c612d8f6b8c18c1f010add7.1684397037.git.matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/18/23 03:21, Daisuke Matsuda wrote:
> rxe_mr_copy() is used widely to copy data to/from a user MR. requester uses
> it to load payloads of requesting packets; responder uses it to process
> Send, Write, and Read operaetions; completer uses it to copy data from
> response packets of Read and Atomic operations to a user MR.
> 
> Allow these operations to be used with ODP by adding a subordinate function
> rxe_odp_mr_copy(). It is comprised of the following steps:
>  1. Check the driver page table(umem_odp->dma_list) to see if pages being
>     accessed are present with appropriate permission.
>  2. If necessary, trigger page fault to map the pages.
>  3. Update the MR xarray using PFNs in umem_odp->pfn_list.
>  4. Execute data copy to/from the pages.
> 
> umem_mutex is used to ensure that dma_list (an array of addresses of an MR)
> is not changed while it is being checked and that mapped pages are not
> invalidated before data copy completes.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c     |  10 +++
>  drivers/infiniband/sw/rxe/rxe_loc.h |   8 ++
>  drivers/infiniband/sw/rxe/rxe_mr.c  |   2 +-
>  drivers/infiniband/sw/rxe/rxe_odp.c | 109 ++++++++++++++++++++++++++++
>  4 files changed, 128 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index f2284d27229b..207a022156f0 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -79,6 +79,16 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
>  
>  		/* IB_ODP_SUPPORT_IMPLICIT is not supported right now. */
>  		rxe->attr.odp_caps.general_caps |= IB_ODP_SUPPORT;
> +
> +		rxe->attr.odp_caps.per_transport_caps.ud_odp_caps |= IB_ODP_SUPPORT_SEND;
> +		rxe->attr.odp_caps.per_transport_caps.ud_odp_caps |= IB_ODP_SUPPORT_RECV;
> +		rxe->attr.odp_caps.per_transport_caps.ud_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
> +
> +		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SEND;
> +		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_RECV;
> +		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_WRITE;
> +		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_READ;
> +		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
>  	}
>  }
>  
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 93247d123642..4b95c8c46bdc 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -206,6 +206,8 @@ static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
>  #ifdef CONFIG_INFINIBAND_ON_DEMAND_PAGING
>  int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
>  			 u64 iova, int access_flags, struct rxe_mr *mr);
> +int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
> +		    enum rxe_mr_copy_dir dir);
>  #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
>  static inline int
>  rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
> @@ -213,6 +215,12 @@ rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int
> +rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
> +		int length, enum rxe_mr_copy_dir dir)
> +{
> +	return -EOPNOTSUPP;
> +}
>  
>  #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
>  
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index cd368cd096c8..0e3cda59d702 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -319,7 +319,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
>  	}
>  
>  	if (mr->odp_enabled)
> -		return -EOPNOTSUPP;
> +		return rxe_odp_mr_copy(mr, iova, addr, length, dir);
>  	else
>  		return rxe_mr_copy_xarray(mr, iova, addr, length, dir);
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index e5497d09c399..cbe5d0c3fcc4 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -174,3 +174,112 @@ int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
>  
>  	return err;
>  }
> +
> +static inline bool rxe_is_pagefault_neccesary(struct ib_umem_odp *umem_odp,
> +					      u64 iova, int length, u32 perm)
> +{
> +	int idx;
> +	u64 addr;
> +	bool need_fault = false;
> +
> +	addr = iova & (~(BIT(umem_odp->page_shift) - 1));
> +
> +	/* Skim through all pages that are to be accessed. */
> +	while (addr < iova + length) {
> +		idx = (addr - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
> +
> +		if (!(umem_odp->dma_list[idx] & perm)) {
> +			need_fault = true;
> +			break;
> +		}
> +
> +		addr += BIT(umem_odp->page_shift);
> +	}
> +	return need_fault;
> +}
> +
> +/* umem mutex must be locked before entering this function. */
> +static int rxe_odp_map_range(struct rxe_mr *mr, u64 iova, int length, u32 flags)
> +{
> +	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> +	const int max_tries = 3;
> +	int cnt = 0;
> +
> +	int err;
> +	u64 perm;
> +	bool need_fault;
> +
> +	if (unlikely(length < 1)) {
> +		mutex_unlock(&umem_odp->umem_mutex);
> +		return -EINVAL;
> +	}
> +
> +	perm = ODP_READ_ALLOWED_BIT;
> +	if (!(flags & RXE_PAGEFAULT_RDONLY))
> +		perm |= ODP_WRITE_ALLOWED_BIT;
> +
> +	/*
> +	 * A successful return from rxe_odp_do_pagefault() does not guarantee
> +	 * that all pages in the range became present. Recheck the DMA address
> +	 * array, allowing max 3 tries for pagefault.
> +	 */
> +	while ((need_fault = rxe_is_pagefault_neccesary(umem_odp,
> +							iova, length, perm))) {
> +		if (cnt >= max_tries)
> +			break;
> +
> +		mutex_unlock(&umem_odp->umem_mutex);
> +
> +		/* umem_mutex is locked on success. */
> +		err = rxe_odp_do_pagefault(mr, iova, length, flags);
> +		if (err < 0)
> +			return err;
> +
> +		cnt++;
> +	}
> +
> +	if (need_fault)
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
> +		    enum rxe_mr_copy_dir dir)
> +{
> +	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> +	u32 flags = 0;
> +	int err;
> +
> +	if (unlikely(!mr->odp_enabled))
> +		return -EOPNOTSUPP;
> +
> +	switch (dir) {
> +	case RXE_TO_MR_OBJ:
> +		break;
> +
> +	case RXE_FROM_MR_OBJ:
> +		flags = RXE_PAGEFAULT_RDONLY;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* If pagefault is not required, umem mutex will be held until data
> +	 * copy to the MR completes. Otherwise, it is released and locked
> +	 * again in rxe_odp_map_range() to let invalidation handler do its
> +	 * work meanwhile.
> +	 */
> +	mutex_lock(&umem_odp->umem_mutex);
> +
> +	err = rxe_odp_map_range(mr, iova, length, flags);
> +	if (err)
> +		return err;
> +
> +	err =  rxe_mr_copy_xarray(mr, iova, addr, length, dir);
> +
> +	mutex_unlock(&umem_odp->umem_mutex);
> +
> +	return err;
> +}

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
