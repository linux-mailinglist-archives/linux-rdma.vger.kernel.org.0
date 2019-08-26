Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBEB79D43B
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 18:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbfHZQm1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 12:42:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46889 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbfHZQm1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Aug 2019 12:42:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so15973135wru.13
        for <linux-rdma@vger.kernel.org>; Mon, 26 Aug 2019 09:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FykkB+Fau3R6BriMBAiFyHBhPsSaPj7uIfl28ZCeRKM=;
        b=grBHDAD+j1Bxh43m8OoqQzh/Fh2Mnlm5O+qLKuCBcIU+RqNK9dD+d8gQmrMWP1x4GI
         an0Gg46XkOvQUOrhHw4jF+V2WjcTMMjSOQ/7pmmhlYjPRFZbZRJF892xFiocQ5xMipzm
         YKBV/51Zb+ErszWmn0js6eShbZ69mue6Fx8kq2NQTkBywCFMm+BFPgGzA2sW7DX3eH8/
         HZAdX9i+iBgUaLxMGgqc86cPNZtuY65Q45wE+PKjAWri9uqi+quaUFAkL8992y7MukWb
         q7EfEVlKv+b5Mo145F1J7pklTViMhZGB4NzmLcshMcg6o59Q+l/b3E8G1I0N5+qYmq6l
         otWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FykkB+Fau3R6BriMBAiFyHBhPsSaPj7uIfl28ZCeRKM=;
        b=s530bD9vQpqDI81JZC/9rglXw71mpaA8oO/16EqTogqYU3agtuDsIq7Z6BV1dGekh4
         zxxWkuq6bV5k5PD8M26PaZ/xBiaHvGbRvdPXO7XzO3kM07NHCCWpXsmrmdx+6/DZIwvC
         7eBWItkdeOpPKqFXZw/xoWs5lSsnlVDEaoSSAwFDNgo/k1Gq1DKWOdnXcJ4pKTCmBSjb
         UEx3EfgvZSiv6VVIW782kjd3lv/lnf477uqC2ithqORlghnwb71kh0aRGgxSQwc3Z2bw
         OgRX8l2rATwO3gfDrpM6dgp2UuWFapdkFwGdKSkz/2KxP2SiSIzlRebweS2csIQIUCIP
         nwqw==
X-Gm-Message-State: APjAAAXxBAZrzQ7/o867GZHTgUNR3iKBKL7+4Y6OrhTrc3AD+H2rvAI+
        S06l9ZkJEq4rSsrmBODKaMg=
X-Google-Smtp-Source: APXvYqxZzSkjk6eQTQmCyMVf+2JqpjiiSETaWOBvCBx5KPayUhDkIhwfaBUuLor6avjfo406NqwaRA==
X-Received: by 2002:adf:f48d:: with SMTP id l13mr4816859wro.190.1566837746009;
        Mon, 26 Aug 2019 09:42:26 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id b3sm21173350wrm.72.2019.08.26.09.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 09:42:25 -0700 (PDT)
Date:   Mon, 26 Aug 2019 09:42:23 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Moni Shoua <monis@mellanox.com>
Subject: Re: [PATCH rdma-next 08/12] RDMA/odp: Check for overflow when
 computing the umem_odp end
Message-ID: <20190826164223.GA122752@archlinux-threadripper>
References: <20190819111710.18440-1-leon@kernel.org>
 <20190819111710.18440-9-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819111710.18440-9-leon@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 19, 2019 at 02:17:06PM +0300, Leon Romanovsky wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> Since the page size can be extended in the ODP case by IB_ACCESS_HUGETLB
> the existing overflow checks done by ib_umem_get() are not
> sufficient. Check for overflow again.
> 
> Further, remove the unchecked math from the inlines and just use the
> precomputed value stored in the interval_tree_node.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/umem_odp.c | 25 +++++++++++++++++++------
>  include/rdma/ib_umem_odp.h         |  5 ++---
>  2 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
> index 2575dd783196..46ae9962fae3 100644
> --- a/drivers/infiniband/core/umem_odp.c
> +++ b/drivers/infiniband/core/umem_odp.c
> @@ -294,19 +294,32 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
>  
>  	umem_odp->umem.is_odp = 1;
>  	if (!umem_odp->is_implicit_odp) {
> -		size_t pages = ib_umem_odp_num_pages(umem_odp);
> -
> +		size_t page_size = 1UL << umem_odp->page_shift;
> +		size_t pages;
> +
> +		umem_odp->interval_tree.start =
> +			ALIGN_DOWN(umem_odp->umem.address, page_size);
> +		if (check_add_overflow(umem_odp->umem.address,
> +				       umem_odp->umem.length,
> +				       &umem_odp->interval_tree.last))
> +			return -EOVERFLOW;

This if statement causes a warning on 32-bit ARM:

drivers/infiniband/core/umem_odp.c:295:7: warning: comparison of distinct
pointer types ('typeof (umem_odp->umem.address) *' (aka 'unsigned long *')
and 'typeof (umem_odp->umem.length) *' (aka 'unsigned int *'))
[-Wcompare-distinct-pointer-types]
                if (check_add_overflow(umem_odp->umem.address,
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/overflow.h:59:15: note: expanded from macro 'check_add_overflow'
        (void) (&__a == &__b);                  \
                ~~~~ ^  ~~~~
1 warning generated.

Cheers,
Nathan
