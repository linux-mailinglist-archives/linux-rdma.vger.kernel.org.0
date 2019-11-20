Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8589103C66
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2019 14:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbfKTNne (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 08:43:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36011 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731316AbfKTNnd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Nov 2019 08:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574257412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BwFx+Dwq/n/prb7owY95fMpf8ebLIV+MGGzw0ANGQiU=;
        b=Tey/YfQK6Kr9DVQmT4sGWZ1+90xKm7lCBtzUGn7eA+dD8BlWqqqq1IZFZ/PuKbrnP1ODqd
        YEs19fIRG3bKRQIbzbRKTuy2aQOdSUJOCzcOQ2Gt5xbUuks/YPweRTclFroM6JtXv1WnsD
        XyH77XwUVhMpJlCou8G9uX94DBHOgy0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-ts337BQQNuOGPds2mbeOXQ-1; Wed, 20 Nov 2019 08:43:29 -0500
Received: by mail-qt1-f200.google.com with SMTP id j18so17084889qtp.15
        for <linux-rdma@vger.kernel.org>; Wed, 20 Nov 2019 05:43:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=feQZhc67FFi+Ko9ak2oh56vIMRGjrYkPDdCN0lvuJuU=;
        b=JQ5IG4mIDJtJ4kCaavq/IP4vQaq/2PmMh57Lsuh1tZSKUxnnuTo4doWjjpGiNXfvzc
         dqka2GzkNGooOOPN+isN8EyqIYXptRGUlsNYk737uT14NwirbuhTV8EUcw+kASjhKppP
         kwtxWU3OEAkDKk6vefCgNNJIEHnGoQkh63gY/FnJfTI7f6IvH7PXNO8R461i3WYDZyX3
         R29gk4RrO4XZKcRIH7RTDjo61Kejd7UmuSiBhDuBnuHhDqBJTkd0I/5xYnn+MxSl9Nb7
         xU414ZyWZ66vPGWKwLaP+A8J59qHg7GcHj2HJXBch84LGUhSu/d7JtCqzZ05jkau7aMk
         elmw==
X-Gm-Message-State: APjAAAUkTfNvKB53alJQEjiIQWAh2rQo+s0hkG3jQCuBwmVgxN5u2DLS
        TgaQhdoMgSmNyL4ZyilqJsHcLePwtCtpN0C7i84XOQ8CsYwVyCU+cXvJCtBvUabeRxpRnmv8yVU
        YS7kUXaY7NveV0DGIws7dhg==
X-Received: by 2002:a37:7305:: with SMTP id o5mr2487943qkc.120.1574257408650;
        Wed, 20 Nov 2019 05:43:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqwMu4Xq4O5OheMkoMoD/p5gJRYFOHibk5C4maRW+a4TNNJe/+fxGATAgpD0kJGaqTTVXuEFhA==
X-Received: by 2002:a37:7305:: with SMTP id o5mr2487922qkc.120.1574257408397;
        Wed, 20 Nov 2019 05:43:28 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id h3sm15059129qte.62.2019.11.20.05.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 05:43:27 -0800 (PST)
Date:   Wed, 20 Nov 2019 08:43:20 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Dave Ertman <david.m.ertman@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "sassmann@redhat.com" <sassmann@redhat.com>,
        Kiran Patil <kiran.patil@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>
Subject: Re: [net-next v2 1/1] virtual-bus: Implementation of Virtual Bus
Message-ID: <20191120083908-mutt-send-email-mst@kernel.org>
References: <ead356f5-db81-cb01-0d74-b9e34965a20f@redhat.com>
 <20191119164632.GA4991@ziepe.ca>
 <20191119134822-mutt-send-email-mst@kernel.org>
 <20191119191547.GL4991@ziepe.ca>
 <20191119163147-mutt-send-email-mst@kernel.org>
 <20191119231023.GN4991@ziepe.ca>
 <20191119191053-mutt-send-email-mst@kernel.org>
 <20191120014653.GR4991@ziepe.ca>
 <20191120022141-mutt-send-email-mst@kernel.org>
 <20191120130319.GA22515@ziepe.ca>
MIME-Version: 1.0
In-Reply-To: <20191120130319.GA22515@ziepe.ca>
X-MC-Unique: ts337BQQNuOGPds2mbeOXQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 20, 2019 at 09:03:19AM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 20, 2019 at 02:38:08AM -0500, Michael S. Tsirkin wrote:
> > > > I don't think that extends as far as actively encouraging userspace
> > > > drivers poking at hardware in a vendor specific way. =20
> > >=20
> > > Yes, it does, if you can implement your user space requirements using
> > > vfio then why do you need a kernel driver?
> >=20
> > People's requirements differ. You are happy with just pass through a VF
> > you can already use it. Case closed. There are enough people who have
> > a fixed userspace that people have built virtio accelerators,
> > now there's value in supporting that, and a vendor specific
> > userspace blob is not supporting that requirement.
>=20
> I have no idea what you are trying to explain here. I'm not advocating
> for vfio pass through.

You seem to come from an RDMA background, used to userspace linking to
vendor libraries to do basic things like push bits out on the network,
because users live on the performance edge and rebuild their
userspace often anyway.

Lots of people are not like that, they would rather have the
vendor-specific driver live in the kernel, with userspace being
portable, thank you very much.

--=20
MST

