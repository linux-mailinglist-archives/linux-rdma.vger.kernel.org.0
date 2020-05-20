Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868FD1DB091
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 12:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgETKup (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 06:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETKup (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 May 2020 06:50:45 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC882C061A0E
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2020 03:50:44 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id w18so2567365ilm.13
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2020 03:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0zhGZwgL8YSUsVySGHm2u7phTBeRPkIbMa1YtQgTt7A=;
        b=ch0CZeE+CTvPRCmyDkuod6uniXlE9P0ByvP09eJWjZtsoK/2gJUcdARo2AP+Gzrbue
         hzb9xr5Vl+YPnge1lb09ogQilybTfXu0QKJJyhAjxv/f9612KhlzmgdJY2tfiieeuIK9
         mj/Y9qhA5zgIzN4AtmknmKbEiFzUZ9FIaG9Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0zhGZwgL8YSUsVySGHm2u7phTBeRPkIbMa1YtQgTt7A=;
        b=rESxvEMQDvMEENl8ISuROcm6V1cUdesUrKeThxMvBWaw6EKTO1sUTW8eUBIDEhwYH5
         7vuT78pGSZqTP6I3i9Wq9EGaXaU50QGqD5pA4i3Rrgc+5IexNNnwfuSqupBVQg4M1T39
         r6zl6oEP1YFSDFKhL1Nz6T9AqxO3QDXaS1i0s7KspdXx0pX5csncwYutDYnAjVk5PQVZ
         uj3JuCPA0Drq/XK41Cdt2Ht7r6LPgGy7ZXXnd/idvg1Lxre1Km8YxQtFehAt89o8ZD5A
         ccRd5Jv+hMEP7Hr0HtyjXMr5YusE9FnTSTrHpxsief1iy6QyK4O+u9ZWeQk/ALw/uBHY
         CRjQ==
X-Gm-Message-State: AOAM533A87cxMDVQYfRg7J6C7B0Iy6xXXo/MxLeZJy6NRb4A4v3OTLD6
        SYWZ8nqjXyt9M96Srtbf/5QYzZN6tYL39tJBi4bTTA==
X-Google-Smtp-Source: ABdhPJzIXE2je70nHkOdoe5BILrjzzK/glF5z006uLfalqIBYey1hgBxH2pqtwP8wFNDF4AIjTZ0mbLH1DZCmg2shCo=
X-Received: by 2002:a92:502:: with SMTP id q2mr3132513ile.89.1589971844078;
 Wed, 20 May 2020 03:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <1589892216-39283-1-git-send-email-yaminf@mellanox.com>
 <1589892216-39283-3-git-send-email-yaminf@mellanox.com> <CANjDDBgPQBOuBNQE=3PqsAtNgSzVbnDDt6wYNrS8iC-gAYzHJQ@mail.gmail.com>
 <1e4eeb19-17a2-d281-24f1-fd79d34c7df2@mellanox.com>
In-Reply-To: <1e4eeb19-17a2-d281-24f1-fd79d34c7df2@mellanox.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Wed, 20 May 2020 16:20:07 +0530
Message-ID: <CANjDDBhenmz=k21BBhK91LwQ9OjgrdPUZx-Vvu2PvUpj0YvNAw@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] RDMA/core: Introduce shared CQ pool API
To:     Yamin Friedman <yaminf@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 20, 2020 at 2:53 PM Yamin Friedman <yaminf@mellanox.com> wrote:
>
>
> On 5/20/2020 9:19 AM, Devesh Sharma wrote:
> >
> >> +
> >> +static int ib_alloc_cqs(struct ib_device *dev, int nr_cqes,
> >> +                       enum ib_poll_context poll_ctx)
> >> +{
> >> +       LIST_HEAD(tmp_list);
> >> +       struct ib_cq *cq;
> >> +       unsigned long flags;
> >> +       int nr_cqs, ret, i;
> >> +
> >> +       /*
> >> +        * Allocated at least as many CQEs as requested, and otherwise
> >> +        * a reasonable batch size so that we can share CQs between
> >> +        * multiple users instead of allocating a larger number of CQs.
> >> +        */
> >> +       nr_cqes = min(dev->attrs.max_cqe, max(nr_cqes, IB_MAX_SHARED_CQ_SZ));
> >> +       nr_cqs = min_t(int, dev->num_comp_vectors, num_online_cpus());
> > No WARN() or return with failure as pointed by Leon and me. Has
> > anything else changes elsewhere?
>
> Hey Devesh,
>
> I am not sure what you are referring to, could you please clarify?
>
I thought on V2 Leon gave a comment "how this will work if
dev->num_comp_vectors" is 0.
there I had suggested to fail the pool creation and issue a
WARN_ONCE() or something.
> >
> >> +       for (i = 0; i < nr_cqs; i++) {
> >> +               cq = ib_alloc_cq(dev, NULL, nr_cqes, i, poll_ctx);
> >> +               if (IS_ERR(cq)) {
> >> +                       ret = PTR_ERR(cq);
> >> +                       goto out_free_cqs;
> >> +               }
> >> +               cq->shared = true;
> >> +               list_add_tail(&cq->pool_entry, &tmp_list);
> >> +       }
> >> +
> >> +       spin_lock_irqsave(&dev->cq_pools_lock, flags);
> >> +       list_splice(&tmp_list, &dev->cq_pools[poll_ctx - 1]);
> >> +       spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
> >> +
> >> +       return 0;
> >> +
> >> +out_free_cqs:
> >> +       list_for_each_entry(cq, &tmp_list, pool_entry) {
> >> +               cq->shared = false;
> >> +               ib_free_cq(cq);
> >> +       }
> >> +       return ret;
> >> +}
> >> +
> >>
