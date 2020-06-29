Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AFD20D6B3
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2020 22:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgF2TXE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jun 2020 15:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732317AbgF2TW5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Jun 2020 15:22:57 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EEEC03E979
        for <linux-rdma@vger.kernel.org>; Mon, 29 Jun 2020 12:22:57 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id k6so15482723ili.6
        for <linux-rdma@vger.kernel.org>; Mon, 29 Jun 2020 12:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZC/wx6BYtpV6+oS6GfTqmrGOk4Agnx/4t/kFHxFuX1c=;
        b=NB0L9Jf44nLOQXjdxaFB7OESdzE0E3n+5gfJPDxlxaGUKeqHJIw4JnHtoPxOkZUNeE
         gWEztc08nsdEdKiaqewWM4/2PufgbC1umy6eeakNmmavgPmTLiCKf4X+tM/lX1XbtRId
         2kCdgJB9MJNxc2cSUUomhH4Im6NEiCvfnMWKHjtb/uiQa/8KOJDdgFiEInN49oAMo6MU
         YWySRaiPNFREDtLEXC3llONWun8g2Ogf011o5WvX0apbDRX9NDLL3Z+1Xoo00loxQoIl
         nvsuoiEipUgt+X1o1iwJQpgUSsj6912/YjdLCEfWQcqeQtLTQ2NNST3fn9rtbF+/onjG
         81tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZC/wx6BYtpV6+oS6GfTqmrGOk4Agnx/4t/kFHxFuX1c=;
        b=ZbiXL7TymrvtMXspemmuf/C0wz9JpCeiR4NbYKKXr3DKPB8/3daPM6GgLqyHpyW047
         76DqjEpXTcaMngRgaR9A7BP3w1LW7rOPs8n2hlacjiXRev+m9O5T9Hhf1byLc6c7cq8e
         oCAGlcbBnIGCHHEM77mWF0TNLUEw+F4qiT6WXd1F748WmIj3a3thVAhCDK7CLMn//4FN
         d+2AXPPq7j9P4nPKzr82ZdNzO72cz70F2AUl10TevYj9RT7b9UZyoxL8tjLGwyiZrjRf
         3p6Lepkw3L73Z/kNnmXuJ4iDH8JD5c18z42YXF5tcvfVXFBJuXAJuovuZVMx3D0Fm6Gz
         t/XA==
X-Gm-Message-State: AOAM530rRR09y/RpF1XwlUbhVN1jy3hIFEnaiJtLG2VKKMzxmYIQzkYq
        hzqe6jbvXr1SBcfn3Z7d9TNO2w==
X-Google-Smtp-Source: ABdhPJxuDCpQ8zVvVIsoUoXrz64TVB2DcaTHauicCj1HoXP6cKM17Jkd9+9Z4z8u9DYEJQnsfGzlZQ==
X-Received: by 2002:a92:9f0e:: with SMTP id u14mr16629538ili.277.1593458576600;
        Mon, 29 Jun 2020 12:22:56 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id v5sm345230ios.54.2020.06.29.12.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 12:22:55 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jpzMl-001Bxd-0w; Mon, 29 Jun 2020 16:22:55 -0300
Date:   Mon, 29 Jun 2020 16:22:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+a929647172775e335941@syzkaller.appspotmail.com>,
        chuck.lever@oracle.com, Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        parav@mellanox.com, Markus Elfring <Markus.Elfring@web.de>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in addr_handler (2)
Message-ID: <20200629192255.GE25301@ziepe.ca>
References: <000000000000107b4605a7bdce7d@google.com>
 <20200614085321.8740-1-hdanton@sina.com>
 <20200627130205.16900-1-hdanton@sina.com>
 <20200627222527.GC25301@ziepe.ca>
 <CACT4Y+ab1q7fON3rkj+FHODPQXDGyP5c0tJt7gbrpmsAAYRb1g@mail.gmail.com>
 <CACT4Y+Zjw=ru-Sqs-V7cP0Exgu7g0jWBXcPeVKnLqpbkS-wDRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Zjw=ru-Sqs-V7cP0Exgu7g0jWBXcPeVKnLqpbkS-wDRg@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 29, 2020 at 07:27:40PM +0200, Dmitry Vyukov wrote:
> On Mon, Jun 29, 2020 at 4:42 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Sun, Jun 28, 2020 at 12:25 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Sat, Jun 27, 2020 at 09:02:05PM +0800, Hillf Danton wrote:
> > > > > So, to hit this syzkaller one of these must have happened:
> > > > >  1) rdma_addr_cancel() didn't work and the process_one_work() is still
> > > > >     runnable/running
> > > >
> > > > What syzbot reported indicates that the kworker did survive not only
> > > > canceling work but the handler_mutex, despite it's a sync cancel that
> > > > waits for the work to complete.
> > >
> > > The syzbot report doesn't confirm that the cancel work was actaully
> > > called.
> > >
> > > The most likely situation is that it was skipped because of the state
> > > mangling the patch fixes..
> > >
> > > > >  2) The state changed away from RDMA_CM_ADDR_QUERY without doing
> > > > >     rdma_addr_cancel()
> > > >
> > > > The cancel does cover the query state in the reported case, and have
> > > > difficult time working out what's in the patch below preventing the
> > > > work from going across the line the sync cancel draws. That's the
> > > > question we can revisit once there is a reproducer available.
> > >
> > > rdma-cm never seems to get reproducers from syzkaller
> >
> > +syzkaller mailing list
> >
> > Hi Jason,
> >
> > Wonder if there is some systematic issue. Let me double check.
> 
> By scanning bugs at:
> https://syzkaller.appspot.com/upstream
> https://syzkaller.appspot.com/upstream/fixed
> 
> I found a significant number of bugs that I would qualify as "rdma-cm"
> and that have reproducers. Here is an incomplete list (I did not get
> to the end):
> 
> https://syzkaller.appspot.com/bug?id=b8febdb3c7c8c1f1b606fb903cee66b21b2fd02f
> https://syzkaller.appspot.com/bug?id=d5222b3e1659e0aea19df562c79f216515740daa
> https://syzkaller.appspot.com/bug?id=c600e111223ce0a20e5f2fb4e9a4ebdff54d7fa6
> https://syzkaller.appspot.com/bug?id=a9796acbdecc1b2ba927578917755899c63c48af
> https://syzkaller.appspot.com/bug?id=95f89b8fb9fdc42e28ad586e657fea074e4e719b
> https://syzkaller.appspot.com/bug?id=8dc0bcd9dd6ec915ba10b3354740eb420884acaa
> https://syzkaller.appspot.com/bug?id=805ad726feb6910e35088ae7bbe61f4125e573b7
> https://syzkaller.appspot.com/bug?id=56b60fb3340c5995373fe5b8eae9e8722a012fc4
> https://syzkaller.appspot.com/bug?id=38d36d1b26b4299bf964d50af4d79688d39ab960
> https://syzkaller.appspot.com/bug?id=25e00dd59f31783f233185cb60064b0ab645310f
> https://syzkaller.appspot.com/bug?id=2f38d7e5312fdd0acc979c5e26ef2ef8f3370996
> 
> Do you mean some specific subset of bugs by "rdma-cm"? If yes, what is
> that subset?

The race condition bugs never seem to get reproducers, I checked a few
of the above and these are much more deterministic things.

I think the recurrance rate for the races is probably too low?

Jason
