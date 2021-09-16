Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063A140DD99
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 17:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhIPPKN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 11:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbhIPPKN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Sep 2021 11:10:13 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1462C061574
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 08:08:52 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t1so6442540pgv.3
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WJkNM/xMmKX6sPuM9GYihXmKT4k9g9uXLWNaRS8FvpY=;
        b=Lpii0tXvNXhCFogtIrCW7tJj37+9qjyt5pZfAVGGVDyD7jVBrHlezlF5Hnp6j9NJqP
         LvIZ6Z+THH/B+6jAqOhNj+vtAdQsDedafZwuzZ08S2Vwmykts7+rJ9nsyIkO+wvc/MKc
         iBB3KpZvafauK3Hr2Kov+izg925MtgPew/XuzUm2KDmWNSfiCN3++llYB9RZoS/frZFN
         I3DFLGuR77lDnkxc8pCFoxv0KkG0j507w++LqxSN1L9Jmd71rXUvIJb6bLYKQ9CF+tFh
         MQ5uZJFUYu9RZ/d5OzMHY0WNuGBKbUXvOW/K66FDx41If/LghN9dzBKB63MTslJ0D4YF
         HO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WJkNM/xMmKX6sPuM9GYihXmKT4k9g9uXLWNaRS8FvpY=;
        b=ZhWueSbo1i/Z2mpFD2qldpMF14OM6QU8NnVY0AsTbIv5GDHFbF3yA/JFWHUUMIKSlo
         t/I+neU0Zwl5PbTXQuFTtMt6RTchrJ24cqFg0bbSLKpUl9PoAM78CnF8KywX5romGMHj
         N7k8Tj8ZvFTjSfzpPHph3QjQxEPe3Gf9VKHx3eT7ecvJGKju5VNgeKoFL8erk+D+MqzS
         9gxnCWXk+LwRNxgovxPZYTyKzrFEQqt8upiIyH+MenoOHp0kr2LAgwFYl5BVLDIePkgC
         uVehVZTWqOm4cj73h9hhQ6nUYV+mbJEc675d4TdJJX2CHix5ovROpmuWDVBNmiUiuHRZ
         j1HA==
X-Gm-Message-State: AOAM532fqUz/oAGJcihlz1eNUiw4594AGrGb15n0/mhAGT+XUkPuRt6f
        UfceWc/VmL5BQeRabuPnpMn12g==
X-Google-Smtp-Source: ABdhPJz9s4X2hqqgVh5+wNVkI9McM26vR77EykgQ5qDe32ykmFwS/lAJFbopVaug6VSGX/wwGwmJLw==
X-Received: by 2002:a63:3449:: with SMTP id b70mr5372824pga.315.1631804932296;
        Thu, 16 Sep 2021 08:08:52 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id a71sm3496584pfd.86.2021.09.16.08.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 08:08:51 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mQt0M-001mZM-6a; Thu, 16 Sep 2021 12:08:50 -0300
Date:   Thu, 16 Sep 2021 12:08:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com>,
        dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Aleksandr Nogikh <nogikh@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in addr_handler (4)
Message-ID: <20210916150850.GN3544071@ziepe.ca>
References: <000000000000ffdae005cc08037e@google.com>
 <20210915193601.GI3544071@ziepe.ca>
 <CACT4Y+bxDuLggCzkLAchrGkKQxC2v4bhc01ciBg+oc17q2=HHw@mail.gmail.com>
 <20210916130459.GJ3544071@ziepe.ca>
 <CACT4Y+aUFbj3_+iBpeP2qrQ=RbGrssr0-6EZv1nx73at7fdbfA@mail.gmail.com>
 <CACT4Y+ZrQL3n=N2GOfJ6vLNW2_4MdiwywXvZpQ=as_NbJ8PXjw@mail.gmail.com>
 <CACT4Y+ZrXft1cMg0X48TrvbLj0moCb5nyWs1HG0WAZkpKmiBaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZrXft1cMg0X48TrvbLj0moCb5nyWs1HG0WAZkpKmiBaA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 16, 2021 at 04:55:16PM +0200, Dmitry Vyukov wrote:

> > I noticed we also had 2 KCSAN reports that mention rdma_resolve_addr.
> >
> > On commit 1df0d896:
> > ==================================================================
> > BUG: KCSAN: data-race in addr_handler / cma_check_port
> >
> > write to 0xffff88809fa40a1c of 4 bytes by task 21 on cpu 1:
> >  cma_comp_exch drivers/infiniband/core/cma.c:426 [inline]
> >  addr_handler+0x9f/0x2b0 drivers/infiniband/core/cma.c:3141
> >  process_one_req+0x22f/0x300 drivers/infiniband/core/addr.c:645
> >  process_one_work+0x3e1/0x9a0 kernel/workqueue.c:2269
> >  worker_thread+0x665/0xbe0 kernel/workqueue.c:2415
> >  kthread+0x20d/0x230 kernel/kthread.c:291
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
> >
> > read to 0xffff88809fa40a1c of 4 bytes by task 11997 on cpu 0:
> >  cma_check_port+0xbd/0x700 drivers/infiniband/core/cma.c:3506

This has since been fixed, cma_check_port() no longer reads state

> > and on commit 5863cc79:

I can't find this commit? Current rdma_resolve_addr should not trigger
this KCSAN.

> This does not immediately explain the use-after-free for me, but these
> races suggest that everything is not protected by a single mutex and
> that there may be some surprising interleavings.
> E.g. rdma_resolve_addr checks status, and then conditionally executes
> cma_bind_addr, but the status can change concurrently.

It is true, they weren't, however I've fixed them all. These hits look
like they all from before it got fixed up..

Jason
