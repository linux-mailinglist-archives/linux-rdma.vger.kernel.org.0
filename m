Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547FB1B73B0
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 14:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgDXMP4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 08:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgDXMP4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Apr 2020 08:15:56 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10868C09B045
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2020 05:15:56 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v26so2049145qto.0
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2020 05:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=stQMKcxru1ycab0nNkNI6do88V3oBob0HPMSzdDCfe8=;
        b=EDZuIF9mh4MO3uMagwfvQxVrPyFcFcQQ/YqjHSU0E/7kpK67/O0VrMTQoYFLr8Xdny
         ceiP3ShAFGqLCCymImyTS/u6CK+6safGqktYl2wczdx4ePh0V3TgYzN1JsDVl6udIRsq
         xyQF4sH+c7HTjpikgxlXaO09iVMuC2RjskPYlDJvaw/qiHWiG4RNmEkxF94TvEQHgFGo
         xpvogtMZJbKVekUBYomI0XHS58lhKGIuW27flx9u3bacRsygXmUNas6R2YrNbOEN5vMO
         PtCu8zKPCWi6bsyPoOJXB0n7faMV4msQWUy1wqQdNqEUyYfLcY1i6S7/tTCbpXSgPsaU
         Q6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=stQMKcxru1ycab0nNkNI6do88V3oBob0HPMSzdDCfe8=;
        b=BmCnwHz5mamZpljjbj6ESLQOxJroZyGYV6Oi6BzarNiU1B3GaYFIN14WFDuKuUXicE
         NAJI8NSRgf8qdP8oTnpo2Zl2CSdbSy1Kgec7EtYKYiEY5El48E5oEZ3MZi7BrGuyZHHb
         Sz2NXtTX/ia9ZmWvKaOtDwbZPHBT2e4KcuAQ//nd1yEHX1QOLGCaeIrhE6bX/IFrTUet
         wKpMmN7DgXkvhPRWtddLiACF7GZVxvONeO4iTTphtt/x9sq0oa3bcrS/6lYKD35QbuUP
         mNEtpYsfa3sE83him9St0ZfeYf95dFAJlMERahoYseD0zJ6DQS70jSrFCelNBzpjwE8e
         uIVA==
X-Gm-Message-State: AGi0PubDdm02FwGu21W49270ThSkHTo8KnjHOagzquSSCmA4md2TdjHd
        DO0PcY9l4dvA+kN59UCoG0FCMA==
X-Google-Smtp-Source: APiQypJwaI8TLuxWqrHXshDeb9lGmk6VW5/OSCE7FqJ0JkKmwRLUmX+YjvFHC38kGO7S4SbpF5T8iQ==
X-Received: by 2002:aed:3ff4:: with SMTP id w49mr9175729qth.61.1587730555234;
        Fri, 24 Apr 2020 05:15:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p80sm3577469qka.134.2020.04.24.05.15.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Apr 2020 05:15:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jRxFJ-0004zP-Fh; Fri, 24 Apr 2020 09:15:53 -0300
Date:   Fri, 24 Apr 2020 09:15:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rdma@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: remaining flexible-array conversions
Message-ID: <20200424121553.GE26002@ziepe.ca>
References: <6342c465-e34b-3e18-cc31-1d989926aebd@embeddedor.com>
 <20200424034704.GA12320@ubuntu-s3-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424034704.GA12320@ubuntu-s3-xlarge-x86>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 23, 2020 at 08:47:04PM -0700, Nathan Chancellor wrote:
> Hi Gustavo,
> 
> On Wed, Apr 22, 2020 at 01:26:02PM -0500, Gustavo A. R. Silva wrote:
> > Hi Linus,
> > 
> > Just wanted to ask you if you would agree on pulling the remaining
> > flexible-array conversions all at once, after they bake for a couple
> > of weeks in linux-next[1]
> > 
> > This is not a disruptive change and there are no code generation
> > differences. So, I think it would make better use of everyone's time
> > if you pull this treewide patch[2] from my tree (after sending you a
> > proper pull-request, of course) sometime in the next couple of weeks.
> > 
> > Notice that the treewide patch I mention here has been successfully
> > built (on top of v5.7-rc1) for multiple architectures (arm, arm64,
> > sparc, powerpc, ia64, s390, i386, nios2, c6x, xtensa, openrisc, mips,
> > parisc, x86_64, riscv, sh, sparc64) and 82 different configurations
> > with the help of the 0-day CI guys[3].
> > 
> > What do you think?
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d496496793ff69c4a6b1262a0001eb5cd0a56544
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?h=for-next/kspp&id=d783301058f3d3605f9ad34f0192692ef572d663
> > [3] https://github.com/GustavoARSilva/linux-hardening/blob/master/cii/kernel-ci/kspp-fam0-20200420.md
> > 
> > Thanks
> 
> That patch in -next appears to introduce some warnings with clang when
> CONFIG_UAPI_HEADER_TEST is enabled (allyesconfig/allmodconfig exposed it
> for us with KernelCI [1]):

Indeed, I've tried these conversions before and run into problems like
this, and more. Particularly in userspace these structs also get
embedded in other structs and the warnings explode.

Please drop changes to ib_user_verbs.h from your series

> ./usr/include/rdma/ib_user_verbs.h:436:34: warning: field 'base' with
> variable sized type 'struct ib_uverbs_create_cq_resp' not at the end of
> a struct or class is a GNU extension
> [-Wgnu-variable-sized-type-not-at-end]
>         struct ib_uverbs_create_cq_resp base;
>                                         ^
> ./usr/include/rdma/ib_user_verbs.h:647:34: warning: field 'base' with
> variable sized type 'struct ib_uverbs_create_qp_resp' not at the end of
> a struct or class is a GNU extension
> [-Wgnu-variable-sized-type-not-at-end]
>         struct ib_uverbs_create_qp_resp base;
>                                         ^
> ./usr/include/rdma/ib_user_verbs.h:743:29: warning: field 'base' with
> variable sized type 'struct ib_uverbs_modify_qp' not at the end of a
> struct or class is a GNU extension
> [-Wgnu-variable-sized-type-not-at-end]
>         struct ib_uverbs_modify_qp base;
>                                    ^
> 3 warnings generated.
> 
> I presume this is part of the point of the conversion since you mention
> a compiler warning when the flexible member is not at the end of a
> struct. How should they be fixed? That should probably happen before the
> patch gets merged.

The flexible member IS at the end of the struct and is often intended
to cover the memory in the enclosing struct. I think clang is being
overzealous with its warnings here.

Jason
