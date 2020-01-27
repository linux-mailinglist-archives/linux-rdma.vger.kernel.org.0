Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D225D149F48
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2020 08:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgA0Hke (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jan 2020 02:40:34 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:40449 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgA0Hke (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jan 2020 02:40:34 -0500
Received: by mail-il1-f196.google.com with SMTP id i7so3486577ilr.7
        for <linux-rdma@vger.kernel.org>; Sun, 26 Jan 2020 23:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h6neGgw29vO5w7OOmDMGy8A3Le0T1faD65OUByrAZo8=;
        b=SI57Tqe4tQjMcf9MScGac7s3HH+Kg/Els7Z03x1gx++AeRo5kHKwP6yDt+XCIuvK7t
         PZo/E36sjTcskFZ6TcrWZ5q8aX1vrpZA5RVdOYqRNW37SS3esKwlJ8Xw7kf+oDdC9wWw
         gSxJjnpwq6rHUzqnM21llsnZXe/g7WOg+KZ6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6neGgw29vO5w7OOmDMGy8A3Le0T1faD65OUByrAZo8=;
        b=UfcpEJdflMHHQmeLZ8UKBORZHXtNmPhGcnHK6QdcE+uKSglf2xRenRnGUy0euHR0fE
         p7MQe2F9zH+DrgEQgJA1CY0/ZiSbT+QaaKAaKGc/UDS2eDn4UQG7btXBlzmiO6r0BZa3
         5lVB70iUCjmMyfA4zz63T+Ij82l4lH5dYxTSaJ2jAr8D49EiozzagI4Q0QaqpXdqq6P3
         8cK4CnIEzAJoO4YBx/H7iTtYDcOXJwhRLYWtTQxYeDWFOrrO2Xt+B8QeA4RF4IgjMfHo
         S6g58iHQ5tD1wJbj5TCq6H/jhj9NACbu4TOw7PcXW+SxqHltZ0/3in/2ZiXmTr2/UU7S
         CBwA==
X-Gm-Message-State: APjAAAV+gQC6YAg+QAX7kfvhCHqS4GEJ0xGTrwd5Xq/y8nmpayZoTAy3
        jeH6lNEwu1SCLyXkNK++cRtzrkdswC0zosGjaWOYbr4EoK8=
X-Google-Smtp-Source: APXvYqwrQv6TyhKItyP7D5jvhD7rECZEjyJN2yM0MWgyAzZog22zr0eUJc/cFuby3dL1YwcvczkT37ifPyZsND+VGzc=
X-Received: by 2002:a92:c703:: with SMTP id a3mr7350673ilp.89.1580110833895;
 Sun, 26 Jan 2020 23:40:33 -0800 (PST)
MIME-Version: 1.0
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com> <20200125180355.GE4616@mellanox.com>
In-Reply-To: <20200125180355.GE4616@mellanox.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Mon, 27 Jan 2020 13:09:57 +0530
Message-ID: <CANjDDBjfNaBgxVTWysF8aDfcT+4ROaDunnF7910m6m21h6ua-A@mail.gmail.com>
Subject: Re: [PATCH for-next 0/7] Refactor control path of bnxt_re driver
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jan 25, 2020 at 11:34 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Fri, Jan 24, 2020 at 12:52:38AM -0500, Devesh Sharma wrote:
> > This is the first series out of few more forthcoming series to refactor
> > Broadcom's RoCE driver. This series contains patches to refactor control
> > path. Since this is first series, there may be few code section which may
> > look redundant or overkill but those will be taken care in future patche
> > series.
> >
> > These patches apply clean on tip of for-next branch.
> > Each patch in this series is tested against user and kernel functionality.
> >
> > Devesh Sharma (7):
> >   RDMA/bnxt_re: Refactor queue pair creation code
> >   RDMA/bnxt_re: Replace chip context structure with pointer
> >   RDMA/bnxt_re: Refactor hardware queue memory allocation
> >   RDMA/bnxt_re: Refactor net ring allocation function
> >   RDMA/bnxt_re: Refactor command queue management code
> >   RDMA/bnxt_re: Refactor notification queue management code
> >   RDMA/bnxt_re: Refactor doorbell management functions
> >
> >  drivers/infiniband/hw/bnxt_re/bnxt_re.h    |  24 +-
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c   | 670 +++++++++++++++++++----------
> >  drivers/infiniband/hw/bnxt_re/main.c       | 134 +++---
> >  drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 423 +++++++++---------
> >  drivers/infiniband/hw/bnxt_re/qplib_fp.h   |  94 ++--
> >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 474 ++++++++++++--------
> >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  85 ++--
> >  drivers/infiniband/hw/bnxt_re/qplib_res.c  | 475 ++++++++++++--------
> >  drivers/infiniband/hw/bnxt_re/qplib_res.h  | 145 ++++++-
> >  drivers/infiniband/hw/bnxt_re/qplib_sp.c   |  52 ++-
> >  10 files changed, 1579 insertions(+), 997 deletions(-)
>
> Usually when you 'refactor' something the code gets smaller, not
> larger. What is going on here?
I agree with this fact however this series is adding object attribute
structures at various places and the attribute initialization before
object creation is adding up code lines.
>
> Jason
