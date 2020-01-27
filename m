Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C826514A2DB
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2020 12:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgA0LRx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jan 2020 06:17:53 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38923 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgA0LRx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jan 2020 06:17:53 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so9515382ioh.6
        for <linux-rdma@vger.kernel.org>; Mon, 27 Jan 2020 03:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kSnlbipL2vRTTGYLBNKgvgTvdf9FMGOMX4ksFQgHARU=;
        b=HPAVzDIcTqXucFHc+3+G4zPbzTu+ha7R31Zb95LA5CiMrYMYYNDEOZCzVy6KRjxO+o
         Ol528pRTvy0yxGHx+NZRUBlM9rBKn7ss1hpznJcqNBguHz8gPG0RPMxe1We2dGtV83wA
         mU7VTlJKY1nsRdsQjYxOlr0Uq2Ghsr0EHNlu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kSnlbipL2vRTTGYLBNKgvgTvdf9FMGOMX4ksFQgHARU=;
        b=OScKDzZ789+FIQkVH5diAbaFyyYMDLIKm5zTJHbVozKsf3q2Px5cXqOte6SRaEnzVc
         E2cj4YMw7Aeu6x3cqbZLYzQ4o3qQlWVK8pGLSx4nVbhHlTIGerJTtJD2nYGuT6aLkL1t
         sHbvUMBw2eGlFz3GzdYW69AIW9eGMF5pTV2LKrvlmbjLNobWHt6YM6XwZQINJYxpvDM5
         HQqbWwhm9CiMiGuMQwyoc79VdzxQtNb5vZya6OlxSUQ/f3CP4BlNoNu0BiT729+CrmiI
         hxrNyjvhIJ9PzDAzqkyTSxupLj+JmfizW0n6f1N3W8a07axO06Z4uG4OKUoW3Cu2nWaa
         Nw4g==
X-Gm-Message-State: APjAAAXLXx0KpkmfpnPVf6B2DvDvtAREFj7+ZpUauV3JS5XHEPdoogRv
        +Pu5b+UAiKS43LZsjFzdu0m9sv+KBMaTmOCuxDXUQg==
X-Google-Smtp-Source: APXvYqybCKPon26hn7gsp8fh/2SoEePfMS8QDadJ0bXyxYYD579koUPggUTrK0UT8FV9gzVVeIESEZIVA9XyR9pviZI=
X-Received: by 2002:a5d:8908:: with SMTP id b8mr6152088ion.89.1580123872537;
 Mon, 27 Jan 2020 03:17:52 -0800 (PST)
MIME-Version: 1.0
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-3-git-send-email-devesh.sharma@broadcom.com>
 <20200125180252.GD4616@mellanox.com> <CANjDDBiSLY55v=cA+gMC6QFAqxUxiiFCy3y3_Rw9vF+v40LgDQ@mail.gmail.com>
 <20200127080440.GL3870@unreal>
In-Reply-To: <20200127080440.GL3870@unreal>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Mon, 27 Jan 2020 16:47:16 +0530
Message-ID: <CANjDDBheoju7MLg+maHzEvVL3Ap70DT3W3ZrcXbSiiz-fVkTGQ@mail.gmail.com>
Subject: Re: [PATCH for-next 2/7] RDMA/bnxt_re: Replace chip context structure
 with pointer
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 27, 2020 at 1:34 PM Leon Romanovsky <leon@kernel.org> wrote:
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
>
> ??? Why does device destroy path need global lock to already existing
> protection from ib_core?
Oh! probably I confused you, What I meant to say was exit path is
executed under netdev-notifier context which already holds the lock.
RoCE driver is not taking that lock explicitly.
>
> Thanks
