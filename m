Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37BED12943A
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2019 11:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfLWKbk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Dec 2019 05:31:40 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:41458 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfLWKbk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Dec 2019 05:31:40 -0500
Received: by mail-il1-f196.google.com with SMTP id f10so13628376ils.8
        for <linux-rdma@vger.kernel.org>; Mon, 23 Dec 2019 02:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k2KG3qxeHruibpXGsVIa4Wl/ThA0sLV8fQC/MJrjy0s=;
        b=ZJDHLQVmWJg9pubaWSGVw5+bzHZEsCdrO8rLoMCYF5cD2/uIjAhCvjh/B0MzplTmY+
         gtYzoWO8Z3eIjCu0cHNk9EAVPcLtQFGo7fHT1e+KoySOm2KJKZ5VEfqOEa33YGiasb1j
         K5TZb9CnawjfJDnE9su1egPT1920OGfeqEId3x0Jm5nv+rEo5F/nVnWGqWiaH9ePM+Ju
         4Y68emC8fzscXHq4v9YeQb9wCJ87GOHzhJVFu3j5T8UAHjzNRloZBMAe66I0lcVxCu3l
         7QQMSP5YEKJsFftAR5etS/D3AjqVOxUhtuI6u3+bsyNGGIMb5CteVoNWaJibSTo13nmU
         ETzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2KG3qxeHruibpXGsVIa4Wl/ThA0sLV8fQC/MJrjy0s=;
        b=HAdoQukrNodoG7JB8iZ4oOZFyYfkcv2SfJEi5LUlIxpbh3LPZEB+XzZyXSWxwgNt9O
         j4DRq6enqT4Xd2wu1zktnxTWVV5iRXUZ4eSl6ecykYIZDinTmSrnL22n8yisRiR6rt/i
         0iHNgr0a2Ih4l6nEZXpaC9JcU5hb1Rjj8C7FquF6c+XU7W4uZqAv/hsA5ErHxm+7Tps7
         N9TZeF76DQN6K8N5ca4vCkpm2xOmzK3cS9oME+MgkMIoEPnzE6dF3Aap9YXcGEh0HM6r
         C+Ri7qBvuWKeFw5dQwjC9mBBqId4qSFBO9fqp7Vj8yNEf/RAzt1luvj1wWrPsyPbt3Ke
         kM1g==
X-Gm-Message-State: APjAAAVkIoe9xUxUm1txeomOspeduavptJWVK/neUuM2CA1D+TVNG6/p
        qJ4xdZBPblbANnGWhVq4Rw6nei3DLz5fLCJxjCVuNZg6
X-Google-Smtp-Source: APXvYqx8puoUeQ/1rOf+Mmdibf48OOGKRlBiWxu0EI9nTQSX7vkl6dvMqzS+1T4ybMe+KUcJ7VJoPM0eqZwQ/TUzLtM=
X-Received: by 2002:a92:d2:: with SMTP id 201mr25608188ila.22.1577097099298;
 Mon, 23 Dec 2019 02:31:39 -0800 (PST)
MIME-Version: 1.0
References: <20191220155109.8959-1-jinpuwang@gmail.com> <20191220155109.8959-3-jinpuwang@gmail.com>
 <20191221101530.GC13335@unreal> <CAHg0HuxC9b+E9CRKuw4qDeEfz7=rwUceG+fFGfNHK5=H2aQMGw@mail.gmail.com>
 <20191222073629.GE13335@unreal> <CAMGffEn9xcBO0661AXCfv0KDnZBX6meCaT07ZutHykSxM4aGaQ@mail.gmail.com>
 <20191223080438.GL13335@unreal>
In-Reply-To: <20191223080438.GL13335@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 23 Dec 2019 11:31:28 +0100
Message-ID: <CAMGffEk_3QYzj6MoSh_06fmvJzvv5qLKJXJ3d-m4oQRhH5ZyGg@mail.gmail.com>
Subject: Re: [PATCH v5 02/25] rtrs: public interface header to establish RDMA connections
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 23, 2019 at 9:04 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Dec 23, 2019 at 08:38:54AM +0100, Jinpu Wang wrote:
> > On Sun, Dec 22, 2019 at 8:36 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Sat, Dec 21, 2019 at 03:27:55PM +0100, Danil Kipnis wrote:
> > > > Hi Leon,
> > > >
> > > > On Sat, Dec 21, 2019 at 11:15 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > > >
> > > > > Perhaps it is normal practice to write half a company as authors,
> > > > > and I'm wrong in the following, but code authorship is determined by
> > > > > multiple tags in the commit messages.
> > > >
> > > > Different developers contributed to the driver over the last several
> > > > years. Currently they are not working any more on this code. What tags
> > > > in the commit message do you think would be appropriate to give those
> > > > people credit for their work?
> > >
> > > Signed-of-by/Co-developed-../e.t.c
> > >
> > > But honestly without looking in your company contract, I'm pretty sure
> > > that those people are not eligible for special authorship rights and
> > > credits beyond already payed by the employer.
> > >
> > Hi, Leon,
> >
> > Thanks for the suggestion, how about only remove the authors for the
> > new entry, only keep the company copyright?
> > > +/* Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
> > > + * Authors: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > + *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > > + *          Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> > > + *          Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
> > > + */
> >
> > The older entries were there, I think it's not polite to remove them.
>
> From our point of view, this is brand new code and it doesn't matter how
> many internal iterations you had prior submission. If you want to be
> polite, your company shall issue official press release and mention
> all those names there as main contributors for RTRS success.
>
> You can find a lot of examples of "Authors:" in the kernel code, but
> they one of two: code from pre-git era or copy/paste multiplied by
> cargo cult.
>
> Thanks
>
Ok, will only keep the copyright lines, and remove Authors.

Thanks
