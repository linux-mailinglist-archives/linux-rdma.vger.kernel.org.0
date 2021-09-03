Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401BC3FF921
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Sep 2021 05:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhICDgD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 23:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbhICDgD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Sep 2021 23:36:03 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA19C061575
        for <linux-rdma@vger.kernel.org>; Thu,  2 Sep 2021 20:35:04 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso5192900otu.0
        for <linux-rdma@vger.kernel.org>; Thu, 02 Sep 2021 20:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NHdOlbf0cPuMEbpfwIohExe1C6Lajv+o8RoiZnO1x+k=;
        b=St1veLN7w1ZFos0VnE+H7SxbU9DWjs4WPIFC49iM0fCEy/TRGLRs9s2zOBG4OzJcAK
         Ja/bnEgV1ZKQbAw/QjKmYqNikS1GcNTjfGcigebVGJoJMTwuVdvjtp4iYyE72K1KWdcf
         ky+ECzKWDMiMGe3N0fFC2Vv+62CwHQ7C/roL3D7HXWOMAUnrMBSu386nsyg6E/8wzlsR
         GUebnNZPSYVfqyJtHt5tNa9Yil8zFrnWp6aksstl/EcQLzswn/lMPEnzEXfZxcXq9lGH
         ix0YTBj6TfxzaFZCbvBeMe3SuuBn8GhBLoARDzvHGOdGZzxTzBMpfGXmugcXDOqIw4Gv
         pc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NHdOlbf0cPuMEbpfwIohExe1C6Lajv+o8RoiZnO1x+k=;
        b=N23bE2li53xoORH+qaydz2R+WHdQ9mQzRjg8LrJOA3il+ke6JGlu1mnrPZp9BzFn4z
         VLXEcVfG1oTvvOTteDI+zbjIJ107ANYTO/BIwP88hiD3vJb9vStth7wIVmVNGumBMUtP
         tIAQQ+N+TCXrfe9y9OZPMvg1p3FnkfJ2/MjM5FDlnUVzEaVnrEVOIyospjAv9ebkiYbl
         pQli7aMXTm8haUnXLUYePI0ioA82ZZw1uKxgD1Ff2P3gKBxAKeJluzoObG8iTCBYYFfy
         Ne4U/FjqOANsTzZPna/p+0azqlNTsmhWutrbHZe45QuZeHAx7UlKMK/rFrc0Elq2tW2I
         MD+Q==
X-Gm-Message-State: AOAM532zyocVryvPUmcchCav7g28yfi315vfkuWCBVl8CMbEHkDzR3Ag
        A4t5i99/lWY4BtSmCU1mD851ys0XLKp3Eh3+2BM=
X-Google-Smtp-Source: ABdhPJxFu1pJ2zgGrp8RpvjeCXV5W2xQwI+BBJk61qSGvadvL5IzxGpWP3stfKw5ZF2jGmEWCQKyXqzJ3jC7OVxo++Y=
X-Received: by 2002:a05:6830:149a:: with SMTP id s26mr1253972otq.59.1630640103466;
 Thu, 02 Sep 2021 20:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210809150738.150596-1-yangx.jy@fujitsu.com> <7279c618-d373-d7ce-c67c-97e519b48e94@gmail.com>
 <CAD=hENc2gt98YyhOC=EsSTsN0=-EZ7Pz1Kht96HYNA+qvdfWyQ@mail.gmail.com>
 <324764c2-4f41-0106-70e0-aaccb3c50c15@gmail.com> <6122FAE1.4080306@fujitsu.com>
 <YSYQ6hLAebrnGow6@unreal> <61308B01.9050706@fujitsu.com>
In-Reply-To: <61308B01.9050706@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 3 Sep 2021 11:34:51 +0800
Message-ID: <CAD=hENedW_tGctDrBUvx=YH82zrH=Zr0Fov8GZcfsZGRK05Rzw@mail.gmail.com>
Subject: Re: [PATCH v2] providers/rxe: Set the correct value of resid for
 inline data
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 2, 2021 at 4:27 PM yangx.jy@fujitsu.com
<yangx.jy@fujitsu.com> wrote:
>
> Hi Yanjun, Bob
>
> Ping. :

Sorry. It is late to reply.
My concern is if this will introduce other risks or not.
If you can confirm that this will not introduce other risks,
I am fine with this commit.

Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>

