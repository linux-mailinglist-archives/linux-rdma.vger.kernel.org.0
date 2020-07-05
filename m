Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125B7214BD2
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 12:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgGEKbD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 06:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgGEKbC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Jul 2020 06:31:02 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56753C061794
        for <linux-rdma@vger.kernel.org>; Sun,  5 Jul 2020 03:31:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f139so38593313wmf.5
        for <linux-rdma@vger.kernel.org>; Sun, 05 Jul 2020 03:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LbVKtIQKd90bKRjmakDJ2UJ5UcpZxf4HmJHj5q+ddrA=;
        b=mTavvQ+vFEtF6y1YrLao+xxCfTTvHA73lEqt1fTCukoX/4/b2EGJ8gKCusbberShuX
         k0Ly10u2FGTYop4IERY5F1pm3NlDghxIT62ROMDKyYX+RAS/jDVWpP5R4curQ80ijsoC
         nLBsZ/kZegLGOEQOEJA1hN8PmwA6j9VvSGYgSz45hiyqCL6DrDB9gz+ASTEqMrsHV/Te
         AcOHbaI0xujDmGi92W074sUCnhwPhJth668X7sTKqxFEv5rVgFrEkNLRMFER6QMd5yHH
         OctEUTwuWUPkHmyfMCqhIRuQjOvXfiTy85BMFHZnXEGmAQRdDGsmizdtrrF9t35HK05C
         V1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LbVKtIQKd90bKRjmakDJ2UJ5UcpZxf4HmJHj5q+ddrA=;
        b=MTlxheHRxbQok+O1TTHtYqdxOP+3MEiHvIr4OB8puSNCUNv4kjlTM6Hp04DDPMGhdW
         YCUHlsF+iK5gjaRLWUz5203CM8Ux5mXGi+LvOSyx89vt0LBgvlc2bEBV2KLunkajJbWz
         j0tsncrRuXpg2cKckIDabEX9wsQ8i3MeuUREZ3MniHH+JfX+cNBf8p6MQgKuc0CzAWzK
         zKt/NOSw7vc5wEtoEF/hH0WGYQpR+o0gfZ7MEL2zRlouu6t8earZM2nOL3QDTPk4PbA+
         VCtk1dLwCI6+a93X5GPzNLxrfQd6zJQyuen59uqDQxbMbNluenIBz/w+p5pcwxBrEvwJ
         fdXQ==
X-Gm-Message-State: AOAM533nBAqsw+CQqMnmWmnmppYH/44Cz+1AlSluLC2S852BB0hT6N97
        AMRsast5NUVl8/gXiH0DRVU=
X-Google-Smtp-Source: ABdhPJzqboRMTwiaG2LRDwRc3CrUNBo1nhG+f0xmqNFzsR8G1dNqDYxjNbwdjN5zM71ZdkuBItyDNw==
X-Received: by 2002:a05:600c:21ca:: with SMTP id x10mr44122643wmj.63.1593945061069;
        Sun, 05 Jul 2020 03:31:01 -0700 (PDT)
Received: from kheib-workstation ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id o29sm21172353wra.5.2020.07.05.03.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 03:31:00 -0700 (PDT)
Date:   Sun, 5 Jul 2020 13:30:58 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: Re: [PATCH for-next 4/4] RDMA/rxe: Remove rxe_link_layer()
Message-ID: <20200705103058.GB280842@kheib-workstation>
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

Correct, but it's used only once.
So, I don't see the point of having it.

Thanks,
Kamal

> 
> Zhu Yanjun
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
