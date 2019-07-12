Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA6E467347
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 18:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfGLQ3v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 12:29:51 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33333 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfGLQ3u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 12:29:50 -0400
Received: by mail-oi1-f193.google.com with SMTP id u15so7751689oiv.0
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 09:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SHcKxWcCHAIxWtDqQqEUu85uB4tHtLH7Yjh4VUfEfZ8=;
        b=Rc7AOzjIxAeByGWEVMcy/97OEY8HfyvA/ew1RT/QPkQcSv/3N5lkqWFccNlT6oGEJj
         qs+2tvPNoQvhztz0b1sI5GVCP8sqqCJs2OtkKnUoBW8cXXlGiytKuMNPq9gc/pxHcfSc
         cY4pAeynemhVZNt0Lc9LhgQHEtrWBP/czucQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SHcKxWcCHAIxWtDqQqEUu85uB4tHtLH7Yjh4VUfEfZ8=;
        b=VpTa9o3T3dJlQrtPjUcHUoqLQ8dL9YG37hOa87L4gG4VictRhhWRMEP5UGc6WxOBu+
         01BFu73YngrD0F/BVORmWWvUXGWE98xaBap6wW6z5qDbr+jMtUdqg90gOilpV8EIhTjh
         lUaVWWZybmJDNnpPdGunVfeuIE+4qV0dVioD9Acm8uBk5gEGvW7mShpj6DEVVOnKaSbz
         PX1KEfWjj4iUinWPGeI+FiLZBH48iMOtJi9sUrjrgGOl39fkCCEAY64+wVb0e7mLTxrn
         gJ9BwvJWK7aQKjYyfbVxVuwjoS0EpXMBtdAtiRXFu69n/oUx4d2TdTG+WqmLd+zA8bV7
         hnXA==
X-Gm-Message-State: APjAAAXPwNdqUGrH/pHFOtyS4ExB13gjtuMlYkvyLw+HYX1n7WV5RVGX
        llZNC1aYR/co83BKKIIDppsVUn/8ICoAzYxKp2mCB+0QoFo=
X-Google-Smtp-Source: APXvYqzFVqDlgidoYbYNHh4/kRKUh7vqILHqlqGB3Jx4FnI3r/Wl8NZlYvmcn2Oasnos5Kd66Xlc6oJgEGyUtguyyyM=
X-Received: by 2002:aca:c48b:: with SMTP id u133mr5954456oif.95.1562948989298;
 Fri, 12 Jul 2019 09:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <AM0PR05MB48664657022ECA8526E3C967D1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866070FBADCCABD1F84E42ED1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <66d43fd8-18e8-8b9d-90e3-ee2804d56889@redhat.com> <AM0PR05MB4866DEDB9DE4379F6A6EF15BD1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <CA+sbYW17PGAW57pyRmQB9KsDA9Q+7FFgSseSTTWE_h6vffa7UQ@mail.gmail.com>
 <AM0PR05MB4866CFEDCDF3CDA1D7D18AA5D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866CCD487C9D99BD9526BA8D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866665D5CACB34AE885BCA2D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <ef6a01a1-9163-ef4e-29ac-4f4130c682f1@redhat.com> <AM0PR05MB48666463325E1D0E25D63F57D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20190712154044.GJ27512@ziepe.ca>
