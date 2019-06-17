Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B47D48977
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2019 18:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfFQQ5u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jun 2019 12:57:50 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39594 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfFQQ5u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jun 2019 12:57:50 -0400
Received: by mail-vs1-f67.google.com with SMTP id n2so6585396vso.6
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jun 2019 09:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=retltkRYeaxJ6adF3YGzOCqdGSJ+TnMcYlKByHm/5DU=;
        b=HM9XZcRH7jNoUwKtDn/wkkMYYyg9wr6zjYQcvYAYvWF5M1tzrgs41DdFiwwTgvt1O5
         KjOS0GHXaKxXHbuqb3yaHFY6s5m+GgG8jbRV5AKURRu+BUwOFgp4r3kAue00v9koQG1w
         A3M5l+cF/ibNvE8yJCY4E6+A4Wcv9UTKgrtukbJgSFBngoBXKyC/nUsbJSqEshzxgU7v
         OjkzG8cTM1db0z9+CHPRCzJf6yJOwQUirXZIKRWYCQ5D1XOdgX6CDWUq7ZrKtG2PzpGN
         +3DiSEl9lQXDncbHpzuwreL+mokGyGGK7aL+x6DR/HBeGpJarIMjtc91XuMaEVI3t0qt
         MUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=retltkRYeaxJ6adF3YGzOCqdGSJ+TnMcYlKByHm/5DU=;
        b=P3tiy8ebW139agSf+3H0uNIFPa5q4/gra5pyCn8VklVOCSn23ajHQgj65zWE/EbprA
         PHvG2xIDzpTjeMmHJNodvOt+YFki4cbHpByn0cuy3SC0g3NzlFk0WiCDa+6IcDb84jHJ
         CppQ8sYwdLjvGV9JtqYemD39wjI2KomcGMRiRRUapJDF0+SIZjd6tOaGrLVgVIaY1TnV
         F6aNz9vs/bq8IwDrI9Khv7+rXozKrTHMR+/npUc2Hp4oV6AJO3F91P6Pp8xZX4wl+gJa
         cghhN6+VTb1pU0CFAfsSH9kFqi38I3H6ICWrkq0GkpXWMAua5liRQIX6hzbrs5c/4aIv
         tYeA==
X-Gm-Message-State: APjAAAVYMXnWKrkXK9jXT5DNP127DHfFvFjHqXmszk2FfreSvwG5hQlh
        QRtCyzg9N9Lkmb55YkHduQiRqPJvWAnG2aSBL7nbIQ==
X-Google-Smtp-Source: APXvYqzrhGSVJ7DV/F7d51q9N5ZE/3Gdj+PUpdVhrLQtXpA774FgTPlA9JMz0E4zBMsomoYTx9It+Pl+lwBwRCw5EpI=
X-Received: by 2002:a67:de99:: with SMTP id r25mr60881073vsk.215.1560790668543;
 Mon, 17 Jun 2019 09:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560339705.git.andreyknvl@google.com> <a7a2933bea5fe57e504891b7eec7e9432e5e1c1a.1560339705.git.andreyknvl@google.com>
 <20190617135636.GC1367@arrakis.emea.arm.com>
In-Reply-To: <20190617135636.GC1367@arrakis.emea.arm.com>
From:   Evgenii Stepanov <eugenis@google.com>
Date:   Mon, 17 Jun 2019 09:57:36 -0700
Message-ID: <CAFKCwrjJ+0ijNKa3ioOP7xa91QmZU0NhkO=tNC-Q_ThC69vTug@mail.gmail.com>
Subject: Re: [PATCH v17 03/15] arm64: Introduce prctl() options to control the
 tagged user addresses ABI
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 17, 2019 at 6:56 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, Jun 12, 2019 at 01:43:20PM +0200, Andrey Konovalov wrote:
> > From: Catalin Marinas <catalin.marinas@arm.com>
> >
> > It is not desirable to relax the ABI to allow tagged user addresses into
> > the kernel indiscriminately. This patch introduces a prctl() interface
> > for enabling or disabling the tagged ABI with a global sysctl control
> > for preventing applications from enabling the relaxed ABI (meant for
> > testing user-space prctl() return error checking without reconfiguring
> > the kernel). The ABI properties are inherited by threads of the same
> > application and fork()'ed children but cleared on execve().
> >
> > The PR_SET_TAGGED_ADDR_CTRL will be expanded in the future to handle
> > MTE-specific settings like imprecise vs precise exceptions.
> >
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>
> A question for the user-space folk: if an application opts in to this
> ABI, would you want the sigcontext.fault_address and/or siginfo.si_addr
> to contain the tag? We currently clear it early in the arm64 entry.S but
> we could find a way to pass it down if needed.

For HWASan this would not be useful because we instrument memory
accesses with explicit checks anyway. For MTE, on the other hand, it
would be very convenient to know the fault address tag without
disassembling the code.
