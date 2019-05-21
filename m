Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB402577E
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 20:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfEUSWT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 14:22:19 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39642 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbfEUSWT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 14:22:19 -0400
Received: by mail-qk1-f193.google.com with SMTP id z128so11680630qkb.6
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 11:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8DK49RZ0tRpirvZcOu9opWSCg93YjUXvIR8FspZJRbM=;
        b=T6bQsSvl126/X69I1vdrHMdMzdV38DSjM8S7zwm6ZTf2lePTB51DE9+KYtGk7ouTzq
         3UkKwF+hPkOUWLfUdzcer/GR23aI08sp9yA9zB34ArUrLJESB9o8JWh0cn+Q4uFOZHTk
         JD2R2nc3jyk5xBJ2V7ynGH1vO4hScYl5W0ISIQCb9yJWeYOeErSNfgnr26FfuAaHKwJg
         aWVnWktK4Eou8IQizCBbpGpvq3hWDAdrAhlutD2bKqhzC9pARiLFT0WTGVeeHNmTnXwA
         /cZAL/ugYxqmgO1PC9KEiP+qo1MhhPrRAqeUhkxFmsCuvzi5/7exwCMixXZCx2DcQjgu
         S6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8DK49RZ0tRpirvZcOu9opWSCg93YjUXvIR8FspZJRbM=;
        b=Y3bM6r0A19y49AH2QahRhjk7jr88h55ZnEmzr4S/OVzsiHPdnlNaO4wS/y9qhYJ7kU
         BEtEAyaBUnLJVxTjrt/fkzojzhYc7cnoHQ2OvCjIBF0Vtlh2m5iI2tvLm1RWBZax8+Qm
         RUftswpXxBRiNU+hauaY4YYR4XcaoI86Fnsgmr7rKa5yy2zWfDb+qe26RrjdA6OAPjUk
         x35eMOly+LtLuOwQ4RDgJurVk85tomta2U1XRYKbyG5QSMaVf3OOc4ZoXiDsBCjzrdaI
         SkvEh2YzLj8q8b+sUryH0uvHAFqg8HogiDXamgXNGwgxES/YEBSZDE5ZMhXzRuV8G0bG
         gFXg==
X-Gm-Message-State: APjAAAWLbLWBq57AV3frkUCbxbITIZ4bYmrGgo6Tpl7m2vWp+GoYEWuu
        hWVUVmoi/LTn1CdiYlbiTr+vwnHvoVo=
X-Google-Smtp-Source: APXvYqw39MszK2gh/iA9CQvQmJy5EL5kynyi5gwuC7y8i1h+AY53oRGJ2/rFAhzbLO6AJXaOfS8lAw==
X-Received: by 2002:a37:bb43:: with SMTP id l64mr63266230qkf.305.1558462937842;
        Tue, 21 May 2019 11:22:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id k54sm13854602qtk.54.2019.05.21.11.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 11:22:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hT9Oy-0001aO-C0; Tue, 21 May 2019 15:22:16 -0300
Date:   Tue, 21 May 2019 15:22:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nirranjan Kirubaharan <nirranjan@chelsio.com>
Cc:     bharat@chelsio.com, dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v3] iw_cxgb4: Fix qpid leak
Message-ID: <20190521182216.GA6034@ziepe.ca>
References: <d60f04ae2f0f5ba6f925d7f56a31e09f33f3fde7.1558438183.git.nirranjan@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d60f04ae2f0f5ba6f925d7f56a31e09f33f3fde7.1558438183.git.nirranjan@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 21, 2019 at 05:32:30AM -0700, Nirranjan Kirubaharan wrote:
> In iw_cxgb4, Added wait in destroy_qp() so that all references to
> qp are dereferenced and qp is freed in destroy_qp() itself.
> This ensures freeing of all QPs before invocation of
> dealloc_ucontext(), which prevents loss of in use qpids stored
> in ucontext.
> 
> Signed-off-by: Nirranjan Kirubaharan <nirranjan@chelsio.com>
> Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>
> v2:
> - Used kref instead of qid count.
> v3:
> - Ensured freeing of qp in destroy_qp() itself.
>  drivers/infiniband/hw/cxgb4/iw_cxgb4.h | 1 +
>  drivers/infiniband/hw/cxgb4/qp.c       | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> index 916ef982172e..10c3e5e9d3de 100644
> +++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> @@ -497,6 +497,7 @@ struct c4iw_qp {
>  	struct work_struct free_work;
>  	struct c4iw_ucontext *ucontext;
>  	struct c4iw_wr_wait *wr_waitp;
> +	struct completion qp_rel_comp;
>  };
>  
>  static inline struct c4iw_qp *to_c4iw_qp(struct ib_qp *ibqp)
> diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
> index e92b9544357a..ea0b7014fb03 100644
> +++ b/drivers/infiniband/hw/cxgb4/qp.c
> @@ -905,7 +905,7 @@ static void free_qp_work(struct work_struct *work)
>  		   ucontext ? &ucontext->uctx : &rhp->rdev.uctx, !qhp->srq);
>  
>  	c4iw_put_wr_wait(qhp->wr_waitp);
> -	kfree(qhp);
> +	complete(&qhp->qp_rel_comp);
>  }
>  
>  static void queue_qp_free(struct kref *kref)
> @@ -2120,7 +2120,11 @@ int c4iw_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
>  
>  	c4iw_qp_rem_ref(ib_qp);
>  
> +	wait_for_completion(&qhp->qp_rel_comp);
> +
>  	pr_debug("ib_qp %p qpid 0x%0x\n", ib_qp, qhp->wq.sq.qid);
> +
> +	kfree(qhp);
>  	return 0;
>  }
>  
> @@ -2184,6 +2188,7 @@ struct ib_qp *c4iw_create_qp(struct ib_pd *pd, struct ib_qp_init_attr *attrs,
>  		(sqsize + rhp->rdev.hw_queue.t4_eq_status_entries) *
>  		sizeof(*qhp->wq.sq.queue) + 16 * sizeof(__be64);
>  	qhp->wq.sq.flush_cidx = -1;
> +	init_completion(&qhp->qp_rel_comp);
>  	if (!attrs->srq) {
>  		qhp->wq.rq.size = rqsize;
>  		qhp->wq.rq.memsize =

So now you don't need the work queue at all, and you are back to using
the to_c4iw_qp(qp)->kref as not-a-kref.

Use the normal pattern please.

Change c3iw_qp_rem_ref to use a refcount not kref and trigger
complete() when the refcount goes t 0.

Move all of queue_qp_free into ciw_destroy_qp

Remove the work item entirely.

Jason
