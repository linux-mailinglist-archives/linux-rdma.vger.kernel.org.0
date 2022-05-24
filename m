Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6EF53288A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 13:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbiEXLLb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 07:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbiEXLLa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 07:11:30 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D930D275D0
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 04:11:25 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id m6so20483663ljb.2
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 04:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xVnBZbCRUphkyh16ai2nREZrZxbPkwA82hYLAd2Zzso=;
        b=RkwIppmDYHJXX56n/FyBjxk3MGMGfPTfClH3bmZUrCQFDxJLnHHn5cjWIPXsT27HcA
         XzVDn8FlDaS6U+jmIbrfxasqHMzyTCD0qahJI35yRqmpaJaGni3hKyq3nlgYShtV3ZI3
         E4qGhV1vXkTeT64ddnX5ng8yvtRUsfzEZCNEH1mH/z3zXeZBY0OotJt2WuK99ORx+4Lj
         hatusqAr8E4g1n3Bg4w7R1J0pc5F+F2WRyJARGH4Bll7ayf4AIPrOU4ndTHv7/dBiMQj
         P+QWyrQxf0ZAWGLg972POI7aTWJRo4IPvxI/NakqsgAPQegmv+VpaoK/5NcN2zu/rSgB
         hHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xVnBZbCRUphkyh16ai2nREZrZxbPkwA82hYLAd2Zzso=;
        b=dECvkIgyMjL7vqBPgnFKszJ6tj5sP5FL6iqlWgE5wMp6I/IcfbirzFuv5jAk260X3B
         7cGIbp0h6T0XzVo1GWYUbngiO6adHB74tzgTtqHeKPJZ/wbeVF1CWaQpN6/hKknG2A63
         GtDiRhMOT0rziQj3DWa2GFO40wnqDQcPDe4CjB6EbSQwBbKyhJXlqfsp6tHf0sW5gNYb
         o+/fL+BlraZ4VNWFECP42eot6ySasu/0qe0CuPZClTmDmbOpHEy40OYDY9RSNc80x29h
         EJbSDTLOyo/Vsod9emRfWwhU4uoTL/6mfew0dTfP8uhCbHT2DGQPu7DjGf/jd6DI6t2D
         z0Yw==
X-Gm-Message-State: AOAM530ht+P6TyYRBaBmEc5z1kUFZYwamqaAicQG11GsMZKQDfGhep/Z
        +mRQDbTfy+i/kHXcPASqHw2PpVi4MCj86JebBbxknbiveKBlBw==
X-Google-Smtp-Source: ABdhPJyROYceKtdm/nVVHb86cT1f6EXtEvn8nI6cmA60nA0J3fVSBwYA3aUns9UnEKbP0eFEF4f+jpVtcIFl1OZb2Pw=
X-Received: by 2002:a05:651c:158b:b0:250:a056:7e48 with SMTP id
 h11-20020a05651c158b00b00250a0567e48mr16055465ljq.64.1653390684172; Tue, 24
 May 2022 04:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220520151926.2616318-1-haris.iqbal@ionos.com> <CAJpMwyhKt4rmuTRPMbxkEe1qB6C5Xv==nYz76xvuqdH-u=gOkw@mail.gmail.com>
In-Reply-To: <CAJpMwyhKt4rmuTRPMbxkEe1qB6C5Xv==nYz76xvuqdH-u=gOkw@mail.gmail.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Tue, 24 May 2022 13:11:13 +0200
Message-ID: <CAJpMwyg25fufaSJsqhWxyLLzrMmbQJTkaKENBBJjMMiKX+etjQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: For fast memory reg wr set both lkey and rkey
To:     linux-rdma@vger.kernel.org, jgg@ziepe.ca
Cc:     leon@kernel.org, jinpu.wang@ionos.com, aleksei.marov@ionos.com,
        danil.kipnis@ionos.com, rpearsonhpe@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 20, 2022 at 5:20 PM Haris Iqbal <haris.iqbal@ionos.com> wrote:
