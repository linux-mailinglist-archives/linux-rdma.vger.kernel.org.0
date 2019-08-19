Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 514CA9235C
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 14:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfHSMY6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 08:24:58 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42369 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbfHSMY6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 08:24:58 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so1176776qkm.9
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 05:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J6S8PyGxqNS60scg+iKmZ5cCTuImRsL4PtO0ywRYYck=;
        b=X93kDt07hIVpfTgj8spZr7YfnLHQB6wshX3MTaX/XqhrFUuKJgpueUy/1Mkav7DdB0
         uIBTlATC7N2Q/TLvBrVZlKG8L28WgmYq7pZKYmdsi8mSMKBVPGXtpvYAms9m9KixReq0
         pGjx8L+UJTj02nS0FhPpkSXz2dp8IwQXZNsFtP0igucLShwbpeSajP3xA6d91bQt1uLk
         b0rltsSmSeSwfIEYX3t3oxI7ifDubxDSsUCRnXz7y7Jny/KjPFWWTaMmvCZOWdaEzAx8
         xc+qn4IUBosFYT1P1KmfZFO/D5A6tP7P7EnXRtZDuKogFJ8xTtRR/3Jv+Ix+i9QqrIOm
         kJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J6S8PyGxqNS60scg+iKmZ5cCTuImRsL4PtO0ywRYYck=;
        b=iCG9BXjsVf/dqhLO+NzLwWEGN972K6ld4OGhPBU06WTjR3r80EGsvb1eFbBNSK/G5P
         Z5bv4FzrJ+OZQpit2jx+/wP0lswh4Q8dv3dFXkua6e1KlHeP7rtwVNvMNiCpmdGwr0fC
         Nvp6DUcdMcgtJ/qtto75LbaOecwYA5TAtTpB4HHfgHxhtyve3ziIw4LmdEn6P73nK2km
         EYeQ8HatJvGx4yUIvDRJM/bvG3RWw8HZI2TAiFwdVKDPhDhX6HiLLW0vS2qeSoZ3Wxkx
         kv6F8olBYuMWkLdDft8lhT4h/fl7vKxuTrdl5lD8ijPP8dMHL6ysxNEhHQAFkXMAyzks
         MBVw==
X-Gm-Message-State: APjAAAUnQx1r0vBBG4BqyYMozkAvwO4ZCYXefOPT5bBe73At6bRveX0P
        eEmgqxoFCIf3Enuy/6Z/AQOVn4kY4f8=
X-Google-Smtp-Source: APXvYqwjkkoF5par/ytgOmhHkPd9ARJtpAsAKEdaxogIeOXTJ/tA1bppGebLtzGZlXrSyD3biFCZ5A==
X-Received: by 2002:a05:620a:4c8:: with SMTP id 8mr19173520qks.366.1566217497196;
        Mon, 19 Aug 2019 05:24:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o200sm7006900qke.66.2019.08.19.05.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 05:24:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hzgiW-0001kj-7m; Mon, 19 Aug 2019 09:24:56 -0300
Date:   Mon, 19 Aug 2019 09:24:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit due to
 u64/pointer abuse
