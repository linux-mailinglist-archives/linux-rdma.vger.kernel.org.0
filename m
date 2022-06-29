Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A478560937
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jun 2022 20:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiF2Set (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jun 2022 14:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiF2Ses (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jun 2022 14:34:48 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BC32F3B4
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jun 2022 11:34:47 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id y14so26116398qvs.10
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jun 2022 11:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ike66Qj+N8mubg4JUBqywYDh/KuybG401mRtes+8y3s=;
        b=BS7JMu2WWZ3C4Rlk30b4lq1eFsjgcmAXJ3eLR+ypKCIbbCnITgz8S7eob4iRylbv91
         fXnnnw0zi0nYI3RLYcX1YVRavR3LkJP6uLYAJtQe0EEgOTVddfQdIIcBjSS/2Mf6U04P
         7NEbuqep1RbRiq6YnEnI1fLc7vRjCtkaYcLo4Esp64zAZsay76ajdR990a/gifY4yXA+
         iKfnuYI+raYpl/rRKwmaD8uqhtCWunnBHRiqomVPDgBUhfAAH17cagr09rlHcVNRGqIZ
         RqpRcTF79/S6grKwMdYBXHCJ8kcOU4chEGwClCd4eA6zIGWiGy3QiJzFXYeS75pCmHMC
         +GKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ike66Qj+N8mubg4JUBqywYDh/KuybG401mRtes+8y3s=;
        b=PhMZzL0svsPDErZcMcpY1reAcHI3G0MihlB8LB9bc8jp31AMMOwVu2EKsSIAwzOUYI
         O11HjGwoTlMZ0qjX7UTSW2+A3BcRaPvANiHnRiF/DPRy2Y5a2sPXQL1lCqlww5xUf2X/
         LG9uZkXzCCPP/ncWLNnNyb/G06+r+2SZeV3GpD2wS2nYbSrRI0hBHu96Du220lfST4aQ
         tuhXi+rXhpf0YAo4Hy1clH0zA4D+zoRfuiBnMHIU+irskOx5tD14g/t4i/NBnacSwXE/
         xSiUkE3xbXLjdRzIqzROreNBHIWSWR33lDes9i9j5FAnyPyoy4YPoS/Gv879AJLW8tR1
         1yXQ==
X-Gm-Message-State: AJIora/5aBpPTQKQzBgte0xWYaMZowoB8JUPXycGafSBrGPb2F3diIHz
        WvpOCa1tZPKUWIWdGDaha75BbA==
X-Google-Smtp-Source: AGRyM1uEvscp6GR9Vu5zyGWVYNgByoS4sXNdvC8awNWUvDq/icVuUqG+wIL8SfQHSop3GnQGzhqdIg==
X-Received: by 2002:ad4:408d:0:b0:470:46eb:3a1a with SMTP id l13-20020ad4408d000000b0047046eb3a1amr3013679qvp.113.1656527686613;
        Wed, 29 Jun 2022 11:34:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006a75a0ffc97sm14075923qko.3.2022.06.29.11.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:34:46 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o6cWT-003bhJ-GA; Wed, 29 Jun 2022 15:34:45 -0300
Date:   Wed, 29 Jun 2022 15:34:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Md Haris Iqbal <haris.phnx@gmail.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com,
        aleksei.marov@ionos.com, leon@kernel.org, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, rpearsonhpe@gmail.com
Subject: Re: [PATCH] RDMA/rxe: For invalidate compare keys according to the
 MR access
Message-ID: <20220629183445.GV23621@ziepe.ca>
References: <20220629164946.521293-1-haris.phnx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629164946.521293-1-haris.phnx@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 29, 2022 at 06:49:46PM +0200, Md Haris Iqbal wrote:
> In rxe, the access permissions decide which of the lkey/rkey would be set
> during an MR registration. For an MR with only LOCAL access, only lkey is
> set and rkey stays 0. For an MR with REMOTE access, both lkey and rkey are
> set, such that rkey=lkey.
> 
> Hence, for MR invalidate, do the comparison for keys according to the MR
> access. Since the invalidate wr can contain only a single key
> (ex.invalidate_rkey), it should match MR->rkey if the MR being invalidated
> has REMOTE access. If the MR has only LOCAL access, then that key should
> match MR->lkey.
> 
> Fixes: 3902b429ca14 ("RDMA/rxe: Implement invalidate MW operations")
> Cc: rpearsonhpe@gmail.com
> Signed-off-by: Md Haris Iqbal <haris.phnx@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h |  2 +-
>  drivers/infiniband/sw/rxe/rxe_mr.c  | 17 +++++++++++------
>  2 files changed, 12 insertions(+), 7 deletions(-)

If the rkey's and lkeys are always the same why do we store them
twice in the mr ?

> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 0e022ae1b8a5..37484a559d20 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -77,7 +77,7 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
>  			 enum rxe_mr_lookup_type type);
>  int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
>  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
> -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
> +int rxe_invalidate_mr(struct rxe_qp *qp, u32 key);
>  int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
>  int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
>  int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index fc3942e04a1f..790cff7077fd 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -576,22 +576,27 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
>  	return mr;
>  }
>  
> -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
> +int rxe_invalidate_mr(struct rxe_qp *qp, u32 key)
>  {
>  	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
>  	struct rxe_mr *mr;
>  	int ret;
>  
> -	mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
> +	mr = rxe_pool_get_index(&rxe->mr_pool, key >> 8);
>  	if (!mr) {
> -		pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
> +		pr_err("%s: No MR for key %#x\n", __func__, key);
>  		ret = -EINVAL;
>  		goto err;
>  	}
>  
> -	if (rkey != mr->rkey) {
> -		pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
> -			__func__, rkey, mr->rkey);
> +	if ((mr->access & IB_ACCESS_REMOTE) && key != mr->rkey) {
> +		pr_err("%s: key (%#x) doesn't match mr->rkey (%#x)\n",
> +			__func__, key, mr->rkey);
> +		ret = -EINVAL;
> +		goto err_drop_ref;
> +	} else if ((mr->access & IB_ACCESS_LOCAL_WRITE) && key != mr->lkey) {
> +		pr_err("%s: key (%#x) doesn't match mr->lkey (%#x)\n",
> +			__func__, key, mr->lkey);
>  		ret = -EINVAL;
>  		goto err_drop_ref;
>  	}

Hurm, I think rxe still has problems here.

By my reading of the spec a FRWR on a l_key should set the variant
bits on the l_key as well, but rxe only updates variant bits on rkeys?

I don't understand why it is trying to keep lkey and rkey seperated..

Are you actually using !IB_ACCESS_REMOTE with FRWR? If so how does it
behave on mlx5 devices with regard to the variant bits?

Jason
