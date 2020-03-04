Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1254178F7C
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 12:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgCDLWG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 06:22:06 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42293 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgCDLWG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Mar 2020 06:22:06 -0500
Received: by mail-io1-f65.google.com with SMTP id q128so1943955iof.9
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2020 03:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zd6EHh+Xv9ufD5cmWFroJXikeJWoDYrEYf9+1i38fSg=;
        b=iejCa/9cMUZhtr0AIkZB5yhas1R9TkZWtZeYbEL0vk5oZQxNNxr9wQIVT+0Q6OrVpy
         Eff/hB8i6MzX0y2a3kd5t46LI9PsNTUEYFg4ah9dw0mgfh4IuPIiVTKpRXgtgTA2NCP3
         jxKtKCY/CWBBBekZ+qzWHDQl57pRJEAPi/EPKCNcL/tUg9HFDQc0zjknVBxpc6MzXbos
         C0pj3Q6R/maREnO8weLahhVdKVVO3OxP/h9omsVHUNwE55XhCQhc49jFOBB6m+O0a0s6
         Ej5/xHb7N2ZHDdFx5dpkFSeTU5hMdB/uSskWLRCIfpstCS2E64MbFmT0fmphzoSy5RbT
         E2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zd6EHh+Xv9ufD5cmWFroJXikeJWoDYrEYf9+1i38fSg=;
        b=YhuTBSenOmKGfBiI9NJ2MJyglxZCjiei11RS/+aCOl/+wCsZuTlAa1jFcyRVZsaUFM
         IgYpH/0wlzvuzx/FmIoTYjMHlhYZu1poKCx/Mt27adDx6rohd1J+IepJfCzmiflXHBli
         aNedLSfotRW6RarK+PX/rPHovXqC2SdamMNmtFQ0guWphNS5BA40rJ/WW6a1pfnqTcDt
         uQUBNDBbbTCkxcsV3710xiE6wIPX7QorMmSNrwaSoqvS1c/BCeX2wu4Oe17k+GOjLp/X
         +Jy0Cd+824++YaQfY+x1vWRUOb17Hi80HLK3BsZ9mSa5sfdR+mke5pEMoxo0RquUJkQX
         Uqxg==
X-Gm-Message-State: ANhLgQ3oOCjNPzi5/gg8bicKfENlcdUvy7if1ytQ6gsqGac6FEvAc2w6
        LjHk6OvG4hK8p2pB+u3WzmPqpfrB5pJ2zhREbQzOzs0T6jM=
X-Google-Smtp-Source: ADFU+vs6pyVQKZY2alGuHv76hcwShmYLnruT8s3fRJrGGedN1GLZ++agFzo20ZUPfC/YHoa9O6Ub4hNqaZQyBAWJOq8=
X-Received: by 2002:a02:3b24:: with SMTP id c36mr2228568jaa.23.1583320924768;
 Wed, 04 Mar 2020 03:22:04 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-5-jinpuwang@gmail.com>
 <20200303095713.GK121803@unreal>
In-Reply-To: <20200303095713.GK121803@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 4 Mar 2020 12:21:52 +0100
Message-ID: <CAMGffEkf2i2cLxNCOep7P=R69dn=gSD=HEkDR4atXaQ=kmLBqw@mail.gmail.com>
Subject: Re: [PATCH v9 04/25] RDMA/rtrs: core: lib functions shared between
 client and server modules
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 3, 2020 at 10:57 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Feb 21, 2020 at 11:47:00AM +0100, Jack Wang wrote:
> > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> >
> > This is a set of library functions existing as a rtrs-core module,
> > used by client and server modules.
> >
> > Mainly these functions wrap IB and RDMA calls and provide a bit higher
> > abstraction for implementing of RTRS protocol on client or server
> > sides.
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs.c | 594 +++++++++++++++++++++++++++++
> >  1 file changed, 594 insertions(+)
> >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs.c
>
> <...>
>
> > +
> > +static void dev_free(struct kref *ref)
> > +{
> > +     struct rtrs_rdma_dev_pd *pool;
> > +     struct rtrs_ib_dev *dev;
> > +
> > +     dev = container_of(ref, typeof(*dev), ref);
> > +     pool = dev->pool;
> > +
> > +     mutex_lock(&pool->mutex);
> > +     list_del(&dev->entry);
> > +     mutex_unlock(&pool->mutex);
> > +
> > +     if (pool->ops && pool->ops->deinit)
> > +             pool->ops->deinit(dev);
> > +
> > +     ib_dealloc_pd(dev->ib_pd);
> > +
> > +     if (pool->ops && pool->ops->free)
> > +             pool->ops->free(dev);
> > +     else
> > +             kfree(dev);
> > +}
> > +
> > +int rtrs_ib_dev_put(struct rtrs_ib_dev *dev)
> > +{
> > +     return kref_put(&dev->ref, dev_free);
> > +}
> > +EXPORT_SYMBOL(rtrs_ib_dev_put);
> > +
> > +static int rtrs_ib_dev_get(struct rtrs_ib_dev *dev)
> > +{
> > +     return kref_get_unless_zero(&dev->ref);
> > +}
> > +
> > +struct rtrs_ib_dev *
> > +rtrs_ib_dev_find_or_add(struct ib_device *ib_dev,
> > +                      struct rtrs_rdma_dev_pd *pool)
> > +{
> > +     struct rtrs_ib_dev *dev;
> > +
> > +     mutex_lock(&pool->mutex);
>
> The scope of this mutex is unclear, you protected everything here with
> this mutex, but in dev_free() you guarded list_del() only.

Looks the mutex only need to guard poll->list, I will run some tests to verify.

Thanks!
