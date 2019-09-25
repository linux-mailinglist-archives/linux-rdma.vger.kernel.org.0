Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE93BBE920
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 01:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbfIYXnz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 19:43:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44444 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbfIYXnz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Sep 2019 19:43:55 -0400
Received: by mail-io1-f67.google.com with SMTP id j4so1460495iog.11
        for <linux-rdma@vger.kernel.org>; Wed, 25 Sep 2019 16:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5LwYKKgnP/uu4YBnL1yf19HqgAMue4Xg7WGZ5d1Hb9I=;
        b=PT+XelCIZHeaQ2RtNP86StDh4h5He+L9wn74mb+upSfVRA5/H91AfGc1fbvMnTpcrP
         0nhQhMjjXKTmDHVJT92TPqyuhgRv+6EMXcDjErugd1tJFrrDK4ieBTSCkMzp+zHOP3Ng
         KlqglC+U1RjGBav73NJM/NllyvFvM9+8yfwxv8smfJQw6yVcdPqJbwNnWfq7VjpIDV6G
         qCwttRt+cKac1QBjSVAAJ2BL4IAVoTgUlhqKQi9dMLWb0/ygGKf9pojqR99QYz6+7CJs
         a6K4+tEbYy7KDBughz4+4/BsR8jAxqtt0/m6x0mfmN9IvmT4y6u0ya8CVvHaKoqH/eq0
         W3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5LwYKKgnP/uu4YBnL1yf19HqgAMue4Xg7WGZ5d1Hb9I=;
        b=R9h+IKb1S+nuteCQMcUK5PF1y8DqJVgAf3sSRtUSc+O6dzBSuvPwYr/66EFdu7zwT/
         WR5kTuz2mtuLfBbCXD3xDMCyJDJeMkKy+B66y2f7Wj2eOZ2ic2lomTSYRuaDYsaPZbY/
         +lwWfjj0FiPZxoKN29SxtLCdfPZjRbIZlN2Jojq17cfep6A4pVEIhY4ZGz6L1hQqMYAc
         q+4rKIxwP1N68FkFS9qXtstGkeqaAGfcJeWHpOfYEc1zIVbaiemgtaBQxaFKX+hduDFf
         tFG0bFGaGpZFmXaNCF9VPk6MOgdk9SIsUysBs06a95Ju94a8smrYo1DKbDwHnNdwRMNr
         o5JA==
X-Gm-Message-State: APjAAAUK1175XCaJGfVTp6FkJyploZRU62NVIeNfhW2jnIu6TjxXicMV
        G+o/54Bz0yTwdfDcXIh087adkMqzehLHhVKEdJFA
X-Google-Smtp-Source: APXvYqwoFQGWkG15HaZHlhkjJUX5a0RWYwR28iBiVNpHBYw9aXrjXcDkS+VJsSxht3UZMJFRSJ9slf+/zhg/fyr3a8E=
X-Received: by 2002:a02:890:: with SMTP id 138mr1018190jac.9.1569455034502;
 Wed, 25 Sep 2019 16:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-17-jinpuwang@gmail.com>
 <7d11d903-7826-8c1a-bef8-74ea4cf5f340@acm.org> <CAMGffEmZdqJ2Nw1KX=DirMp4e89i-G4ut24qNSVYRy0eG=v8sg@mail.gmail.com>
In-Reply-To: <CAMGffEmZdqJ2Nw1KX=DirMp4e89i-G4ut24qNSVYRy0eG=v8sg@mail.gmail.com>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Thu, 26 Sep 2019 01:43:43 +0200
Message-ID: <CAHg0Huyuf_rVCb3gugYWu1jaFT4gyrex+SpC1vsuUtWRk-UOFQ@mail.gmail.com>
Subject: Re: [PATCH v4 16/25] ibnbd: client: private header with client
 structs and functions
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 17, 2019 at 6:36 PM Jinpu Wang <jinpu.wang@cloud.ionos.com> wrote:
>
> On Sat, Sep 14, 2019 at 12:25 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On 6/20/19 8:03 AM, Jack Wang wrote:
> > > +     char                    pathname[NAME_MAX];
> > [ ... ]
> >  > +    char                    blk_symlink_name[NAME_MAX];
> >
> > Please allocate path names dynamically instead of hard-coding the upper
> > length for a path.
Those strings are used to name directories and files under sysfs,
which I think makes NAME_MAX a natural limitation for them. Client and
server only exchange those strings on connection establishment, not in
the IO path. We do not really need to safe 256K on a server with 1000
devices mapped in parallel. A patch to allocate those strings makes
the code longer, introduces new error paths and in my opinion doesn't
bring any benefits.
