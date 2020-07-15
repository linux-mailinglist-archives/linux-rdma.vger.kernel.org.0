Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF23220A16
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2020 12:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgGOKfl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jul 2020 06:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbgGOKfh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jul 2020 06:35:37 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CA7C061755
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 03:35:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g10so3189899wmc.1
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 03:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3AascDAmdcHInNJUweqW4/OebqAY5HxiTj8B/jM0t1c=;
        b=LtquEeya+CIPhQ4IHJvU51WELdriegIGEXEpMy6Ah7Jisc7144VwVCCl0gXbV1ek7f
         KlJysu99Q5RbvOZWdJ6/XPB0FZeoSnp8OwNkqnKg4BtqZOfyGkY4k36XrPhcAZBmLJxw
         +drqOCdPfIkFNLnVQ+BwFWsFfLV9fBtmZnEV1sYjqd66BJZ8m6oKiNKDJrgtZVCmgxeL
         pbCuutCzh6a0d7Gc2OxhllVLNYuFRa71SMDrx1OrOUFY9G2ufcX3lXlEeZ9nq1iC5cLW
         gr6YQEurbOjCyP5HFUXNm0til3t8jKHmYmAwHDZcMdav1UssQajClimynFqz79V7D9rJ
         efZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3AascDAmdcHInNJUweqW4/OebqAY5HxiTj8B/jM0t1c=;
        b=IdT1Mj96LaIM7BZkjldQ25/k1vgj1rhhgNYDz3azOuXOygMg/Lt1f7JsbT9FUj+x+e
         ax8F85e43cygDH6YuJsLXONAEAeb0risem//Skx45J8cyaDOTLmdcnI3HC8JRPX4vFLG
         eAsO+jwWqF80EbWt9Fp5aRYm2i3IFy6h602kiR60kbxx2wGBmY0X5xEb0KlWQIFwQ5A3
         OlYU1IkVdFeBBYt0wWT8I6oDDGheRD7ZIztju0e4LDz/y15ypVIMCrSjDJAQEtt77sBp
         ebJ3af8ONh/iTsK4p9NTxXxFPPtEx0RlF2ilgkqwXg8jdnQHRassMdnUOZIIrzKmLcK7
         xtsQ==
X-Gm-Message-State: AOAM5308hPCBdlVOoPjRgYp6bvGzKkSWg1d6hB2oim2zf7NLVRQH69J4
        7TinHbN+FF38JgBgB6nAeUVJPA85GXI=
X-Google-Smtp-Source: ABdhPJzqJGLirzeIE7EW5BRqCEv+RH5PkfEae03AzF5Y15jq/9sC7Y9/YbwVIlMOxF00wR5oiJ5jJg==
X-Received: by 2002:a1c:dfd6:: with SMTP id w205mr8432103wmg.118.1594809335928;
        Wed, 15 Jul 2020 03:35:35 -0700 (PDT)
Received: from kheib-workstation ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id n16sm2863190wrq.39.2020.07.15.03.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 03:35:35 -0700 (PDT)
Date:   Wed, 15 Jul 2020 13:35:32 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix QP cleanup flow
Message-ID: <20200715103532.GA122431@kheib-workstation>
References: <20200603101738.159637-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603101738.159637-1-kamalheib1@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 03, 2020 at 01:17:38PM +0300, Kamal Heib wrote:
> Avoid releasing the socket associated with each QP in rxe_qp_cleanup()
> which can sleep and move it to rxe_destroy_qp() instead, after doing
> this there is no need for the execute_work that used to avoid calling
> rxe_qp_cleanup() directly. also check that the socket is valid in
> rxe_skb_tx_dtor() to avoid use-after-free.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Fixes: bb3ffb7ad48a ("RDMA/rxe: Fix rxe_qp_cleanup()")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---

This will require more work, please drop this patch.

Nacked-by: Kamal Heib <kamalheib1@gmail.com> 

>  drivers/infiniband/sw/rxe/rxe_net.c   | 14 ++++++++++++--
>  drivers/infiniband/sw/rxe/rxe_qp.c    | 22 ++++++----------------
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  3 ---
>  3 files changed, 18 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 312c2fc961c0..298ccd3fd3e2 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -411,8 +411,18 @@ int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb, u32 *crc)
>  static void rxe_skb_tx_dtor(struct sk_buff *skb)
>  {
>  	struct sock *sk = skb->sk;
> -	struct rxe_qp *qp = sk->sk_user_data;
> -	int skb_out = atomic_dec_return(&qp->skb_out);
> +	struct rxe_qp *qp;
> +	int skb_out;
> +
> +	if (!sk)
> +		return;
> +
> +	qp = sk->sk_user_data;
> +
> +	if (!qp)
> +		return;
> +
> +	skb_out = atomic_dec_return(&qp->skb_out);
>  
>  	if (unlikely(qp->need_req_skb &&
>  		     skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW))
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 6c11c3aeeca6..89dac6c1111c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -787,6 +787,7 @@ void rxe_qp_destroy(struct rxe_qp *qp)
>  	if (qp_type(qp) == IB_QPT_RC) {
>  		del_timer_sync(&qp->retrans_timer);
>  		del_timer_sync(&qp->rnr_nak_timer);
> +		sk_dst_reset(qp->sk->sk);
>  	}
>  
>  	rxe_cleanup_task(&qp->req.task);
> @@ -798,12 +799,15 @@ void rxe_qp_destroy(struct rxe_qp *qp)
>  		__rxe_do_task(&qp->comp.task);
>  		__rxe_do_task(&qp->req.task);
>  	}
> +
> +	kernel_sock_shutdown(qp->sk, SHUT_RDWR);
> +	sock_release(qp->sk);
>  }
>  
>  /* called when the last reference to the qp is dropped */
> -static void rxe_qp_do_cleanup(struct work_struct *work)
> +void rxe_qp_cleanup(struct rxe_pool_entry *arg)
>  {
> -	struct rxe_qp *qp = container_of(work, typeof(*qp), cleanup_work.work);
> +	struct rxe_qp *qp = container_of(arg, typeof(*qp), pelem);
>  
>  	rxe_drop_all_mcast_groups(qp);
>  
> @@ -828,19 +832,5 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
>  		qp->resp.mr = NULL;
>  	}
>  
> -	if (qp_type(qp) == IB_QPT_RC)
> -		sk_dst_reset(qp->sk->sk);
> -
>  	free_rd_atomic_resources(qp);
> -
> -	kernel_sock_shutdown(qp->sk, SHUT_RDWR);
> -	sock_release(qp->sk);
> -}
> -
> -/* called when the last reference to the qp is dropped */
> -void rxe_qp_cleanup(struct rxe_pool_entry *arg)
> -{
> -	struct rxe_qp *qp = container_of(arg, typeof(*qp), pelem);
> -
> -	execute_in_process_context(rxe_qp_do_cleanup, &qp->cleanup_work);
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index 92de39c4a7c1..339debaf095f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -35,7 +35,6 @@
>  #define RXE_VERBS_H
>  
>  #include <linux/interrupt.h>
> -#include <linux/workqueue.h>
>  #include <rdma/rdma_user_rxe.h>
>  #include "rxe_pool.h"
>  #include "rxe_task.h"
> @@ -285,8 +284,6 @@ struct rxe_qp {
>  	struct timer_list rnr_nak_timer;
>  
>  	spinlock_t		state_lock; /* guard requester and completer */
> -
> -	struct execute_work	cleanup_work;
>  };
>  
>  enum rxe_mem_state {
> -- 
> 2.25.4
> 
