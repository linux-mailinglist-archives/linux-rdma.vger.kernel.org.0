Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 095EE920F6
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 12:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfHSKI2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 06:08:28 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37591 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfHSKI2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 06:08:28 -0400
Received: by mail-ot1-f67.google.com with SMTP id f17so1143999otq.4;
        Mon, 19 Aug 2019 03:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H0chY2RMwrvKKhuZqglGq4kNze9QwWoVSAq4R82N4iE=;
        b=KNTCSnJ+iZHLRzR3uPtDDt1JbCje1rR6NpJyd1jzGqe0xm7im9ApyhRL5iPYv5+TnR
         Gr1RAO/IlduNF1G1NMcp8T7n0p33s0tuf/HPP9sMXHUCeDlvhLg22S7eBWEvljgewnxS
         XeIvLzYUUo2o86PYgcF2MDdhr2tgxZ4BQvhA+wbb2F90nk6lTh7XCb7NTYi5WXeMsb92
         ouRGzguOPZg6VWAx44i2ZHZCvBrqtdAIQgbAwdtbNe7/QgF/2WljICfNVV+RhoKopq2S
         XNKUnyl42Y7B6RAXloddBSCeE8l2rK2RYJ5qu7OIgKnNZfn6585QMuKTJLX8f/bVsnzE
         KxtQ==
X-Gm-Message-State: APjAAAXEffMjgL+e6kBTlbVU9dheyD/CdCm/kwvRKTkwno+b8aEMVtPN
        kEkC+zHs7zFc3xMaHZ8HW0Yyai/pLdOvdZPBWqup2w==
X-Google-Smtp-Source: APXvYqxuABoRd/1ngipZ1X5vpMcIf31xF8UXBhXIGYXI+TitX9C1HmLOmMNrcTsTJwzYVsvRfTGPxkkt+rhpmXJ8cNQ=
X-Received: by 2002:a9d:459d:: with SMTP id x29mr18331698ote.39.1566209307503;
 Mon, 19 Aug 2019 03:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <09bcafaab07dfde728357bfe61b6a7edfa3b25c9.camel@redhat.com>
In-Reply-To: <09bcafaab07dfde728357bfe61b6a7edfa3b25c9.camel@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Aug 2019 12:08:16 +0200
Message-ID: <CAMuHMdWp+g-W0rJtVTWEiJpbhcV7GoSkub11fZPMUbhJcxMUNA@mail.gmail.com>
Subject: Re: [PULL REQUEST] Please pull rdma.git
To:     Doug Ledford <dledford@redhat.com>,
        Bernard Metzler <bmt@zurich.ibm.com>
Cc:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Gunthorpe, Jason" <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Doug, Bernard,

On Wed, Aug 14, 2019 at 5:00 PM Doug Ledford <dledford@redhat.com> wrote:
> Fairly small pull request for -rc3.  I'm out of town the rest of this
> week, so I made sure to clean out as much as possible from patchworks in
> enough time for 0-day to chew through it (Yay! for 0-day being back
> online! :-)).  Jason might send through any emergency stuff that could
> pop up, otherwise I'm back next week.
>
> The only real thing of note is the siw ABI change.  Since we just merged
> siw *this* release, there are no prior kernel releases to maintain
> kernel ABI with.  I told Bernard that if there is anything else about
> the siw ABI he thinks he might want to change before it goes set in
> stone, he should get it in ASAP.  The siw module was around for several
> years outside the kernel tree, and it had to be revamped considerably
> for inclusion upstream, so we are making no attempts to be backward
> compatible with the out of tree version.  Once 5.3 is actually released,
> we will have our baseline ABI to maintain.

[...]

> - Allow siw to be built on 32bit arches (siw, ABI change, but OK since
>   siw was just merged this merge window and there is no prior released
>   kernel to maintain compatibility with and we also updated the
>   rdma-core user space package to match)

> Bernard Metzler (1):
>       RDMA/siw: Change CQ flags from 64->32 bits

Obviously none of this was ever compiled for a 32-bit platform?!?

Patch sent to kill the warnings.
But there may be deeper issues not exposed by them.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
