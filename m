Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7227BCC25C
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 20:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbfJDSNH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 14:13:07 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44668 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfJDSNH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 14:13:07 -0400
Received: by mail-io1-f68.google.com with SMTP id w12so15436999iol.11;
        Fri, 04 Oct 2019 11:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v8UsR0kNBiv7TX5BwyKWmoMM1TMa1sl5V/BHTRSzPsE=;
        b=P+iGnGe4QIyf7I+F1pUZZO0Kppw6jE6Vmy5VOoqHcsA6AWDz8YcGV3K6NxBfefAU0T
         04tweKxfpC5BZExMV/aSOPmTkQ8kiRcQTIbwHdltftyXJ9glKPgc8XOtoCz1eNwTtuQ2
         JP6+ZBWCsTnokEvApQIl2o4ZdkR1VDZjJAMtIy1aOOIYxaFhG6LYhZFzcK+R1a5u5Sap
         6qXwMJfpg7G1/uMbSGGdyA4cKu3vsOwFIcCcrUkK+mcsfdO9b9JBsIo2h95+1gQCrTiJ
         92HSrGiIGJ0kqcQCqnxxfhW2Unyps/KZABW2W0Ykmgfjo7ZSDj7K7Ow8PGjPfHnCi2i5
         deZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8UsR0kNBiv7TX5BwyKWmoMM1TMa1sl5V/BHTRSzPsE=;
        b=aMW6yksH5vBC6/GmLDuBdgTH2q6RWNgR0SDvxKINVlR+QIfyzQDcxsszXnd1GmmnFd
         5eZCjj3wSqL9YYPOMq/odTkjurKr2jJw3nJwnNC7xQIviehpwQsWbPcAUwcGOCON0K5O
         IFATXkWXkjTLzBrV6n4QrM+9QbdEFxzSI/7V5wTyRl+kmylOf920NOkTqNqCLwOxTbkm
         ukGUzA9A0EZ47zpyN22H5gxhktJ6ucPfMpVIf0jIQlFdQCF2qkhHRwWcjXJzXFTxNU9W
         8krddZylhYW1framyxZiNLKQ3QX0YnEHyOQtiyvT9irXHAZwNFeUePtesCPpKPZ7lbjV
         yCVg==
X-Gm-Message-State: APjAAAVrp/lMBNL0uyY6JhOnNKDn9XYnFBdVRqca7XOPHq32yZwbZ8i0
        E53pBEZJSbfWE5dPMXHP4J8O1VXN+Cwa62boAUE=
X-Google-Smtp-Source: APXvYqzZcW+suOjUfS0TSiHIIW0vthhI/MVBQ2EcnpCIQ2562V4H7KFuoAtjJUn1UieH6X9UaAEDmm/kqtdk8Sl0rZM=
X-Received: by 2002:a92:8702:: with SMTP id m2mr17674771ild.294.1570212786091;
 Fri, 04 Oct 2019 11:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190923050823.GL14368@unreal> <20190923155300.20407-1-navid.emamdoost@gmail.com>
 <20191001135430.GA27086@ziepe.ca> <CAEkB2EQF0D-Fdg74+E4VdxipZvTaBKseCtKJKnFg7T6ZZE9x6Q@mail.gmail.com>
 <20191003102510.GA10875@chelsio.com>
In-Reply-To: <20191003102510.GA10875@chelsio.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Fri, 4 Oct 2019 13:12:55 -0500
Message-ID: <CAEkB2ERA_Tn_yYz=ZQ58rF6sLGopxFghuTFBD=pWwcPwjLjTmw@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA: release allocated skb
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon and Potnuri,

Based on the following call sequence, skb is passed along to uld_send().
c4iw_ref_send_wait
        c4iw_ofld_send
                cxgb4_ofld_send
                        t4_ofld_send
                                uld_send

In uld_send() skb is consumed (released or added to queue) via
ctrl_xmit() or ofld_xmit(), which assures no leak is happening. But in
the condition check for txq_info the return value is NET_XMIT_DROP
which means the skb should be released. Here I believe skb is being
leaked:

        txq_info = adap->sge.uld_txq_info[tx_uld_type];
        if (unlikely(!txq_info)) {
                WARN_ON(true);
                return NET_XMIT_DROP;
        }

Please let me know what you think, then I can go ahead and fix the patch.

Thank you,
Navid.

On Thu, Oct 3, 2019 at 5:25 AM Potnuri Bharat Teja <bharat@chelsio.com> wrote:
>
> On Thursday, October 10/03/19, 2019 at 03:05:06 +0530, Navid Emamdoost wrote:
> > Hi Jason,
> >
> > Thanks for the feedback. Yes, you are right if the skb release is
> > moved under err4 label it will cause a double free as
> > c4iw_ref_send_wait will release skb in case of error.
> > So, in order to avoid leaking skb in case of c4iw_bar2_addrs failure,
> > the kfree(skb) could be placed under the error check like the way
> > patch v1 did. Do you see any mistake in version 1?
> > https://lore.kernel.org/patchwork/patch/1128510/
>
> Hi Navid,
> Both the revisions of the patch are invalid. skb is freed in both the cases of
> failure and success through c4iw_ofld_send().
> case success: in ctrl_xmit()
> case failure: in c4iw_ofld_send()
>
> Thanks,
> Bharat.
>
>
> >
> >
> > Thanks,
> > Navid
> >
> > On Tue, Oct 1, 2019 at 8:54 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Mon, Sep 23, 2019 at 10:52:59AM -0500, Navid Emamdoost wrote:
> > > > In create_cq, the allocated skb buffer needs to be released on error
> > > > path.
> > > > Moved the kfree_skb(skb) under err4 label.
> > >
> > > This didn't move anything
> > >
> > > > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > > >  drivers/infiniband/hw/cxgb4/cq.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
> > > > index b1bb61c65f4f..1886c1af10bc 100644
> > > > +++ b/drivers/infiniband/hw/cxgb4/cq.c
> > > > @@ -173,6 +173,7 @@ static int create_cq(struct c4iw_rdev *rdev, struct t4_cq *cq,
> > > >  err4:
> > > >       dma_free_coherent(&rdev->lldi.pdev->dev, cq->memsize, cq->queue,
> > > >                         dma_unmap_addr(cq, mapping));
> > > > +     kfree_skb(skb);
> > > >  err3:
> > > >       kfree(cq->sw_queue);
> > > >  err2:
> > >
> > > This looks wrong to me:
> > >
> > > int c4iw_ofld_send(struct c4iw_rdev *rdev, struct sk_buff *skb)
> > > {
> > >         int     error = 0;
> > >
> > >         if (c4iw_fatal_error(rdev)) {
> > >                 kfree_skb(skb);
> > >                 pr_err("%s - device in error state - dropping\n", __func__);
> > >                 return -EIO;
> > >         }
> > >         error = cxgb4_ofld_send(rdev->lldi.ports[0], skb);
> > >         if (error < 0)
> > >                 kfree_skb(skb);
> > >         return error < 0 ? error : 0;
> > > }
> > >
> > > Jason
> >
> >
> >
> > --
> > Navid.



-- 
Navid.