>
> On Fri, May 20, 2022 at 5:19 PM Md Haris Iqbal <haris.iqbal@ionos.com> wrote:
> >
> > Fixes: 001345339f4c ("RDMA/rxe: Separate HW and SW l/rkeys")
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > Signed-off-by: Aleksei Marov <aleksei.marov@ionos.com>
> > ---
> > Cc: rpearsonhpe@gmail.com
> > ---
> >  drivers/infiniband/sw/rxe/rxe_mr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> > index fc3942e04a1f..04eb804efb23 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> > @@ -648,7 +648,7 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
> >
> >         mr->access = access;
> >         mr->lkey = (mr->lkey & ~0xff) | key;
> > -       mr->rkey = (access & IB_ACCESS_REMOTE) ? mr->lkey : 0;
> > +       mr->rkey = mr->lkey;
> >         mr->state = RXE_MR_STATE_VALID;
> >
> >         set = mr->cur_map_set;
> > --
> > 2.25.1
>
> This code was changed in the below mentioned commit.
>
> commit 001345339f4ca85790a1644a74e33ae77ac116be
> Author: Bob Pearson <rpearsonhpe@gmail.com>
> Date:   Tue Sep 14 11:42:05 2021 -0500
>
>     RDMA/rxe: Separate HW and SW l/rkeys
>
>     Separate software and simulated hardware lkeys and rkeys for MRs and MWs.
>     This makes struct ib_mr and struct ib_mw isolated from hardware changes
>     triggered by executing work requests.
>
>     This change fixes a bug seen in blktest.
>
>     Link: https://lore.kernel.org/r/20210914164206.19768-4-rpearsonhpe@gmail.com
>     Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>     Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>
>
> After the change, mapping for rnbd/rtrs fails with the following error.
>
> Mapping error,
> Client
>
> [Fri May 20 20:27:45 2022] rdma_rxe: qp#17 moved to error state
> [Fri May 20 20:27:45 2022] rtrs_server L1211: <blya>: remote access
> error (wr_cqe: 000000002d27244a, type: 0, vendor_err: 0x0, len: 0)
>
> Server
> [Fri May 20 20:27:45 2022] rnbd_client L597: Mapping device
> /dev/nullb0 on session blya, (access_mode: rw, nr_poll_queues: 0)
> [Fri May 20 20:27:45 2022] rnbd_client L1208: [session=blya] mapped
> 4/4 default/read queues.
> [Fri May 20 20:27:45 2022] rtrs_client L605: <blya>: RDMA failed:
> remote access error
> [Fri May 20 20:27:45 2022] rtrs_client L346: <blya>: Failed
> IB_WR_LOCAL_INV: WR flushed
> [Fri May 20 20:27:45 2022] rtrs_client L605: <blya>: RDMA failed:
> remote access error
> [Fri May 20 20:27:45 2022] rtrs_client L346: <blya>: Failed
> IB_WR_LOCAL_INV: WR flushed
> [Fri May 20 20:27:45 2022] rnbd_client L413: </dev/nullb0@blya> read
> I/O failed with err: -103
> [Fri May 20 20:27:45 2022] I/O error, dev rnbd0, sector 0 op
> 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [Fri May 20 20:27:45 2022] rnbd_client L653: </dev/nullb0@blya> Device
> disconnected.
> [Fri May 20 20:27:45 2022] Buffer I/O error on dev rnbd0, logical
> block 0, async page read
> [Fri May 20 20:27:45 2022] rnbd_client L1049: </dev/nullb0@blya> RTRS
> failed to transfer IO, err: -103
> [Fri May 20 20:27:45 2022] I/O error, dev rnbd0, sector 0 op
> 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [Fri May 20 20:27:45 2022] Buffer I/O error on dev rnbd0, logical
> block 0, async page read
> [Fri May 20 20:27:45 2022] ldm_validate_partition_table(): Disk read failed.
> [Fri May 20 20:27:45 2022] rnbd_client L1049: </dev/nullb0@blya> RTRS
> failed to transfer IO, err: -103
> [Fri May 20 20:27:45 2022] I/O error, dev rnbd0, sector 0 op
> 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [Fri May 20 20:27:45 2022] Buffer I/O error on dev rnbd0, logical
> block 0, async page read
> [Fri May 20 20:27:45 2022] rnbd_client L1049: </dev/nullb0@blya> RTRS
> failed to transfer IO, err: -103
> [Fri May 20 20:27:45 2022] I/O error, dev rnbd0, sector 0 op
> 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [Fri May 20 20:27:45 2022] Buffer I/O error on dev rnbd0, logical
> block 0, async page read
> [Fri May 20 20:27:45 2022]  rnbd0: unable to read partition table
>
> Error on write
> Client
> [Fri May 20 20:28:39 2022] rdma_rxe: rxe_invalidate_mr: rkey (0x20416)
> doesn't match mr->rkey (0x0)
> [Fri May 20 20:28:39 2022] rtrs_client L346: <blya>: Failed
> IB_WR_LOCAL_INV: local QP operation error
>
> The code for rnbd/rtrs works fine on mlx4 and mlx5.
> From the spec perspective, is there a need for the wr access flag to
> be set while doing IB_WR_REG_MR?

We went through the IB spec and realized that what RXE is doing is correct.

in IBA spec it is said in sections
"10.6.3.7 FAST REGISTRATION"
..."If the free L_Key has an accompanying free R_Key, and the
Consumer requests Remote Access Rights, a Fast Registration associ-
ates the R_Key with a set of memory locations"

Hence my above patch is incorrect and should not be considered. The
correct fix would be to change the access flag in RTRS IB_WR_REG_MR
wr. We will send a patch soon.

But I do have a follow-up question. Since without this access flag,
the code works fine in mlx4 and mlx5, they are doing something
differently. Is this an issue?

>
>
>
>
> >
