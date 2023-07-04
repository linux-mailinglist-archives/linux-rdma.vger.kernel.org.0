Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DF6747023
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jul 2023 13:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjGDLs6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jul 2023 07:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjGDLs5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jul 2023 07:48:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBF4135;
        Tue,  4 Jul 2023 04:48:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B54E6121F;
        Tue,  4 Jul 2023 11:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3914C433C7;
        Tue,  4 Jul 2023 11:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688471335;
        bh=GJkHeVjvMujvpKVUZcEumEtlW+Gx++DF0djb7kdfwkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DE9iaSVHwYYugFEJ6VJBPzIKD1MTrwvPZuyPN1pD2IV0OQvmpjDwewHndbpTRTWH0
         DFDFXq2/EDwcJhSHc/PZcgRJq1jA4uAxNxMx7DxaIzp+xtovXulNKKNEOfqM6HgwZZ
         kstFok8gLBDbqkw0jxVdeeGYID1YU7uiZpWAFhtqKTnGzCvN5wI9TkvYKEV8S8qHkH
         ydDcy5xNw0A1tztfenvCUQEWfE2BKo7MDH6on/1uS8t487kyHgnA02czTNwzomqu3b
         k3x+V/lwtMan1Kwsg6r8aotAgBbN072qcD8C2GIuFTZsDLKOsOfnhqHGnrXK9MGQyz
         hxPUEs9VePnTQ==
Date:   Tue, 4 Jul 2023 14:48:49 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/hfi1: Fix potential deadlock on &sde->flushlist_lock
Message-ID: <20230704114849.GA6455@unreal>
References: <20230628045925.5261-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628045925.5261-1-dg573847474@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 28, 2023 at 04:59:25AM +0000, Chengfeng Ye wrote:
> As &sde->flushlist_lock is acquired by timer sdma_err_progress_check()
> through layer of calls under softirq context, other process
> context code acquiring the lock should disable irq.
> 
> Possible deadlock scenario
> sdma_send_txreq()
>     -> spin_lock(&sde->flushlist_lock)
>         <timer interrupt>
>         -> sdma_err_progress_check()
>         -> __sdma_process_event()
>         -> sdma_set_state()
>         -> sdma_flush()
>         -> spin_lock_irqsave(&sde->flushlist_lock, flags) (deadlock here)
> 
> This flaw was found using an experimental static analysis tool we are
> developing for irq-related deadlock.
> 
> The tentative patch fix the potential deadlock by spin_lock_irqsave().
> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> ---
>  drivers/infiniband/hw/hfi1/sdma.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
> index bb2552dd29c1..0431f575c861 100644
> --- a/drivers/infiniband/hw/hfi1/sdma.c
> +++ b/drivers/infiniband/hw/hfi1/sdma.c
> @@ -2371,9 +2371,9 @@ int sdma_send_txreq(struct sdma_engine *sde,
>  	tx->sn = sde->tail_sn++;
>  	trace_hfi1_sdma_in_sn(sde, tx->sn);
>  #endif
> -	spin_lock(&sde->flushlist_lock);
> +	spin_lock_irqsave(&sde->flushlist_lock, flags);
>  	list_add_tail(&tx->list, &sde->flushlist);
> -	spin_unlock(&sde->flushlist_lock);
> +	spin_unlock_irqrestore(&sde->flushlist_lock, flags);
>  	iowait_inc_wait_count(wait, tx->num_desc);
>  	queue_work_on(sde->cpu, system_highpri_wq, &sde->flush_worker);
>  	ret = -ECOMM;

It can't work as exactly after "ret = -ECOMM;" line, there is "goto unlock"
and there hfi1 calls to spin_unlock_irqrestore(..) with same "flags".

Plus, we already in context where interrupts are stopped.

Thanks

> @@ -2459,7 +2459,7 @@ int sdma_send_txlist(struct sdma_engine *sde, struct iowait_work *wait,
>  	*count_out = total_count;
>  	return ret;
>  unlock_noconn:
> -	spin_lock(&sde->flushlist_lock);
> +	spin_lock_irqsave(&sde->flushlist_lock, flags);
>  	list_for_each_entry_safe(tx, tx_next, tx_list, list) {
>  		tx->wait = iowait_ioww_to_iow(wait);
>  		list_del_init(&tx->list);
> @@ -2472,7 +2472,7 @@ int sdma_send_txlist(struct sdma_engine *sde, struct iowait_work *wait,
>  		flush_count++;
>  		iowait_inc_wait_count(wait, tx->num_desc);
>  	}
> -	spin_unlock(&sde->flushlist_lock);
> +	spin_unlock_irqrestore(&sde->flushlist_lock, flags);
>  	queue_work_on(sde->cpu, system_highpri_wq, &sde->flush_worker);
>  	ret = -ECOMM;
>  	goto update_tail;
> -- 
> 2.17.1
> 
