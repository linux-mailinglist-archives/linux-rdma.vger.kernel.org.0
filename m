Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69268150F0E
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 19:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgBCSBn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 13:01:43 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40388 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgBCSBn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Feb 2020 13:01:43 -0500
Received: by mail-io1-f67.google.com with SMTP id x1so17737044iop.7
        for <linux-rdma@vger.kernel.org>; Mon, 03 Feb 2020 10:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YU/pth4/DupsG0uIPY1bt5gNKOCSmK1JaUrnxbbm6QI=;
        b=Ma69k/4LdwA5braW9R77PRCwRzENVCeloh0omLhMmXppjo90HZTe46RT10Zc3uWeeR
         U+Ry0hi1ORJHlxc06ur3Oe3nF2DznbRdiEW3kdrrF2LsIb+OAHZdS5NnWKYLk7fmApU+
         jF0cGbfi3FzfJJxUXVIRUJj/zbi0EE52DBEJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YU/pth4/DupsG0uIPY1bt5gNKOCSmK1JaUrnxbbm6QI=;
        b=hS+o4YUcjzXdC7RZqBdog85nh713tsHc3rQIe2zp68XNxwOgmGncxSubbm7twhydW7
         IlRkSX6GYgxm+o4R453kli646gSJ8xVfaae18wVKlZmtJSQmGN+QUz9AQeVulWgFCV/O
         Sk0MM/RmjoJVpIGE1g5acjjXTBbNZK9gwMkMc0Z3dh2Fw0wUQ+uYbDilG7OXUTQDHYpv
         5ULczgzQ0YErfbjDNpwOx8EiVoh3Fqig1yNK9y2CLvcietd6We19lEiA5nHhGAi9xhE2
         1EeI6q3rcOzoSPPwM3IaMFF7TehTJWl4gF5fnPFWGuEzy063u+i3huy+OqV/LJWxGpm/
         Ws/g==
X-Gm-Message-State: APjAAAWppsy6T0XfoD6w8Jlvl/+8J6tYSC5MW1qy9/XQb+5ay+5oXVUg
        FXcDDQR4x4LKY5oGaSzloM1fVi1wjEXxn/g4eVWTvA==
X-Google-Smtp-Source: APXvYqwP/WpWfgwRTkhfs+fhHfDIwCb02Uy/xYQzXOUpvEk31Y3crjG8FCbu68SId7VZgAEEOPzxm9brEvsXkOiFznY=
X-Received: by 2002:a5d:8908:: with SMTP id b8mr19031881ion.89.1580752902518;
 Mon, 03 Feb 2020 10:01:42 -0800 (PST)
MIME-Version: 1.0
References: <1580752324-24742-1-git-send-email-devesh.sharma@broadcom.com> <20200203175317.GQ23346@mellanox.com>
In-Reply-To: <20200203175317.GQ23346@mellanox.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Mon, 3 Feb 2020 23:31:06 +0530
Message-ID: <CANjDDBh_Xv0BNhTYZ1xaaOCQ8-ijHUMqDE68_J4aqRF-EnT2Zg@mail.gmail.com>
Subject: Re: [PATCH v5] libibverbs: display gid type in ibv_devinfo
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 3, 2020 at 11:23 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Mon, Feb 03, 2020 at 12:52:04PM -0500, Devesh Sharma wrote:
> > It becomes difficult to make out from the output of ibv_devinfo
> > if a particular gid index is RoCE v2 or not.
> >
> > Adding a string to the output of ibv_devinfo -v to display the
> > gid type at the end of gid.
> >
> > The output would look something like below:
> > $ ibv_devinfo -v -d bnxt_re2
> > hca_id: bnxt_re2
> >  transport:             InfiniBand (0)
> >  fw_ver:                216.0.220.0
> >  node_guid:             b226:28ff:fed3:b0f0
> >  sys_image_guid:        b226:28ff:fed3:b0f0
> >   .
> >   .
> >   .
> >   .
> >        phys_state:      LINK_UP (5)
> >        GID[  0]:               fe80::b226:28ff:fed3:b0f0, IB/RoCE v1
> >        GID[  1]:               fe80::b226:28ff:fed3:b0f0, RoCE v2
> >        GID[  2]:               ::ffff:192.170.1.101, IB/RoCE v1
> >        GID[  3]:               ::ffff:192.170.1.101, RoCE v2
>
> v1 GIDs are GIDs and should never be formed as IPv6 addreses..
So, V1 gids would fall back to old style of display and there will be
one more check for gid-type inside the loop...
>
> Jason