In-Reply-To: <20190712154044.GJ27512@ziepe.ca>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Fri, 12 Jul 2019 21:59:38 +0530
Message-ID: <CA+sbYW0F6Vgpa5SQX+9ge4EwWrMkJ4kQ-psEq11S00=-L_mVhg@mail.gmail.com>
Subject: Re: regression: nvme rdma with bnxt_re0 broken
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Parav Pandit <parav@mellanox.com>, Yi Zhang <yi.zhang@redhat.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 12, 2019 at 9:10 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Jul 12, 2019 at 12:52:24PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Yi Zhang <yi.zhang@redhat.com>
> > > Sent: Friday, July 12, 2019 5:11 PM
> > > To: Parav Pandit <parav@mellanox.com>; Selvin Xavier
> > > <selvin.xavier@broadcom.com>
> > > Cc: Daniel Jurgens <danielj@mellanox.com>; linux-rdma@vger.kernel.org;
> > > Devesh Sharma <devesh.sharma@broadcom.com>; linux-
> > > nvme@lists.infradead.org
> > > Subject: Re: regression: nvme rdma with bnxt_re0 broken
> > >
> > > Hi Parav
> > > The nvme connect still failed[1], I've paste all the dmesg log to[2], pls check it.
> > >
> > >
> > > [1]
> > > [root@rdma-perf-07 ~]$ nvme connect -t rdma -a 172.31.40.125 -s 4420 -n
> > > testnqn
> > > Failed to write to /dev/nvme-fabrics: Connection reset by peer
> > > [2]
> > > https://pastebin.com/ipvak0Sp
> > >
> >
> > I think vlan_id is not initialized to 0xffff due to which ipv4 entry addition also failed with my patch.
> > This is probably solves it. Not sure. I am not much familiar with it.
> >
> > Selvin,
> > Can you please take a look?
> >
> > From 7b55e1d4500259cf7c02fb4d9fbbeb5ad1cfc623 Mon Sep 17 00:00:00 2001
> > From: Parav Pandit <parav@mellanox.com>
> > Date: Fri, 12 Jul 2019 04:34:52 -0500
> > Subject: [PATCH v1] IB/bnxt_re: Honor vlan_id in GID entry comparison
> >
> > GID entry consist of GID, vlan, netdev and smac.
> > Extend GID duplicate check companions to consider vlan_id as well
> > to support IPv6 VLAN based link local addresses.
> >
> > GID deletion based on only GID comparision is not correct.
> > It needs further fixes.
> >
> > Fixes: 823b23da7113 ("IB/core: Allow vlan link local address based RoCE GIDs")
> > Change-Id: I2e026ec8065c8425ba24fad8525323d112a2f4e4
> > Signed-off-by: Parav Pandit <parav@mellanox.com>
> >  drivers/infiniband/hw/bnxt_re/qplib_res.c | 5 +++++
> >  drivers/infiniband/hw/bnxt_re/qplib_sp.c  | 7 ++++++-
> >  drivers/infiniband/hw/bnxt_re/qplib_sp.h  | 1 +
> >  3 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> > index 37928b1111df..216648b640ce 100644
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> > @@ -488,6 +488,8 @@ static int bnxt_qplib_alloc_sgid_tbl(struct bnxt_qplib_res *res,
> >                                    struct bnxt_qplib_sgid_tbl *sgid_tbl,
> >                                    u16 max)
> >  {
> > +     u16 i;
> > +
> >       sgid_tbl->tbl = kcalloc(max, sizeof(struct bnxt_qplib_gid), GFP_KERNEL);
> >       if (!sgid_tbl->tbl)
> >               return -ENOMEM;
> > @@ -500,6 +502,9 @@ static int bnxt_qplib_alloc_sgid_tbl(struct bnxt_qplib_res *res,
> >       if (!sgid_tbl->ctx)
> >               goto out_free2;
> >
> > +     for (i = 0; i < max; i++)
> > +             sgid_tbl->tbl[i].vlan_id = 0xffff;
> > +
> >       sgid_tbl->vlan = kcalloc(max, sizeof(u8), GFP_KERNEL);
> >       if (!sgid_tbl->vlan)
> >               goto out_free3;
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> > index 48793d3512ac..0d90be88685f 100644
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> > @@ -236,6 +236,9 @@ int bnxt_qplib_del_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
> >               return -ENOMEM;
> >       }
> >       for (index = 0; index < sgid_tbl->max; index++) {
> > +             /* FIXME: GID delete should happen based on index
> > +              * and refcount
> > +              */
> >               if (!memcmp(&sgid_tbl->tbl[index], gid, sizeof(*gid)))
> >                       break;
> >       }
> > @@ -296,7 +299,8 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
> >       }
> >       free_idx = sgid_tbl->max;
> >       for (i = 0; i < sgid_tbl->max; i++) {
> > -             if (!memcmp(&sgid_tbl->tbl[i], gid, sizeof(*gid))) {
> > +             if (!memcmp(&sgid_tbl->tbl[i], gid, sizeof(*gid)) &&
> > +                 sgid_tbl->tbl[i].vlan_id == vlan_id) {
> >                       dev_dbg(&res->pdev->dev,
> >                               "SGID entry already exist in entry %d!\n", i);
>
> bnxt guys: please just delete this duplicate detection code from the
> driver. Every GID provided from the core must be programmed into the
> given gid table index.

Jason,
 This check is required in bnxt_re because the HW need only one entry
in its table for RoCE V1 and RoCE v2 Gids.
Sending the second add_gid for RoCE V2 (with the same gid as RoCE v1)
to the HW returns failure. So
driver handles this using a ref count. During delete_gid, the entry in
the HW is deleted only if the refcount is zero.

Thanks,
Selvin

>
> Jason
