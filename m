Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87AFD98FE5
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 11:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbfHVJmv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 05:42:51 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35289 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbfHVJmu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Aug 2019 05:42:50 -0400
Received: by mail-oi1-f193.google.com with SMTP id a127so3892837oii.2
        for <linux-rdma@vger.kernel.org>; Thu, 22 Aug 2019 02:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sNS+hvO1EObJpEGnmn3R5eOojILZzhJfJtiDYA4GWWM=;
        b=gTTFnthTCvtXLkVoWttv39LZ7bhs25w6Y/X3FhTkSCxgW9BQd4OkgROSDszkfmkulX
         n5X77XqQ8IzrlniA0XE7Prdm4yE5au9VfpE5A6DKBGj2IXs5oAKORA33V37af9LLLatE
         ovOmQfomTYxGSmtRjziGC6Hm77M8yL0jVHh2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sNS+hvO1EObJpEGnmn3R5eOojILZzhJfJtiDYA4GWWM=;
        b=QnA1hfmmZwBv/P7rVgP4LEFa68QThR8ALGZKfVqZob8SBa/7xiovt0eCfPf/ejBMKd
         D+iJds/u9SgLiiydrBPW+bg/nbZpY91i8CYAwWBlpiSsg3s2BUH6kzQJx+zHocBIUH6T
         bEeqXTVTQ7HXXoloOEK3q/hGwctOYHujXBI8LZvJg1dtXShHLNqdgNyx4EXHe+nFxoDH
         N/Qyo/86c8dUhRM90cpAjPOd394t+z+ipiHAqlOPQ8/SCCMIGLOTgqSwf57O8kc4I01+
         Q/GUADXRPyWhJwiHOqbYiT7iV1OPm550t31+5PGNVR3Z2bKiznncEimFAokeZU764/gn
         en6A==
X-Gm-Message-State: APjAAAWV21yQ/c2oGs6RlOVEcm60jka/Ry8ZrTm/9EgR7G/YhwIBHVpF
        86TW3TtQb+4kYJdv6BJZCKkENJDlQ3gBw59EnT7XQ0GjzeWgxw==
X-Google-Smtp-Source: APXvYqxNzOIPYV5uiFLpGa/SLoz8HlY3OtV31ZwVe95W7kRrPwDp0+7ic+BHaBdnf7xeSb4eqv65Q4gn+qzC8WuQ2fo=
X-Received: by 2002:a05:6808:1d5:: with SMTP id x21mr3087080oic.94.1566466970128;
 Thu, 22 Aug 2019 02:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <1565869477-19306-1-git-send-email-selvin.xavier@broadcom.com>
 <20190815130740.GE21596@ziepe.ca> <CA+sbYW3t2=bCpYjkuNQeT3LSFcL9n9=awHYpSrB6VZBna4dWhg@mail.gmail.com>
 <20190816120023.GA5398@ziepe.ca> <CA+sbYW01BgPXyK3mOi_yCNj4=6Z8AuH89-0A_RB5E-AXX+L2cg@mail.gmail.com>
 <bffdcce391aa895fead64a63d86e9857f5da9694.camel@redhat.com> <CA+sbYW2yozotYTVHZ6q0UgQh24RzrgarXdk=3PsffK4m=TQXww@mail.gmail.com>
In-Reply-To: <CA+sbYW2yozotYTVHZ6q0UgQh24RzrgarXdk=3PsffK4m=TQXww@mail.gmail.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Thu, 22 Aug 2019 15:12:38 +0530
Message-ID: <CA+sbYW0cOMzJZyP-X257m4voA1B2OuxXYRr-DnXBh6YVNRZ2+Q@mail.gmail.com>
Subject: Re: [PATCH for-rc] RDMA/bnxt_re: Fix stack-out-of-bounds in bnxt_qplib_rcfw_send_message
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 4:41 PM Selvin Xavier
<selvin.xavier@broadcom.com> wrote:
>
> On Tue, Aug 20, 2019 at 10:43 PM Doug Ledford <dledford@redhat.com> wrote:
> >
> > On Mon, 2019-08-19 at 13:42 +0530, Selvin Xavier wrote:
> > > On Fri, Aug 16, 2019 at 5:30 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > On Fri, Aug 16, 2019 at 10:22:25AM +0530, Selvin Xavier wrote:
> > > > > On Thu, Aug 15, 2019 at 6:37 PM Jason Gunthorpe <jgg@ziepe.ca>
> > > > > wrote:
> > > > > > On Thu, Aug 15, 2019 at 04:44:37AM -0700, Selvin Xavier wrote:
> > > > > > > @@ -583,7 +584,7 @@ int bnxt_qplib_create_srq(struct
> > > > > > > bnxt_qplib_res *res,
> > > > > > >       req.eventq_id = cpu_to_le16(srq->eventq_hw_ring_id);
> > > > > > >
> > > > > > >       rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
> > > > > > > -                                       (void *)&resp, NULL,
> > > > > > > 0);
> > > > > > > +                                       (void *)&resp,
> > > > > > > sizeof(req), NULL, 0);
> > > > > >
> > > > > > I really don't like seeing casts to void * in code. Why can't
> > > > > > you
> > > > > > properly embed the header in the structs??
> > > > > Is your objection only in casting to void * or you dont like any
> > > > > casting here?
> > > >
> > > > Explicit cast to void to erase the type is a particularly bad habit
> > > > that I don't like to see.
> > > >
> > > > You'd be better to make the send_message accept void * and the cast
> > > > inside to the header.
> > > >
> > > Ok. Will make this change. But this looks like a for-next item..
> > > right?
> > > If so, can you take this patch as is for RC? I will post the change
> > > mentioned for for-next separately.
> >
> > This patch is a lot of lines of churn.  What creating an array of sizes
> > such that you could use the cmd value as an index into the array.  Then
> > you'd only need to modify a header file to define the array, and the
> > send function to lookup the length of the command based upon the command
> > value itself.  Far fewer lines of churn, especially if you are possibly
> > going to replace this fix in for-next.
> Ok. I will work on an optimized solution for this and post it.
> Thanks,
>
Doug,
Instead of using an arrary to handle this,  I am posting a patch which
is taking the
exact command size in the structure passed to
bnxt_qplib_rcfw_send_message. Before
sending the command to FW, we will modify the value to the way FW expects.

Thanks,
Selvin
