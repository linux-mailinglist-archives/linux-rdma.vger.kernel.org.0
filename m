Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D72565EA0
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 19:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfGKRaf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 13:30:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35647 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbfGKRaf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jul 2019 13:30:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so7201626wrm.2;
        Thu, 11 Jul 2019 10:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U3b0G1E1maoK6A4e9Ca/0e/KTMO66Xm7oZqBqZ5gCxk=;
        b=TKv2sJnddYV0SAh+0b25B0nWCvHDEp0nnayzul0ypf+gYb78r4UALyCCXmyeh68S/m
         sjP6uWt6XmfRcwXRmgGIaKwlUSAZzvz53a63//yW2whDjrf/6C+me2WXbjMrlmMN4Bjb
         I9Z1gXRMyU9ijAsFrOosCFBUaSdU+6VVK5lVAPDwWzpPQDqqDeFIsQPB3tmmooIh9ba6
         Z0kn2DXQm4CVS+vfU0zlPIfnfjTBdUJgFMfkb+wqXBKTEDtzl9x1bcnE24sJaHK3vjtf
         DLeXLpYO0DrHvwK6apIx/3ugeAzRva63nTwZDd6HrqHMQJ/VZAFvC3GzlNc1w0z5mKTh
         kmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U3b0G1E1maoK6A4e9Ca/0e/KTMO66Xm7oZqBqZ5gCxk=;
        b=YPbYacoRBN3GKXlHPvhivqhhyJoGQVIL/ZFHFw2+086hLDYlh+zfjn37u1rZTGlpgy
         Tg3l+qn5jz9eLfmvXXjnAFEqLeXYjUZFwcb9CCcdYMAgBi5XmqnC5Qa8dTh+YuT3qztM
         aaNKlpb1aBOH2+WXqQggVEX7z+IjRpOvHgPnVTyFxZPaNhyzHSGONQYZpK3N7a6/fuGR
         mRYuYc93j0FSykrcD8uT79PHiDmfhb9OVY1t7kIGRKxk/FeQeWGL1pmGkgMNmasi7nIS
         3rNFx8kC3P+wZE9DpExBOLru94uFT9x6CWISRe7GGcbIP6FecAExX/+1L0uA7Wfc5/TY
         rFwg==
X-Gm-Message-State: APjAAAWpxj1e4tMdDkKw/KbvydW2AQHo8oP2OyjPS3ENqHKcQ3DAhEul
        5SkP0eXhAne70PgqBxjnGa4=
X-Google-Smtp-Source: APXvYqzo3byxyxCxShNQCAttoD2gEStU3rn0zpqaJflGhfsxBtoj91oh78aSJNGNESC/oRF2RhYVPg==
X-Received: by 2002:adf:90e7:: with SMTP id i94mr5935660wri.224.1562866232510;
        Thu, 11 Jul 2019 10:30:32 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id y7sm4588363wmm.19.2019.07.11.10.30.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 10:30:31 -0700 (PDT)
Date:   Thu, 11 Jul 2019 10:30:30 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
Message-ID: <20190711173030.GA844@archlinux-threadripper>
References: <20190710174800.34451-1-natechancellor@gmail.com>
 <OFE93E0F86.E35CE856-ON00258434.002A83CE-00258434.002A83DF@notes.na.collabserv.com>
 <20190711081434.GA86557@archlinux-threadripper>
 <20190711133915.GA25807@ziepe.ca>
 <CAKwvOdnHz3uH4ZM20LGQJ3FYhLQQUYn4Lg0B-YMr7Y1L66TAsA@mail.gmail.com>
 <20190711171808.GF25807@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711171808.GF25807@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 11, 2019 at 02:18:08PM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 11, 2019 at 10:16:44AM -0700, Nick Desaulniers wrote:
> > On Thu, Jul 11, 2019 at 6:39 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Thu, Jul 11, 2019 at 01:14:34AM -0700, Nathan Chancellor wrote:
> > > > Maybe time to start plumbing Clang into your test flow until it can get
> > > > intergrated with more CI setups? :) It can catch some pretty dodgy
> > > > behavior that GCC doesn't:
> > >
> > > I keep asking how to use clang to build the kernel and last I was told
> > > it still wasn't ready..
> > >
> > > Is it ready now? Is there some flow that will compile with clang
> > > warning free, on any arch? (at least the portion of the kernel I check)
> > 
> > $ make CC=clang ...
> > 
> > Let us know if you find something we haven't already.
> > https://clangbuiltlinux.github.io/
> > https://github.com/ClangBuiltLinux/linux/issues
> 
> What clang version?
> 
> Jason

You'll need clang-9 for x86 because of the asm-goto requirement (or a
selective set of reverts for clang-8) but everything else should be
good with clang-8:

https://travis-ci.com/ClangBuiltLinux/continuous-integration/builds/118745131

We wrote a Python script that builds an LLVM 9 toolchain suitable for
kernel development that is self contained (doesn't install anything to
your system):

https://github.com/ClangBuiltLinux/tc-build

Let me know if there are any issues with it if you give it a go, I've
already fixed one from Thomas Gleixner:

https://lore.kernel.org/lkml/alpine.DEB.2.21.1906262140570.32342@nanos.tec.linutronix.de/

Cheers,
Nathan
