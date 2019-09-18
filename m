Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 787CFB67B2
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2019 18:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfIRQFv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Sep 2019 12:05:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40201 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfIRQFv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Sep 2019 12:05:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id b24so674989wmj.5
        for <linux-rdma@vger.kernel.org>; Wed, 18 Sep 2019 09:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Af9Cdulw4q7srqZuhUQyn+hRAqzd94sDxeWyEO6s9c=;
        b=AJpEVX6leYrrW7IsKErz5RLmIxuGxxP8mwsBrP+jy+BTGbq9BzxlimqWvPNptBhNq9
         IZ6pnWFDfYR0U0zO33GKUh17x3l9ym4RAQHFbUsCRGkCNGZh/m9aSzDRmBzSCIS37dH+
         t36fVC+xAxPvUKypvowCEUyIc158xGNq5/e35H4qASO3pJocJvvdd6oesObnTygiU6bq
         9NxK/IPHRnJa8iJ8VmaTo3V3iytue79Bw8kin8GL5rtdr3aidSeFqdL4qhCgySY+O8zR
         HXY2PI3AYTAfkKjlAszEvq4TwOvXxgrgTB3I6QZv/IeUoFKOZmzrvIFZpfgbPymvFldG
         VFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Af9Cdulw4q7srqZuhUQyn+hRAqzd94sDxeWyEO6s9c=;
        b=aAz6buV3dEz+L3MNGsNaFLeflM48qhePAcZHtDkEdJNmIUj7u6B2J5jKTUY1U42lnY
         jMrPBjmYJXQr7a3izv8UXDgVofAN8M0xCB2Bw4lSSN4OvqR/VPGZVVBP0emWcK52bA1P
         c1MVdidiwDv11LTFoxvaqEPJJIHv7rlu3BdtwRnRMOU73ri/grc8YcJ7Z7XWXfIZNN3m
         PSetuEhpcfmTsLfGw6xzUfu66S1rLU+dJ5NlHtoSgfI7gW8JKx52xIA625m4+FsWzIpY
         d22Oma/7jYjDR2uL8jhN2o6mkZuSCnXeAjGPovwRWevs4RasGLCNL0ffxCIpf8U+cf3A
         izKQ==
X-Gm-Message-State: APjAAAWZsnzZdY8rKAC3JnTCKNIqYE8wrqUhcWm1Q29V4dWs+fXOtquy
        tP6NPmI5hb0c7dLq4PJn/g9HvwsxuFepYibCCiv6/Q==
X-Google-Smtp-Source: APXvYqzS8d0FXM09U5a5BaQzms9ev4/1tLwd/tqmLh3O2bt4X/pOwkXpPuasVXAiPT6H2TbwMOWMLKOfk3ggYMvJpfU=
X-Received: by 2002:a1c:4384:: with SMTP id q126mr3879637wma.153.1568822749203;
 Wed, 18 Sep 2019 09:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-18-jinpuwang@gmail.com>
 <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org>
In-Reply-To: <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 18 Sep 2019 18:05:38 +0200
Message-ID: <CAMGffEm-HUWJ4hPc4kqX5-f7Y4CPKWnRswKVMTZgLqBfPy+WjQ@mail.gmail.com>
Subject: Re: [PATCH v4 17/25] ibnbd: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > +static void destroy_gen_disk(struct ibnbd_clt_dev *dev)
> > +{
> > +     del_gendisk(dev->gd);
>
> > +     /*
> > +      * Before marking queue as dying (blk_cleanup_queue() does that)
> > +      * we have to be sure that everything in-flight has gone.
> > +      * Blink with freeze/unfreeze.
> > +      */
> > +     blk_mq_freeze_queue(dev->queue);
> > +     blk_mq_unfreeze_queue(dev->queue);
>
> Please remove the above seven lines. blk_cleanup_queue() calls
> blk_set_queue_dying() and the second call in blk_set_queue_dying() is
> blk_freeze_queue_start().
>
It was an old bug we had in 2016, we retested with newer kernel like
4.14+, the bug is fixed,
I will remove the above seven lines.

Thanks
Jinpu
