Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343853ECD60
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Aug 2021 05:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhHPD4V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Aug 2021 23:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhHPD4U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Aug 2021 23:56:20 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C222C061764
        for <linux-rdma@vger.kernel.org>; Sun, 15 Aug 2021 20:55:50 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id n1-20020a9d1e810000b0290514da4485e4so16712087otn.4
        for <linux-rdma@vger.kernel.org>; Sun, 15 Aug 2021 20:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z6IXTugj+COmKqsCS5NIy0SPIiVCzpfU94xwbgJZ+lU=;
        b=mKW9Nf+G1iK9gAq+axOrlokGadOjy0Xs/8dqSm26fzI/Gcyy+BF65kzqYfhA7L5vFb
         Eo99fIn3M3Hs/B4nZF57Do4TD5xCd7gyXknGf0dYGBIMyt/HW/iVJ9ykzCw7/CeUuSKm
         e1RBeJVVoRw9TRoAccOa3KMYn/IfBJQlz6eWRdFiZeU96cnAifxbX/itx2oAC2wP1C8o
         I2vJ7yg9X/e0WdCki226mRnkbsCxQ6Vcjxc5VRcPtIrN4o4rdQfuojPRtGAo7xNtx/oz
         pD6anlFmG7IU3lj+1Zp0F4e/Kt21NU4/VEt/nYOPfXxnFsGEg90FHZ1H2c2Ko90ojNW1
         IeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z6IXTugj+COmKqsCS5NIy0SPIiVCzpfU94xwbgJZ+lU=;
        b=Rlf0jbHWYRzj1Qtq4BOLrcBvel0TDY7M6FGdfcfGlsZLMvy37iD69wYFyQtLmDV1xz
         wPYD7dIVU9akuWNnf1m2PbLpHOkJciyiKO1YuWsjDr7ybPDFcwOk2Shg9Dz3ye4zmTDF
         ParO4qpFb5oJMCSddGJGpikCdTb5AoYGkvEazQPyMiauFKompxQL8OHGAqNL4r8AxeaY
         y8OrqUrNbmPSlZ2RAypdcK9QvwGkGkgcYvv2gsfipr6ExS857kACTirmgVrtumm7ih1N
         ugRsmsu0HixnLJ2zPD29hOVnTlGPJOW/k2LZ41POYiC8B/Ku/I1JZ9MGGZwgOdwv4s0e
         ooVw==
X-Gm-Message-State: AOAM531dYO1sB1l9UJ1o6DVX4XlhReQS7/1DZvOkYfQXtdmUh1hJbQOz
        pE/tWTzEXMy8bz02qLt5S2Z2kUldaojxTG/Wjhk=
X-Google-Smtp-Source: ABdhPJxVEuVIsVqPEd8tyd0n2hpAG5fezBAD5gcrRJ/02nOplQiZtywIeUHT9KDTDbb/qmxziSIgwC3TQt79UJBZHzU=
X-Received: by 2002:a05:6830:149a:: with SMTP id s26mr6397495otq.59.1629086149378;
 Sun, 15 Aug 2021 20:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210809150738.150596-1-yangx.jy@fujitsu.com> <7279c618-d373-d7ce-c67c-97e519b48e94@gmail.com>
In-Reply-To: <7279c618-d373-d7ce-c67c-97e519b48e94@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 16 Aug 2021 11:55:38 +0800
Message-ID: <CAD=hENc2gt98YyhOC=EsSTsN0=-EZ7Pz1Kht96HYNA+qvdfWyQ@mail.gmail.com>
Subject: Re: [PATCH v2] providers/rxe: Set the correct value of resid for
 inline data
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Xiao Yang <yangx.jy@fujitsu.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Aug 14, 2021 at 6:11 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 8/9/21 10:07 AM, Xiao Yang wrote:
> > Resid indicates the residual length of transmitted bytes but current
> > rxe sets it to zero for inline data at the beginning.  In this case,
> > request will transmit zero byte to responder wrongly.
> >
> > Resid should be set to the total length of transmitted bytes at the
> > beginning.
> >
> > Note:
> > Just remove the useless setting of resid in init_send_wqe().
> >
> > Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex verb")
> > Fixes: 8337db5df125 ("Providers/rxe: Implement memory windows")
> > Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> > ---
> >  providers/rxe/rxe.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
> > index 3c3ea8bb..3533a325 100644
> > --- a/providers/rxe/rxe.c
> > +++ b/providers/rxe/rxe.c
> > @@ -1004,7 +1004,7 @@ static void wr_set_inline_data(struct ibv_qp_ex *=
ibqp, void *addr,
> >
> >       memcpy(wqe->dma.inline_data, addr, length);
> >       wqe->dma.length =3D length;
> > -     wqe->dma.resid =3D 0;
> > +     wqe->dma.resid =3D length;
> >  }
> >
> >  static void wr_set_inline_data_list(struct ibv_qp_ex *ibqp, size_t num=
_buf,
> > @@ -1035,6 +1035,7 @@ static void wr_set_inline_data_list(struct ibv_qp=
_ex *ibqp, size_t num_buf,
> >       }
> >
> >       wqe->dma.length =3D tot_length;
> > +     wqe->dma.resid =3D tot_length;
> >  }
> >
> >  static void wr_set_sge(struct ibv_qp_ex *ibqp, uint32_t lkey, uint64_t=
 addr,
> > @@ -1473,8 +1474,6 @@ static int init_send_wqe(struct rxe_qp *qp, struc=
t rxe_wq *sq,
> >       if (ibwr->send_flags & IBV_SEND_INLINE) {
> >               uint8_t *inline_data =3D wqe->dma.inline_data;
> >
> > -             wqe->dma.resid =3D 0;
> > -
> >               for (i =3D 0; i < num_sge; i++) {
> >                       memcpy(inline_data,
> >                              (uint8_t *)(long)ibwr->sg_list[i].addr,
> >
>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>

The Signed-off-by: tag indicates that the signer was involved in the
development of the patch, or that he/she was in the patch=E2=80=99s deliver=
y
path.

Zhu Yanjun
