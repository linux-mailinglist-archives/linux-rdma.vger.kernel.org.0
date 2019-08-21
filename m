Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3D19977C3
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 13:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfHULLt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 07:11:49 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42369 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfHULLs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 07:11:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id j7so1642236ota.9
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2019 04:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KMeswQ3ndj8UPy/ggYmoyr6WShZumw7I/g8Uco+crmg=;
        b=WW7L8nAIaSGBQwFT0M1yzt8naz4f2omN5WYG5xOQIu7Ay1JmfOReytmh1bib2raYF0
         /rEC8GLKto/luAQxGFJuu6emfsZSzXOfvYPsWK8h0Yd82KqIa383j6bbVNjSEhgHW6oJ
         mSqo2Zty0bYGk6+jXBYow1hGnumXSA29x0gWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMeswQ3ndj8UPy/ggYmoyr6WShZumw7I/g8Uco+crmg=;
        b=myCjFG2xdai2w9gGrBG92uZi2eZU5YLbwkdgZ1IdwhgQrdWg9codWhsEC7rdpvM/Vi
         +baU1ykWDrigPkCQ9hjJgWf4RMPgoDFpYgEgzGJr/TjMbWnOy+3MEo+KfneGDUNW4CrK
         /ARwxZj1Emm8+TfNi/ET/Jj9DMutYYXvgzUlqdiYJuDpd8I+py5jCSQi9TcXyxyd5J3l
         YJ/EEfx64wfAynHlGGkNyD1AaPWl+CczXZaJxqKwXnd38hc7LOM2n8/vfB+6KtMpHnBY
         uvkJLWT/i7q/eVS8R09jBM5YhYOTQIGBBdT2Q2M0HsFrj+lnx54AlMt0sIdS5LFaFoQC
         da4A==
X-Gm-Message-State: APjAAAU87QgsH0iit7Fm3VUbn4+G0PSqa3fFK68h/GH0QbNPoMr3vGyF
        VFx9QNWgxCzVPoCFXHFIJB7aQTN5yJ+fxXV9Tszh5A==
X-Google-Smtp-Source: APXvYqxIbVzAIDxeLYt1NanX7CH6AqyuoWs1jlcoMXxXryL+BcfsTbBhR6yRpb0e2EpBbBUk5gVAZbjms/L5g+t6ht0=
X-Received: by 2002:a9d:198c:: with SMTP id k12mr25936486otk.154.1566385907648;
 Wed, 21 Aug 2019 04:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <1565869477-19306-1-git-send-email-selvin.xavier@broadcom.com>
 <20190815130740.GE21596@ziepe.ca> <CA+sbYW3t2=bCpYjkuNQeT3LSFcL9n9=awHYpSrB6VZBna4dWhg@mail.gmail.com>
 <20190816120023.GA5398@ziepe.ca> <CA+sbYW01BgPXyK3mOi_yCNj4=6Z8AuH89-0A_RB5E-AXX+L2cg@mail.gmail.com>
 <bffdcce391aa895fead64a63d86e9857f5da9694.camel@redhat.com>
In-Reply-To: <bffdcce391aa895fead64a63d86e9857f5da9694.camel@redhat.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Wed, 21 Aug 2019 16:41:36 +0530
Message-ID: <CA+sbYW2yozotYTVHZ6q0UgQh24RzrgarXdk=3PsffK4m=TQXww@mail.gmail.com>
Subject: Re: [PATCH for-rc] RDMA/bnxt_re: Fix stack-out-of-bounds in bnxt_qplib_rcfw_send_message
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 20, 2019 at 10:43 PM Doug Ledford <dledford@redhat.com> wrote:
>
> On Mon, 2019-08-19 at 13:42 +0530, Selvin Xavier wrote:
> > On Fri, Aug 16, 2019 at 5:30 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > On Fri, Aug 16, 2019 at 10:22:25AM +0530, Selvin Xavier wrote:
> > > > On Thu, Aug 15, 2019 at 6:37 PM Jason Gunthorpe <jgg@ziepe.ca>
> > > > wrote:
> > > > > On Thu, Aug 15, 2019 at 04:44:37AM -0700, Selvin Xavier wrote:
> > > > > > @@ -583,7 +584,7 @@ int bnxt_qplib_create_srq(struct
> > > > > > bnxt_qplib_res *res,
> > > > > >       req.eventq_id = cpu_to_le16(srq->eventq_hw_ring_id);
> > > > > >
> > > > > >       rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
> > > > > > -                                       (void *)&resp, NULL,
> > > > > > 0);
> > > > > > +                                       (void *)&resp,
> > > > > > sizeof(req), NULL, 0);
> > > > >
> > > > > I really don't like seeing casts to void * in code. Why can't
> > > > > you
> > > > > properly embed the header in the structs??
> > > > Is your objection only in casting to void * or you dont like any
> > > > casting here?
> > >
> > > Explicit cast to void to erase the type is a particularly bad habit
> > > that I don't like to see.
> > >
> > > You'd be better to make the send_message accept void * and the cast
> > > inside to the header.
> > >
> > Ok. Will make this change. But this looks like a for-next item..
> > right?
> > If so, can you take this patch as is for RC? I will post the change
> > mentioned for for-next separately.
>
> This patch is a lot of lines of churn.  What creating an array of sizes
> such that you could use the cmd value as an index into the array.  Then
> you'd only need to modify a header file to define the array, and the
> send function to lookup the length of the command based upon the command
> value itself.  Far fewer lines of churn, especially if you are possibly
> going to replace this fix in for-next.
Ok. I will work on an optimized solution for this and post it.
Thanks,

>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
