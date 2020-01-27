Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFFE14A5D3
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2020 15:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgA0OPV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jan 2020 09:15:21 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:43185 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgA0OPV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jan 2020 09:15:21 -0500
Received: by mail-il1-f194.google.com with SMTP id o13so6914687ilg.10
        for <linux-rdma@vger.kernel.org>; Mon, 27 Jan 2020 06:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTVOP036S+y34sP8EJEd8YVtpi8I4LqxONXKe76YoGM=;
        b=cVG0YsK/5VER3dU2AjAX70RiFEWELW2QAY7jowAttokN7fcIeOM/GM96owqTEN9HXY
         O8ouB4uD48aVNctqDrQl3eJlMDXU07GRDJiLqJAAcgofkh+7Tw7kRtvMBym6TcIucleq
         cVTeCuP2SAHmVzXxyI/jC4FvoTY+evdjzZqwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTVOP036S+y34sP8EJEd8YVtpi8I4LqxONXKe76YoGM=;
        b=KTXtSc2hfL5MmAsgeAHfqDfzxKB+iNXkhCgeEr/boVBnk8hOiNTyRidoy0Dgf6W7c+
         aO/1FA0j1EUpSgX5PJ/7isPuQTZSDC9nkykmNPckXb+vX8+snIdlS9uPEID9ugJTemUi
         OQxslzAa0rtyvwiUXR+R+JSujDBAgTHFoBzF1Wgy6sYvgNxyUIQbmKshO/olpBcnLEQk
         gqmAT1cFgrRGBGlH1ItJ/mdbPicjDXxXwvn7rgRaAIV8JiRfXeTFdpXP8xIaRbA1eaWe
         vG+5PuggvHK4EF+hLlyOu6Gzj3acswdMOsl+P1Ijchb1pfS9uMMSlHyHLKZFLrGz8Xcv
         RFVA==
X-Gm-Message-State: APjAAAVjE3WVfjUxFSbFQDlBX2XSNNFuKnE6jKzFy2UL35yJW47FCQSe
        ZHtvczeHMIKq9agaaXW/sbsz2nSpnXWTwr1/qQnOhYOrlAA=
X-Google-Smtp-Source: APXvYqzAFfYlOouWoviawo3vBRxlCTDX65vFm4gfC/ZQwlMw/4aT+BO9AnT5KtdlBnz0TaResyBfMf9yeuiMihxSAHo=
X-Received: by 2002:a92:bf10:: with SMTP id z16mr15243954ilh.87.1580134520178;
 Mon, 27 Jan 2020 06:15:20 -0800 (PST)
MIME-Version: 1.0
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-5-git-send-email-devesh.sharma@broadcom.com>
 <20200126142928.GG2993@unreal> <CANjDDBhxVC0ps8ee5NTW3QrN9bFNVdEcwxS2=Kfn1uOfDR2v_A@mail.gmail.com>
 <20200127080216.GK3870@unreal> <CANjDDBj_vieac6bzbNHNa-WhzpRoSJfOG-bQNqK7U8fN7A+WaA@mail.gmail.com>
 <20200127124404.GP3870@unreal>
In-Reply-To: <20200127124404.GP3870@unreal>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Mon, 27 Jan 2020 19:44:43 +0530
Message-ID: <CANjDDBh4afTVznxGo8U0bafm9LQv0p+w5VHU6rcXu+Q9htvdQg@mail.gmail.com>
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

