Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E2157E393
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jul 2022 17:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbiGVPOV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jul 2022 11:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiGVPOV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jul 2022 11:14:21 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7616D9B9CF
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 08:14:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q43-20020a17090a17ae00b001f1f67e053cso4466743pja.4
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 08:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y5eFDftmXwgIIBngrfRuBc8e4rfXgpso7ev9tO8jcQ8=;
        b=OgEKfOXbIOXpmfrKcz4xGksjgGbM9/H/Smo4+kiLmfX712Q3ytcs9/UH9zuTFDKo+r
         vlNHEhB1/qnd/yz1D6b0eSMcorrgVx/sgVIguzQKlFSC/+EsoBGN2Rr0fs+uYtalyhoO
         TOdRp/7JaFHtxyHf3jDLay3np8VzmsXdOVyDzXQ3P8ePJ21MgcTUiUaSbnCse7DePoAS
         csOKUAtVwnFextPcO5BRN9PJ6gUR1wtAjjVfLSTsTlmC3IGrIVGaOnh66PdEWpdO9bzR
         sBWRJMBB+5TfZzwbnNNp4uqQDpYHZ5i/Z1LZnIfStGGelf/JTnpNFrz/vxDZpjr2VktS
         9BVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y5eFDftmXwgIIBngrfRuBc8e4rfXgpso7ev9tO8jcQ8=;
        b=vxgwV5vS5FZc4IwyMM8Q19/et7OJhcNC4je+XuS2dxJYsyNd5FW29N2gzHe31CTvv9
         on6Pe/ZvW9CqCov0WYEGZNurXLarHOJh/p0mCWJVTKv0cimdec51xD79xfL9qgwfPEbT
         M9SQCkT5+gueAAIsNMuqPe3dnzAxdEaiLSvfs1GFR9nCh8mNRnSKdWL+ISZB6nbiiQnt
         29M9xBe1nUngQxrRMswW+EWGnVm/TSUYuSziz2SqkAaIUTstpdRrMOBs2//vMpCLMxTz
         57loFCHlHb1XIT8t2O9jt7ZrfNrif80M0x4PKYKmo636x87YvjNLbW/436bVW7Z5rYAV
         oxGw==
X-Gm-Message-State: AJIora+NZacgs4+DS7juBIEE0hO+jtKqbDXa/4uCU04PD+eHdS53aX9p
        AyVn2/LulW5Le68f2AffOSVL1g==
X-Google-Smtp-Source: AGRyM1sjvo9FMzXxriLY/fIIvaRsBRYK0Zt+QWpLhlLNh5gvGBPa9Ocp8yikXg/jYPrCQrEaJ/GLIw==
X-Received: by 2002:a17:902:e80a:b0:16c:408c:e548 with SMTP id u10-20020a170902e80a00b0016c408ce548mr348519plg.171.1658502858366;
        Fri, 22 Jul 2022 08:14:18 -0700 (PDT)
Received: from ziepe.ca (S0106a84e3fe8c3f3.cg.shawcable.net. [24.64.144.200])
        by smtp.gmail.com with ESMTPSA id p127-20020a622985000000b00528d3d7194dsm4097095pfp.4.2022.07.22.08.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 08:14:17 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1oEuM4-000F7v-Lj; Fri, 22 Jul 2022 12:14:16 -0300
Date:   Fri, 22 Jul 2022 12:14:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     haris iqbal <haris.phnx@gmail.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com,
        Leon Romanovsky <leon@kernel.org>, haris.iqbal@ionos.com,
        Jinpu Wang <jinpu.wang@ionos.com>, aleksei.marov@ionos.com,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH] RDMA/rxe: For invalidate compare according to set keys
 in mr
Message-ID: <20220722151416.GB55077@ziepe.ca>
References: <20220707073006.328737-1-haris.phnx@gmail.com>
 <CAE_WKMzj3i6bKrHN_GuBpjoEzuQBXLoEZrXpsqKjtkxvM+ZbfA@mail.gmail.com>
 <CAE_WKMz9G8BYVA=pbNyZv7RdM0gvjDo15EzdgtgEAXcRpjjOmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE_WKMz9G8BYVA=pbNyZv7RdM0gvjDo15EzdgtgEAXcRpjjOmA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 22, 2022 at 05:10:46PM +0200, haris iqbal wrote:
> On Fri, Jul 15, 2022 at 11:21 AM haris iqbal <haris.phnx@gmail.com> wrote:
> >
> > On Thu, Jul 7, 2022 at 9:30 AM Md Haris Iqbal <haris.phnx@gmail.com> wrote:
> > >
> > > The 'rkey' input can be an lkey or rkey, and in rxe the lkey or rkey have
> > > the same value, including the variant bits.
> > >
> > > So, if mr->rkey is set, compare the invalidate key with it, otherwise
> > > compare with the mr->lkey.
> > >
> > > Since we already did a lookup on the non-varient bits to get this far,
> > > the check's only purpose is to confirm that the wqe has the correct
> > > variant bits.
> > >
> > > Fixes: 001345339f4c ("RDMA/rxe: Separate HW and SW l/rkeys")
> > > Cc: rpearsonhpe@gmail.com
> > > Signed-off-by: Md Haris Iqbal <haris.phnx@gmail.com>
> > > ---
> > >  drivers/infiniband/sw/rxe/rxe_loc.h |  2 +-
> > >  drivers/infiniband/sw/rxe/rxe_mr.c  | 12 ++++++------
> > >  2 files changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> > > index 0e022ae1b8a5..37484a559d20 100644
> > > --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> > > +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> > > @@ -77,7 +77,7 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
> > >                          enum rxe_mr_lookup_type type);
> > >  int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
> > >  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
> > > -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
> > > +int rxe_invalidate_mr(struct rxe_qp *qp, u32 key);
> > >  int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
> > >  int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
> > >  int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> > > index fc3942e04a1f..3add52129006 100644
> > > --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> > > +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> > > @@ -576,22 +576,22 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
> > >         return mr;
> > >  }
> > >
> > > -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
> > > +int rxe_invalidate_mr(struct rxe_qp *qp, u32 key)
> > >  {
> > >         struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> > >         struct rxe_mr *mr;
> > >         int ret;
> > >
> > > -       mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
> > > +       mr = rxe_pool_get_index(&rxe->mr_pool, key >> 8);
> > >         if (!mr) {
> > > -               pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
> > > +               pr_err("%s: No MR for key %#x\n", __func__, key);
> > >                 ret = -EINVAL;
> > >                 goto err;
> > >         }
> > >
> > > -       if (rkey != mr->rkey) {
> > > -               pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
> > > -                       __func__, rkey, mr->rkey);
> > > +       if (mr->rkey ? (key != mr->rkey) : (key != mr->lkey)) {
> > > +               pr_err("%s: wr key (%#x) doesn't match mr key (%#x)\n",
> > > +                       __func__, key, (mr->rkey ? mr->rkey : mr->lkey));
> > >                 ret = -EINVAL;
> > >                 goto err_drop_ref;
> > >         }
> >
> > Ping.
> 
> Ping.
> 
> Does this need more discussions or changes?

I was hoping Bob would say something but I am happy with it..

Jason
