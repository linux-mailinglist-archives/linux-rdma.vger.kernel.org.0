Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCE440DAA0
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 15:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbhIPNGW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 09:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239805AbhIPNGW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Sep 2021 09:06:22 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA05C061764
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 06:05:01 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id cf2so4012229qvb.10
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 06:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=acPxGanWudVp0KiXHdjtVTDLfzNEsbUYMSqmQk92sDI=;
        b=BqSjPT7X1NzzdHsX8YIObaF7E3kv9ttGWXhE/fKF8+/SvXJmsRT3sVeBJ5loU/NEk5
         tHTgHEFmuVAGxxQfkVXVbvvAgxxPDrtkPgdc/i1e871vE2JFhiY8AjQLUhlADU7zDY+l
         AwneVt4STcQs7miWFgJ/7sZaylwFoRBKc0KCUzsp+wmGjk9ZfbF1iSFUaKYXAOao0/5o
         qFtMNtOf1oH+ZBVuj2SlES7EEdBPFotKIJKkfK941TYw6ZuiCgPRJxdDFXOBpxWFgDHm
         6k6Mq64k36gK/cuDtlhvLY7sz/29XDjRwhTVxlaaKYxU7poxfKeBNLB/1ra/SiW0RVMA
         adhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=acPxGanWudVp0KiXHdjtVTDLfzNEsbUYMSqmQk92sDI=;
        b=O3hBPAroQeKoANLcgc70xY3nKFmKO+9mBLy4j77kVyKJO7PQvtLfrpVRiwhINErQlY
         Lx8MFOyPHgKWbF3OVi1qwbW3ECj43bv7Re0AA10lIDNyqtddMNR+BJaAXqy04awEYZzp
         jA9uy1LGAXKuDxFc1QtLHp9FhHIrbVyqhIj3QnAih3UL/xJKkvxXJKf4wqbYT/Gc25vn
         wRb+IhHsfX2BPCMSIXxlyqZM5aPkDKZ/qDKM8+E3+FG3DA6Upk50uOfqnVB8nTcycdl6
         1PgqMv2OGH41QF7AQbEe5433C51t9RYOLy7W6TzbE0qK31EJckvJGwuRsnNcq1AfmXzx
         xz7Q==
X-Gm-Message-State: AOAM532mfNPpEDNBRKak2z3MXjOctAZ8mM5igkLGTEL/PWc5bgGsogrG
        X/Ed7tj+l5EUGfMK9Y+a7Nm1BQ==
X-Google-Smtp-Source: ABdhPJwGR/9rt1lMFSmo/fGCtn7y0alVkwxO63R7/ik+cH+HR/fyXg+bbMT6Ll22OSbvRsdIhIoowA==
X-Received: by 2002:a0c:be85:: with SMTP id n5mr5081009qvi.59.1631797500834;
        Thu, 16 Sep 2021 06:05:00 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id h17sm1964816qtu.68.2021.09.16.06.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 06:05:00 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mQr4V-001Me8-4O; Thu, 16 Sep 2021 10:04:59 -0300
Date:   Thu, 16 Sep 2021 10:04:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com>,
        dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in addr_handler (4)
Message-ID: <20210916130459.GJ3544071@ziepe.ca>
References: <000000000000ffdae005cc08037e@google.com>
 <20210915193601.GI3544071@ziepe.ca>
 <CACT4Y+bxDuLggCzkLAchrGkKQxC2v4bhc01ciBg+oc17q2=HHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bxDuLggCzkLAchrGkKQxC2v4bhc01ciBg+oc17q2=HHw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 16, 2021 at 09:43:19AM +0200, Dmitry Vyukov wrote:
> On Wed, 15 Sept 2021 at 21:36, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Sep 15, 2021 at 05:41:22AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    926de8c4326c Merge tag 'acpi-5.15-rc1-3' of git://git.kern..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=11fd67ed300000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=37df9ef5660a8387
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=dc3dfba010d7671e05f5
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com
> >
> > #syz dup: KASAN: use-after-free Write in addr_resolve (2)
> >
> > Frankly, I still can't figure out how this is happening
> >
> > RDMA_USER_CM_CMD_RESOLVE_IP triggers a background work and
> > RDMA_USER_CM_CMD_DESTROY_ID triggers destruction of the memory the
> > work touches.
> >
> > rdma_addr_cancel() is supposed to ensure that the work isn't and won't
> > run.
> >
> > So to hit this we have to either not call rdma_addr_cancel() when it
> > is need, or rdma_addr_cancel() has to be broken and continue to allow
> > the work.
> >
> > I could find nothing along either path, though rdma_addr_cancel()
> > relies on some complicated properties of the workqueues I'm not
> > entirely positive about.
> 
> I stared at the code, but it's too complex to grasp it all entirely.
> There are definitely lots of tricky concurrent state transitions and
> potential for unexpected interleavings. My bet would be on some tricky
> hard-to-trigger thread interleaving.

From a uapi perspective the entire thing is serialized with a mutex..

> The only thing I can think of is adding more WARNINGs to the code to
> check more of these assumptions. But I don't know if there are any
> useful testable assumptions...

Do you have any idea why we can't get a reproduction out of syzkaller
here? 

I feel less comfortable with syzkaller's debug output, can you give
some idea what it might be doing concurrently?

Jason