Message-ID: <20190819122456.GB5058@ziepe.ca>
References: <20190819100526.13788-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819100526.13788-1-geert@linux-m68k.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 19, 2019 at 12:05:26PM +0200, Geert Uytterhoeven wrote:
> When compiling on 32-bit:
> 
>     drivers/infiniband/sw/siw/siw_cq.c:76:20: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     drivers/infiniband/sw/siw/siw_qp.c:952:28: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>     drivers/infiniband/sw/siw/siw_qp_tx.c:53:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     drivers/infiniband/sw/siw/siw_qp_tx.c:59:11: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     drivers/infiniband/sw/siw/siw_qp_tx.c:59:26: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     drivers/infiniband/sw/siw/siw_qp_tx.c:61:23: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     drivers/infiniband/sw/siw/siw_qp_tx.c:62:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     drivers/infiniband/sw/siw/siw_qp_tx.c:82:12: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     drivers/infiniband/sw/siw/siw_qp_tx.c:87:12: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     drivers/infiniband/sw/siw/siw_qp_tx.c:101:12: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     drivers/infiniband/sw/siw/siw_qp_tx.c:169:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>     drivers/infiniband/sw/siw/siw_qp_tx.c:192:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>     drivers/infiniband/sw/siw/siw_qp_tx.c:204:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>     drivers/infiniband/sw/siw/siw_qp_tx.c:219:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>     drivers/infiniband/sw/siw/siw_qp_tx.c:476:24: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     drivers/infiniband/sw/siw/siw_qp_tx.c:535:7: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     drivers/infiniband/sw/siw/siw_qp_tx.c:832:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>     drivers/infiniband/sw/siw/siw_qp_tx.c:927:26: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     drivers/infiniband/sw/siw/siw_qp_rx.c:43:5: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     drivers/infiniband/sw/siw/siw_qp_rx.c:43:24: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     drivers/infiniband/sw/siw/siw_qp_rx.c:141:23: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     drivers/infiniband/sw/siw/siw_qp_rx.c:488:6: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     drivers/infiniband/sw/siw/siw_qp_rx.c:601:5: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     drivers/infiniband/sw/siw/siw_qp_rx.c:844:24: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     drivers/infiniband/sw/siw/siw_verbs.c:665:22: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>     drivers/infiniband/sw/siw/siw_verbs.c:828:19: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>     drivers/infiniband/sw/siw/siw_verbs.c:846:32: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> 
> Fix this by applying the following rules:
>   1. When printing a u64, the %llx format specififer should be used,
>      instead of casting to a pointer, and printing the latter.
>   2. When assigning a pointer to a u64, the pointer should be cast to
>      uintptr_t, not u64,
>   3. When casting from u64 to pointer, an intermediate cast to uintptr_t
>      should be added,
> 
> Fixes: 2c8ccb37b08fe364 ("RDMA/siw: Change CQ flags from 64->32 bits")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> The issues predate the commit mentioned above, but didn't become visible
> before.
> 
> The Right Thing(TM) would be to get rid of all this casting, and use
> proper types instead.
> This would involve teaching the siw people that a kernel virtual address
> is not called a physical address, and should not use u64.
>  drivers/infiniband/sw/siw/siw_cq.c    |  5 ++--
>  drivers/infiniband/sw/siw/siw_qp.c    |  2 +-
>  drivers/infiniband/sw/siw/siw_qp_rx.c | 16 +++++++------
>  drivers/infiniband/sw/siw/siw_qp_tx.c | 34 ++++++++++++++-------------
>  drivers/infiniband/sw/siw/siw_verbs.c |  8 +++----
>  5 files changed, 35 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_cq.c b/drivers/infiniband/sw/siw/siw_cq.c
> index e381ae9b7d62498e..f4ec26eeb9df62bf 100644
> +++ b/drivers/infiniband/sw/siw/siw_cq.c
> @@ -71,9 +71,10 @@ int siw_reap_cqe(struct siw_cq *cq, struct ib_wc *wc)
>  				wc->wc_flags = IB_WC_WITH_INVALIDATE;
>  			}
>  			wc->qp = cqe->base_qp;
> -			siw_dbg_cq(cq, "idx %u, type %d, flags %2x, id 0x%p\n",
> +			siw_dbg_cq(cq,
> +				   "idx %u, type %d, flags %2x, id 0x%llx\n",
>  				   cq->cq_get % cq->num_cqe, cqe->opcode,
> -				   cqe->flags, (void *)cqe->id);
> +				   cqe->flags, cqe->id);

If the value is really a kernel pointer, then it ought to be printed
with %p. We have been getting demanding on this point lately in RDMA
to enforce the ability to keep kernel pointers secret.

> -			wqe->sqe.sge[0].laddr = (u64)&wqe->sqe.sge[1];
> +			wqe->sqe.sge[0].laddr = (uintptr_t)&wqe->sqe.sge[1];

[..]

>  			rv = siw_rx_kva(srx,
> -					(void *)(sge->laddr + frx->sge_off),
> +					(void *)(uintptr_t)(sge->laddr + frx->sge_off),
>  					sge_bytes);

Bernard, this is nonsense, what is going on here with sge->laddr that
it can't be a void *?

Jason
