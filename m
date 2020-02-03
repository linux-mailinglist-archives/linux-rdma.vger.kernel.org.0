Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2491508EE
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 16:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgBCPAa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 10:00:30 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:35698 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgBCPA3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Feb 2020 10:00:29 -0500
Received: by mail-il1-f196.google.com with SMTP id g12so12894917ild.2
        for <linux-rdma@vger.kernel.org>; Mon, 03 Feb 2020 07:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zXolVJ6sWAKeCRQmigrieHew0qKARrfqzoQa9PVG1FQ=;
        b=bYw99RTirGD39xO2I9X7mx6e0L91Gglw2LWCH8QDGfh6EG1uDZ1TyPlXWhusMmxbl4
         /qT4mMhhdahNCA8xKBMy6JFYZqEviVu1/lXJJ463TFD2V9ric2wGUUdQTdXH2DM5Njux
         L13/z9Wnn9jUVRF+JOLt+wmeMN/XEUUwI260c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXolVJ6sWAKeCRQmigrieHew0qKARrfqzoQa9PVG1FQ=;
        b=LgXUw0Eul77QYI5NYk0N5gtQziLcQeyq9wOuYZ4+HVOPKnEbiM3rz8LJBcH2+UytkG
         /kwTlV8n9SnL0qUY8yuIqN7bD9GRwbeN4GNW1pPmB38ZJapUnDmVgzs6NgFhbRNJvmZ8
         YP8ySPi6h3SPx360/PImiSrj5EMAyc+mqkUUbkOFcsl1kIDUwg/ZnLZtNeawV3gzSdL6
         We18lfQvDFtfk2SZjuiB7doUCH1tMKJ0XxFkfNd8AryeKc071TfOZome3PJeWh6KA7PK
         urmW04LshGfH591bu6Fxw0ckh6eJIYO1jMpkcFoxwFOkIQGqQG55X8yMR+GT9PRd/5jU
         bJjg==
X-Gm-Message-State: APjAAAWC5Yho3gXCRpCJFXDqnX0Cm+mD760tWcGHnaARXSfrA+L2kv8f
        r2aR1fnF2Pl8CbirwaC7EGZtA4PiRDyEccArIRYgqfiv
X-Google-Smtp-Source: APXvYqzhNZ61tMwSkPd9Btfs2CNSOOwwWqmGZGHnryo2JSmQC+G7n6AmOVf88/j1zaEFmspJpOjI1ARC78JKuo75cFc=
X-Received: by 2002:a92:bf10:: with SMTP id z16mr15654290ilh.87.1580742028719;
 Mon, 03 Feb 2020 07:00:28 -0800 (PST)
MIME-Version: 1.0
References: <1580708846-10851-1-git-send-email-devesh.sharma@broadcom.com> <20200203084958.GN414821@unreal>
In-Reply-To: <20200203084958.GN414821@unreal>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Mon, 3 Feb 2020 20:29:51 +0530
Message-ID: <CANjDDBhPczh2mNxm6xbQSyf7wL-PvaU-+ovet9p72YyAPrMoGg@mail.gmail.com>
Subject: Re: [PATCH v3] rdma-core/libibverbs: display gid type in ibv_devinfo
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 3, 2020 at 2:20 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Feb 03, 2020 at 12:47:26AM -0500, Devesh Sharma wrote:
> > It becomes difficult to make out from the output of ibv_devinfo
> > if a particular gid index is RoCE v2 or not.
> >
> > Adding a string to the output of ibv_devinfo -v to display the
> > gid type at the end of gid.
> >
> > Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> > ---
> >  libibverbs/examples/devinfo.c | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> >
>
> It will be very helpful to add example of "ibv_devinfo -v"
> to the commit message.
Sure, adding it.
>
> Thanks
