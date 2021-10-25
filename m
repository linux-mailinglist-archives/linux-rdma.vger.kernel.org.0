Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83010439357
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 12:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhJYKJW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 06:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhJYKJV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Oct 2021 06:09:21 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1E4C061745
        for <linux-rdma@vger.kernel.org>; Mon, 25 Oct 2021 03:06:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z14so10690598wrg.6
        for <linux-rdma@vger.kernel.org>; Mon, 25 Oct 2021 03:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gG16OdG8o+2urhqbre+IlByaYS4wcJnGlzznkYg60vg=;
        b=dnpTNM9hZTIpHz0YC/9V+82NPf5ST+pzZPqcp1xrXAcYFygBoZ3/5/nl2Smr7r00hg
         0P5QPMXXW83VyjR923zMSZ161V7Z27CjXcCQq6Hvq1ZNumlfIgkSslByLYf5pSuxn5jF
         bs4J1vL3+u2SJhdt9F5DOxE2ta2cs7Oari5woETlWpvJTnUP00tOLrJcE0o6PhLSZYrm
         aT4Sf1YSsWhJBqAS/MCz/UnjDg5pFVqMdKkyRfGfxyOkltt1862l3r/yMzBQiEnO4az7
         4voDAV2q0zSxRFAbbSS40h7b59UempqU3fzv20f/qotCPpOeEHSdSBREhlCVf2aizAv1
         QlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gG16OdG8o+2urhqbre+IlByaYS4wcJnGlzznkYg60vg=;
        b=NSB0CY/Ei8/ltn/hZEMKD+zeWDTVfl/pf7/N7z5NjDuC13bQCJGkhKwUg/NcKgm4vt
         Q5B/1uaNjXBwrnaTWt9x4Al1Qmbfg1LZaRygIJP8LCTpnE5aUvIuEQa+mrxfAzBfa3vB
         8HRj9B7TwC4dMhBuo0TbkR4dFscLvDmsHLIymiH3vIypxXY56iBxIId331Xc7F0PjgIe
         IeRfItqgcGwRkgyV+ecCzaWrGR2XkaAhVxrXrSFhsGGnfkwePnzzU5I+ipPBu+KqF243
         PjOSM8Y4C3sBSu24vQiOym8sbjoZbw0ThJyooPkYNqswbZJ7WIwlig4ghXLcLQD8YQDB
         8bhQ==
X-Gm-Message-State: AOAM533eE+z6ew+SfupEThvMcljxxr7t1GMRaK7D3webPm7mX8nxrImV
        1CrE3s5VleBHA9EFGsRf45LTfKfOOhuazw==
X-Google-Smtp-Source: ABdhPJyeSwBKgvX9pnESeSB1FyJ7NOYtHMd5hKQH2yJuyuvYmdAImkIHFtW7ENh7NwLhU7zx6y8s6w==
X-Received: by 2002:a05:6000:1acc:: with SMTP id i12mr3825959wry.80.1635156417839;
        Mon, 25 Oct 2021 03:06:57 -0700 (PDT)
Received: from fedora ([2a00:a040:19b:e02f::1006])
        by smtp.gmail.com with ESMTPSA id q14sm18287536wmq.4.2021.10.25.03.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 03:06:57 -0700 (PDT)
Date:   Mon, 25 Oct 2021 13:06:54 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Prabhakar Kushwaha <pkushwaha@marvell.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, Ariel Elior <aelior@marvell.com>,
        Alok Prasad <palok@marvell.com>
Subject: Re: [PATCH for-next] RDMA/qedr: Remove unsupported qedr_resize_cq
 callback
Message-ID: <YXaBvtre1/BzFJYy@fedora>
References: <DM5PR1801MB20576F5ED830B11E8F83A037B2839@DM5PR1801MB2057.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR1801MB20576F5ED830B11E8F83A037B2839@DM5PR1801MB2057.namprd18.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 25, 2021 at 09:24:41AM +0000, Prabhakar Kushwaha wrote:
> Dear Kamal,
> 

Hi Prabhakar,

> > -----Original Message-----
> > From: Kamal Heib <kamalheib1@gmail.com>
> > Sent: Monday, October 25, 2021 9:27 AM
> > To: linux-rdma@vger.kernel.org
> > Cc: Michal Kalderon <mkalderon@marvell.com>; Ariel Elior
> > <aelior@marvell.com>; Doug Ledford <dledford@redhat.com>; Jason
> > Gunthorpe <jgg@ziepe.ca>; Kamal Heib <kamalheib1@gmail.com>
> > Subject:  [PATCH for-next] RDMA/qedr: Remove unsupported
> > qedr_resize_cq callback
> > 
> > External Email
> > 
> > ----------------------------------------------------------------------
> > There is no need to return always zero for function which is not supported.
> > 
> > Fixes: a7efd7773e31 ("qedr: Add support for PD,PKEY and CQ verbs")
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > ---
> >  drivers/infiniband/hw/qedr/main.c  |  1 -  drivers/infiniband/hw/qedr/verbs.c |
> > 10 ----------  drivers/infiniband/hw/qedr/verbs.h |  1 -
> >  3 files changed, 12 deletions(-)
> 
> Have you tested this patch? I afraid, there may be a crash because of  this 
>

I do not think that we will face a crash, because the libqedr in the
rdma-core package dose not implement the resize_cq() callback.

Furthermore, if there is a bug in the kernel rdma core this doesn't mean
that the qedr driver need to fake supporting resize_cq() to avoid a crash!.

Anyway, To be in the safe side we I'll prepare another patch that checks
for NULL in the core and return -EOPNOTSUPP if resize_cq() is not set
by the driver.


> static int ib_uverbs_resize_cq(struct uverbs_attr_bundle *attrs)
> {
> <snip>
> 
>         cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
>         if (!cq)
>                 return -EINVAL;
> 
>         ret = cq->device->ops.resize_cq(cq, cmd.cqe, &attrs->driver_udata);    <<<< No check for NULL.
> 
> 
> --pk
>

Thanks,
Kamal
