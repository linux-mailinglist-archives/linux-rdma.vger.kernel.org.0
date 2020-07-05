Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB49214AFB
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 09:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgGEHqI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 03:46:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgGEHqH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 5 Jul 2020 03:46:07 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 823A6206BE;
        Sun,  5 Jul 2020 07:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593935167;
        bh=OcVOa8WuzJRVdavjz0+UcCPdjDWaQpI8SH+WClSUFak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P75/VSVY3iNzsR/tPYfRQMs7MMiUKVBt/lwu4pEevlMayN3lL3Xorr/51v8TSPo5Q
         kRFZWYccCzounHbKvcqNc1AfMikE+ASd9pmCVHJ3Ahd3qGibcB0tNl0/EL0xYIAMjb
         Odc0BbRCdOw98hEbcoFkickUb8V/39ECO8bdhdeE=
Date:   Sun, 5 Jul 2020 10:46:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Kamal Heib <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: Re: [PATCH for-next 4/4] RDMA/rxe: Remove rxe_link_layer()
Message-ID: <20200705074603.GB5149@unreal>
References: <20200703153428.173758-1-kamalheib1@gmail.com>
 <20200703153428.173758-5-kamalheib1@gmail.com>
 <CAD=hENe33xJ+WEj3q7DpVB17Cn+Yu9Sz6at=oZKhDdz_PR9bKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENe33xJ+WEj3q7DpVB17Cn+Yu9Sz6at=oZKhDdz_PR9bKw@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 05, 2020 at 09:49:31AM +0800, Zhu Yanjun wrote:
> On Fri, Jul 3, 2020 at 11:35 PM Kamal Heib <kamalheib1@gmail.com> wrote:
> >
> > Instead of return IB_LINK_LAYER_ETHERNET from rxe_link_layer return it
> > directly from get_link_layer callback and remove rxe_link_layer().
> >
> > Fixes: 8700e3e7c485 ("Soft RoCE driver")
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_loc.h   | 1 -
> >  drivers/infiniband/sw/rxe/rxe_net.c   | 5 -----
> >  drivers/infiniband/sw/rxe/rxe_verbs.c | 4 +---
> >  3 files changed, 1 insertion(+), 9 deletions(-)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> > index 0688928cf2b1..39dc3bfa5d5d 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> > +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> > @@ -142,7 +142,6 @@ int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb);
> >  struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
> >                                 int paylen, struct rxe_pkt_info *pkt);
> >  int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb, u32 *crc);
> > -enum rdma_link_layer rxe_link_layer(struct rxe_dev *rxe, unsigned int port_num);
> >  const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num);
> >  struct device *rxe_dma_device(struct rxe_dev *rxe);
> >  int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid);
> > diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> > index 312c2fc961c0..0c3808611f95 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_net.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> > @@ -520,11 +520,6 @@ const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num)
> >         return rxe->ndev->name;
> >  }
> >
> > -enum rdma_link_layer rxe_link_layer(struct rxe_dev *rxe, unsigned int port_num)
> > -{
> > -       return IB_LINK_LAYER_ETHERNET;
> > -}
>
> This is a wrapper function.

What does one-time used/one-line wrapper function give us?

Thanks
