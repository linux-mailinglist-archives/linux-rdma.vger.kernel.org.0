Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C159115B036
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2020 19:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgBLSxS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Feb 2020 13:53:18 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44675 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBLSxS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Feb 2020 13:53:18 -0500
Received: by mail-io1-f68.google.com with SMTP id z16so3434745iod.11
        for <linux-rdma@vger.kernel.org>; Wed, 12 Feb 2020 10:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xMqI5ZJM87r+yi61ZF0ys+vNtYVMECXl7SBwCn+sqBw=;
        b=aRvJoJnJlDI1uAsAqm/931tOQpwGkwtnX2TOkHlGTGccPE0sr2U53OxVCWZx5rsjLu
         R5P4mcmKWGQhpTuD0E9vvN5/W+rWvZBI45YQTOBtYZNOmK/ODZF7vTJUjfzJPeZM6A5r
         KmGXgmDOUo4JO1K+KL4QDieUT6a6DnqEH5Ink=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xMqI5ZJM87r+yi61ZF0ys+vNtYVMECXl7SBwCn+sqBw=;
        b=rgPCiszJ0+fwBWcQZ/WNYAZamGumEtB7ha+FwTce+M8hSxydoBIg9nSDxwzx56i1rF
         mm/e/nZA/Uhsfe5bY0vjx+0cpr4cS7jaw/Bmi0yfSV6ah0wOKA42jt6tibYlQiamahHW
         GocP14Ovg6FNbidwP9Cn6M5nqu/HcfAD9r00KRv8YPS7Td716hjSZmjtboKtOBADC3Ab
         QeKb2frhzPl7mUMRd7vdxG84HpUIijlzOZ8ScBOenIy9+2ufQHWlgXIo8R6od0ohMmlK
         DrvBMPOffYw+9MuGrH0DIFvGRQXJ6tKmYJR6kC3rf7RwqUor/8BqaIJHJD28Ak+T8j4T
         qQ4Q==
X-Gm-Message-State: APjAAAWW+JfjhczKs0LdqLor9oK0lgZsaHa7tJc+SrISgekICdsxDqrg
        VQR5wp+mvhNClu2uUe1bG1gwbJAuuIh62Sk/QmQeeijY
X-Google-Smtp-Source: APXvYqxFKaEHubazw2k56bLUNwBZ+R/98YOC6YVndnGFZe9+MZCcviQRv6bYDZZtp3mhI9ecNJq5YroSNGz+KznLblg=
X-Received: by 2002:a02:2404:: with SMTP id f4mr19572819jaa.50.1581533597079;
 Wed, 12 Feb 2020 10:53:17 -0800 (PST)
MIME-Version: 1.0
References: <1581355065-763-1-git-send-email-devesh.sharma@broadcom.com> <20200212175458.GE679970@unreal>
In-Reply-To: <20200212175458.GE679970@unreal>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Thu, 13 Feb 2020 00:22:40 +0530
Message-ID: <CANjDDBi6S04wAwzsum_utZCsf2YxaX1qiffaT4iUD-56hjBzEA@mail.gmail.com>
Subject: Re: [PATCH v8] libibverbs: display gid type in ibv_devinfo
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 12, 2020 at 11:25 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Feb 10, 2020 at 12:17:45PM -0500, Devesh Sharma wrote:
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
> >       phys_state:     LINK_UP (5)
> >       GID[  0]:       fe80:0000:0000:0000:b226:28ff:fed3:b0f0, RoCE v1
> >       GID[  1]:       fe80::b226:28ff:fed3:b0f0, RoCE v2
> >       GID[  2]:       0000:0000:0000:0000:0000:ffff:c0aa:0165, RoCE v1
> >       GID[  3]:       ::ffff:192.170.1.101, RoCE v2
> > $
> > $
> > $
> >
> > Reviewed-by: Jason Gunthrope <jgg@ziepe.ca>
> > Reviewed-by: Gal Pressman <galpress@amazon.com>
> > Reviewed-by: Parav Pandit <parav@mellanox.com>
> > Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> > ---
> >  libibverbs/examples/devinfo.c | 61 ++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 49 insertions(+), 12 deletions(-)
> >
>
> Devesh,
>
> I see that everyone is happy now, can you please refresh PR so I will
> merge it?
>
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Done

Thanks!