On Mon, Jan 27, 2020 at 6:14 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Jan 27, 2020 at 04:55:07PM +0530, Devesh Sharma wrote:
> > On Mon, Jan 27, 2020 at 1:32 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Mon, Jan 27, 2020 at 01:10:10PM +0530, Devesh Sharma wrote:
> > > > On Sun, Jan 26, 2020 at 7:59 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > >
> > > > > On Fri, Jan 24, 2020 at 12:52:42AM -0500, Devesh Sharma wrote:
> > > > > > Introducing a new attribute structure to reduce
> > > > > > the long list of arguments passed in bnxt_re_net_ring_alloc()
> > > > > > function.
> > > > > >
> > > > > > The caller of bnxt_re_net_ring_alloc should fill in
> > > > > > the list of attributes in bnxt_re_ring_attr structure
> > > > > > and then pass the pointer to the function.
> > > > > >
> > > > > > Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
> > > > > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > > > > Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> > > > > > ---
> > > > > >  drivers/infiniband/hw/bnxt_re/bnxt_re.h |  9 +++++
> > > > > >  drivers/infiniband/hw/bnxt_re/main.c    | 65 ++++++++++++++++++---------------
> > > > > >  2 files changed, 45 insertions(+), 29 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> > > > > > index 86274f4..c736e82 100644
> > > > > > --- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> > > > > > +++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> > > > > > @@ -89,6 +89,15 @@
> > > > > >
> > > > > >  #define BNXT_RE_DEFAULT_ACK_DELAY    16
> > > > > >
> > > > > > +struct bnxt_re_ring_attr {
> > > > > > +     dma_addr_t      *dma_arr;
> > > > > > +     int             pages;
> > > > > > +     int             type;
> > > > > > +     u32             depth;
> > > > > > +     u32             lrid; /* Logical ring id */
> > > > > > +     u8              mode;
> > > > > > +};
> > > > > > +
> > > > > >  struct bnxt_re_work {
> > > > > >       struct work_struct      work;
> > > > > >       unsigned long           event;
> > > > > > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> > > > > > index a966c68..648a5ea 100644
> > > > > > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > > > > > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > > > > > @@ -427,9 +427,9 @@ static int bnxt_re_net_ring_free(struct bnxt_re_dev *rdev,
> > > > > >       return rc;
> > > > > >  }
> > > > > >
> > > > > > -static int bnxt_re_net_ring_alloc(struct bnxt_re_dev *rdev, dma_addr_t *dma_arr,
> > > > > > -                               int pages, int type, u32 ring_mask,
> > > > > > -                               u32 map_index, u16 *fw_ring_id)
> > > > > > +static int bnxt_re_net_ring_alloc(struct bnxt_re_dev *rdev,
> > > > > > +                               struct bnxt_re_ring_attr *ring_attr,
> > > > > > +                               u16 *fw_ring_id)
> > > > > >  {
> > > > > >       struct bnxt_en_dev *en_dev = rdev->en_dev;
> > > > > >       struct hwrm_ring_alloc_input req = {0};
> > > > > > @@ -443,18 +443,18 @@ static int bnxt_re_net_ring_alloc(struct bnxt_re_dev *rdev, dma_addr_t *dma_arr,
> > > > > >       memset(&fw_msg, 0, sizeof(fw_msg));
> > > > > >       bnxt_re_init_hwrm_hdr(rdev, (void *)&req, HWRM_RING_ALLOC, -1, -1);
> > > > > >       req.enables = 0;
> > > > > > -     req.page_tbl_addr =  cpu_to_le64(dma_arr[0]);
> > > > > > -     if (pages > 1) {
> > > > > > +     req.page_tbl_addr =  cpu_to_le64(ring_attr->dma_arr[0]);
> > > > > > +     if (ring_attr->pages > 1) {
> > > > > >               /* Page size is in log2 units */
> > > > > >               req.page_size = BNXT_PAGE_SHIFT;
> > > > > >               req.page_tbl_depth = 1;
> > > > > >       }
> > > > > >       req.fbo = 0;
> > > > > >       /* Association of ring index with doorbell index and MSIX number */
> > > > > > -     req.logical_id = cpu_to_le16(map_index);
> > > > > > -     req.length = cpu_to_le32(ring_mask + 1);
> > > > > > -     req.ring_type = type;
> > > > > > -     req.int_mode = RING_ALLOC_REQ_INT_MODE_MSIX;
> > > > > > +     req.logical_id = cpu_to_le16(ring_attr->lrid);
> > > > > > +     req.length = cpu_to_le32(ring_attr->depth + 1);
> > > > > > +     req.ring_type = ring_attr->type;
> > > > > > +     req.int_mode = ring_attr->mode;
> > > > > >       bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
> > > > > >                           sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
> > > > > >       rc = en_dev->en_ops->bnxt_send_fw_msg(en_dev, BNXT_ROCE_ULP, &fw_msg);
> > > > > > @@ -1006,12 +1006,13 @@ static void bnxt_re_free_res(struct bnxt_re_dev *rdev)
> > > > > >
> > > > > >  static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
> > > > > >  {
> > > > > > +     struct bnxt_qplib_ctx *qplib_ctx;
> > > > > > +     struct bnxt_re_ring_attr rattr;
> > > > > >       int num_vec_created = 0;
> > > > > > -     dma_addr_t *pg_map;
> > > > > >       int rc = 0, i;
> > > > > > -     int pages;
> > > > > >       u8 type;
> > > > > >
> > > > > > +     memset(&rattr, 0, sizeof(rattr));
> > > > >
> > > > > Initialize rattr to zero from the beginning and save call to memset.
> > > > I moved from static initialization to memset due to some sparse/smatch
> > > > warnings, rattr has a "pointer member".
> > >
> > > Can you share the error and tool version, because it is pretty common
> > > way to initialize variables? Also "= {0}" would solve your checker
> > > warning.
> > I will have to duplicate it again to report the precise warning but
> > based on my memory, sparse or smatch was shouting about "pointer
> > converted to integer without cast"
> > I guess that was because rattr.dma_arr is a pointer and static
> > initialization was assigning value 0 while it should had been NULL. If
> > you insist I would send you exact warning msg and tool-version-number
> > soon.
>
> Yes, please, because NULL is 0 and has special meaning in C standard.
This is what sparse warns about:
make C=2 CHECK="/data2/upstream/tools/sparse/sparse"
CF="-D__CHECK_ENDIAN__" drivers/infiniband/hw/bnxt_re/
  CHECK   drivers/infiniband/hw/bnxt_re/main.c
drivers/infiniband/hw/bnxt_re/main.c:1010:43: warning: Using plain
integer as NULL pointer

sparse version used:
v0.6.1-131-g22978b6b
>
> > >
> > > Thanks
