Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7C51DAF9F
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 12:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgETKEl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 06:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgETKEk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 May 2020 06:04:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE82C05BD43
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2020 03:04:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id v12so2464400wrp.12
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2020 03:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=inIn2ONjibCnSjCghxYnKq2rJ8+ESmy4DRNsddh+5yQ=;
        b=hsxRs5C5YKYa0yGhhIMT8XTt4BoSeJuvqv1ep1IHg83tnHnWPY4qC0Ary05LJN/ytf
         MK+6DkmMTO9O0cs/6rjB0kxORhU0VilWrccz3QYeTs8o6uBYGgvisL5HVrzJNsF0M0Cm
         khtyZ8qYv/5VG54vdTkCJbphGw5c5EMeKbH8Ro+648vM+QF8RiY0AgPDyr7AgfxuCYYJ
         iNFQpZnN2WnqBrOWTtdai6yvUPzCjS+38ty6JN2Nw/wWgvgVcVxN43DCqKbos6f6w2Un
         EHqpC/elSDJHwrCkFAHHxsWWXCKf/owGUskeqyzFrGaTxyYkV1bHxnKz/elmGJiVfDEj
         DjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=inIn2ONjibCnSjCghxYnKq2rJ8+ESmy4DRNsddh+5yQ=;
        b=UPhxRo+fuD/TfT/01T8HUxVXU2YnJvHaswTmzYyUFnlpHve+B0J032PImngMblrZ3x
         rk2i+nV7G1D/5Uak3i2AEHbYocy8dhihwbOluO6LVvpp/d06IBGh1i6mucwtMsUVB+CH
         etpsXhFVfqPrju6PktvcexDR/L5mgOIHef1HcunTeiEB6BK04oDkG6zg2FQjfj8/ZysQ
         KqPIgdGaeYaBdMM3KLYGkIsuETpQcFKkTFyfkaRCjAnG70M71sz3OeifVBNmhKZXiEoh
         ivZ8v/6A1/x7a2+8rLCubzol740ce9Kut4HhsO4qE6Ffyf1AUC/zC0EpzrARtJAmMkTa
         VTLA==
X-Gm-Message-State: AOAM533wkXP+jA44q3DJJIFh6Za6klr/EHhQuCYS7166tfnu5+KiSwOr
        XGw+HRVzeZc3SVWsY2VygTSEwSGDBO28vA4JZwE9
X-Google-Smtp-Source: ABdhPJwVhiOqJ6pZXZNbYxT2v3Gmlpbge7+a6xMaVWYDFGQk3afXhXJbIz+s1l5P0HUngJK5K88CcaSWqMTubKH3ZVc=
X-Received: by 2002:a5d:6705:: with SMTP id o5mr3608109wru.426.1589969078863;
 Wed, 20 May 2020 03:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200519112936.928185-1-danil.kipnis@cloud.ionos.com>
 <76b6b987-4f63-2487-7fbe-a1d9c2f06b76@acm.org> <20200519233847.GC12656@ziepe.ca>
In-Reply-To: <20200519233847.GC12656@ziepe.ca>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 20 May 2020 12:04:28 +0200
Message-ID: <CAHg0Huy3JmK=iFSrEFhbv==KFJusNr6Z+=H7Xwf+fHEZU2pYmQ@mail.gmail.com>
Subject: Re: [PATCH v2] rtrs-clt: silence kbuild test inconsistent intenting
 smatch warning
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 20, 2020 at 1:38 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, May 19, 2020 at 07:29:15AM -0700, Bart Van Assche wrote:
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > index 468fdd0d8713..8dfa56dc32bc 100644
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -727,18 +727,13 @@ struct path_it {
> >       struct rtrs_clt_sess *(*next_path)(struct path_it *it);
> >  };
> >
> > -#define do_each_path(path, clt, it) {                                        \
> > -     path_it_init(it, clt);                                          \
> > -     rcu_read_lock();                                                \
> > -     for ((it)->i = 0; ((path) = ((it)->next_path)(it)) &&           \
> > -                       (it)->i < (it)->clt->paths_num;               \
> > +#define for_each_path(path, clt, it)                                 \
> > +     for (path_it_init((it), (clt)), rcu_read_lock(), (it)->i = 0;   \
> > +          (((path) = ((it)->next_path)(it)) &&                       \
> > +           (it)->i < (it)->clt->paths_num) ||                        \
> > +                  (path_it_deinit(it), rcu_read_unlock(), 0);        \
> >            (it)->i++)
>
> That is nicer, even better to write it with some inlines..

You mean pass a callback to an inline function that would iterate?
>
> Jason
