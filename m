Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD7F15153C
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 06:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgBDFIG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 00:08:06 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:45477 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgBDFIG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Feb 2020 00:08:06 -0500
Received: by mail-il1-f196.google.com with SMTP id p8so14732837iln.12
        for <linux-rdma@vger.kernel.org>; Mon, 03 Feb 2020 21:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Re0iNdHFFrs0larlR9CaRMQKPLbEvWFifkBfefqofM=;
        b=MoHgdqGsrPzEFz9DqVwxDqGHqRcVS/+4lFNlIhXbk4upHkrzwsdMOAOzoG5C/5t+e6
         XRBgIRUwBVtQqOKI4h/UYsBnz1nKwCaRm4DSn3FAhKfyHdOueBz0KVoXvQeIyf1ww8LS
         47+WJB0ChtA7fSqRH6csTOHVk+EOuHw0e3Pg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Re0iNdHFFrs0larlR9CaRMQKPLbEvWFifkBfefqofM=;
        b=COsxlPc4zZ+gN0kTZNIwiX2Nl24OUxYxoMnPuIn37LwY8fEi60fW7czHDKOTueNu/+
         1AbqGxOFxgO4wGhzg6WoY+k4jRAT6jzuP73ogDx/cH/C80oHoOk4/9UZDgq76lCeiuRX
         XB7wmtQRe5z5mhzivT/k0VSQDbW9JsUS/ZILEDpnjZhx1phY3AbDWiFVzhL66bslOb16
         6W9p6GQZNB5qycxy85bDl+oHqQMIpc02BFlwzHHPGdwen1+wJcv7NoSXg/9B8aDngb4A
         okQ6bLfQta5YyBC3fskTTHlxg7LtLOqHG91zd3IyUTf+x4ZdLi/l5sYAlRKCWeZ0MbMf
         Msvg==
X-Gm-Message-State: APjAAAUmnXy3m1OqEj6ikRrY09Iys0rRp0itO7xUUY4aTPYyEk6q/h1K
        33tZcIr/8vqRBkntsABHNQXrkJmTeF3aJm5p1ku9og==
X-Google-Smtp-Source: APXvYqyUjNNBnGp4BTJJOHlJVBWuvsxYdsPUr5tEu90lwA6ZjJfO1Y8D7uE0N/jr9bMzTrnlyFlQnOWQDgztZLf00uk=
X-Received: by 2002:a92:d7cd:: with SMTP id g13mr19362935ilq.300.1580792885418;
 Mon, 03 Feb 2020 21:08:05 -0800 (PST)
MIME-Version: 1.0
References: <1580752324-24742-1-git-send-email-devesh.sharma@broadcom.com> <20200203194614.GT414821@unreal>
In-Reply-To: <20200203194614.GT414821@unreal>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Tue, 4 Feb 2020 10:37:28 +0530
Message-ID: <CANjDDBi6zq_V3wfxhAEcZ3qTcAaD6iF6=5eXNBoGQn6qG3k3rA@mail.gmail.com>
Subject: Re: [PATCH v5] libibverbs: display gid type in ibv_devinfo
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 4, 2020 at 1:16 AM Leon Romanovsky <leon@kernel.org> wrote:
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
> > $
> > $
> >
> > Reviewed-by: Jason Gunthrope <jgg@ziepe.ca>
> > Reviewed-by: Leon Romanovsky <leon@kernel.org>
> > Reviewed-by: Gal Pressman <galpress@amazon.com>
> > Reviewed-by: Parav Pandit <parav@mellanox.com>
> > Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> > ---
> >  libibverbs/driver.h           |  1 +
> >  libibverbs/examples/devinfo.c | 35 ++++++++++++++++++++++++-----------
> >  2 files changed, 25 insertions(+), 11 deletions(-)
> >
> > diff --git a/libibverbs/driver.h b/libibverbs/driver.h
> > index a0e6f89..fc0699d 100644
> > --- a/libibverbs/driver.h
> > +++ b/libibverbs/driver.h
> > @@ -84,6 +84,7 @@ enum verbs_qp_mask {
> >  enum ibv_gid_type {
> >       IBV_GID_TYPE_IB_ROCE_V1,
> >       IBV_GID_TYPE_ROCE_V2,
> > +     IBV_GID_TYPE_INVALID
> >  };
> >
>
> Agree with Gal, this hunk shouldn't be in the patch at all.
Okay, will change.
>
> Thanks
