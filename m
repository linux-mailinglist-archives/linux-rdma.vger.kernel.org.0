Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E96602BC6
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 14:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJRMa1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 08:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiJRMa0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 08:30:26 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8214FA02FF;
        Tue, 18 Oct 2022 05:30:24 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id a24so9469408qto.10;
        Tue, 18 Oct 2022 05:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LA5Rw3StwiOqL+QwzJgo3njgEZhTbHuX12wcOa2B5Os=;
        b=Ii73Xm4qYOpwdKdTImAOfK4v5TThDEEOii1c40foC6cBmIQSl/oJ4CNt/qBjkwV+Rf
         IsCodeAX1yd+Aahx1Ab5Akm93REV+z6kv36LLvLPjTw1Gh09VmCkGj+iMAEQ1/DZz3eW
         KZKJMHRIs30cTpTdfKRWfGS7R97bi7ipz9d52ZVWdDBQq4YUM37WOcsHa2fHSMSHgAYy
         HPo4VY3NXUsWm+TUyON6gV3TDy4wAw31/HG1zFhUuopJVw4gGFJlPmOUxH92WvSUJc/p
         zThQaaInMOrC+k0As2qDfLoHyzcMlAtj+2LdBbVjF7JVYY1B3i5fZzksVQ+y6uuAL6AH
         84YA==
X-Gm-Message-State: ACrzQf1uXHGsROcsNficI288QEVWleJx/Bae8A3dLvURj5I1PA7LyHJ+
        8Ar9Sh4d1YpumoTDTAqvaFN4UwiQcqFjaQ==
X-Google-Smtp-Source: AMsMyM787KZDxWm9qtGFBmjdpQkf8XwXaiFsOUrkiHjboDALwsYvDEqYVzAiEuaUvcSfOPX2zumXkQ==
X-Received: by 2002:ac8:5848:0:b0:39c:e974:1c2c with SMTP id h8-20020ac85848000000b0039ce9741c2cmr1833279qth.674.1666096223404;
        Tue, 18 Oct 2022 05:30:23 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id bq36-20020a05620a46a400b006ee77f1ecc3sm2249510qkb.31.2022.10.18.05.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 05:30:23 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-3573ed7cc15so135568527b3.1;
        Tue, 18 Oct 2022 05:30:22 -0700 (PDT)
X-Received: by 2002:a81:98d:0:b0:357:2422:13b4 with SMTP id
 135-20020a81098d000000b00357242213b4mr2107285ywj.316.1666096222450; Tue, 18
 Oct 2022 05:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221017145157.1866351-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2210171653540.9136@ramsan.of.borg> <alpine.DEB.2.21.2210181126040.50489@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2210181126040.50489@angie.orcam.me.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Oct 2022 14:30:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVbo0wMaVVhe4f4tC9-TW2+DsOVAB77TtLdnsG=us8Q2A@mail.gmail.com>
Message-ID: <CAMuHMdVbo0wMaVVhe4f4tC9-TW2+DsOVAB77TtLdnsG=us8Q2A@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.1-rc1
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     linux-kernel@vger.kernel.org,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-arm-kernel@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-um@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Maciej,

On Tue, Oct 18, 2022 at 12:39 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
> On Mon, 17 Oct 2022, Geert Uytterhoeven wrote:
> > .> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9abf2313adc1ca1b6180c508c25f22f9395cc780/ (all 149 configs)

> > >  + {standard input}: Error: branch to a symbol in another ISA mode: 1339 =>
> > > 2616, 2621
> >
> > mips-gcc11/micro32r2_defconfig
> > mips-gcc11/micro32r2el_defconfig
>
>  Where can these configs be obtained from?

By following the links in the URL above you removed while replying? ;-)

http://kisskb.ellerman.id.au/kisskb/buildresult/14818296/
http://kisskb.ellerman.id.au/kisskb/buildresult/14818298/

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
