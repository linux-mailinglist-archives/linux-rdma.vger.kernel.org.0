Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A566149F49
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2020 08:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgA0Hkt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jan 2020 02:40:49 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36255 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgA0Hkt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jan 2020 02:40:49 -0500
Received: by mail-io1-f68.google.com with SMTP id d15so8898012iog.3
        for <linux-rdma@vger.kernel.org>; Sun, 26 Jan 2020 23:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGENlprZT8KHeG83KsLSmYk44Pb0wI32BHm2oTDJvMQ=;
        b=Uqt1Z3YTX1vpafs5OAFNkSorTQ8QtWE6NICf28YhSG/E14DwUcGIkYoHXzYE/T/mos
         u1+NaJ2CtunBy3OBajVMii2kT9gb8LQ5VAfQJzwNcM2EQWtGuJN0yhBXEEtSTy1YwcrF
         FYTr8XgBqUJHh75d/rox8Jfr69v3DpnSiYTZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGENlprZT8KHeG83KsLSmYk44Pb0wI32BHm2oTDJvMQ=;
        b=GxAiFzuIxx3JvW0SwASEe2lvipUkRDAjhgu05OUYST1aoM4c3PZkfv6o673XdRJWhU
         +LsEPlEY70rnwfXQjKIQaspLQg+erMzlaBuMQUwrH6ykkwxD8JnibBXg5ksssLDGwiRc
         WEFXiHRHyymktzJNabTL8TaYQGv2t1A3OQwJY7ogTBVTignpHD25cyUGvyI6tauP/zEF
         izb1rLYKPjQAaxH8EHzVPQOjsUyz7pzSlXo8ngJqPqlnPNyM8wnys0/7Ms4vio2w1rnm
         grc9Y6uJp3hzBjpFj4jC05pIJz+c1DDo8xU2CBZyb+1vBnQ8Tn+BeH7MwHIcZ8vDgYpr
         E1ag==
X-Gm-Message-State: APjAAAXyohR/iJSQ20eWsE+HYBtBI5p8rHRpJCSZe3yVcwO+OscAq1Pi
        cJpnyjnHYSiSpKuRvWsb0XIEA4NC8fCw5rbxjbJzcw==
X-Google-Smtp-Source: APXvYqz7MsprBXIJDz78PhXw/55aruo+enxoeGNLX4eKkd6XA/PI51T5kUpUtCvKZrsvLzU2Do61aMWkhpHiPbpERAg=
X-Received: by 2002:a5e:9246:: with SMTP id z6mr12027646iop.232.1580110848297;
 Sun, 26 Jan 2020 23:40:48 -0800 (PST)
