Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E07675FF6C
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2019 04:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfGECM4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jul 2019 22:12:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40804 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfGECM4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jul 2019 22:12:56 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so7845520iom.7
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jul 2019 19:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+i+rWpWM4CxLTsXoxrblls6Y6nuSgSt1B6piLDXksQM=;
        b=OvqyFOeFRZh3yx2Qm/toca2DHR0OoQhUXTaQYkw0QnttoqQqP84i0m0gGRe5XhI9pR
         lGntF5NZpCAcOhqEmTVgdMlMh18W4Vcsg4icpPGB2csRo/yaa7jC0gKRUafmEdyxKM+T
         +pHEt6fHyWxKhAJTNCCSD/oXH4qwthbWbrnsy/wz1BqEhPvUT2aDpGQPQTV4BLndQBD+
         d6lyM4iIQ9n9IcUfg313tqhfIwczwVLP4iMU1bc3brWMTf6MI12dq5WBrgYc4gY1s+x4
         t+sVhRVi1BwZGijF+awKTXhBQKs55tPHNQ4Y1OC/0b5/13fVMzJ6X6uXVGSAJdyRTcow
         vXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+i+rWpWM4CxLTsXoxrblls6Y6nuSgSt1B6piLDXksQM=;
        b=Mmf2iNM+ysTe9y4MNrO4Ua/lMM3HUvvJTwwJB4xhNQfPuTII9BtxuU4T78Fof2Ted4
         MnS7hM6ZSnv6R3ODWaw9U4Lb8YfjfUUgTfc7Fz1dWlT9BEnGxlKdaAX7vn1c3Y3udW4W
         WI14XIeiA0T/+nxErFOQwBWHZ5U74s1XniWRjrKyLxOHwEQXXgDl98tvKdhIW5d+IKkv
         goidoJgrMN80l0TSjX7AI6vN+kaqFupkz65ZDdqIDlhQhyX5BsCr6anQdSMXxH0ePVj9
         NUXAuOt+YC79MUhdWnHuYYwP2ZxenXTUyNFNPHWdiXFrpip0JHx3e8AQ6xAbTvn8J4Wu
         FalQ==
X-Gm-Message-State: APjAAAUsRH/wkgpdmLuOchDw1jH+hhEAbjFk8FVu/+/lEqISJ1sHP2OV
        VPaKbyAu9H/eLQg7/j3zU9OYJ8B0ntilgc17laluCVA7
X-Google-Smtp-Source: APXvYqwxpez2ygitEY+qTIoTFJe6v/Ma8PdGk2xC7R1VCIlwhG/AufnrA5UnLrM+sJTCBHcIt6o200zZXnBfbRgfYQU=
X-Received: by 2002:a5d:8049:: with SMTP id b9mr1431472ior.199.1562292775077;
 Thu, 04 Jul 2019 19:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190704130402.8431-1-leon@kernel.org> <20190704173403.GA20921@ziepe.ca>
In-Reply-To: <20190704173403.GA20921@ziepe.ca>
From:   Parav Pandit <pandit.parav@gmail.com>
Date:   Fri, 5 Jul 2019 07:42:44 +0530
Message-ID: <CAG53R5UjQzJs+sCPt2BS2iii1NUWELxRStN0xGF1rQNKh7DiPw@mail.gmail.com>
Subject: Re: [PATCH rdma-next 0/2] Allow netlink commands in non init_net net namespace
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 4, 2019 at 11:46 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Jul 04, 2019 at 04:04:00PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Now that RDMA devices can be attached to specific net namespace,
> > allow netlink commands in non init_net namespace.
> >
> > Parav Pandit (2):
> >   IB/core: Work on the caller socket net namespace in nldev_newlink()
> >   IB: Support netlink commands in non init_net net namespaces
>
> Could someone please confirm that all the new libibverbs stuff works
> properly in a container after this series?
>
Hi Jason,

I tested rping using rdma-core from [1] where I had to skip siw
compilation due to a compile error.
I used kernel from [2].

[1] https://github.com/jgunthorpe/rdma-plumbing.git branch netlink
[2] https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=rdma-next

Test were done in non init_net net namespace.
It looks good.
A sample kernel frace to double confirm below.

Due to our internal net-next-mlx5 behind of nldev patches, I couldn't
test mdev devices yet with this series.

19)               |  rdma_nl_rcv [ib_core]() {
19)               |    rdma_nl_rcv_msg [ib_core]() {
19)               |      nldev_get_chardev [ib_core]() {
19)   2.220 us    |        ib_device_get_by_index [ib_core]();
19)               |        ib_get_client_nl_info [ib_core]() {
19)               |          __ib_get_client_nl_info [ib_core]() {
19)   1.697 us    |            xan_find_marked.constprop.26 [ib_core]();
19)   1.024 us    |            xan_find_marked.constprop.26 [ib_core]();
19)   1.023 us    |            xan_find_marked.constprop.26 [ib_core]();
19)   1.153 us    |            xan_find_marked.constprop.26 [ib_core]();
19)   0.574 us    |            ib_uverbs_get_nl_info [ib_uverbs]();
19) + 12.507 us   |          }
19) + 13.533 us   |        }
19)   0.380 us    |        ib_device_put [ib_core]();
19)   4.600 us    |        rdma_nl_unicast [ib_core]();
19) + 26.533 us   |      }
19) + 27.457 us   |    }

Some issue with my outlook email. So replying from gmail..
Thanks.
