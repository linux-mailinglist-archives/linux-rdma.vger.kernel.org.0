Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB469B1D6
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2019 16:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390775AbfHWOYa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Aug 2019 10:24:30 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34866 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731879AbfHWOY3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Aug 2019 10:24:29 -0400
Received: by mail-qk1-f193.google.com with SMTP id r21so8332543qke.2
        for <linux-rdma@vger.kernel.org>; Fri, 23 Aug 2019 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RZxP956OaKkH9WuNbAGH2Ye8Wz/eWZMm/eoqzNqOOhE=;
        b=ZI/ikWc8jIUB67yAoz9WFASP4hZT+5jCwTs30zaoEF8U1UiI9Mv22Niptyk0X4dUox
         qWzKeMP4RgZLkkU8aYn23BGcgpoHY9rbhgof8lJfttwch8w9DrIUkz2k5T4QnpiViU5K
         WEVRy4qenD4SErBb6Q0pPeI8sxk6+az0/UnWBKVumFrvromtGqstKAD8ETYWF396RrLv
         WkrZr0JxF7Is5PhQhpdY2YeL3QcU7x0RZ2whQUCRsPPMzxkIGQil48Zf6yWvGjPiqRuL
         T3840+0QGjiIVCg5T/+t+8WlN7fpi8d5/2aKzGARumqCAiigHdumG4Oo+6J9bB/SYTl7
         H63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RZxP956OaKkH9WuNbAGH2Ye8Wz/eWZMm/eoqzNqOOhE=;
        b=DC5KYg/K0YW42RmiYHCG52WTye/OJeoMCj8RhEbqonx2lXp7gdDIBtBLDx07EY3yGC
         35FfTLrNFw1RSnjFdU8nyPaTePNqd9hZKhuZFC9H3xuii4xfOML92p5VXcILuKN5YfKp
         ITWQzTS03194zd1Z6TsZOE3MrV8kquFM4iupG6EbqbCMo/NGf7buh53dlbjXH3GkQDcn
         Hcbm5GoWPLhLJ960bNoIeh9YZqUL44ZH3si7105OW/7gt1sx63M8Ocruytx2iGS2/HXD
         x7iVNlgeK6FTYxwOie8SK6/JkSiho6TTC7TlClr2i1tVmLRUBLDYaiI9VDIODwy0uRCB
         99mA==
X-Gm-Message-State: APjAAAWnxL7jf0r2x2sF5PtxPlC/0Hsz0tOKSJTtG6IUWySiNRHZhIHh
        TB2eObrjVSZqCRb5GTTlzyUTsg==
X-Google-Smtp-Source: APXvYqyqFda9e0GyIrw1K2507j+j0yP11wlqxsBZJJtBWlXa+xxrHR7TFaJMWg/2H/NMdtQK/oHXVw==
X-Received: by 2002:a37:a142:: with SMTP id k63mr4187227qke.487.1566570268736;
        Fri, 23 Aug 2019 07:24:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id j11sm773547qtn.20.2019.08.23.07.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Aug 2019 07:24:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i1AUN-0007Wh-LJ; Fri, 23 Aug 2019 11:24:27 -0300
Date:   Fri, 23 Aug 2019 11:24:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
Message-ID: <20190823142427.GD12968@ziepe.ca>
References: <20190710174800.34451-1-natechancellor@gmail.com>
 <OFE93E0F86.E35CE856-ON00258434.002A83CE-00258434.002A83DF@notes.na.collabserv.com>
 <20190711081434.GA86557@archlinux-threadripper>
 <20190711133915.GA25807@ziepe.ca>
 <CAKwvOdnHz3uH4ZM20LGQJ3FYhLQQUYn4Lg0B-YMr7Y1L66TAsA@mail.gmail.com>
 <20190711171808.GF25807@ziepe.ca>
 <20190711173030.GA844@archlinux-threadripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711173030.GA844@archlinux-threadripper>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 11, 2019 at 10:30:30AM -0700, Nathan Chancellor wrote:
> On Thu, Jul 11, 2019 at 02:18:08PM -0300, Jason Gunthorpe wrote:
> > On Thu, Jul 11, 2019 at 10:16:44AM -0700, Nick Desaulniers wrote:
> > > On Thu, Jul 11, 2019 at 6:39 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Thu, Jul 11, 2019 at 01:14:34AM -0700, Nathan Chancellor wrote:
> > > > > Maybe time to start plumbing Clang into your test flow until it can get
> > > > > intergrated with more CI setups? :) It can catch some pretty dodgy
> > > > > behavior that GCC doesn't:
> > > >
> > > > I keep asking how to use clang to build the kernel and last I was told
> > > > it still wasn't ready..
> > > >
> > > > Is it ready now? Is there some flow that will compile with clang
> > > > warning free, on any arch? (at least the portion of the kernel I check)
> > > 
> > > $ make CC=clang ...
> > > 
> > > Let us know if you find something we haven't already.
> > > https://clangbuiltlinux.github.io/
> > > https://github.com/ClangBuiltLinux/linux/issues
> > 
> > What clang version?
> > 
> > Jason
> 
> You'll need clang-9 for x86 because of the asm-goto requirement (or a
> selective set of reverts for clang-8) but everything else should be
> good with clang-8:

The latest clang-9 packages from apt.llvm.org do seem to build the
kernel, I get one puzzling warning under RDMA:

drivers/infiniband/hw/hfi1/platform.o: warning: objtool: tune_serdes()+0x1f4: can't find jump dest instruction at .text+0x118a

And a BPF one:

kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0xd: sibling call from callable instruction with modified stack frame

Jason
