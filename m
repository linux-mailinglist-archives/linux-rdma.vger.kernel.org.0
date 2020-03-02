Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55A431757CB
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 10:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCBJ6x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 04:58:53 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36178 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgCBJ6w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Mar 2020 04:58:52 -0500
Received: by mail-io1-f68.google.com with SMTP id d15so10837807iog.3
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2020 01:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CgZRkqKTlqTPulCP/Z/qQC513Xv4FPfpHxLuqBbnjAk=;
        b=g15Sio73VOBgipZ8AqV6rXMyYIH/FjaISdLiWSdC0XmkFQK+jkP4oZSNp6y/GdqjvG
         Vk69oGdMYQnk1lUJZ5SlEM1Mg+lKO1i+ZTC9DtuG4tW8F+uQ3BYFah4NT+Qj+gASTqoO
         ABFI0wguzqgwePZGt9Pz36/0A9sc+SgdBXMOCNw+PSIlEI+maRoa/Gw7pVf4+vyxciIv
         OL7f6Lln0QoTsRidgU1ktWoemibzEbYsgjvUspDQP3o6V1ME5QJ0AVvGRQQjwW5UOWGi
         3b5sFXoEGc4prtPB9Rj3ZcN5YUMNwqnvJyJ/9qnffZCK2a7h3uCuWzYo3NYy9sR7a3I1
         2jUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CgZRkqKTlqTPulCP/Z/qQC513Xv4FPfpHxLuqBbnjAk=;
        b=Ikhd8Xa8Zrgxvn9qyYSDhMuqWq1PL7pXYzhE+KQxMQ9FTg/eSp9D+R+uq6WSDGMWzQ
         x8i127FOO6X4BdYrDtAVvHGUW81qBJwVgfqNkc4bVHLd9l0Y1xnLbRMnpTIe/KKWrcnp
         MkVT1WLAAtc0TZ7zVUqSIw1ogkP7zTjs/B353x3Joxp91b3cQIuGuz0G9wZmUpfFRf2F
         LACyKT9llokSK4hb8XARS+82Gi/9CUaQwo1+5xEAhydUPCeKEORnxmZ4b4YW+Xet+wUl
         487R48V+SJ9Qf6TMaaOofp9wAniAgP/5Az3B+zPx0JsG3G/gbH2se7esRLVFjL8gAf+d
         htdQ==
X-Gm-Message-State: APjAAAU2iXqO1S+6O1oKydB27u+BYQLVL4Uar4SnfEovOXyTjRhtSDwg
        83EH/hf4aNUZNiMqJ5zoeUTK9sjsq8fFv/ZjgxMv
X-Google-Smtp-Source: APXvYqyIpuywT4gaQSZZrGI4CtG5X618MR1wirAOy2xoXfW/vaZpNm0TtwxRfClkClwj0az1I5CQ1qO0+duuQ8nfLG8=
X-Received: by 2002:a02:caa8:: with SMTP id e8mr6403877jap.126.1583143131655;
 Mon, 02 Mar 2020 01:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-21-jinpuwang@gmail.com>
 <33864f54-62af-cb5f-45fa-55a283dcd434@acm.org>
In-Reply-To: <33864f54-62af-cb5f-45fa-55a283dcd434@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 10:58:40 +0100
Message-ID: <CAHg0HuwvdYNB=C4yi4_tXeOWkj9rjTsV0B59Ea+_axLAuZ98Zg@mail.gmail.com>
Subject: Re: [PATCH v9 20/25] block/rnbd: server: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 1, 2020 at 3:58 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:47, Jack Wang wrote:
> > +static int dev_search_path_set(const char *val, const struct kernel_param *kp)
> > +{
> > +     char *dup;
> > +
> > +     if (strlen(val) >= sizeof(dev_search_path))
> > +             return -EINVAL;
> > +
> > +     dup = kstrdup(val, GFP_KERNEL);
> > +
> > +     if (dup[strlen(dup) - 1] == '\n')
> > +             dup[strlen(dup) - 1] = '\0';
> > +
> > +     strlcpy(dev_search_path, dup, sizeof(dev_search_path));
> > +
> > +     kfree(dup);
> > +     pr_info("dev_search_path changed to '%s'\n", dev_search_path);
> > +
> > +     return 0;
> > +}
>
> It is not necessary in this function to do memory allocation. Something
> like the following (untested) code should be sufficient:
>
>         const char *p = strrchr(val, '\n') ? : val + strlen(val);
>
>         snprintf(dev_search_path, sizeof(dev_search_path), "%.*s",
>                 (int)(p - val), val);
>
> How are concurrent attempts to change dev_search_path serialized?
>
Hi Bart,

thanks a lot for your comments. Will try to avoid the allocation. The
module parameter is readonly. It's only set during module init - I
guess we don't need to handle concurrent access?

Best,
Danil.


> Thanks,
>
> Bart.
