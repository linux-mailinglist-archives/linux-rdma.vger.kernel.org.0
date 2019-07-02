Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7AAB5D12E
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jul 2019 16:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfGBOGt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jul 2019 10:06:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfGBOGt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Jul 2019 10:06:49 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D5E6206A3;
        Tue,  2 Jul 2019 14:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562076408;
        bh=r1/Hk3wqJv5W2Qi8HM0jhslv0U+uV2buvj1ni1hDUqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JSgcfGrTjN4Ysm6Akq0BeauHE4LU3Z79OIcqWn6pF0PduECebNQ7HDAqxz28IRM7s
         OXxFPtbHZPi/yqQvIW3hjreH4Uv44SorFh82CFtLg1KgHRdlL7t1urXwo3io6I+i0i
         ia/0e6kux09k4a2GMLv+s+1uylf/6gCWQKmIMPt4=
Date:   Tue, 2 Jul 2019 17:06:43 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Cc:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] ibverbs/rxe: Remove variable self-initialization
Message-ID: <20190702140643.GV4727@mtr-leonro.mtl.com>
References: <20190702134928.31534-1-mplaneta@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702134928.31534-1-mplaneta@os.inf.tu-dresden.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 02, 2019 at 03:49:28PM +0200, Maksym Planeta wrote:
> In some cases (not in this particular one) variable self-initialization
> can lead to undefined behavior. In this case, it is just obscure code.
>
> Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
> ---
>  drivers/infiniband/sw/rxe/rxe_comp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
> index 00eb99d3df86..116cafc9afcf 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -558,7 +558,7 @@ int rxe_completer(void *arg)
>  {
>  	struct rxe_qp *qp = (struct rxe_qp *)arg;
>  	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> -	struct rxe_send_wqe *wqe = wqe;
> +	struct rxe_send_wqe *wqe = NULL;

This can't work, for example call to do_read() will crash the system,
due to pointer dereference.

>  	struct sk_buff *skb = NULL;
>  	struct rxe_pkt_info *pkt = NULL;
>  	enum comp_state state;
> --
> 2.20.1
>
