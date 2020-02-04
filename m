Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A7015153F
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 06:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgBDFJd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 00:09:33 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:43028 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgBDFJc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Feb 2020 00:09:32 -0500
Received: by mail-il1-f195.google.com with SMTP id o13so14754071ilg.10
        for <linux-rdma@vger.kernel.org>; Mon, 03 Feb 2020 21:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+YnUW0cfWuymPPICwh9J45f4XHrvuRw3JgEK9PQankM=;
        b=LgjwdDCiHjaM4MrpNpTOUDmppWfVsYv0gXxZ74c1O7U+Tq8PIDMe96r//ZDwqvIA5Q
         wegsHr3St4R9gXCt4RjLAJjNWYhhEBf4F5AS3ZeHpckmQmA+UimdW9p4TWKBNx0uFZ7h
         hSMe+pk+O/X0eAaibOzt1PWK/hK6NfoTklqII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+YnUW0cfWuymPPICwh9J45f4XHrvuRw3JgEK9PQankM=;
        b=m1//Zp1blL9dGFZQAQ1/6ivqcUl4DbcViXZJFv0Lt+FHAiRuflOXdAUrt/NyTRkJeC
         THEj2W5DdlbZ4jYJq6oEuUtBUZRqg2YXKWsH3KdP2XmY+VQaaYwB8DYDVGgfmJ8T8FoX
         Tm+zMknpA0aUYtg6Bh/bUG6Z4Go66UllqDiJ0elXSLLeX6iIJjgK8osj1XqbVbq2mQ3L
         HGaP6Ys6wd607V6NoDihEllcdlswaUKMsilJ4qVzsvuYSJhnCJ9Ws7nbBi0gMLoevsFs
         ZKabEYDf9ovHem10aDC+sMSN50okpvW16kda0z/hS44GEdBZJbM7Tnc4hXRVotOsKZs/
         A+nA==
X-Gm-Message-State: APjAAAWA31S0qjbqDzKMZ9l456KSegakJZVvyA2mEHPZOxsMYHbRqOQo
        Z7e0bM1GJCg2Ib1ZPW9m3HJjQTc5TBPJYBq8pxOp3g==
X-Google-Smtp-Source: APXvYqy4mI3OW11GWmMiYRuilozs8gifoO0bCqONbhoEgA6+ZaCe8sYCziRMrYmYXKl5xnynpsCzkBBvslWNe0CpPbQ=
X-Received: by 2002:a92:c703:: with SMTP id a3mr17916985ilp.89.1580792972255;
 Mon, 03 Feb 2020 21:09:32 -0800 (PST)
MIME-Version: 1.0
References: <1580752324-24742-1-git-send-email-devesh.sharma@broadcom.com>
 <20200203175317.GQ23346@mellanox.com> <CANjDDBh_Xv0BNhTYZ1xaaOCQ8-ijHUMqDE68_J4aqRF-EnT2Zg@mail.gmail.com>
 <20200203180405.GR23346@mellanox.com> <AM0PR05MB486694589EA1CBC66F598066D1030@AM0PR05MB4866.eurprd05.prod.outlook.com>
In-Reply-To: <AM0PR05MB486694589EA1CBC66F598066D1030@AM0PR05MB4866.eurprd05.prod.outlook.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Tue, 4 Feb 2020 10:38:55 +0530
Message-ID: <CANjDDBjPuQBD6woxMT9K=jVD5DiTYu0ODBd24BOzOMQw3VoO9w@mail.gmail.com>
Subject: Re: [PATCH v5] libibverbs: display gid type in ibv_devinfo
To:     Parav Pandit <parav@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 4, 2020 at 9:57 AM Parav Pandit <parav@mellanox.com> wrote:
>
>
>
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > Sent: Monday, February 3, 2020 11:34 PM
> >
> > On Mon, Feb 03, 2020 at 11:31:06PM +0530, Devesh Sharma wrote:
> > > On Mon, Feb 3, 2020 at 11:23 PM Jason Gunthorpe <jgg@mellanox.com>
> > wrote:
> > > >
> > > > On Mon, Feb 03, 2020 at 12:52:04PM -0500, Devesh Sharma wrote:
> > > > > It becomes difficult to make out from the output of ibv_devinfo if
> > > > > a particular gid index is RoCE v2 or not.
> > > > >
> > > > > Adding a string to the output of ibv_devinfo -v to display the gid
> > > > > type at the end of gid.
> > > > >
> > > > > The output would look something like below:
> > > > > $ ibv_devinfo -v -d bnxt_re2
> > > > > hca_id: bnxt_re2
> > > > >  transport:             InfiniBand (0)
> > > > >  fw_ver:                216.0.220.0
> > > > >  node_guid:             b226:28ff:fed3:b0f0
> > > > >  sys_image_guid:        b226:28ff:fed3:b0f0
> > > > >   .
> > > > >   .
> > > > >   .
> > > > >   .
> > > > >        phys_state:      LINK_UP (5)
> > > > >        GID[  0]:               fe80::b226:28ff:fed3:b0f0, IB/RoCE v1
> > > > >        GID[  1]:               fe80::b226:28ff:fed3:b0f0, RoCE v2
> > > > >        GID[  2]:               ::ffff:192.170.1.101, IB/RoCE v1
> > > > >        GID[  3]:               ::ffff:192.170.1.101, RoCE v2
> > > >
> > > > v1 GIDs are GIDs and should never be formed as IPv6 addreses..
> > > So, V1 gids would fall back to old style of display and there will be
> > > one more check for gid-type inside the loop...
> >
> > Yes
> >
> > Parav should we show both the v6 and classic format for a v2 GID? ie
> >
> >         GID[  3]:               0000:0000:0000:ffff:xxxx:xxxx:xxxx, RoCE v2
> >                                 ::ffff:192.170.1.101
> >
> Due to lack of support of GID's netdev, v1/v2 type info in ibv_devinfo output, most users that I know of are using non upstream show_gids script.
> So changing format here shouldn't break the existing users scripts.
> There may be some scripts that may find this format different.
> So I think printing both is likely a more safer option.
>
> > Lets also supress the 'IB/RoCE v1' string on !roce device. IB only has one GID
> > type, there is no reason to print anything
> >
Okay, so two changes and one from Gal's comment. Will change.
> > Jason
