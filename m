Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2315A9D2E6
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 17:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731987AbfHZPiF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 11:38:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37535 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731833AbfHZPiE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Aug 2019 11:38:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id d16so16322252wme.2;
        Mon, 26 Aug 2019 08:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sh9DJjMgqXE7WeVQf/Tx2s2yKAPE6CjBynjLsZuWR9M=;
        b=lDltRrG2+uHyKNgvQKaYSjqwL/N3HD3dAh6sDbLjcYDQEFT/ZrEFtRzaZTTtvp4XRJ
         AfxMz/PEc66hkn/zQXQZ8xVvRLmGTaAYW39jDEfwRUphMZz2xJ28RFlutTzV/Wf3Whmk
         P4GmHK62zvCO7sGJkjrjago8qVKqe+TjLjakGAJEDJwEdIEL9GVpRRJBjs2OmFQKHYXQ
         HsSVa5FDVqmqCdCV2sF08sos75Y9VO+ZyXZBWh+7LQbiCoXDuOtf/c8D7JD9f6Hd8Jvn
         6TYxvd60ti7IblY2XxPPQmvNmlheKmeCCxGypMNMjRhEfYfhPlow0B8hrw1AWQqKOJc3
         meAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sh9DJjMgqXE7WeVQf/Tx2s2yKAPE6CjBynjLsZuWR9M=;
        b=YyU08iXBHTooc2IcAqgUf5f16XrKaE8ZQWURZ+Z3/E7X9FgSGwm92BbAFNVRFriBHw
         09yG8FOKIpnT3cOI8mq0buSYQs/MQWgyiSLlZkBtAW4LXoIDXfuMiVhZAhHz+dzY9k9E
         tewE/pXZutRSz07QKzPPx7otQdJukFjpq+s35oYCvBQcu+f0Htrhv3Xe1HMYmogGOWpu
         K0D14fmZkT2mYcS4PvSyvtuMRCtZ9qsKwb3FU8eZid7htujB+VceO31qmM2D2gmpWZ5W
         IqEPnBzBQTlYC5zJebUl14xGxMAS82edcMs8L3BCMWsZdSQY69vgSGv4RhoSxMfOMHs1
         C8VQ==
X-Gm-Message-State: APjAAAUaTTZLDMPwiHYcK7GENcHKeeNFEGAxMFTgTw76+kDmvQyr4o/o
        NLUl9hAfDBMPpYr0xsdzNWA=
X-Google-Smtp-Source: APXvYqxLILlxLVypuvY3dis/5jWnxjA8EZXYa52Wudn0LEl6/LvtxMWr5FAvJ9nF5MzYYs1Zt+w/kQ==
X-Received: by 2002:a1c:6145:: with SMTP id v66mr23582593wmb.42.1566833882631;
        Mon, 26 Aug 2019 08:38:02 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id 39sm37272363wrc.45.2019.08.26.08.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 08:38:02 -0700 (PDT)
Date:   Mon, 26 Aug 2019 08:38:00 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
Message-ID: <20190826153800.GA4752@archlinux-threadripper>
References: <20190710174800.34451-1-natechancellor@gmail.com>
 <OFE93E0F86.E35CE856-ON00258434.002A83CE-00258434.002A83DF@notes.na.collabserv.com>
 <20190711081434.GA86557@archlinux-threadripper>
 <20190711133915.GA25807@ziepe.ca>
 <CAKwvOdnHz3uH4ZM20LGQJ3FYhLQQUYn4Lg0B-YMr7Y1L66TAsA@mail.gmail.com>
 <20190711171808.GF25807@ziepe.ca>
 <20190711173030.GA844@archlinux-threadripper>
 <20190823142427.GD12968@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823142427.GD12968@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

On Fri, Aug 23, 2019 at 11:24:27AM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 11, 2019 at 10:30:30AM -0700, Nathan Chancellor wrote:
> > On Thu, Jul 11, 2019 at 02:18:08PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Jul 11, 2019 at 10:16:44AM -0700, Nick Desaulniers wrote:
> > > > On Thu, Jul 11, 2019 at 6:39 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > >
> > > > > On Thu, Jul 11, 2019 at 01:14:34AM -0700, Nathan Chancellor wrote:
> > > > > > Maybe time to start plumbing Clang into your test flow until it can get
> > > > > > intergrated with more CI setups? :) It can catch some pretty dodgy
> > > > > > behavior that GCC doesn't:
> > > > >
> > > > > I keep asking how to use clang to build the kernel and last I was told
> > > > > it still wasn't ready..
> > > > >
> > > > > Is it ready now? Is there some flow that will compile with clang
> > > > > warning free, on any arch? (at least the portion of the kernel I check)
> > > > 
> > > > $ make CC=clang ...
> > > > 
> > > > Let us know if you find something we haven't already.
> > > > https://clangbuiltlinux.github.io/
> > > > https://github.com/ClangBuiltLinux/linux/issues
> > > 
> > > What clang version?
> > > 
> > > Jason
> > 
> > You'll need clang-9 for x86 because of the asm-goto requirement (or a
> > selective set of reverts for clang-8) but everything else should be
> > good with clang-8:
> 
> The latest clang-9 packages from apt.llvm.org do seem to build the
> kernel, I get one puzzling warning under RDMA:
> 
> drivers/infiniband/hw/hfi1/platform.o: warning: objtool: tune_serdes()+0x1f4: can't find jump dest instruction at .text+0x118a

Any particular config that I should use to easily reproduce this?

> And a BPF one:
> 
> kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0xd: sibling call from callable instruction with modified stack frame

I think this might be related to this?

https://lore.kernel.org/lkml/cf0273fb-c272-72be-50f9-b25bb7c7f183@windriver.com/

Cheers,
Nathan
