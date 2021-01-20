Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BA82FD33D
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 15:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388367AbhATOwH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jan 2021 09:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733276AbhATOpj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Jan 2021 09:45:39 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E55BC0613C1
        for <linux-rdma@vger.kernel.org>; Wed, 20 Jan 2021 06:44:59 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id d1so3057755otl.13
        for <linux-rdma@vger.kernel.org>; Wed, 20 Jan 2021 06:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KjbJ8BCMiI4gj1kbqIoMnXoMG7ObkiarPXWS0k+9RN4=;
        b=OOT6BOrmy4VptfEVr5A8piAU7lVp6hy+zBs3Pby7+3FCikj2BXZhL7B6uSN+Di6OHz
         9Ozqnok3yTErdHOvYmqAKMFMCRMymg4laFQW+D3uePnplejhZ8r91NrJ416IMaFLtAQW
         Qsj/X6HkNn//TsXTlEUQVogTimEdmW1bZoZyUAKoSvF+hWzSVybOBkPh+YjI+3Y1ioAB
         MhnOhy9ayg0u/3UIB2NsZtvQqhp39MoUTV3aFjJJBX4Av57WB2+DIpQ+Nqz/xpjIjH81
         0JGjGsnD+xJPovPw2M73sT02+rwhzJf1Zs0GObUyX3hh7ImIhvVQ6tcD1OQJgOTpDxjM
         IGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KjbJ8BCMiI4gj1kbqIoMnXoMG7ObkiarPXWS0k+9RN4=;
        b=DQHsfd+OoCT993UQqQPy/YosG4TOcGsuJd4m2asj7oXzIHVTEQl5SkUS5cU9jrcpxZ
         FO/UsEVf/jZxqdDnjF3Zm7XTAl2J+I1PnMBS3k39f9CDxAbI1oI7jd6ndplJ/rP9mTN/
         US0rYZzgT5J7a2Vu7IMHhx+n02bwmlyiiC/cJAftPVxsO8OpySBbP+iiL3FoUWKs4hoU
         gI/w4d2a7TYvAtHEgP3OEhul1QEOsMkmjLQvjsGKfG3Pydfd6Eh2AXTg1XkVoKvh5oNZ
         BND3WpNVhHKyCMF85hDsTmOexNkjtYs0lKVvUTLJYlM4LgOEmBY0UQgRrP44vG+gsoe7
         JqCg==
X-Gm-Message-State: AOAM530waW8tGoKkwXREJRstevJaFfLrm7+RrnTrYgsOUo5ZVtHB2V8Z
        k6sDIbwesilxQxndtIwLyO5FRSGV2c/MbeorZPs=
X-Google-Smtp-Source: ABdhPJwV9hSzosynkUveNiSAaadhbQqM5Y0f0XB0xpbiLkyMHaUABIQ3SVU6GDBx+kz47TXDjE3FiD7f7EGMOLCWLV0=
X-Received: by 2002:a05:6830:3482:: with SMTP id c2mr7292862otu.59.1611153898581;
 Wed, 20 Jan 2021 06:44:58 -0800 (PST)
MIME-Version: 1.0
References: <CAD=hENfPfgZpcs+JER9qijyo-D16n1X0q2oPqF-qo88GLkkBXw@mail.gmail.com>
 <411ad58698ea4fe8a6b80758de0039e98ba6a316.camel@suse.com>
In-Reply-To: <411ad58698ea4fe8a6b80758de0039e98ba6a316.camel@suse.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 20 Jan 2021 22:44:47 +0800
Message-ID: <CAD=hENfCoW9pqM3ACWyLaZhw9NhRr-yJz6LLqbwW2psz_SuWHw@mail.gmail.com>
Subject: Re: Revert "RDMA/rxe: Remove VLAN code leftovers from RXE"
To:     Martin Wilck <mwilck@suse.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 20, 2021 at 10:30 PM Martin Wilck <mwilck@suse.com> wrote:
>
> On Wed, 2021-01-20 at 13:33 +0800, Zhu Yanjun wrote:
> > On Tue, 2021-01-19 at 20:10 +0800, Zhu Yanjun wrote:
> > > On Tue, Jan 19, 2021 at 6:57 PM <mwilck@suse.com> wrote:
> > >
> >
> > > My test scenario which is broken by your patch uses a script that
> > > does
> > > roughly the following:
> >
> > > # (set up eth0)
> > > rdma link add rxe_eth0 type rxe netdev eth0
> > > ip link add link eth0 name eth0.10 type vlan id 10
> > > ip link set eth0.10 up
> > > ip addr add 192.168.10.102/24 dev eth0.10
> >
> > Thanks a lot.
> > It seems that the vlan SKBs also enter RXE.
> >
> > There are 3 hunks in the commit b2d2440430c0("RDMA/rxe: Remove VLAN
> > code leftovers from RXE").
> >
> > Can you make more research to find out which hunk causes this
> > problem?
>
> I'm positive they all need to be reverted. It's not much code
> altogether that is removed, but this much is necessary to make VLANs

RXE does not support VLAN now.

> work.
>
> >
> > From Jason, vlan is not supported now.
> > If you want to make more work, the link
> > https://www.spinics.net/lists/linux-rdma/msg94737.html can give some
> > tips.
>
> That's fd49ddaf7e26. Did you notice that I referenced that commit in my
> patch description and actually said it was "absolutely correct"?
>
> Anyway, quoting from Mohammad's email: "therefore RXE must behave the
> same like HW-RoCE devices and create rxe device per real device only".
> This is exactly how the code behaved before your patch was applied.
> Or what am I missing?
>
> I have no experience with HW-RoCE. If it's true that RDMA is setup only
> "per real device only" there, why would the same thing be wrong for
> SW-RoCE?
>
>
> Martin
>
>
