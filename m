Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C78E214BCB
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 12:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgGEK1V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 06:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgGEK1V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Jul 2020 06:27:21 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D78DC061794
        for <linux-rdma@vger.kernel.org>; Sun,  5 Jul 2020 03:27:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so37621247wrs.11
        for <linux-rdma@vger.kernel.org>; Sun, 05 Jul 2020 03:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cj/e5bvWS0a8Kkyx+VaU7sDne+q6vUQg+SYLcIX1aco=;
        b=jl8vAookvvp8bt1FuF0Pf6tLZuwJgUcXXJDUdmUidvOZe2Y5bA9/Y04ogs5VPyH1eb
         FGwA+DY4hzXBr4tyU8F825x62SBaIbcMAPD2nSzDfGdlat+fzOwExcOp23pp+64D8lfl
         7/OXjFloX8qcofYUHEr9a6+ED5N/jDNJtDPp1sPwqy+N7yn7R+438bhvgOnx4t3dyPFs
         knPSWd6aPiFi9gN6wxJJOznETtQBD2ARKKAAXFU/zLbrePg6rbA7UL29DE6WzP69U73A
         0702y22wj85T+d8OqxNMzaqWzoTbnJjnll+fHtvOGJDDxPKQBrxsRrzqmBujeBzHTmYS
         TQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cj/e5bvWS0a8Kkyx+VaU7sDne+q6vUQg+SYLcIX1aco=;
        b=s2xHaLSqtO4Y0ZPh4kcYNUSsq1yZcKd3eZgXNnH5G+t2wcRXuzxy1BZDlEWwAmJwqs
         AcN8eu6XRnjNlqHA9zuEQ4N+XRjkjdQ8sDVoHr+82Qx82tiUfp9cCDmL2xyigh3Fazjy
         0l4xZl6QUdMgxWa7oHfW8VxTANyWJB6nYLFs6vjScCv/UwkeqNOstGJwAY+fgWPWlW1a
         sf56cjvlzeeua0LI93r5TR8CojY+cptc1MXyC41431mvtJoeXxGKgqcz+lqz8AxZaveT
         mXX73QVIrGOEY1Ku9iUJe3xTuOlzVaSsB1UIs9feDm7Bzh+sljZH8IO2VsU0JzeKWtYb
         Q18Q==
X-Gm-Message-State: AOAM532DHuoiiTK8t3HBECqhqvm1+2812Seu0YPju8ecwR/f9XD1fOKg
        mrIQnuSim4K19uhogHNG7Sg=
X-Google-Smtp-Source: ABdhPJyH+cw61LeNcX3kTPeRFsWgugZKKyw/bLncNe4ONeJ/U7tPTVEqZYQiWD+iPzmwueIMzMscYA==
X-Received: by 2002:adf:ec4e:: with SMTP id w14mr46390457wrn.280.1593944839977;
        Sun, 05 Jul 2020 03:27:19 -0700 (PDT)
Received: from kheib-workstation ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id q4sm18541401wmc.1.2020.07.05.03.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 03:27:19 -0700 (PDT)
Date:   Sun, 5 Jul 2020 13:27:16 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: Re: [PATCH for-next 4/4] RDMA/rxe: Remove rxe_link_layer()
Message-ID: <20200705102716.GA280842@kheib-workstation>
References: <20200703153428.173758-1-kamalheib1@gmail.com>
 <20200703153428.173758-5-kamalheib1@gmail.com>
 <CAD=hENe8ZDWRVXzhm6u_fB0c=BQP4+uSWBW4cBdgKkMQidKnUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENe8ZDWRVXzhm6u_fB0c=BQP4+uSWBW4cBdgKkMQidKnUw@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jul 04, 2020 at 12:18:36PM +0800, Zhu Yanjun wrote:
> On Fri, Jul 3, 2020 at 11:35 PM Kamal Heib <kamalheib1@gmail.com> wrote:
> >
> > Instead of
> 
> return
> 
> returning?
>

I'll fix it in v2.

Thanks,
Kamal

>  IB_LINK_LAYER_ETHERNET from rxe_link_layer return it
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
> > -
> >  int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
> >  {
> >         int err;
> > diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> > index ee80b8862db8..a3cf9bbe818d 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> > @@ -141,9 +141,7 @@ static int rxe_modify_port(struct ib_device *dev,
> >  static enum rdma_link_layer rxe_get_link_layer(struct ib_device *dev,
> >                                                u8 port_num)
> >  {
> > -       struct rxe_dev *rxe = to_rdev(dev);
> > -
> > -       return rxe_link_layer(rxe, port_num);
> > +       return IB_LINK_LAYER_ETHERNET;
> >  }
> >
> >  static int rxe_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
> > --
> > 2.25.4
> >