>
> Best Regards,
> Xiao Yang
> On 2021/8/25 17:44, Leon Romanovsky wrote:
> > On Mon, Aug 23, 2021 at 01:33:24AM +0000, yangx.jy@fujitsu.com wrote:
> >> Hi Leon,
> >>
> >> Could you review the patch?
> > There is no need, I trust to Zhu's and Bob's review.
> >
> > Thanks
> >
> >> Best Regards,
> >> Xiao Yang
> >> On 2021/8/17 2:52, Bob Pearson wrote:
> >>> On 8/15/21 10:55 PM, Zhu Yanjun wrote:
> >>>> On Sat, Aug 14, 2021 at 6:11 AM Bob Pearson<rpearsonhpe@gmail.com>  =
 wrote:
> >>>>> On 8/9/21 10:07 AM, Xiao Yang wrote:
> >>>>>> Resid indicates the residual length of transmitted bytes but curre=
nt
> >>>>>> rxe sets it to zero for inline data at the beginning.  In this cas=
e,
> >>>>>> request will transmit zero byte to responder wrongly.
> >>>>>>
> >>>>>> Resid should be set to the total length of transmitted bytes at th=
e
> >>>>>> beginning.
> >>>>>>
> >>>>>> Note:
> >>>>>> Just remove the useless setting of resid in init_send_wqe().
> >>>>>>
> >>>>>> Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex ve=
rb")
> >>>>>> Fixes: 8337db5df125 ("Providers/rxe: Implement memory windows")
> >>>>>> Signed-off-by: Xiao Yang<yangx.jy@fujitsu.com>
> >>>>>> ---
> >>>>>>    providers/rxe/rxe.c | 5 ++---
> >>>>>>    1 file changed, 2 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
> >>>>>> index 3c3ea8bb..3533a325 100644
> >>>>>> --- a/providers/rxe/rxe.c
> >>>>>> +++ b/providers/rxe/rxe.c
> >>>>>> @@ -1004,7 +1004,7 @@ static void wr_set_inline_data(struct ibv_qp=
_ex *ibqp, void *addr,
> >>>>>>
> >>>>>>         memcpy(wqe->dma.inline_data, addr, length);
> >>>>>>         wqe->dma.length =3D length;
> >>>>>> -     wqe->dma.resid =3D 0;
> >>>>>> +     wqe->dma.resid =3D length;
> >>>>>>    }
> >>>>>>
> >>>>>>    static void wr_set_inline_data_list(struct ibv_qp_ex *ibqp, siz=
e_t num_buf,
> >>>>>> @@ -1035,6 +1035,7 @@ static void wr_set_inline_data_list(struct i=
bv_qp_ex *ibqp, size_t num_buf,
> >>>>>>         }
> >>>>>>
> >>>>>>         wqe->dma.length =3D tot_length;
> >>>>>> +     wqe->dma.resid =3D tot_length;
> >>>>>>    }
> >>>>>>
> >>>>>>    static void wr_set_sge(struct ibv_qp_ex *ibqp, uint32_t lkey, u=
int64_t addr,
> >>>>>> @@ -1473,8 +1474,6 @@ static int init_send_wqe(struct rxe_qp *qp, =
struct rxe_wq *sq,
> >>>>>>         if (ibwr->send_flags&   IBV_SEND_INLINE) {
> >>>>>>                 uint8_t *inline_data =3D wqe->dma.inline_data;
> >>>>>>
> >>>>>> -             wqe->dma.resid =3D 0;
> >>>>>> -
> >>>>>>                 for (i =3D 0; i<   num_sge; i++) {
> >>>>>>                         memcpy(inline_data,
> >>>>>>                                (uint8_t *)(long)ibwr->sg_list[i].a=
ddr,
> >>>>>>
> >>>>> Signed-off-by: Bob Pearson<rpearsonhpe@gmail.com>
> >>>> The Signed-off-by: tag indicates that the signer was involved in the
> >>>> development of the patch, or that he/she was in the patch=E2=80=99s =
delivery
> >>>> path.
> >>>>
> >>>> Zhu Yanjun
> >>>>
> >>> Sorry, my misunderstanding. Then I want to say
> >>>
> >>> Reviewed-by: Bob Pearson<rpearsonhpe@gmail.com>
> >>>
> >>> The patch looks correct to me.
