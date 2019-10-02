Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B8EC938B
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 23:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfJBVfU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 17:35:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44370 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfJBVfT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Oct 2019 17:35:19 -0400
Received: by mail-io1-f68.google.com with SMTP id w12so690919iol.11;
        Wed, 02 Oct 2019 14:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gnlFMlNypABzLw5irR8OlMn/0wqoIPMi5PCZlnfktBc=;
        b=J/j7EnsMpbJA8yJk7WiiiRf2aEycL7N0/yMWKKoWPvWx6QCGnBDEhzH0VAvC2v4CLQ
         v3V8kAyN7v16sscwmvWO9a+VXf0vyAGdXVGCVxhBdqjC56wlDbQd56WsaVMZ2EvQEPoS
         mdOyELSWmzbzPmgavFQ/sLMqUIyJNrrId5MQW/V44d41KtB9t8imArRpW9Owl140EBmf
         s0H0al/rVm9L7tJzM+rnU/Lm66AHNuRJ2vB2HFiBhPb5ssLPCB9jes2JUVQ0zpi1tBsc
         MFesIM8bAcUAXdJUVEKxyY918T/Z9RW4p4yY65wLFgHxe1mIqxEv1vXT0c7Eg67i6xTW
         ZxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gnlFMlNypABzLw5irR8OlMn/0wqoIPMi5PCZlnfktBc=;
        b=Nb2Ajg/b7P3nn68Gt3TgEDEf0Ef5a2Vy4d3gSmtrB1pcWlALGlF2mLCe0t4NXKksIZ
         hGE+XOaae45PFWGJC6/qn8OG9md5i02cWfr+37JZPt08r3zGSaE7AfRlA745XXcXc8CU
         orls7pWaxfWqFxMd4KQXnsyC8buQeB1QQOYXVfWrNbEhT3Ji7WQNwtaKYYG6yiujEO/W
         Me7IBk/1Sv3lXSH76i6rt+v0hr9Qlpy+r0b4Lmr2rRoC0WJF6G8Jqvw19P+IUaAqGSu9
         ilVgRw3ldAankApAuUkriWfwhpXjPDNPI7iHBhA1ePtLTTbsbNiELVAsJgtLGSUULreX
         dXKg==
X-Gm-Message-State: APjAAAXUrfzNY0F5q2b6akp/JqPvKjB/HgOxMq6LJFKD37nbF9dkuAOt
        Gc8oBL/wcMusvKlopp5AhwoaK1/O5vMS+sGlJn8=
X-Google-Smtp-Source: APXvYqzOA3zPAidGAa3rwzBrR+yHc0akSPI7N6kZIMeg+KCx3xKt86FB6MaFniD7JYNR2ESpns2Na4vGi1xWW+XriKI=
X-Received: by 2002:a92:b112:: with SMTP id t18mr6345688ilh.252.1570052117394;
 Wed, 02 Oct 2019 14:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190923050823.GL14368@unreal> <20190923155300.20407-1-navid.emamdoost@gmail.com>
 <20191001135430.GA27086@ziepe.ca>
In-Reply-To: <20191001135430.GA27086@ziepe.ca>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Wed, 2 Oct 2019 16:35:06 -0500
Message-ID: <CAEkB2EQF0D-Fdg74+E4VdxipZvTaBKseCtKJKnFg7T6ZZE9x6Q@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA: release allocated skb
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

Thanks for the feedback. Yes, you are right if the skb release is
moved under err4 label it will cause a double free as
c4iw_ref_send_wait will release skb in case of error.
So, in order to avoid leaking skb in case of c4iw_bar2_addrs failure,
the kfree(skb) could be placed under the error check like the way
patch v1 did. Do you see any mistake in version 1?
https://lore.kernel.org/patchwork/patch/1128510/


Thanks,
Navid

On Tue, Oct 1, 2019 at 8:54 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Sep 23, 2019 at 10:52:59AM -0500, Navid Emamdoost wrote:
> > In create_cq, the allocated skb buffer needs to be released on error
> > path.
> > Moved the kfree_skb(skb) under err4 label.
>
> This didn't move anything
>
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> >  drivers/infiniband/hw/cxgb4/cq.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
> > index b1bb61c65f4f..1886c1af10bc 100644
> > +++ b/drivers/infiniband/hw/cxgb4/cq.c
> > @@ -173,6 +173,7 @@ static int create_cq(struct c4iw_rdev *rdev, struct t4_cq *cq,
> >  err4:
> >       dma_free_coherent(&rdev->lldi.pdev->dev, cq->memsize, cq->queue,
> >                         dma_unmap_addr(cq, mapping));
> > +     kfree_skb(skb);
> >  err3:
> >       kfree(cq->sw_queue);
> >  err2:
>
> This looks wrong to me:
>
> int c4iw_ofld_send(struct c4iw_rdev *rdev, struct sk_buff *skb)
> {
>         int     error = 0;
>
>         if (c4iw_fatal_error(rdev)) {
>                 kfree_skb(skb);
>                 pr_err("%s - device in error state - dropping\n", __func__);
>                 return -EIO;
>         }
>         error = cxgb4_ofld_send(rdev->lldi.ports[0], skb);
>         if (error < 0)
>                 kfree_skb(skb);
>         return error < 0 ? error : 0;
> }
>
> Jason



-- 
Navid.
