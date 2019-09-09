Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D98CADB89
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 16:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfIIOyh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 10:54:37 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:45696 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfIIOyh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Sep 2019 10:54:37 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x89EsXFx027891;
        Mon, 9 Sep 2019 07:54:34 -0700
Date:   Mon, 9 Sep 2019 20:24:32 +0530
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH v1 rdma-next] RDMA/siw: Relax from kmap_atomic() use in
 TX path
Message-ID: <20190909145427.GA12481@chelsio.com>
References: <20190909132945.30462-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909132945.30462-1-bmt@zurich.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Monday, September 09/09/19, 2019 at 18:59:45 +0530, Bernard Metzler wrote:
> Since the transmit path is never executed in an atomic
> context, we do not need kmap_atomic() and can always
> use less demanding kmap().
> 
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_qp_tx.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
> index 8e72f955921d..5d97bba0ce6d 100644
> --- a/drivers/infiniband/sw/siw/siw_qp_tx.c
> +++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
> @@ -76,16 +76,15 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, void *paddr)
>  			if (unlikely(!p))
>  				return -EFAULT;
>  
> -			buffer = kmap_atomic(p);
> +			buffer = kmap(p);
>  
>  			if (likely(PAGE_SIZE - off >= bytes)) {
>  				memcpy(paddr, buffer + off, bytes);
> -				kunmap_atomic(buffer);
missing kunmap()
>  			} else {
>  				unsigned long part = bytes - (PAGE_SIZE - off);
>  
>  				memcpy(paddr, buffer + off, part);
> -				kunmap_atomic(buffer);
> +				kunmap(p);
kunmap(buffer)
>  
>  				if (!mem->is_pbl)
>  					p = siw_get_upage(mem->umem,
> @@ -97,11 +96,10 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, void *paddr)
>  				if (unlikely(!p))
>  					return -EFAULT;
>  
> -				buffer = kmap_atomic(p);
> -				memcpy(paddr + part, buffer,
> -				       bytes - part);
> -				kunmap_atomic(buffer);
> +				buffer = kmap(p);
> +				memcpy(paddr + part, buffer, bytes - part);
>  			}
> +			kunmap(p);
Can this be out of if()? the buffers seem to be different.
>  		}
>  	}
>  	return (int)bytes;
> -- 
> 2.17.2
> 
