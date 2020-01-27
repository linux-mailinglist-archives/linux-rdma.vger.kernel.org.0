Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37FD7149F64
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2020 09:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgA0ICV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jan 2020 03:02:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgA0ICV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Jan 2020 03:02:21 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D40072071E;
        Mon, 27 Jan 2020 08:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580112139;
        bh=xAAjm4hit5cEdS4MqviI3cOFrPXuPXDHiOPprOdfNJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mv5sDVDFiXOZCo3N35rG+Miw7jYJqdNlaWpn9OempYyyAKhbh98FNx6JS2C1fYZUV
         KYCSup6/Cz/u7Tjm1z4EEeCuj4P08BaLVX/9QSbGaa86pBNzUI5HIhpkPVaDPebjyX
         57Z7ssjNe5Go5JdVMQu2PhNj1CL3PGaNvymUrnJ8=
Date:   Mon, 27 Jan 2020 10:02:16 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next 4/7] RDMA/bnxt_re: Refactor net ring allocation
 function
Message-ID: <20200127080216.GK3870@unreal>
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-5-git-send-email-devesh.sharma@broadcom.com>
 <20200126142928.GG2993@unreal>
 <CANjDDBhxVC0ps8ee5NTW3QrN9bFNVdEcwxS2=Kfn1uOfDR2v_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjDDBhxVC0ps8ee5NTW3QrN9bFNVdEcwxS2=Kfn1uOfDR2v_A@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 27, 2020 at 01:10:10PM +0530, Devesh Sharma wrote:
> On Sun, Jan 26, 2020 at 7:59 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Jan 24, 2020 at 12:52:42AM -0500, Devesh Sharma wrote:
> > > Introducing a new attribute structure to reduce
> > > the long list of arguments passed in bnxt_re_net_ring_alloc()
> > > function.
> > >
> > > The caller of bnxt_re_net_ring_alloc should fill in
> > > the list of attributes in bnxt_re_ring_attr structure
> > > and then pass the pointer to the function.
> > >
> > > Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
> > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> > > ---
> > >  drivers/infiniband/hw/bnxt_re/bnxt_re.h |  9 +++++
> > >  drivers/infiniband/hw/bnxt_re/main.c    | 65 ++++++++++++++++++---------------
> > >  2 files changed, 45 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> > > index 86274f4..c736e82 100644
> > > --- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> > > +++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> > > @@ -89,6 +89,15 @@
> > >
> > >  #define BNXT_RE_DEFAULT_ACK_DELAY    16
> > >
> > > +struct bnxt_re_ring_attr {
> > > +     dma_addr_t      *dma_arr;
> > > +     int             pages;
> > > +     int             type;
> > > +     u32             depth;
> > > +     u32             lrid; /* Logical ring id */
> > > +     u8              mode;
> > > +};
> > > +
> > >  struct bnxt_re_work {
> > >       struct work_struct      work;
> > >       unsigned long           event;
> > > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> > > index a966c68..648a5ea 100644
> > > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > > @@ -427,9 +427,9 @@ static int bnxt_re_net_ring_free(struct bnxt_re_dev *rdev,
> > >       return rc;
> > >  }
> > >
> > > -static int bnxt_re_net_ring_alloc(struct bnxt_re_dev *rdev, dma_addr_t *dma_arr,
> > > -                               int pages, int type, u32 ring_mask,
> > > -                               u32 map_index, u16 *fw_ring_id)
> > > +static int bnxt_re_net_ring_alloc(struct bnxt_re_dev *rdev,
> > > +                               struct bnxt_re_ring_attr *ring_attr,
> > > +                               u16 *fw_ring_id)
> > >  {
> > >       struct bnxt_en_dev *en_dev = rdev->en_dev;
> > >       struct hwrm_ring_alloc_input req = {0};
> > > @@ -443,18 +443,18 @@ static int bnxt_re_net_ring_alloc(struct bnxt_re_dev *rdev, dma_addr_t *dma_arr,
> > >       memset(&fw_msg, 0, sizeof(fw_msg));
> > >       bnxt_re_init_hwrm_hdr(rdev, (void *)&req, HWRM_RING_ALLOC, -1, -1);
> > >       req.enables = 0;
> > > -     req.page_tbl_addr =  cpu_to_le64(dma_arr[0]);
> > > -     if (pages > 1) {
> > > +     req.page_tbl_addr =  cpu_to_le64(ring_attr->dma_arr[0]);
> > > +     if (ring_attr->pages > 1) {
> > >               /* Page size is in log2 units */
> > >               req.page_size = BNXT_PAGE_SHIFT;
> > >               req.page_tbl_depth = 1;
> > >       }
> > >       req.fbo = 0;
> > >       /* Association of ring index with doorbell index and MSIX number */
> > > -     req.logical_id = cpu_to_le16(map_index);
> > > -     req.length = cpu_to_le32(ring_mask + 1);
> > > -     req.ring_type = type;
> > > -     req.int_mode = RING_ALLOC_REQ_INT_MODE_MSIX;
> > > +     req.logical_id = cpu_to_le16(ring_attr->lrid);
> > > +     req.length = cpu_to_le32(ring_attr->depth + 1);
> > > +     req.ring_type = ring_attr->type;
> > > +     req.int_mode = ring_attr->mode;
> > >       bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
> > >                           sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
> > >       rc = en_dev->en_ops->bnxt_send_fw_msg(en_dev, BNXT_ROCE_ULP, &fw_msg);
> > > @@ -1006,12 +1006,13 @@ static void bnxt_re_free_res(struct bnxt_re_dev *rdev)
> > >
> > >  static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
> > >  {
> > > +     struct bnxt_qplib_ctx *qplib_ctx;
> > > +     struct bnxt_re_ring_attr rattr;
> > >       int num_vec_created = 0;
> > > -     dma_addr_t *pg_map;
> > >       int rc = 0, i;
> > > -     int pages;
> > >       u8 type;
> > >
> > > +     memset(&rattr, 0, sizeof(rattr));
> >
> > Initialize rattr to zero from the beginning and save call to memset.
> I moved from static initialization to memset due to some sparse/smatch
> warnings, rattr has a "pointer member".

Can you share the error and tool version, because it is pretty common
way to initialize variables? Also "= {0}" would solve your checker
warning.

Thanks
