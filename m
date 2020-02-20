Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9197616637B
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 17:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgBTQwA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 11:52:00 -0500
Received: from ale.deltatee.com ([207.54.116.67]:42316 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbgBTQwA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Feb 2020 11:52:00 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1j4p3O-00024R-Sx; Thu, 20 Feb 2020 09:51:59 -0700
To:     Max Gurtovoy <maxg@mellanox.com>, jgg@mellanox.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     israelr@mellanox.com
References: <20200220100819.41860-1-maxg@mellanox.com>
 <20200220100819.41860-2-maxg@mellanox.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9e68c521-f083-c713-c19a-c08a0227c95e@deltatee.com>
Date:   Thu, 20 Feb 2020 09:51:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220100819.41860-2-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: israelr@mellanox.com, linux-rdma@vger.kernel.org, leon@kernel.org, jgg@mellanox.com, maxg@mellanox.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v2 2/2] RDMA/rw: map P2P memory correctly for signature
 operations
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020-02-20 3:08 a.m., Max Gurtovoy wrote:
> Since RDMA rw API support operations with P2P memory sg list, make sure
> to map/unmap the scatter list for signature operation correctly.

Does anyone actually use P2P pages with rdma_rw_ctx_signature_init()?

Logan

> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> ---
>  drivers/infiniband/core/rw.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
> index 69513b484507..6eba8453f206 100644
> --- a/drivers/infiniband/core/rw.c
> +++ b/drivers/infiniband/core/rw.c
> @@ -392,13 +392,13 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
>  		return -EINVAL;
>  	}
>  
> -	ret = ib_dma_map_sg(dev, sg, sg_cnt, dir);
> +	ret = rdma_rw_map_sg(dev, sg, sg_cnt, dir);
>  	if (!ret)
>  		return -ENOMEM;
>  	sg_cnt = ret;
>  
>  	if (prot_sg_cnt) {
> -		ret = ib_dma_map_sg(dev, prot_sg, prot_sg_cnt, dir);
> +		ret = rdma_rw_map_sg(dev, prot_sg, prot_sg_cnt, dir);
>  		if (!ret) {
>  			ret = -ENOMEM;
>  			goto out_unmap_sg;
> @@ -467,9 +467,9 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
>  	kfree(ctx->reg);
>  out_unmap_prot_sg:
>  	if (prot_sg_cnt)
> -		ib_dma_unmap_sg(dev, prot_sg, prot_sg_cnt, dir);
> +		rdma_rw_unmap_sg(dev, prot_sg, prot_sg_cnt, dir);
>  out_unmap_sg:
> -	ib_dma_unmap_sg(dev, sg, sg_cnt, dir);
> +	rdma_rw_unmap_sg(dev, sg, sg_cnt, dir);
>  	return ret;
>  }
>  EXPORT_SYMBOL(rdma_rw_ctx_signature_init);
> @@ -629,9 +629,9 @@ void rdma_rw_ctx_destroy_signature(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
>  	ib_mr_pool_put(qp, &qp->sig_mrs, ctx->reg->mr);
>  	kfree(ctx->reg);
>  
> -	ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
>  	if (prot_sg_cnt)
> -		ib_dma_unmap_sg(qp->pd->device, prot_sg, prot_sg_cnt, dir);
> +		rdma_rw_unmap_sg(qp->pd->device, prot_sg, prot_sg_cnt, dir);
> +	rdma_rw_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
>  }
>  EXPORT_SYMBOL(rdma_rw_ctx_destroy_signature);
>  
> 
