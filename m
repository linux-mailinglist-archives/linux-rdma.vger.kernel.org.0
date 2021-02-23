Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9730B323236
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Feb 2021 21:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhBWUl2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Feb 2021 15:41:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232461AbhBWUl1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Feb 2021 15:41:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22C4264DD3;
        Tue, 23 Feb 2021 20:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614112847;
        bh=uGAJBC1OsCmtfvTh5XYTZ5wEtalNDzB3n4lHqeFc7k4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YxQWpnQ2buDzVseqcgxrgYW1htp84hHQ6NXADwKzBwVfbNkEPwxb+09NQD3b17C2Y
         jdSSdjnJlqURRq4jgId0E2xWYTb3XLRhByr9Y58djbdQ+GXgxnO4yzE9CbacFN7Fgb
         gAy0ova4Kaxn9uXI//u/DiEoK0a/TxzOVra3sgShKkUE6pmD0pi2kCCAtEiQ2/tzn7
         My3oYzDzazwLIe2mHzKdAGfqVtZUkEAm29aLfu7SYRI6qQvNMdUkF5L58Zp8oFQmO6
         BcOHcQAIxYwcxwddFnf3v7JJ5q4DAt9PFlmKSZpG7eLmo0ryt+wESnGAXUGSBgAIxL
         Z58F/Oqeew8cg==
Received: by mail-oi1-f176.google.com with SMTP id q186so11622oig.12;
        Tue, 23 Feb 2021 12:40:47 -0800 (PST)
X-Gm-Message-State: AOAM531giY6o8IXLXgrn2he8/c25VSQFYU4DMUEZh7ErP7pCvyPFQHMK
        DkQCw4g9U/KNLS0zQ7loS0Jx7PD2QuFi/ACRpMs=
X-Google-Smtp-Source: ABdhPJy7rOhk5gpqOjkm8fSqe7oHwz9gRrjdvymeMMlciL8l7IQfvz1S2H/tsQVBVv/BaRtzdEQjvTIR0mlLvWuNtFM=
X-Received: by 2002:aca:4fd3:: with SMTP id d202mr416278oib.11.1614112846578;
 Tue, 23 Feb 2021 12:40:46 -0800 (PST)
MIME-Version: 1.0
References: <21525878.NYvzQUHefP@ubuntu-mate-laptop> <YDICM3SwwGZfE+Sg@unreal>
 <CAD=hENeCXGtKrXxLof=DEZjxpKyYBFS80pAX20nnJBuP_s-GBA@mail.gmail.com>
 <YDOq060TvAwLgknl@unreal> <20210222155845.GI2643399@ziepe.ca>
 <e1e3bec7-0350-4bdd-50c3-41b21388fc71@infradead.org> <20210222164645.GK2643399@ziepe.ca>
 <850d8bf2-c5a0-9fee-f95f-2dfc7d22a528@infradead.org> <CAK8P3a3z0_TNWP7TAVcZC8+MDJKhAZMbQoEH8tgfLQy2MJmG0Q@mail.gmail.com>
In-Reply-To: <CAK8P3a3z0_TNWP7TAVcZC8+MDJKhAZMbQoEH8tgfLQy2MJmG0Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 23 Feb 2021 21:40:29 +0100
X-Gmail-Original-Message-ID: <CAK8P3a194XrKArryJbL+FQoza08xB3FOepyXxBxZAF7ChYkLZQ@mail.gmail.com>
Message-ID: <CAK8P3a194XrKArryJbL+FQoza08xB3FOepyXxBxZAF7ChYkLZQ@mail.gmail.com>
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

On Tue, Feb 23, 2021 at 9:36 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> For the specific case of CRC32, it might actually a good idea to change
> the code to call into the CRC32 code directly instead of the CRYPTO_CRC32
> abstraction. Would that work for RDMA_RXE?

On the more general question of whether a driver should 'select CRYPTO',
this is how it's currently done for the other users, but I don't
actually like this,
and in general recommend against force-enabling another subsystem when
a particular driver is enabled.

My preference would be to change all drivers that require crypto services
of some kind to use 'depends on CRYPTO' in combination with 'select CRYPTO_*',
as this is what we do for other cross-subsystem dependencies. However,
it seems unlikely that we can change it anytime soon, as the current method
is widespread and changing the dependencies would break users that do
'make oldconfig' on an old configuration.

       Arnd
