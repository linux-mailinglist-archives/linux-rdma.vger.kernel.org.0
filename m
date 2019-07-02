Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2688C5D2E5
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jul 2019 17:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfGBP3j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jul 2019 11:29:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfGBP3i (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Jul 2019 11:29:38 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D4FF2184C;
        Tue,  2 Jul 2019 15:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562081377;
        bh=8qUm6lbGEuRk5JL1KZKlQ/j+/DnAZtaH/I96238AzC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SjT3o8niS7ALH8UvBDsISjJnv4KYvjlu4FFxdh6yPg/Kzgu15hxds33AlFq64B+Uw
         oVBMwkcVmfYi370veC1clZkj8uhRCQvbf5ptqPDUsvQq25XEneMkDTsz0eHfFgEsvF
         7TSDdNcuNjpNRJUrkBXhvEAomLn0xL4Q+MVo6UP0=
Date:   Tue, 2 Jul 2019 18:29:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Cc:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] ibverbs/rxe: Remove variable self-initialization
Message-ID: <20190702152933.GW4727@mtr-leonro.mtl.com>
References: <20190702134928.31534-1-mplaneta@os.inf.tu-dresden.de>
 <20190702140643.GV4727@mtr-leonro.mtl.com>
 <87010175-9072-b0e6-afc0-4e632587503a@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87010175-9072-b0e6-afc0-4e632587503a@os.inf.tu-dresden.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 02, 2019 at 04:14:11PM +0200, Maksym Planeta wrote:
>
>
> On 02/07/2019 16:06, Leon Romanovsky wrote:
> > On Tue, Jul 02, 2019 at 03:49:28PM +0200, Maksym Planeta wrote:
> > > In some cases (not in this particular one) variable self-initialization
> > > can lead to undefined behavior. In this case, it is just obscure code.
> > >
> > > Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
> > > ---
> > >   drivers/infiniband/sw/rxe/rxe_comp.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
> > > index 00eb99d3df86..116cafc9afcf 100644
> > > --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> > > +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> > > @@ -558,7 +558,7 @@ int rxe_completer(void *arg)
> > >   {
> > >   	struct rxe_qp *qp = (struct rxe_qp *)arg;
> > >   	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> > > -	struct rxe_send_wqe *wqe = wqe;
> > > +	struct rxe_send_wqe *wqe = NULL;
> >
> > This can't work, for example call to do_read() will crash the system,
> > due to pointer dereference.
> >
>
> wqe will be properly initialized before actual usage.
>
> Before do_read can be called, first there is necessary COMPST_GET_ACK, and
> then necessary COMPST_GET_WQE. Then get_wqe will be called, that sets proper
> value for wqe.

I see it now, thanks


>
> > >   	struct sk_buff *skb = NULL;
> > >   	struct rxe_pkt_info *pkt = NULL;
> > >   	enum comp_state state;
> > > --
> > > 2.20.1
> > >
>
> --
> Regards,
> Maksym Planeta
