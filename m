Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10A436B6E5
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2019 08:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfGQGrz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 02:47:55 -0400
Received: from condef-06.nifty.com ([202.248.20.71]:47268 "EHLO
        condef-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfGQGrz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jul 2019 02:47:55 -0400
X-Greylist: delayed 629 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jul 2019 02:47:53 EDT
Received: from conssluserg-06.nifty.com ([10.126.8.85])by condef-06.nifty.com with ESMTP id x6H6Y95s008077
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jul 2019 15:34:09 +0900
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x6H6Y50h019086;
        Wed, 17 Jul 2019 15:34:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x6H6Y50h019086
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563345246;
        bh=rG7ekEvaQy1IjhchJCTkqJacKz4cRc1jvbuG8gJAP9M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gXVacMquCuEXEGhx3Ti/SvGU6V2I4SNFOhfrjTKdUzbkaCwO18NlV21SnudqyxPHG
         d+PjzkPbvOk0scjD/dOXf3Vg52Bp0v1WK5EC6wX6RxboJZXTw41dJjoNWQ3Je3c++e
         u4XU2LWxmOGQKbRUkvSXBhNMBme07AqBAarjfd2ve+aftPiCe3CBPARFZ9Nf6p/Rz3
         EWV/8P+MkYogE6+47q6v7DuYqJOdUCeQ62DHmXnud4EvHOHwAgybx8VzNoq4N3AI5o
         eGV7K+mpxuGafTKlxs8WDo9sHqRvSe6q0D7RKCPOcUK8Q7lQzRBpib8ZOhy+0rpveI
         fPEBa27iGHVKQ==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id m8so15737320vsj.0;
        Tue, 16 Jul 2019 23:34:05 -0700 (PDT)
X-Gm-Message-State: APjAAAUbd3RgE1WpC6uDxGuibYNgQPrGTdPD4ZUt7KtG7DTCmiP6zIfN
        D+84pE3NEA0enK2maE4CDkzypayhzHINxEOZfcs=
X-Google-Smtp-Source: APXvYqzgNWfC169qm/VJmhV93vE8pqpShdA43iCdrk/fvt6DOhA6i66MYEisEz8GA2ScseJMPjrlg8uFi3GEPxYwCfk=
X-Received: by 2002:a67:f495:: with SMTP id o21mr23161422vsn.54.1563345244535;
 Tue, 16 Jul 2019 23:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190709133019.25a8cd27@canb.auug.org.au> <ba1dd3e2-3091-816c-c308-2f9dd4385596@mellanox.com>
 <20190709071758.GI7034@mtr-leonro.mtl.com> <20190709124631.GG3436@mellanox.com>
 <20190710110443.002220c8@canb.auug.org.au> <20190710143036.1582c79d@canb.auug.org.au>
 <20190717092801.77037015@canb.auug.org.au>
In-Reply-To: <20190717092801.77037015@canb.auug.org.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 17 Jul 2019 15:33:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNARZqi-QcGaTEaoTEASbnBaGzYchgDoWeuthR+G8jxQHMg@mail.gmail.com>
Message-ID: <CAK7LNARZqi-QcGaTEaoTEASbnBaGzYchgDoWeuthR+G8jxQHMg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the rdma tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markz@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Stephen,


On Wed, Jul 17, 2019 at 8:28 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi,
>
> On Wed, 10 Jul 2019 14:30:36 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Wed, 10 Jul 2019 11:04:43 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > On Tue, 9 Jul 2019 12:46:34 +0000 Jason Gunthorpe <jgg@mellanox.com> wrote:
> > > >
> > > > It isn't quite enough to make the header compile stand alone, I'm
> > > > adding this instead.
> > > >
> > > > From 37c1e072276b03b080eb24ff24c39080aeaf49ef Mon Sep 17 00:00:00 2001
> > > > From: Jason Gunthorpe <jgg@mellanox.com>
> > > > Date: Tue, 9 Jul 2019 09:44:47 -0300
> > > > Subject: [PATCH] RDMA/counters: Make rdma_counter.h compile stand alone
> > >
> > > I will apply this to linux-next today and reenable the stand alone
> > > building for rdma_counter.h
> >
> > That worked for me ...
>
> rdma_counter.h should be able to be removed from the exceptions list now.
>
> I have been building linux-next with this patch for a while, so maybe
> it could be applied to the kbuild tree?
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 10 Jul 2019 13:03:16 +1000
> Subject: [PATCH] rdma: attempt to build rdma_counter.h stand alone again
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  include/Kbuild | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/Kbuild b/include/Kbuild
> index 7e9f1acb9dd5..765ff864130d 100644
> --- a/include/Kbuild
> +++ b/include/Kbuild
> @@ -949,7 +949,6 @@ header-test-                        += pcmcia/ds.h
>  header-test-                   += rdma/ib.h
>  header-test-                   += rdma/iw_portmap.h
>  header-test-                   += rdma/opa_port_info.h
> -header-test-                   += rdma/rdma_counter.h
>  header-test-                   += rdma/rdmavt_cq.h
>  header-test-                   += rdma/restrack.h
>  header-test-                   += rdma/signature.h

Yes, this is just a one-liner fix-up,
so I'd like to fold it into this:

https://patchwork.kernel.org/patch/11047283/


-- 
Best Regards
Masahiro Yamada
