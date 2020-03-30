Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65D2C197958
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2020 12:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgC3KeM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Mar 2020 06:34:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40601 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgC3KeM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Mar 2020 06:34:12 -0400
Received: by mail-io1-f66.google.com with SMTP id k9so17191079iov.7
        for <linux-rdma@vger.kernel.org>; Mon, 30 Mar 2020 03:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwCeWXDbgjIElFYKkes5rERYm3Ob27L2LcltFTTWKsg=;
        b=PstBHiegsEuxaw2j41eBZo8SATeeuO7UCSjT0IvFYEqUB7byCqpO/kJ2/SMtHBuZ2I
         Za4IrRXLHULx02TKTkPBLEg9QD3Ocf4sLpAEF717YEMugJPxi39ZXtiGrk7iRDWvE4EX
         c6jJ8IX+LR2yl3uoqbv6GrCw7rKqM5q1QWKwy0WQHkUcYoHC6+C1dcQtyakmIuLY4qlT
         h7qmA874tp6dnarBBwQH2L9Itb9EsobufbcbDl8WtlAIfqP8GH+CpW/HmknsBNB9Pj19
         udZdx5GXyvb5VOscVcG/Dj7NgDgeKhXrobJqqz4IymglQ7KyIPBPg6c3z7+l3dI4gxaF
         VMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwCeWXDbgjIElFYKkes5rERYm3Ob27L2LcltFTTWKsg=;
        b=ZhQTc6shEw5HBXObz1GKJ5iMfTrJ4B/z5dKRcPo0nLmkZcdG24fMoL+qFrYStpmt9Z
         1fWR1+CBKyg6G2hvOqnQ984AGPJaU358g4sxD2uPKXq/w3M7MaJMmXajCjxSaPR/1Bso
         wJxaGcSZgGpPVA6GeoD+7yOh2ggngLI/qFudkyv8sfPddxS35dvxO6mVDh0NxM/P5YgY
         KpNHsvw/MBaqObxqjPl/wuUG/3RhHjvYPl7/32ym03SMWo6yISv4mcZXLn1OCNYOlLUX
         zGVyWfFajmwr23hBLz/NFj2Skp1vfngbv6RyBTjAnJEMwMKVAKoiqRvGnkbIcy56BBNh
         NUWQ==
X-Gm-Message-State: ANhLgQ3/hnw6DAbmn5od3jv8XNYgZ6qMrJwZZbf2bOGOaJ1vM/gDdQ0H
        R9hsDJQ8IySVeuikohJ3bie4B65L8pxf18eFUpSbNw==
X-Google-Smtp-Source: ADFU+vsy/7bUVBc0RlfuMVsJIIKjh4tu97nMt7BGY4fillqwMNeu3vq+BCNf/Re5WCqCsytkI8p+QZ98MzSLA/snKcw=
X-Received: by 2002:a02:7a18:: with SMTP id a24mr10197357jac.54.1585564450908;
 Mon, 30 Mar 2020 03:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-5-jinpu.wang@cloud.ionos.com> <cad654ae-d6c9-882d-aeeb-d6871994d280@acm.org>
In-Reply-To: <cad654ae-d6c9-882d-aeeb-d6871994d280@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 30 Mar 2020 12:34:00 +0200
Message-ID: <CAMGffE=oU=auw9Re3JcpBx2cap=6i4P0R__bcO4NnN+yW76b8w@mail.gmail.com>
Subject: Re: [PATCH v11 04/26] RDMA/rtrs: core: lib functions shared between
 client and server modules
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 28, 2020 at 5:26 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
> > +/**
> > + * rtrs_str_to_sockaddr() - Convert rtrs address string to sockaddr
> > + * @addr:    String representation of an addr (IPv4, IPv6 or IB GID):
> > + *              - "ip:192.168.1.1"
> > + *              - "ip:fe80::200:5aee:feaa:20a2"
> > + *              - "gid:fe80::200:5aee:feaa:20a2"
> > + * @len:        String address length
> > + * @port:    Destination port
> > + * @dst:     Destination sockaddr structure
> > + *
> > + * Returns 0 if conversion successful. Non-zero on error.
> > + */
> > +static int rtrs_str_to_sockaddr(const char *addr, size_t len,
> > +                              short port, struct sockaddr_storage *dst)
> > +{
> > +     if (strncmp(addr, "gid:", 4) == 0) {
> > +             return rtrs_str_gid_to_sockaddr(addr + 4, len - 4, port, dst);
> > +     } else if (strncmp(addr, "ip:", 3) == 0) {
> > +             char port_str[8];
> > +             char *cpy;
> > +             int err;
> > +
> > +             snprintf(port_str, sizeof(port_str), "%u", port);
> > +             cpy = kstrndup(addr + 3, len - 3, GFP_KERNEL);
> > +             err = cpy ? inet_pton_with_scope(&init_net, AF_UNSPEC,
> > +                                              cpy, port_str, dst) : -ENOMEM;
> > +             kfree(cpy);
> > +
> > +             return err;
> > +     }
> > +     return -EPROTONOSUPPORT;
> > +}
>
> Please use 'u16' or 'uint16_t' for port numbers instead of 'short'.
ok, will use u16.
>
> > +/**
> > + * rtrs_addr_to_sockaddr() - convert path string "src,dst" to sockaddreses
> > + * @str:     string containing source and destination addr of a path
> > + *           separated by comma. I.e. "ip:1.1.1.1,ip:1.1.1.2". If str
> > + *           contains only one address it's considered to be destination.
> > + * @len:     string length
> > + * @port:    will be set to port.
>                 ^^^^^^^^^^^^^^^^^^^
> What does this mean? Please make comments easy to comprehend.
how about just "port number"?
>
> > + * @addr:    will be set to the source/destination address or to NULL
> > + *           if str doesn't contain any sorce address.
>                                            ^^^^^
> Is this perhaps a typo?
yes, should be "source".
>
> > + *
> > + * Returns zero if conversion successful. Non-zero otherwise.
> > + */
> > +int rtrs_addr_to_sockaddr(const char *str, size_t len, short port,
>                                                           ^^^^^
> I think most kernel code uses type u16 for port numbers.
ok.
>
> > +                        struct rtrs_addr *addr)
> > +{
> > +     const char *d;
> > +
> > +     d = strchr(str, ',');
> > +     if (!d)
> > +             d = strchr(str, '@');
> > +     if (d) {
> > +             if (rtrs_str_to_sockaddr(str, d - str, 0, addr->src))
>                                                       ^^^
> Does this mean that the @port argument only applies to the destination
> address? If so, please mention this in the comment above this function.
Yes, will update the comments.

>
> > +                     return -EINVAL;
> > +             d += 1;
> > +             len -= d - str;
> > +             str  = d;
> > +
> > +     } else {
> > +             addr->src = NULL;
> > +     }
> > +     return rtrs_str_to_sockaddr(str, len, port, addr->dst);
> > +}
> > +EXPORT_SYMBOL(rtrs_addr_to_sockaddr);
>
> So this function either accepts ',' or '@' as separator between source
> and destination address?  Shouldn't that be mentioned in the comment
> block above the function?
Yes, will update the comment.
>
> Thanks,
>
> Bart.

Thanks Bart!
