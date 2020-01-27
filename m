Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73FD7149F46
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2020 08:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgA0HkM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jan 2020 02:40:12 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34119 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgA0HkM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jan 2020 02:40:12 -0500
Received: by mail-io1-f65.google.com with SMTP id z193so8899695iof.1
        for <linux-rdma@vger.kernel.org>; Sun, 26 Jan 2020 23:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iVv+rmDnpWUWrjFcIUQRfKvM0cPVHhEabRBImifFxWI=;
        b=CfjdH+yM41fvurI79ezvoI9QuEORYmiSL3HIFgMa4z58ksLMy4qujabvs/ZXkEe0Mf
         qUuWcdla6uzqmmD8iwDvEaXIKYl9anzQC++9A3onwZ84BijDTgFJAGhHaV5dFBlIMrrL
         9gon+0qYpZ8+S7ZD2K34X/fxG68lAa/bWJQ5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iVv+rmDnpWUWrjFcIUQRfKvM0cPVHhEabRBImifFxWI=;
        b=MCSyVyN06TcDHK7NfWysv1JdE3DlnY2BeaP02AKKNmErEjs42Tmub0NH6T5MhKg2TE
         0pwNMTxngZJoRkaPfj29F7vXJLaG6FPFhqgoMQrnQVSdyqrKOaVsX1pxhLp1GQvjI0cs
         fTOs1LrQEnxqV1XasezFIHKsJiZebwnhrNHf14FkYXYcFx7OAUMWMgkphoaepfqyOCKx
         BdjaksKhNLYp8SbdKovxPTfURgtrHyhDt5jAmtmqTJ7cszR+THaBkcdODNovABY9qfM2
         y5rqVcC3wJ/AtsuOvlIZuCk1ZY+EAU36N+UnC5nDdtkmhkq9JYVpVVV70MslZ2BRKium
         TWNQ==
X-Gm-Message-State: APjAAAUBtT3PDuQ6Uo1+tBRK0/5D79xfICrwq35Zp2uVsn7J7bZ9qlxZ
        AwX6T932Oc7LYZchWyVYlqQ3Ydn2Nh4prhfHKq8l1g==
X-Google-Smtp-Source: APXvYqzXlYJFq7qktHAJgcMe4eEA1z5aLsjsDpx94HDgtUfmhUlBCCTsWGNH7NCgoxFkvP/3HJxAoANY6ag9mn6JqxU=
X-Received: by 2002:a5d:93d1:: with SMTP id j17mr12008893ioo.300.1580110811477;
 Sun, 26 Jan 2020 23:40:11 -0800 (PST)
MIME-Version: 1.0
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-2-git-send-email-devesh.sharma@broadcom.com>
 <20200124112347.GA35595@unreal> <CANjDDBjJygjcbbwDFtwVS--GF5YtYAiZL78_jiqHf+TMkQ7j+g@mail.gmail.com>
 <20200125185045.GB2993@unreal>
In-Reply-To: <20200125185045.GB2993@unreal>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Mon, 27 Jan 2020 13:09:35 +0530
Message-ID: <CANjDDBh=v2xzx42uX+VkBstBdeBptDrL0wMg2UgL6nUigd3qmA@mail.gmail.com>
Subject: Re: [PATCH for-next 1/7] RDMA/bnxt_re: Refactor queue pair creation code
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 26, 2020 at 12:20 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Sat, Jan 25, 2020 at 10:33:41PM +0530, Devesh Sharma wrote:
> > On Fri, Jan 24, 2020 at 4:53 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Fri, Jan 24, 2020 at 12:52:39AM -0500, Devesh Sharma wrote:
> > > > Restructuring the bnxt_re_create_qp function. Listing below
> > > > the major changes:
> > > >  --Monolithic central part of create_qp where attributes are
> > > >    initialized is now enclosed in one function and this new
> > > >    function has few more sub-functions.
> > > >  --Top level qp limit checking code moved to a function.
> > > >  --GSI QP creation and GSI Shadow qp creation code is handled
> > > >    in a sub function.
> > > >
> > > > Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
> > > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > > Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> > > > ---
> > > >  drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  13 +-
> > > >  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 635 ++++++++++++++++++++-----------
> > > >  drivers/infiniband/hw/bnxt_re/main.c     |   3 +-
> > > >  3 files changed, 434 insertions(+), 217 deletions(-)
> > > >
> > >
> > > Please remove dev_err/dev_dbg/dev_* prints from the driver code.
> > Sure I can do that, are you suggesting to add one more patch in this series?
> > I guess it should be okay to follow the hw/efa way to  have debug msgs still on.
>
> It is ok to use ibdev_* prints, it is not ok to use dev_* prints.
Okay, I will add a new patch to this series
>
> Thanks
>
> > >
> > >
> > > Thanks
