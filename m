Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC90B3582E4
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 14:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhDHMIu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 08:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhDHMIu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 08:08:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C09C061760
        for <linux-rdma@vger.kernel.org>; Thu,  8 Apr 2021 05:08:39 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id m3so2110872edv.5
        for <linux-rdma@vger.kernel.org>; Thu, 08 Apr 2021 05:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SX4An+Ddv1gdPP4eQd+TxqKgL66zLg4Qs8vWLdzD4IM=;
        b=fay+47Oy6D1+jUL91EvWVxOzA2zJUfyiJroKNzl1uDRAHz1o+fy1/iT1C+8iqASZ9S
         2mgjIgk0YJghF7KIzXoLy4q49w/5+ZhAEYkDYjGbQI+W8kVq4pFv/eZgce2z0ZjUyD6G
         J3uSb2nDMVS+a8iCRCBFTNr3kP17YTt/YfrMRNqbFalu7TXRQot6r9olC8nQKAKg6LB0
         whHCvXL3mgTKZKJwRTdpXeKsha1L33VOuDVFWwjrU0frAovXyPteOHn0dbvM/yY3cO17
         IshEN+r44Hmc7mX/IEZXYJyHAgtezZjoqbFgIeteaeBafoctB5KSSR7J0ZQwWzlWttXN
         54zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SX4An+Ddv1gdPP4eQd+TxqKgL66zLg4Qs8vWLdzD4IM=;
        b=cJ9v5oRqKGvpCNa4HLGusD6pZPSJhf3kTPnMu3DtwlCQyYjNGymRrkdlf004gS398b
         vfk8hpUlKXmEiRYQM0Ij8g2UHDOpuORHB5sdidxvO4KIpaQSQxSh3mSOZqtTADYAX8hL
         PoNAsURfnzW+nVDUQr0K6fCQqDYLdFjhovz68hpVbpfkgteaP9OLZGCqnxt/o/kicXZP
         nUyT/P27aqIGvQVX9MjYxv1XX0ilJTE9i+IiirG43Q8EetOMkyP3fVYJKav9Sg3lBWX2
         6K0fvhb9mFzApFghTaaZiBQrWoTFJ2OjHoUzkXeglDTfahH/YOfdDobeJbsFXODkXA2/
         9PKQ==
X-Gm-Message-State: AOAM532s+liuAxSNUnMYbIqaJo/JFP2iPWCEO/7nkNWXiyFWFN6T1UYO
        Ujhlh1jO2xOLhGF6zDgCxL4h9ylirE1M8FKsBxSuTw==
X-Google-Smtp-Source: ABdhPJyH3pYK7zh6QRZJjZgos33Kbuoa5R/Ya8JqYlylH7Pcjm1ENJAvu0OByIXDgPSIrU6Iaw6OqXKDxxlv7wY6zCY=
X-Received: by 2002:a05:6402:1c04:: with SMTP id ck4mr10841062edb.74.1617883717820;
 Thu, 08 Apr 2021 05:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com> <20210325153308.1214057-13-gi-oh.kim@ionos.com>
 <20210401184448.GA1647065@nvidia.com> <CAJX1Ytao0LMYkGPy+E4XQzyxZFSytRDuwB2By2HQ6VBS7btCWg@mail.gmail.com>
 <20210408120418.GQ7405@nvidia.com>
In-Reply-To: <20210408120418.GQ7405@nvidia.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Thu, 8 Apr 2021 14:08:02 +0200
Message-ID: <CAJX1YtYUxZOiaKvTVxPou=a3icyVBrK8OCiatf+G3j6yV0bZtA@mail.gmail.com>
Subject: Re: [PATCH for-next 12/22] RDMA/rtrs-clt: Check state of the
 rtrs_clt_sess before reading its stats
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 8, 2021 at 2:04 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Apr 06, 2021 at 10:55:59AM +0200, Gioh Kim wrote:
> > On Thu, Apr 1, 2021 at 8:44 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Thu, Mar 25, 2021 at 04:32:58PM +0100, Gioh Kim wrote:
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > index 42f49208b8f7..1519191d7154 100644
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > @@ -808,6 +808,9 @@ static struct rtrs_clt_sess *get_next_path_min_inflight(struct path_it *it)
> > > >       int inflight;
> > > >
> > > >       list_for_each_entry_rcu(sess, &clt->paths_list, s.entry) {
> > > > +             if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
> > > > +                     continue;
> > >
> > > There is no way this could be right, a READ_ONCE can't guarentee that
> > > a following load is not going to happen without races.
> > >
> > > You need locking.
> >
> > Hi Jason,
> >
> > rtrs_clt_request() calls rcu_read_lock() before calling
> > get_next_path_min_inflight().
> > And rtrs_clt_change_state_from_to(), that changes the sess->state,
> > calls spin_lock_irq() before changing it.
> > I think that is enough, isn't it?
>
> Why would that be enough?
>
> Under RCU this check is racy and effetively does nothing.

Thank you for your review.
I will have a discussion with my colleagues and let you know the result.


>
> This is an OK usage of RCU:
>
>         list_del_rcu(&sess->s.entry);
>
>         /* Make sure everybody observes path removal. */
>         synchronize_rcu();
>
> And you could say that observing the sess in the list is required, but
> checking state is pointless.
>
> Jason
