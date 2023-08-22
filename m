Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489037843E2
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 16:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjHVOVq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 10:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbjHVOVq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 10:21:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C2DCCA
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 07:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11C1C6561E
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 14:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2AAC433CA;
        Tue, 22 Aug 2023 14:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692714097;
        bh=MdPYbni1RKsDxekwygwHXygP/Bn2HpK43VuVOjMOr/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mTMtdHx5tso7wVhJaiLqMhqQt6xBl9FAP3e2XwraYZ1OgY8krqmVduP7HSvNfEA23
         S97zohtQDg3UguaP1e3JhV6jXoDsrRSaeJE/QQJwRuWZ4ewCF24qMw8M+n3Ejyq1+1
         f+RbPIZuNdd6CKz0HbU7C7Ds/9J6UPEZfQGDVA8e6D7Ir58Wcolc8P/JxjDnKC51YS
         RlaV7j1cMjtL5bHMR/0jm5AQ8rek/8du2KVQO8ZUvaGqhfQKd0+7gozH6N37GXeT9W
         c4o4t+Ba+AGMvU3ABM5K+AEp9ANX4Mqen3t+Z823Mv1q0IC6Fujn1cNiPaHOmUltLx
         NMtNfXKzUveHA==
Date:   Tue, 22 Aug 2023 17:21:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     ynachum@amazon.com
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, sleybo@amazon.com,
        matua@amazon.com, Michael Margolin <mrgolin@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Fix wrong resources deallocation order
Message-ID: <20230822142133.GJ6029@unreal>
References: <20230822082725.31719-1-ynachum@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822082725.31719-1-ynachum@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 22, 2023 at 08:27:25AM +0000, ynachum@amazon.com wrote:
> From: Yonatan Nachum <ynachum@amazon.com>
> 
> When trying to destroy QP or CQ, we first decrease the refcount and
> potentially free memory regions allocated for the object and then
> request the device to destroy the object. If the device fails, the
> object isn't fully destroyed so the user/IB core can try to destroy the
> object again which will lead to underflow when trying to decrease an
> already zeroed refcount.
> Deallocate resources in reverse order of allocating them to safely free
> them.
> 
> Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_verbs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied together with the following Fixes line
Fixes: ff6629f88c52 ("RDMA/efa: Do not delay freeing of DMA pages")

Thanks

> 
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index 7a27d79c0541..0f8ca99d0827 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -453,12 +453,12 @@ int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
>  
>  	ibdev_dbg(&dev->ibdev, "Destroy qp[%u]\n", ibqp->qp_num);
>  
> -	efa_qp_user_mmap_entries_remove(qp);
> -
>  	err = efa_destroy_qp_handle(dev, qp->qp_handle);
>  	if (err)
>  		return err;
>  
> +	efa_qp_user_mmap_entries_remove(qp);
> +
>  	if (qp->rq_cpu_addr) {
>  		ibdev_dbg(&dev->ibdev,
>  			  "qp->cpu_addr[0x%p] freed: size[%lu], dma[%pad]\n",
> @@ -1017,8 +1017,8 @@ int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
>  		  "Destroy cq[%d] virt[0x%p] freed: size[%lu], dma[%pad]\n",
>  		  cq->cq_idx, cq->cpu_addr, cq->size, &cq->dma_addr);
>  
> -	efa_cq_user_mmap_entries_remove(cq);
>  	efa_destroy_cq_idx(dev, cq->cq_idx);
> +	efa_cq_user_mmap_entries_remove(cq);
>  	if (cq->eq) {
>  		xa_erase(&dev->cqs_xa, cq->cq_idx);
>  		synchronize_irq(cq->eq->irq.irqn);
> -- 
> 2.40.1
> 
