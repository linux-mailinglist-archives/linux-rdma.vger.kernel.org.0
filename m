Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E8C1A882
	for <lists+linux-rdma@lfdr.de>; Sat, 11 May 2019 18:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfEKQw1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 11 May 2019 12:52:27 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38538 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfEKQw0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 11 May 2019 12:52:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id y19so6228323lfy.5
        for <linux-rdma@vger.kernel.org>; Sat, 11 May 2019 09:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=8wz43C7jxGCUsHy9MfWjXgalwSWO3z1P/EsbM3jZ0KM=;
        b=GDi3fsBTBmf9X/8Hz0x1TQFBY0bhDBOVG947LRV8qCxSuuclixM+RZ23aQRJsD+7QL
         FFoQee+EIXhKJpQVIge77dug+vh6aZEAXj7EobIugSWNrnrQ+lfqlnR8Q37ZkFcIA5GB
         v7yQJ7MNZn/9ofUQykM+64Arse7i9M0xZTWTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=8wz43C7jxGCUsHy9MfWjXgalwSWO3z1P/EsbM3jZ0KM=;
        b=n8lSQy538TPwsE219y8Nv2Ustxx6FxZ9V4ZYeLEbAzlSJCC6tOlK232vq2m4u4EXoi
         W7FCtYU58mP+UM8XPDjAPPnGneMwLULxK/jihAcBwFeK7mr214LSsYJMFzA9KIwc6HB9
         eKYy7faH86EYGelpThieg+Mkwa/Ivw6fTlTMwddRurk9HPYHlL29WnBj9/59vHPsPjBZ
         aC5aFkyCEggfbvqnmPRR2F+iGuftJd0lD9noFn50jrfqhaJmdmZ1MEL8MA9vX6XCPGgI
         CHHRW0nVtlEIVxo0X+zfgD19MWUw3g8wxvrGvoXX2+oB/iWUhKkw7EJk5dLrFJi2YMPC
         VmEA==
X-Gm-Message-State: APjAAAXp9pjM8cm0bNrJefAY2peJsvtvdFIXBcIbxCXw1KAWYKXON7M8
        qbrX/qa1DDeqbzZOSuqOSPDha7VEFno=
X-Google-Smtp-Source: APXvYqxh5PIM5zuvgwWRfC8P0JZcutftU/3UE3jPD6i2+37T6bW4TCC3mBGXYPqZDo7x5aQUWkjtRw==
X-Received: by 2002:ac2:54b7:: with SMTP id w23mr9377342lfk.139.1557593544444;
        Sat, 11 May 2019 09:52:24 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id o21sm2157132ljj.19.2019.05.11.09.52.23
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 09:52:23 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id f1so6232434lfl.6
        for <linux-rdma@vger.kernel.org>; Sat, 11 May 2019 09:52:23 -0700 (PDT)
X-Received: by 2002:a19:5015:: with SMTP id e21mr9229137lfb.62.1557593542751;
 Sat, 11 May 2019 09:52:22 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 May 2019 12:52:06 -0400
X-Gmail-Original-Message-ID: <CAHk-=whbuwm5FbkPSfftZ3oHMWw43ZNFXqvW1b6KFMEj5wBipA@mail.gmail.com>
Message-ID: <CAHk-=whbuwm5FbkPSfftZ3oHMWw43ZNFXqvW1b6KFMEj5wBipA@mail.gmail.com>
Subject: Annoying gcc / rdma / networking warnings
To:     Jason Gunthorpe <jgg@mellanox.com>,
        David Miller <davem@davemloft.net>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jason and Davem,
 with gcc-9, I'm now seeing a number of annoying warnings from the
rdma layer. I think it depends on the exact gcc version, because I'm
seeing them on my laptop but didn't see them on my desktop, probably
due to updating at different times.

The warning is because gcc now looks at pointer types for some
allocation sizes, and will do things like this:

In function =E2=80=98memset=E2=80=99,
    inlined from =E2=80=98rdma_gid2ip=E2=80=99 at ./include/rdma/ib_addr.h:=
168:3,
    inlined from =E2=80=98roce_resolve_route_from_path=E2=80=99 at
drivers/infiniband/core/addr.c:735:2:
./include/linux/string.h:344:9: warning: =E2=80=98__builtin_memset=E2=80=99=
 offset
[17, 28] from the object at =E2=80=98dgid=E2=80=99 is out of the bounds of =
referenced
subobject =E2=80=98_sockaddr=E2=80=99 with type =E2=80=98struct sockaddr=E2=
=80=99 at offset 0
[-Warray-bounds]
  344 |  return __builtin_memset(p, c, size);

because the "memset()" is done onto a "sockaddr_in6" (where it's not
out of bounds), but the rdma_gid2ip() function was passed a "sockaddr"
type (where it *is* out of bounds.

All the cases I found actually have good *allocations* for the
underlying storage, using a union of the different sockaddr types, and
includes a "sockaddr_in6". So the warning actually looks bogus from an
actual allocation standpoint, but at the same time, I think the
warning does show a real issue in the networking code.

In particular, a "struct sockaddr" is supposed to be a valid superset
of the different sockaddr types, and the rdma use is in that sense the
rdma use of "struct sockaddr *" is entirely sane.

BUT.

The Linux kernel sockaddr is actually just 16 bytes. While a
sockaddr_int is about twice that.

So if you look at the types like gcc does, then the rdma layer really
is passing a pointer to a 16-byte sockaddr, and then filling it with
(much bigger) sockaddr_ip6 data.

Arguably gcc is being stupid, and it should look at the actual
allocation, but that's not what it does. And I do think what gcc does
is at least understandable.

So David, arguably the kernel "struct sockaddr" is simply wrong, if it
can't contain a "struct sockaddr_in6". No? Is extending it a huge
problem for other users that don't need it (mainly stack, I assume..)?

Also equally arguably, the rdma code could just use a "struct
sockaddr_in6 for this use and avoid the gcc issue, couldn't it? It has
the type right there, and rdma_gid2ip() could just take that type
instead, since that's what it actually then uses anyway.

Comments?

               Linus
