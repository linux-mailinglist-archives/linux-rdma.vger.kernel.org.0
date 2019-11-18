Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61AAE100A70
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 18:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfKRRjZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Nov 2019 12:39:25 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:36263 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfKRRjZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Nov 2019 12:39:25 -0500
Received: by mail-il1-f196.google.com with SMTP id s75so16793194ilc.3;
        Mon, 18 Nov 2019 09:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lf4InM0YI2+1aYtMIf2xouOUlZ6aXX0k8Eyyf1Yerfk=;
        b=i4oc0cwOD1lN3zekYlydgd3wVyZj9E5tingr6Ej4w1sYKLdWbVL4/z9VMWRLI48BQd
         +mRdbUPx7rss752LjqQ4PC777H5o2LGZx5zouk3BvLNAbWKBi5GHOxR3vgebH3A0hjRk
         0rZBZF58Xef2ZVLiv9pfqn+5TbSdmAx07ZLZ9trnRlUfmOUy5Jqxb8jiWS/9zgAi4LJQ
         2yOV2dK1/Buzsp42dCx+4uKpcXXOGUdKSnjKJ2u9VHlMP35K5AfMvFFtWdK+mm46FwjI
         JHfWNzAeaiC3TpM8XFign/ZjsBGu2/2d84ld4PkGohxC45GfWWIVxfSyvbxSeLnAggmV
         +X+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lf4InM0YI2+1aYtMIf2xouOUlZ6aXX0k8Eyyf1Yerfk=;
        b=aJTSzCIJ9S8OEAcIFydKET6HejfuN++UPC5TBLUP32EbZz36ye2AvmMqu1aJBTBnec
         jK6du1k8dSA4tWmhb8u2BuoQYvk7sylSEVFqOAO5HsxrtemA++AsJX4RACfZBXEEJ+9f
         NowcKJe4gX5Bi5xUJNh1JhTnMKm1xLBh7qhqw0MEvHfVprPnXsW//07M3MpmZVGNujUq
         rjGSpU4sEMeEDP0UKeqM1/8Jw2AVD76O9oh1ZwiwRfIxzE9wnDYG7dwtpBW/ylO27Mdz
         jiIZH70VAQQQMGJ63STcLrnfHpkUXVeNHi65T6AYmJZv7zEIJR7QUttN0aH3Y5t+uMPG
         LOyw==
X-Gm-Message-State: APjAAAXbIozRrtpM7lO85a5Bjvjjh57prKvWA8ekEJsuLEa2HC8ksUid
        pUrs1vANZGBvQ18IBcV/UEeOCUQXcdSKlyI2/7Y=
X-Google-Smtp-Source: APXvYqwk9HmjMTxp6OUbjx0WTu1hIeTIFANjf/A1CwYoEuiRLsjHHiIfdliSCCJYh57WuvoQkSzW2gxuBlvaVvNqs+Q=
X-Received: by 2002:a92:5cce:: with SMTP id d75mr17291997ilg.299.1574098763980;
 Mon, 18 Nov 2019 09:39:23 -0800 (PST)
MIME-Version: 1.0
References: <20190923190746.10964-1-christophe.jaillet@wanadoo.fr> <20191115210020.GA29581@ziepe.ca>
In-Reply-To: <20191115210020.GA29581@ziepe.ca>
From:   Steve Wise <larrystevenwise@gmail.com>
Date:   Mon, 18 Nov 2019 11:39:12 -0600
Message-ID: <CADmRdJcWrsSWSc9_73+V==zbyxoGUdRMVKzOi6bAwVY+5k+cEQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/iw_cgxb4: Fix an error handling path in 'c4iw_connect()'
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Those horrible error labels in cxgb* are my bad.  :(   I now always
use descriptive labels.

Stevo

On Fri, Nov 15, 2019 at 3:01 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Sep 23, 2019 at 09:07:46PM +0200, Christophe JAILLET wrote:
> > We should jump to fail3 in order to undo the 'xa_insert_irq()' call.
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > Not sure which Fixes tag to use because of the many refactorings in this
> > area. So I've choosen to use none :).
> > The issue was already there in 4a740838bf44c. This commit has renamed
> > all labels because a new fail1 was introduced. I've not searched further.
> >
> > Naming of error labels should be improved. Having nowadays a fail5
> > between fail2 and fail3 (because fail5 was the last
> > error handling path added) is not that readable.
> > However, it goes beyong the purpose of this patch.
> >
> > Maybe, just using a fail2a, just as already done in 9f5a9632e412 (which
> > introduced fail5) would be enough.
> > ---
> >  drivers/infiniband/hw/cxgb4/cm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> The disaster of the error label aside, this does fix the bug, so
> applied to for-next
>
> Thanks,
> Jason
