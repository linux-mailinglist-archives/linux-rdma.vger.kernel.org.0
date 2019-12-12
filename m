Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C49911C235
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 02:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfLLBdV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Dec 2019 20:33:21 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34677 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfLLBdV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Dec 2019 20:33:21 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so769710otf.1;
        Wed, 11 Dec 2019 17:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lzwdJDAmxJY1eABknzBM4VRQbsIRzOn9IbtmF0lZgCU=;
        b=CnvWkqCIuOLMkvjfdwAteNxGWDSx/41p6Mxfq1pDteizNN4eSX3TrU6hCvEzwzGHlL
         I2savvk5kobSLwvhb4l+JPtAKAh8/XZ1NmIkNmpROXN7N5lh5J9orwRJDGIkeTp1tL/E
         m0XcH3/8Eyh4ItkJ/KDVbAMRGKx2OhWPC0JfDvt0vhbj0O+CTVWUWartgVImJ0XYDshT
         6VTQLpE9QWbAX6CpKEvQHP4K/cDUDi23fUOqxC0tjOkb0AryP2A0X8yURAUt1dvqC22c
         VwODXc0/eTYZdanR/YwU6TyOywUphf1zXBRPZIf9n5pQBT+I/xGvMyEv/8uJP8s6ftFw
         EtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lzwdJDAmxJY1eABknzBM4VRQbsIRzOn9IbtmF0lZgCU=;
        b=m0jOsNtog8EEZ/u2IZb6wSgEGtX0d3ISa23+XZV8gFjXMQzjYEdkjZ7y/jakWZX9xQ
         mASGPEG+N1UN1J7TqAM/mVuU0BRX2xdYaYfuxNKinBkAzopV7gQ4WzmQEPgEaUbKomIh
         l5pFJofALXhNj5hneZBx5R1aBqcmGYos78B3kf2tb6Ii8OHlS0ImNmufbL4wB4gz0CEz
         UkDzyKiCbTQ5czzdMPeHPAqkV7DxOrn3QlHq1hBrWjwgyMDKdcLWY2v5/JuvuiLn8A7B
         c0BAqiibI1YqxAoDH43YVuhKwPFGvRJ/YaD5x+ZWNo7srLMKm6zoSJ+Su/h40gz5Gsm9
         tNOg==
X-Gm-Message-State: APjAAAX2KS6xmRAwASB3kPJMVQsa2iyFtwBjkALk99+JLSF7wIRx0ILH
        qsMdjTW7i9fEgzNc1La6ODh0lNPqqiSUQDOekSc=
X-Google-Smtp-Source: APXvYqx0Veo01LY+lVcztJhE85CJaZ2sZ5n/EcknAKg/M7aXZfNy5+ZipN+IhtT0o3fqlLmnElL+3FhI+5yErdlFwlY=
X-Received: by 2002:a05:6830:158d:: with SMTP id i13mr5301485otr.33.1576114400042;
 Wed, 11 Dec 2019 17:33:20 -0800 (PST)
MIME-Version: 1.0
References: <20191211111628.2955-1-max.hirsch@gmail.com> <20191211162654.GD6622@ziepe.ca>
In-Reply-To: <20191211162654.GD6622@ziepe.ca>
From:   Max Hirsch <max.hirsch@gmail.com>
Date:   Wed, 11 Dec 2019 20:33:10 -0500
Message-ID: <CADgTo880aSn++fcf_rt0+8DCE4Y=xgXtZxFx9B0nzM_M1HdWPw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/cma: Fix checkpatch error
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Steve Wise <swise@opengridcomputing.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Danit Goldberg <danitg@mellanox.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dag Moxnes <dag.moxnes@oracle.com>,
        Myungho Jung <mhjungk@gmail.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks for the quick response. This is my first patch, so I want to
follow the correct protocol. I reran checkpatch after making the
changes and there were no errors or warnings in the region I changed.

...
WARNING: line over 80 characters
#308: FILE: drivers/infiniband/core/cma.c:308:
+ return cma_dev->default_roce_tos[port - rdma_start_port(cma_dev->device)]=
;

<<<<<<<<<<<<<<<<<< HERE IS WHERE THE ERROR WAS

WARNING: line over 80 characters
#495: FILE: drivers/infiniband/core/cma.c:495:
+ struct cma_multicast *mc =3D container_of(kref, struct cma_multicast, mcr=
ef);
...

I was have read that it is beneficial to make the changes very small.
I wanted to target a specific checkpatch error. If you believe it
would be better I can make a patch cleaning up the entire function.

I can also make a second patch changing ret to a bool. I did not want
to do that as a part of this patch because: I wanted a VERY small
change (increase acceptance likelihood), and there is a specific
protocol for submitting multiple commits in a patch, i.e. ordering
them correctly. I did not want to introduce a potential error source
when submitting a patch i.e. I submitted 2 commits in the wrong order.

Since you have the comment to remove the brackets around the ret
assign how would I go about modifying this patch? Should I resubmit a
patch i.e. start a new email with with your proposed changes?


On Wed, Dec 11, 2019 at 11:26 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Dec 11, 2019 at 11:16:26AM +0000, Max Hirsch wrote:
> > When running checkpatch on cma.c the following error was found:
>
> I think checkpatch will complain about your patch, did you run it?
>
> > ERROR: do not use assignment in if condition
> > #413: FILE: drivers/infiniband/tmp.c:413:
> > +     if ((ret =3D (id_priv->state =3D=3D comp)))
> >
> > This patch moves the assignment of ret to the previous line. The if sta=
tement then checks the value of ret assigned on the previous line. The assi=
gned value of ret is not changed. Testing involved recompiling and loading =
the kernel. After the changes checkpatch does not report this the error in =
cma.c.
> >
> > Signed-off-by: Max Hirsch <max.hirsch@gmail.com>
> >  drivers/infiniband/core/cma.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cm=
a.c
> > index 25f2b70fd8ef..bdb7a8493517 100644
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -410,7 +410,8 @@ static int cma_comp_exch(struct rdma_id_private *id=
_priv,
> >       int ret;
> >
> >       spin_lock_irqsave(&id_priv->lock, flags);
> > -     if ((ret =3D (id_priv->state =3D=3D comp)))
> > +     ret =3D (id_priv->state =3D=3D comp);
>
> Brackets are not needed
>
> Ret and the return result should be changed to a bool
>
> Jason
