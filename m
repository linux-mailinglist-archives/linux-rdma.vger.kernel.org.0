Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC169323395
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Feb 2021 23:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbhBWWGp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Feb 2021 17:06:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232464AbhBWWGo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Feb 2021 17:06:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D77F764EC8;
        Tue, 23 Feb 2021 22:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614117962;
        bh=wQfO2oJhyft3ZSiuh872nfltEKFOtACSv0UUDDAaDhw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u7rXegoR7E53Lt69mVl9c4mDgh+jE/KRo+4C5GZ+EgrVdEMDtuCp4OnXhX/x23H1a
         TpQezwh7d14NwvtofEj7TTpjMB1k4urunDhDXpsW29ePBDOU6oZPSlfz0GlumuQW7y
         iRJP4V5BfkdJFvXUVowKExknEwwnBE3LORYrK5CLbPqixgyOxDeN/VYvSYOCfjBwTJ
         FH6EOm4NEyqP1BnhTjtRL8zwFWwJlgfZajMciKpH3+J21uG42RS8F3S0YaSaCOZ/uT
         K8aan69aGZxscrvT6q5rXGbJ5DwpPKXUdb5GGZ+EPeA3D28AdXflPD/PNcF/HUx1s9
         bkKbqMEZCGNXw==
Received: by mail-oi1-f176.google.com with SMTP id z126so304170oiz.6;
        Tue, 23 Feb 2021 14:06:02 -0800 (PST)
X-Gm-Message-State: AOAM531w7R2g2y+ufyRyaU6lu9wO4WTyXacNZfW5sTFA6Ki+Bun0hkjO
        ZZZMxcqscTQVJUUYdhnz/sBqnFyYDSZr9eGwv8Q=
X-Google-Smtp-Source: ABdhPJxkG337q0phi/7Wv6CeiOedzqOMZgXJFexe6sVQ9eSby86Lsa+wIdadIddmZVmEzR/s4OcmrHHnPDPUAs3V9is=
X-Received: by 2002:aca:4a47:: with SMTP id x68mr579924oia.67.1614117962232;
 Tue, 23 Feb 2021 14:06:02 -0800 (PST)
MIME-Version: 1.0
References: <21525878.NYvzQUHefP@ubuntu-mate-laptop> <CAJ-ZY99xZEsS5pCbZ7evi_ohozQBpHcNHDcXxfoeaLzuWRzyzw@mail.gmail.com>
 <CAK8P3a1jRS=QyTxJzSxfEsaAuF5HnOXbv4MOu8b5EZWEhUep=Q@mail.gmail.com> <10464303.FBcTZR2von@ubuntu-mate-laptop>
In-Reply-To: <10464303.FBcTZR2von@ubuntu-mate-laptop>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 23 Feb 2021 23:05:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1XW0NTFHiEUoLgeHGpKUfYgM8T8Or7ix3m6Fd-TLEn5w@mail.gmail.com>
Message-ID: <CAK8P3a1XW0NTFHiEUoLgeHGpKUfYgM8T8Or7ix3m6Fd-TLEn5w@mail.gmail.com>
Subject: Re: [PATCH] drivers: infiniband: sw: rxe: fix kconfig dependency on CRYPTO
To:     Julian Braha <julianbraha@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 23, 2021 at 10:54 PM Julian Braha <julianbraha@gmail.com> wrote:
> On Tuesday, February 23, 2021 4:26:44 PM EST Arnd Bergmann wrote:
> > On Tue, Feb 23, 2021 at 9:46 PM Julian Braha <julianbraha@gmail.com> wrote:
> > >
> > > I have other similar patches that I intend to submit. What should I do,
> > > going forward? Should I use "depends on CRYPTO" for cases like these?
> > > Should I resubmit this patch with that change?
> >
> > No, we should not mix the two methods, that just leads to circular dependencies.
> >
> > How many more patches do you have that need to get merged?
> >
> > If it's only a few, I'd suggest merging them first before we consider a
> > broader change. If the problem is very common, we may want to
> > think about alternative approaches first, and then change everything
> > at once.
>
> Sorry, I don't have a specific number, but it's certainly under a dozen patches.

It's probably best to continue pushing those first then.

        Arnd
