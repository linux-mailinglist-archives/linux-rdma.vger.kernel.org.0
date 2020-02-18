Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A66B16217B
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 08:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgBRHXq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 02:23:46 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44301 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgBRHXp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 02:23:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id h9so18553472otj.11
        for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2020 23:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvMrWZCZLlG0TPKZ0muMD4fk+ec1v06BBMU7xt+XZAg=;
        b=NpNytwFDAA1aBsf3JlyHbVT87sKn157MLWLeWmTvWGFBTUBR2OSuSgWU/HLi2Wbu/J
         esM5DpiIIZI8XAB5Uea7fs+000FSlHrTR83F3kHbMr0mJl8ypZFzm1oaP19nteuXcHSj
         IstY2tPKyijECPCYjhTUY6+Hw7gCg2vLJPSsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvMrWZCZLlG0TPKZ0muMD4fk+ec1v06BBMU7xt+XZAg=;
        b=RQvwTiLitvsrIj+XsCIUDEzswHfQF+tZ11L+456wwJ18UcMeMsap3eTqz7rJg6pS8/
         nzT2PS84cyCIf+lvMyvNY2eY3slWPYnh1mZOXLUw/M3o+58ehIT79WsdQettDv5bIPzg
         qBCsQ0146sfinVX28ZLwFtA/ucPp2IxMGeAAHAT5ML+eeLP8dSoZqZrgRzM7/KCrz+4/
         9JLTitCSCoElMMgKjj8CjAIAO0PUUTj+2f3of2AQAEA+Nm9w//VmRnzeeAD0ZVGIkhFs
         0n4qHTUIA4ic5JZLpLzoSywsJa0RB8cuPjIE6fdPiCaKkh0UuJ+TcUwT5aWLTxiT1/rA
         o23A==
X-Gm-Message-State: APjAAAWp7/8i8/fnX00mQyKAntUjo5bi9jeD2wIzX0Ksa82wgsTfWPa8
        Ef63xgN2oKwjsrDm9MfBPxZHt6Bat602rPewkh/wH8DmTW4=
X-Google-Smtp-Source: APXvYqxSnJRUAmyEWB6qgJ++ZDbo0zvTc9r8oooHqEtD0bNkQ9NC+lVKJmcj3OyTqJq3iC+GqJIeXooMC0uZjBLQUpU=
X-Received: by 2002:a9d:7511:: with SMTP id r17mr13427496otk.154.1582010625091;
 Mon, 17 Feb 2020 23:23:45 -0800 (PST)
MIME-Version: 1.0
References: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
 <1574671174-5064-5-git-send-email-selvin.xavier@broadcom.com> <20200103193612.GA16566@ziepe.ca>
In-Reply-To: <20200103193612.GA16566@ziepe.ca>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Tue, 18 Feb 2020 12:53:33 +0530
Message-ID: <CA+sbYW1TBnVC9uRNNwQhQgv9PCjd0w7Bf05M-u9dNJyHC5oUKQ@mail.gmail.com>
Subject: Re: [PATCH for-next 4/6] RDMA/bnxt_re: Refactor device add/remove functionalities
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jan 4, 2020 at 1:06 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Nov 25, 2019 at 12:39:32AM -0800, Selvin Xavier wrote:
> >  - bnxt_re_ib_reg() handles two main functionalities - initializing
> >    the device and registering with the IB stack.  Split it into 2
> >    functions i.e. bnxt_re_dev_init() and bnxt_re_ib_init()  to account
> >    for the same thereby improve modularity. Do the same for
> >    bnxt_re_ib_unreg()i.e. split into two functions - bnxt_re_dev_uninit()
> >    and  bnxt_re_ib_uninit().
> >  - Simplify the code by combining the different steps to add and
> >    remove the device into two functions.
> >
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> >  drivers/infiniband/hw/bnxt_re/main.c | 133 ++++++++++++++++++++---------------
> >  1 file changed, 78 insertions(+), 55 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> > index fbe3192..0cf38a4 100644
> > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > @@ -78,7 +78,8 @@ static struct list_head bnxt_re_dev_list = LIST_HEAD_INIT(bnxt_re_dev_list);
> >  /* Mutex to protect the list of bnxt_re devices added */
> >  static DEFINE_MUTEX(bnxt_re_dev_lock);
> >  static struct workqueue_struct *bnxt_re_wq;
> > -static void bnxt_re_ib_unreg(struct bnxt_re_dev *rdev);
> > +static void bnxt_re_remove_device(struct bnxt_re_dev *rdev);
> > +static void bnxt_re_ib_uninit(struct bnxt_re_dev *rdev);
> >
> >  static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
> >  {
> > @@ -222,7 +223,9 @@ static void bnxt_re_shutdown(void *p)
> >       if (!rdev)
> >               return;
> >
> > -     bnxt_re_ib_unreg(rdev);
> > +     bnxt_re_ib_uninit(rdev);
> > +     /* rtnl_lock held by L2 before coming here */
> > +     bnxt_re_remove_device(rdev);
>
> Is this a warning that RTNL is held, or a note that is is required? If
> it is the latter then plen use ASSERT_RTNL instead of a comment
>
It was intended as a note. I will replace this with the ASSERT_RTNL.
Thanks
> Jason
