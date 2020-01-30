Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A8314D654
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2020 07:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgA3GGO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jan 2020 01:06:14 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43418 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgA3GGO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jan 2020 01:06:14 -0500
Received: by mail-io1-f66.google.com with SMTP id n21so2635654ioo.10
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jan 2020 22:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrb5RA3mMbj8GzTd6DqnMJj45qiHJLM7VyJR9YOAPHg=;
        b=O6LuJg6KTGFue3ONddhXTVxRmRjOBJcPUjWDvsI9ZsPJWvCQuWjDUnqqJm13SSwsBt
         XhF9soQ2vFSV2Z2lUl8cFF1BNlEMxxhyh/WizNjkBbWafHaQIME3eq8g+DG2bqc/G2fN
         YoCvntELOtZ53CliFb16/C1x/vnOE+Kdkytu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrb5RA3mMbj8GzTd6DqnMJj45qiHJLM7VyJR9YOAPHg=;
        b=iJnyU7aXjvSMZTAekbmlw/FzCxyPea7P/kHJB+WyiTHGPQ0rS1fY2dVU1S0/7Z1ZYP
         +yLu5V5j5/JDxZ9FLosMl7CWJwwYQtSZMrecWBwLozIlmd7U2LaSFUsYSoFsx7v+/dnt
         LbGAAUeiIiUf+o+w+fY4eObCR92T0d0TkRjFFu3IF5Bh64ud7RJAhceKDjsSoD9B17/K
         jueU+IOFBgUGDFutHs1ntDmo02gglLf18RtpnsaFRVTPdLr6cPjVO1qHO3gVAFuTiMjF
         dG8Khzy1HRMElN6XVGIoVUwwCDempSCrnsmFNvPK9Q/Gs4J2pNqC+pUaco5FZVg+GbUd
         eu3A==
X-Gm-Message-State: APjAAAVPDEYpmsDYVOA9ojvh8hkzFSNBwZlkWbnWaxhT3GvLq43DZ4vA
        WBk0V7smxg+xxnE7duv7jT4xP0fXE8PzGZCa3MXmTw==
X-Google-Smtp-Source: APXvYqxEr/6snlI7WyMDQhbOyEpC9uGA5piskfJPwFuIdvAKjrthL4r+e7TAy0S7d2EK41gWmBlF0n+oUlJtzgRWywQ=
X-Received: by 2002:a6b:6604:: with SMTP id a4mr2890031ioc.300.1580364373425;
 Wed, 29 Jan 2020 22:06:13 -0800 (PST)
MIME-Version: 1.0
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-3-git-send-email-devesh.sharma@broadcom.com>
 <20200125180252.GD4616@mellanox.com> <CANjDDBiSLY55v=cA+gMC6QFAqxUxiiFCy3y3_Rw9vF+v40LgDQ@mail.gmail.com>
 <20200128201548.GO21192@mellanox.com>
In-Reply-To: <20200128201548.GO21192@mellanox.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Thu, 30 Jan 2020 11:35:37 +0530
Message-ID: <CANjDDBh8tb26ECCszf1PkJJemZZPOMGqMSdd8h_Do_ytmxT0=A@mail.gmail.com>
Subject: Re: [PATCH for-next 2/7] RDMA/bnxt_re: Replace chip context structure
 with pointer
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 29, 2020 at 1:45 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Mon, Jan 27, 2020 at 01:09:46PM +0530, Devesh Sharma wrote:
> > On Sat, Jan 25, 2020 at 11:33 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > >
> > > On Fri, Jan 24, 2020 at 12:52:40AM -0500, Devesh Sharma wrote:
> > > >  static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
> > > >  {
> > > > +     struct bnxt_qplib_chip_ctx *chip_ctx;
> > > > +
> > > > +     if (!rdev->chip_ctx)
> > > > +             return;
> > > > +     chip_ctx = rdev->chip_ctx;
> > > > +     rdev->chip_ctx = NULL;
> > > >       rdev->rcfw.res = NULL;
> > > >       rdev->qplib_res.cctx = NULL;
> > > > +     kfree(chip_ctx);
> > > >  }
> > >
> > > Are you sure this kfree is late enough? I couldn't deduce if it was
> > > really safe to NULL chip_ctx here.
> > With the current design its okay to free this here because
> > bnxt_re_destroy_chip_ctx is indeed the last deallocation performed
> > before ib_device_dealloc() in any exit path. Further, the call to
> > bnxt_re_destroy_chip_ctx is protected by rtnl.
> > following is the exit sequence anyewere in the driver control path
> > bnxt_re_ib_unreg(rdev); --->> the last deallocation in this func is
> > destroy_chip_ctx().
> > bnxt_re_remove_one(rdev); -->> this is a single line function just to
> > put pci device reference
> > bnxt_re_dev_unreg(rdev); -->> the first deallocation in this func is
> > ib_device_dealloc().
>
> It makes more sense to me to put all the memory deallocation together
> in one place, then there is no concern about ordering.
>
> We now have the dealloc_driver callback for this purpose.
>
> It is not 'last deallocation' that matters, but what all the other
> stuff is doing between destroy_chip_ctx() and ib_device_dealloc()
As far as this series is concerned, driver is saving crashes however
in a nasty way. I would like to move forward with what I have in this
patch and submit a new patch series which would implement your
suggestion.
>
> Jason