MIME-Version: 1.0
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-5-git-send-email-devesh.sharma@broadcom.com> <20200126142928.GG2993@unreal>
In-Reply-To: <20200126142928.GG2993@unreal>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Mon, 27 Jan 2020 13:10:10 +0530
Message-ID: <CANjDDBhxVC0ps8ee5NTW3QrN9bFNVdEcwxS2=Kfn1uOfDR2v_A@mail.gmail.com>
Subject: Re: [PATCH for-next 4/7] RDMA/bnxt_re: Refactor net ring allocation function
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 26, 2020 at 7:59 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Jan 24, 2020 at 12:52:42AM -0500, Devesh Sharma wrote:
> > Introducing a new attribute structure to reduce
> > the long list of arguments passed in bnxt_re_net_ring_alloc()
> > function.
> >
> > The caller of bnxt_re_net_ring_alloc should fill in
> > the list of attributes in bnxt_re_ring_attr structure
> > and then pass the pointer to the function.
> >
> > Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/bnxt_re.h |  9 +++++
> >  drivers/infiniband/hw/bnxt_re/main.c    | 65 ++++++++++++++++++---------------
> >  2 files changed, 45 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> > index 86274f4..c736e82 100644
> > --- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> > +++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> > @@ -89,6 +89,15 @@
> >
> >  #define BNXT_RE_DEFAULT_ACK_DELAY    16
> >
> > +struct bnxt_re_ring_attr {
> > +     dma_addr_t      *dma_arr;
> > +     int             pages;
> > +     int             type;
> > +     u32             depth;
> > +     u32             lrid; /* Logical ring id */
> > +     u8              mode;
> > +};
> > +
> >  struct bnxt_re_work {
> >       struct work_struct      work;
> >       unsigned long           event;
> > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> > index a966c68..648a5ea 100644
> > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > @@ -427,9 +427,9 @@ static int bnxt_re_net_ring_free(struct bnxt_re_dev *rdev,
> >       return rc;
> >  }
> >
> > -static int bnxt_re_net_ring_alloc(struct bnxt_re_dev *rdev, dma_addr_t *dma_arr,
> > -                               int pages, int type, u32 ring_mask,
> > -                               u32 map_index, u16 *fw_ring_id)
> > +static int bnxt_re_net_ring_alloc(struct bnxt_re_dev *rdev,
> > +                               struct bnxt_re_ring_attr *ring_attr,
> > +                               u16 *fw_ring_id)
> >  {
> >       struct bnxt_en_dev *en_dev = rdev->en_dev;
> >       struct hwrm_ring_alloc_input req = {0};
> > @@ -443,18 +443,18 @@ static int bnxt_re_net_ring_alloc(struct bnxt_re_dev *rdev, dma_addr_t *dma_arr,
> >       memset(&fw_msg, 0, sizeof(fw_msg));
> >       bnxt_re_init_hwrm_hdr(rdev, (void *)&req, HWRM_RING_ALLOC, -1, -1);
> >       req.enables = 0;
> > -     req.page_tbl_addr =  cpu_to_le64(dma_arr[0]);
> > -     if (pages > 1) {
> > +     req.page_tbl_addr =  cpu_to_le64(ring_attr->dma_arr[0]);
> > +     if (ring_attr->pages > 1) {
> >               /* Page size is in log2 units */
> >               req.page_size = BNXT_PAGE_SHIFT;
> >               req.page_tbl_depth = 1;
> >       }
> >       req.fbo = 0;
> >       /* Association of ring index with doorbell index and MSIX number */
> > -     req.logical_id = cpu_to_le16(map_index);
> > -     req.length = cpu_to_le32(ring_mask + 1);
> > -     req.ring_type = type;
> > -     req.int_mode = RING_ALLOC_REQ_INT_MODE_MSIX;
> > +     req.logical_id = cpu_to_le16(ring_attr->lrid);
> > +     req.length = cpu_to_le32(ring_attr->depth + 1);
> > +     req.ring_type = ring_attr->type;
> > +     req.int_mode = ring_attr->mode;
> >       bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
> >                           sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
> >       rc = en_dev->en_ops->bnxt_send_fw_msg(en_dev, BNXT_ROCE_ULP, &fw_msg);
> > @@ -1006,12 +1006,13 @@ static void bnxt_re_free_res(struct bnxt_re_dev *rdev)
> >
> >  static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
> >  {
> > +     struct bnxt_qplib_ctx *qplib_ctx;
> > +     struct bnxt_re_ring_attr rattr;
> >       int num_vec_created = 0;
> > -     dma_addr_t *pg_map;
> >       int rc = 0, i;
> > -     int pages;
> >       u8 type;
> >
> > +     memset(&rattr, 0, sizeof(rattr));
>
> Initialize rattr to zero from the beginning and save call to memset.
I moved from static initialization to memset due to some sparse/smatch
warnings, rattr has a "pointer member".

>
> >       /* Configure and allocate resources for qplib */
> >       rdev->qplib_res.rcfw = &rdev->rcfw;
> >       rc = bnxt_qplib_get_dev_attr(&rdev->rcfw, &rdev->dev_attr,
> > @@ -1030,10 +1031,13 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
> >       if (rc)
> >               goto dealloc_res;
> >
> > +     qplib_ctx = &rdev->qplib_ctx;
> >       for (i = 0; i < rdev->num_msix - 1; i++) {
> > -             rdev->nq[i].res = &rdev->qplib_res;
> > -             rdev->nq[i].hwq.max_elements = BNXT_RE_MAX_CQ_COUNT +
> > -                     BNXT_RE_MAX_SRQC_COUNT + 2;
> > +             struct bnxt_qplib_nq *nq;
> > +
> > +             nq = &rdev->nq[i];
> > +             nq->hwq.max_elements = (qplib_ctx->cq_count +
> > +                                     qplib_ctx->srqc_count + 2);
> >               rc = bnxt_qplib_alloc_nq(&rdev->qplib_res, &rdev->nq[i]);
> >               if (rc) {
> >                       dev_err(rdev_to_dev(rdev), "Alloc Failed NQ%d rc:%#x",
> > @@ -1041,12 +1045,13 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
> >                       goto free_nq;
> >               }
> >               type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
> > -             pg_map = rdev->nq[i].hwq.pbl[PBL_LVL_0].pg_map_arr;
> > -             pages = rdev->nq[i].hwq.pbl[rdev->nq[i].hwq.level].pg_count;
> > -             rc = bnxt_re_net_ring_alloc(rdev, pg_map, pages, type,
> > -                                         BNXT_QPLIB_NQE_MAX_CNT - 1,
> > -                                         rdev->msix_entries[i + 1].ring_idx,
> > -                                         &rdev->nq[i].ring_id);
> > +             rattr.dma_arr = nq->hwq.pbl[PBL_LVL_0].pg_map_arr;
> > +             rattr.pages = nq->hwq.pbl[rdev->nq[i].hwq.level].pg_count;
> > +             rattr.type = type;
> > +             rattr.mode = RING_ALLOC_REQ_INT_MODE_MSIX;
> > +             rattr.depth = BNXT_QPLIB_NQE_MAX_CNT - 1;
> > +             rattr.lrid = rdev->msix_entries[i + 1].ring_idx;
> > +             rc = bnxt_re_net_ring_alloc(rdev, &rattr, &nq->ring_id);
> >               if (rc) {
> >                       dev_err(rdev_to_dev(rdev),
> >                               "Failed to allocate NQ fw id with rc = 0x%x",
> > @@ -1371,10 +1376,10 @@ static void bnxt_re_worker(struct work_struct *work)
> >
> >  static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
> >  {
> > -     dma_addr_t *pg_map;
> > -     u32 db_offt, ridx;
> > -     int pages, vid;
> > +     struct bnxt_re_ring_attr rattr;
> > +     u32 db_offt;
> >       bool locked;
> > +     int vid;
> >       u8 type;
> >       int rc;
> >
> > @@ -1383,6 +1388,7 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
> >       locked = true;
> >
> >       /* Registered a new RoCE device instance to netdev */
> > +     memset(&rattr, 0, sizeof(rattr));
>
> ditto
>
> >       rc = bnxt_re_register_netdev(rdev);
> >       if (rc) {
> >               rtnl_unlock();
> > @@ -1422,12 +1428,13 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
> >       }
> >
> >       type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
> > -     pg_map = rdev->rcfw.creq.pbl[PBL_LVL_0].pg_map_arr;
> > -     pages = rdev->rcfw.creq.pbl[rdev->rcfw.creq.level].pg_count;
> > -     ridx = rdev->msix_entries[BNXT_RE_AEQ_IDX].ring_idx;
> > -     rc = bnxt_re_net_ring_alloc(rdev, pg_map, pages, type,
> > -                                 BNXT_QPLIB_CREQE_MAX_CNT - 1,
> > -                                 ridx, &rdev->rcfw.creq_ring_id);
> > +     rattr.dma_arr = rdev->rcfw.creq.pbl[PBL_LVL_0].pg_map_arr;
> > +     rattr.pages = rdev->rcfw.creq.pbl[rdev->rcfw.creq.level].pg_count;
> > +     rattr.type = type;
> > +     rattr.mode = RING_ALLOC_REQ_INT_MODE_MSIX;
> > +     rattr.depth = BNXT_QPLIB_CREQE_MAX_CNT - 1;
> > +     rattr.lrid = rdev->msix_entries[BNXT_RE_AEQ_IDX].ring_idx;
> > +     rc = bnxt_re_net_ring_alloc(rdev, &rattr, &rdev->rcfw.creq_ring_id);
> >       if (rc) {
> >               pr_err("Failed to allocate CREQ: %#x\n", rc);
> >               goto free_rcfw;
> > --
> > 1.8.3.1
> >
