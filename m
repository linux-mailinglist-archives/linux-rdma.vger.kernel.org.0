Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17891DBDAB
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 21:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgETTLI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 15:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgETTLH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 May 2020 15:11:07 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0979C061A0E
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2020 12:11:07 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f189so4749462qkd.5
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2020 12:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/sqdOB9lKM/Nc1w+qHw4m9hGCxNbAzYfvQuKdseO/n0=;
        b=MXzSeHFzDSTIUNevgBXiTwS2J8RMBqWhoRVcMCYchJt0y1HV/laFtIROWFVcfD/K1b
         LnkE25JxoqwdPOWgB2qlM1XXobwj9hNviNrt3f6yIgFVpCBPoiELvyLvmaIdSUl1gQDi
         KQT7VUKbDnDJ2Fom8u2VmHFGrptcmWOZoKkVONr0FttCIc+5evdf1c/7lDefhrDfKuOW
         rrJM3JMIfnwvbOubnUMLVPTfyYn1bjLluEdpCLrSY9I+1PI6OISPeUVYGb66NP5Aa9pe
         tNmJA0rYffmDYMXTfvnpfJtQub+v1UErP5zmwAs7qGCccW5R/UEeApUx9Yjv8RP9WMXa
         poLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/sqdOB9lKM/Nc1w+qHw4m9hGCxNbAzYfvQuKdseO/n0=;
        b=tuxQPi55pw2GwZmVgdkmW2Rj3LsjzFgghbNlEZqhrmyWaEThmWfcjvaQSlPThrCeus
         bRDedkKl/gedAz1Q0AG5NiPr9QTvZBg3Uiwu/FgRGHWdgmy4+MUT18ofcbcJPpJD++fb
         9msTFLl14/q6Xt0/9+CkKfPuwIohHzGwB9DcNx7/69bagiam+RyRGwnu/7uNLmpzRIBO
         IAiW50nSoPjqpEoUWeVEpklbbo/k2rRe/Mf636jqWzds7+t2bCGwektiWKwxMLfyIy/l
         chnvFgPMMSnTZq/lCDTbDjX8J53mKdSamLmUsGoypKJxf+Xgj1UEXwYaGr43i/Y8abb0
         Kqaw==
X-Gm-Message-State: AOAM531DVQaYO330cf5G+VJGR1rvfqHIhB8br1/Ahl5EqsgVZqHXkn/t
        l93ALHPFmsPH9+G+7jLcG6ptJw==
X-Google-Smtp-Source: ABdhPJyOF+2fMEBgEzVU6xGikKPNqjG1sfefK3EBa5NTChgyalt0B9uSUcNs4jEq3JrDrQSD/jU4nQ==
X-Received: by 2002:a05:620a:12f2:: with SMTP id f18mr5796160qkl.78.1590001866946;
        Wed, 20 May 2020 12:11:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id j45sm3383258qtk.14.2020.05.20.12.11.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 May 2020 12:11:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbU7N-0002LO-RA; Wed, 20 May 2020 16:11:05 -0300
Date:   Wed, 20 May 2020 16:11:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2] rtrs-clt: silence kbuild test inconsistent intenting
 smatch warning
Message-ID: <20200520191105.GK31189@ziepe.ca>
References: <20200519112936.928185-1-danil.kipnis@cloud.ionos.com>
 <76b6b987-4f63-2487-7fbe-a1d9c2f06b76@acm.org>
 <20200519233847.GC12656@ziepe.ca>
 <CAHg0Huy3JmK=iFSrEFhbv==KFJusNr6Z+=H7Xwf+fHEZU2pYmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHg0Huy3JmK=iFSrEFhbv==KFJusNr6Z+=H7Xwf+fHEZU2pYmQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 20, 2020 at 12:04:28PM +0200, Danil Kipnis wrote:
> On Wed, May 20, 2020 at 1:38 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, May 19, 2020 at 07:29:15AM -0700, Bart Van Assche wrote:
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > index 468fdd0d8713..8dfa56dc32bc 100644
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > @@ -727,18 +727,13 @@ struct path_it {
> > >       struct rtrs_clt_sess *(*next_path)(struct path_it *it);
> > >  };
> > >
> > > -#define do_each_path(path, clt, it) {                                        \
> > > -     path_it_init(it, clt);                                          \
> > > -     rcu_read_lock();                                                \
> > > -     for ((it)->i = 0; ((path) = ((it)->next_path)(it)) &&           \
> > > -                       (it)->i < (it)->clt->paths_num;               \
> > > +#define for_each_path(path, clt, it)                                 \
> > > +     for (path_it_init((it), (clt)), rcu_read_lock(), (it)->i = 0;   \
> > > +          (((path) = ((it)->next_path)(it)) &&                       \
> > > +           (it)->i < (it)->clt->paths_num) ||                        \
> > > +                  (path_it_deinit(it), rcu_read_unlock(), 0);        \
> > >            (it)->i++)
> >
> > That is nicer, even better to write it with some inlines..
> 
> You mean pass a callback to an inline function that would iterate?

no, just wrap some of that logic embedded in the for statement in some
inlines, not sure

Jason
