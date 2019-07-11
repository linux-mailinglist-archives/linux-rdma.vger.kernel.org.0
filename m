Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33A0065E58
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 19:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfGKRSK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 13:18:10 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39315 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbfGKRSJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jul 2019 13:18:09 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9so5096595qtu.6
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2019 10:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UTxsWXTECGBMOG0GnFyPFPTi0lGjRsY0+YyFpMLhFhg=;
        b=aHkrW0+ndgyKfgFDGXlpBhpn1+sV9FtQ/iMrxyBxCrjC01IoBpEqLL2eM7XRxus4Pj
         5bOoD3jNgSBg3uLAke200qmPrEzjwaACw0IK5j/rOLyibFdsrkMqb1DRb+669yFiiw4+
         3A5e123BmNr/XIGc9C3denUABqv9A1p5Yy1rc9sIAOfPcO6/dfdTjusBQDM+TziliOmI
         JnVGUC1XyozrN0sc+ED/NbFiwglM26cCw/LnGTVfnz1+6BzyxITIc9p3xrGTHZjRqvG6
         VB8nfDPboYdK6mQmvn8nGLDLpDluCTDp0ldJZnWhvrkb6vu4gH+vl6OzLWSNKkPPqG8E
         k9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UTxsWXTECGBMOG0GnFyPFPTi0lGjRsY0+YyFpMLhFhg=;
        b=FJOPCquqR/JLwaT1ttZ2LHo2vwPLNKWNnCwjk2IBGkp51rhUMs4Ix9wN5qZJ12rwSB
         z64wBuU1cUjL3dBp1O95+fjchvc74lFT8uyQCFtMQHZ7J+SOrhx+2NPr6ijn9CXDtXdc
         Cc70zx3kKJ2L51wJZRDAlZ0+ugGjzc4xsDh6cCG2726Mq5P9gs4R0qVfUt03sBaY60Tv
         yc6Nk4dXFJfgX9a4fPr6vxfWGbtS+g/nTqIAJf9r8+ZpE2Pu/fTiyURueC7S0EpOxIaf
         jxqhUTLC2e/EAXCCztLREI+aBEeTvPiP08Nm4LOnZ3teyj1KANOnOYzRCIeZeLjFpQ++
         FXew==
X-Gm-Message-State: APjAAAW7MMJ8z2xvrx/3iigek0ZPg01g7OCqsMc/DJ6SWxjdB9HLu9OM
        2l9qQzTS8OLmh+ppi3iM689YKw==
X-Google-Smtp-Source: APXvYqxHKUD0V0Z3mECjZTXp2KOCMRJVQO1szSv2M6Gj1Gew096GN/XAN83pJ+5jpKYP9pb/eYa4gA==
X-Received: by 2002:ac8:2194:: with SMTP id 20mr2673385qty.203.1562865488951;
        Thu, 11 Jul 2019 10:18:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id p13sm1976377qkj.4.2019.07.11.10.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 10:18:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlchs-00086y-0u; Thu, 11 Jul 2019 14:18:08 -0300
Date:   Thu, 11 Jul 2019 14:18:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
Message-ID: <20190711171808.GF25807@ziepe.ca>
References: <20190710174800.34451-1-natechancellor@gmail.com>
 <OFE93E0F86.E35CE856-ON00258434.002A83CE-00258434.002A83DF@notes.na.collabserv.com>
 <20190711081434.GA86557@archlinux-threadripper>
 <20190711133915.GA25807@ziepe.ca>
 <CAKwvOdnHz3uH4ZM20LGQJ3FYhLQQUYn4Lg0B-YMr7Y1L66TAsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnHz3uH4ZM20LGQJ3FYhLQQUYn4Lg0B-YMr7Y1L66TAsA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 11, 2019 at 10:16:44AM -0700, Nick Desaulniers wrote:
> On Thu, Jul 11, 2019 at 6:39 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Jul 11, 2019 at 01:14:34AM -0700, Nathan Chancellor wrote:
> > > Maybe time to start plumbing Clang into your test flow until it can get
> > > intergrated with more CI setups? :) It can catch some pretty dodgy
> > > behavior that GCC doesn't:
> >
> > I keep asking how to use clang to build the kernel and last I was told
> > it still wasn't ready..
> >
> > Is it ready now? Is there some flow that will compile with clang
> > warning free, on any arch? (at least the portion of the kernel I check)
> 
> $ make CC=clang ...
> 
> Let us know if you find something we haven't already.
> https://clangbuiltlinux.github.io/
> https://github.com/ClangBuiltLinux/linux/issues

What clang version?

Jason
