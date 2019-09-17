Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F43BB4DC9
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2019 14:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfIQM2L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Sep 2019 08:28:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43957 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfIQM2K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Sep 2019 08:28:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id q17so2919634wrx.10
        for <linux-rdma@vger.kernel.org>; Tue, 17 Sep 2019 05:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M6NXDdLeZOMJf3cWxByu2Fry9FRYrZl4lG8kh5/SBho=;
        b=AVkaPP6Mpl4j71cXN8IpXyWDgUzST5dWUXU0NMDqQVHhyWAb5m7SG7EItPJQcZiRlh
         ZPQlRxvFAVoBk9dkeAitNVMihPK4V6rhWhIBN0/ZGAyKPk1/H/u282vCwEA5edlb1X8n
         k6qq5B0YRb0MVAMlatwPEmtwRQ2oH2sMl86msTGh1mmQydfvQLX8aAE+rO9BVwVXtorc
         auSJ60RsRWPlQkNy7n2MaOJ7bYI77WhtKyUTTwAPa9bEMUL7i/c+x399rsQyoUksXepv
         eAUXOrs/w85oltCckaEF6pt2m+GH3l57xduT+eOySRlcE/UjuWAUkKx0GPwwx3kJGI5p
         IN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M6NXDdLeZOMJf3cWxByu2Fry9FRYrZl4lG8kh5/SBho=;
        b=olKuBVSGYbUwmdXTwP15hscsovNVSaDOe1SKXW0K3jpijjoLRnV8pFPxl6JLd9CHor
         RFmoM7miprKBj3tXeM7mP+OS/RQDFIRYPkvIuHSE5mbDXG52PIDbJujQb5D+gV/M1raL
         eHwg+wnHiY8PsYmfXXQFxBeXJgTutHxJA/Wuyk3G3x1VG4CIZ1T/ktzQvZ1Wktqcz9Ls
         25FQ6s1JWJWvvkz8+G0MCClpBf5BV8Z8//jhbWdnK8TAED1TR7XKxeqGyrdoLeeTaklj
         jIRj+NEUtQ9YbwhjOUXrJS++G13QNM9+VKuTPNQDhW5u+YQAi13p/c6OJfPoGcLr5ROO
         COxw==
X-Gm-Message-State: APjAAAWgKTzP2yzk2eWeh7SkIEsWaMruh4dg2DmraDVBTX3i0uKXDdht
        3gKFKD85K8Bq2egz4Sw5vioxYVvoRJrGsMdWfMNHMg==
X-Google-Smtp-Source: APXvYqx/40G6xULaZQt9FoNPnqJkzaL4lnpeUgH+w8N1XVGQ1YZ7NmPaQfVpLZNwcd8jKY6MwNxe2RDiB9Oo5bmaMdc=
X-Received: by 2002:a5d:4744:: with SMTP id o4mr2762494wrs.95.1568723287328;
 Tue, 17 Sep 2019 05:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-16-jinpuwang@gmail.com>
 <4fbad80b-f551-131e-9a5c-a24f1fa98fea@acm.org> <CAMGffEnVFHpmDCiazHFX1jwi4=p401T9goSkes3j1AttV0t1Ng@mail.gmail.com>
 <CAMGffEmnTG4ixN1Hfy7oY93TgG3qQtF9TkpGzi=BxWm5a2i3Eg@mail.gmail.com> <a7d4b3eb-d0c7-0c9d-ce64-da37a732564a@acm.org>
In-Reply-To: <a7d4b3eb-d0c7-0c9d-ce64-da37a732564a@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 17 Sep 2019 14:27:56 +0200
Message-ID: <CAMGffE=J2-jmpTcRr14ndwHPncr9PV-NvX1mJ+M0tEne6oJD9Q@mail.gmail.com>
Subject: Re: [PATCH v4 15/25] ibnbd: private headers with IBNBD protocol
 structs and helpers
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 16, 2019 at 7:25 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 9/16/19 7:57 AM, Jinpu Wang wrote:
> >>>> +#define _IBNBD_FILEIO  0
> >>>> +#define _IBNBD_BLOCKIO 1
> >>>> +#define _IBNBD_AUTOIO  2
> >>>>
> >>>> +enum ibnbd_io_mode {
> >>>> +     IBNBD_FILEIO = _IBNBD_FILEIO,
> >>>> +     IBNBD_BLOCKIO = _IBNBD_BLOCKIO,
> >>>> +     IBNBD_AUTOIO = _IBNBD_AUTOIO,
> >>>> +};
> >>>
> >>> Since the IBNBD_* and _IBNBD_* constants have the same numerical value,
> >>> are the former constants really necessary?
>  >>
> >> Seems we can remove _IBNBD_*.
>  >
> > Sorry, checked again,  we defined _IBNBD_* constants to show the right
> > value for def_io_mode description.
> > If we remove the _IBNBD_*, then the modinfo shows:
> > def_io_mode:By default, export devices in blockio(IBNBD_BLOCKIO) or
> > fileio(IBNBD_FILEIO) mode. (default: IBNBD_BLOCKIO (blockio))
> > instead of:
> > parm:           def_io_mode:By default, export devices in blockio(1)
> > or fileio(0) mode. (default: 1 (blockio))
>
> So the user is required to enter def_io_mode as a number? Wouldn't it be
> more friendly towards users to change that parameter from a number into
> a string?
>
Ok, it's a bit more code, will change to allow user to set "blockio"
or "fileio" as string.

Thanks,
Jinpu
