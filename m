Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D2532322F
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Feb 2021 21:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhBWUhV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Feb 2021 15:37:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234404AbhBWUhT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Feb 2021 15:37:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F1A564EC3;
        Tue, 23 Feb 2021 20:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614112599;
        bh=yEGgFL8k53m3R7IpaGtWjZIWePAa7cqEb/2P0j1Tt5E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YJ4c8V9Gpnr2S8WYr2Dwqtz/+cXWXraXKQEe7Aa1KUf39IvEjwRAJz1RLt8SgFWGk
         qHVjhc2Iy+lt38JM+xJwa8YOFzw5PU1hNViIKvCA5BCcoh0tJDFaElTZwJlblCU9VK
         MdJQm0e8SdAeUzCFckTd3ku26rAfsyKspSEJ8vYy/2hpWve7//SbYqSN+kTLZKiNwU
         /NYw2MpJTJe4ikTyh8IVTeTLxq5gRMabZ72Wj74NteiovaMLAxLt5fNevQvfrMj5pl
         6wCTyZmOUdWCY/gbHm54kltnAz7XqzQ95f90Sli44VKgs4terBDIjY18Xe4FwbVhCZ
         /hm4iHAmQJmlg==
Received: by mail-ot1-f50.google.com with SMTP id b16so17017317otq.1;
        Tue, 23 Feb 2021 12:36:39 -0800 (PST)
X-Gm-Message-State: AOAM533UNupuRSngbyFXSQ3d3soyKcysh+aPHMeV1Z5o7ztALJm2N5/j
        h8ya4ZEPc3KvUb/teuv9zXdTjQfrLwNtoC6SgVU=
X-Google-Smtp-Source: ABdhPJx0sJznCDv7/Q3w4b6Nk0WxhuBRjtsLccpGUMiYKEab/XOHD4gCPKH0UgXEZrAyrQGCrWHK0w1UX3mbjNEVkoA=
X-Received: by 2002:a9d:6b8b:: with SMTP id b11mr2790661otq.210.1614112598462;
 Tue, 23 Feb 2021 12:36:38 -0800 (PST)
MIME-Version: 1.0
References: <21525878.NYvzQUHefP@ubuntu-mate-laptop> <YDICM3SwwGZfE+Sg@unreal>
 <CAD=hENeCXGtKrXxLof=DEZjxpKyYBFS80pAX20nnJBuP_s-GBA@mail.gmail.com>
 <YDOq060TvAwLgknl@unreal> <20210222155845.GI2643399@ziepe.ca>
 <e1e3bec7-0350-4bdd-50c3-41b21388fc71@infradead.org> <20210222164645.GK2643399@ziepe.ca>
 <850d8bf2-c5a0-9fee-f95f-2dfc7d22a528@infradead.org>
In-Reply-To: <850d8bf2-c5a0-9fee-f95f-2dfc7d22a528@infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 23 Feb 2021 21:36:22 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3z0_TNWP7TAVcZC8+MDJKhAZMbQoEH8tgfLQy2MJmG0Q@mail.gmail.com>
Message-ID: <CAK8P3a3z0_TNWP7TAVcZC8+MDJKhAZMbQoEH8tgfLQy2MJmG0Q@mail.gmail.com>
Subject: Re: [PATCH] drivers: infiniband: sw: rxe: fix kconfig dependency on CRYPTO
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Julian Braha <julianbraha@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 22, 2021 at 5:53 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 2/22/21 8:46 AM, Jason Gunthorpe wrote:
>
> > There is nearly 1000 places that use a 'select CRYPTO_*' in the
> > kernel.
> >
> > I see only 60 'select CRYPTO' statements.

I think most of these are correct, as you typically have a single
'select CRYPTO'
in combination with a couple of 'select CRYPTO_*' ones for the specific
algorithms. I just added a lot of 'select CRC32' statements to deal with
all the build failures in drivers that require this but fail to have an extra
select statement. The way I got the list was to start with 'make allmodconfig'
and then recursively disable everything that had an explicit select, until
I was left with all the modules that need it without selecting it.

The same method could be used for CONFIG_CRYPTO, but it's a few
hours of work.

> Correct. :(
> We (community) tend to fix bug reports, not do global audits
> to see what needs to be fixed (with a few exceptions).
>
>
> I'll gladly wait to see what Arnd says.

For the specific case of CRC32, it might actually a good idea to change
the code to call into the CRC32 code directly instead of the CRYPTO_CRC32
abstraction. Would that work for RDMA_RXE?

       Arnd
