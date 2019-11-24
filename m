Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5768F108304
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Nov 2019 12:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfKXLAg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Nov 2019 06:00:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56124 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726090AbfKXLAg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 24 Nov 2019 06:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574593234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1KXhsg+a1KjUX11ht7XLI08v5r74uXuYj8COBG7LPM4=;
        b=Y32iW4tp9LBYfvdWpPSWLVUfCAVEJcBW26gzbn3iXoWrUo9N6NuTv6GGKR8tTjcdJnNNUI
        cqMp/Db57S0zAnqtc2hUS66DX1V9XUxREq3ZMjSK0rogZgfV3tPAZchRm5iJb2G1k0IGyR
        buyFVaExhDtTu3QwTVvZbeRuiVTIgWM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-offCb6uXNASKEN6YLYIVbg-1; Sun, 24 Nov 2019 06:00:31 -0500
Received: by mail-qt1-f197.google.com with SMTP id v92so8173303qtd.18
        for <linux-rdma@vger.kernel.org>; Sun, 24 Nov 2019 03:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0fpSEO2RRD2QaPeNSiFSwgUcyKpHEGr4rGYpZ1TQU8Q=;
        b=WB64lIZ+BgxOHnLmKxnvkLbv0rMvfqs62fIbSq7W1VjO6dDPagzc2soJuK/puMZhJb
         Vhp4RQkaDwLU2S10UpS672P4C4faUA7qh/EeAGkTg/KGvHX3TMVd/II2X9ZIMVaHdGqS
         zpCISa5VlvIFN+b5j8s1Y48/mjAysvCO+yAfPzZdLriwPakQcCoapy/j5+ajRQaYifHe
         Z0g0w5tfHb9FDvTaQfQ5s/9Pghsmut5/Yn6VkQZcd2ie99hbREJnCjb0Q0CqKwKvWOvv
         hed83PBiugJsC0gGOhny4kaeYBwOE4q109utO4cRFK8ui47TJkPMkOWUQkDQ57CQ7tAX
         h0Zg==
X-Gm-Message-State: APjAAAV9iFb87zghZ+mSdWouED3z4HNL/6m8BlaYw+EPuK50+Tl81TrP
        voSZrfVHX/crbVakifDcP8fIgin1BCmDN2Or06jdFzu9XOIiFQ0Sh9Ohbj9IE/fa5btj0s+hRt0
        HfMWcWrjo1y08e46nzzwxQA==
X-Received: by 2002:aed:2706:: with SMTP id n6mr6931485qtd.224.1574593230967;
        Sun, 24 Nov 2019 03:00:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqybYQ+vHAMF1k+WWrJoHiMbEVYdPp4I1ebcXb9vBUxJeIk0O9YkuFJsowcY8HNYb0x/TxIk2Q==
X-Received: by 2002:aed:2706:: with SMTP id n6mr6931468qtd.224.1574593230796;
        Sun, 24 Nov 2019 03:00:30 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id m186sm1685825qkc.39.2019.11.24.03.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 03:00:29 -0800 (PST)
Date:   Sun, 24 Nov 2019 06:00:23 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Tiwei Bie <tiwei.bie@intel.com>, Jason Wang <jasowang@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Dave Ertman <david.m.ertman@intel.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, nhorman@redhat.com,
        sassmann@redhat.com, Kiran Patil <kiran.patil@intel.com>
Subject: Re: [net-next v2 1/1] virtual-bus: Implementation of Virtual Bus
Message-ID: <20191124055343-mutt-send-email-mst@kernel.org>
References: <20191120102856.7e01e2e2@x1.home>
 <20191120181108.GJ22515@ziepe.ca>
 <20191120150732.2fffa141@x1.home>
 <20191121030357.GB16914@ziepe.ca>
 <5dcef4ab-feb5-d116-b2a9-50608784a054@redhat.com>
 <20191121141732.GB7448@ziepe.ca>
 <721e49c2-a2e1-853f-298b-9601c32fcf9e@redhat.com>
 <20191122180214.GD7448@ziepe.ca>
 <20191123043951.GA364267@___>
 <20191123230948.GF7448@ziepe.ca>
MIME-Version: 1.0
In-Reply-To: <20191123230948.GF7448@ziepe.ca>
X-MC-Unique: offCb6uXNASKEN6YLYIVbg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Nov 23, 2019 at 07:09:48PM -0400, Jason Gunthorpe wrote:
> > > > > Further, I do not think it is wise to design the userspace ABI ar=
ound
> > > > > a simplistict implementation that can't do BAR assignment,
> > > >=20
> > > > Again, the vhost-mdev follow the VFIO ABI, no new ABI is invented, =
and
> > > > mmap() was kept their for mapping device regions.
> > >=20
> > > The patches have a new file in include/uapi.
> >=20
> > I guess you didn't look at the code. Just to clarify, there is no
> > new file introduced in include/uapi. Only small vhost extensions to
> > the existing vhost uapi are involved in vhost-mdev.
>=20
> You know, I review alot of patches every week, and sometimes I make
> mistakes, but not this time. From the ICF cover letter:
>=20
> https://lkml.org/lkml/2019/11/7/62
>=20
>  drivers/vfio/mdev/mdev_core.c    |  21 ++
>  drivers/vhost/Kconfig            |  12 +
>  drivers/vhost/Makefile           |   3 +
>  drivers/vhost/mdev.c             | 556 +++++++++++++++++++++++++++++++
>  include/linux/mdev.h             |   5 +
>  include/uapi/linux/vhost.h       |  21 ++
>  include/uapi/linux/vhost_types.h |   8 +
>       ^^^^^^^^^^^^^^
>=20
> Perhaps you thought I ment ICF was adding uapi? My remarks cover all
> three of the series involved here.

Tiwei seems to be right - include/uapi/linux/vhost.h and
include/uapi/linux/vhost_types.h are both existing files.  vhost uapi
extensions included here are very modest. They
just add virtio spec things that vhost was missing.

Are you looking at a very old linux tree maybe?
vhost_types.h appeared around 4.20.

--=20
MST

