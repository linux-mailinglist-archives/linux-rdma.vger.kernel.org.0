Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4C03F4376
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 04:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhHWCpa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Aug 2021 22:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhHWCpa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 Aug 2021 22:45:30 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED24C061575
        for <linux-rdma@vger.kernel.org>; Sun, 22 Aug 2021 19:44:48 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id i3-20020a056830210300b0051af5666070so22772306otc.4
        for <linux-rdma@vger.kernel.org>; Sun, 22 Aug 2021 19:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vY/e7TqCtiwkLn9swsNIczA+coe1AG+PZ238UHzcb1Q=;
        b=WRKRkUB/u+36Ju6dkjc+ROPdW4Ulo/MDZf6OAhgd0gG0kCKy1akg4eG2tC1HDivskI
         gEk9o6f64aFSul900Cmnm8pLJAt33FcQ0E5LR4J14r+Bu3js5LGrGD9XXzfeJt7i4v9x
         Ndguvo0sUUT2pVmxiZAjbNk8ONAOyID0ZOSgktqWYoCQtATMcEcXEGBhtoMvJeNNBQzS
         ZaJc67CvpM9o7jhKXsOrmasVIT88+LnTGfZdjWLbuuBQN7JntobZK3Dljsd2yiBEdJ+q
         NayrXf5AVZnqnKUe65Y6rjMeF1EkFT5LG5SsIeBqWyWSVIPxIlKNI2dG2YJNSqItB3v7
         U+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vY/e7TqCtiwkLn9swsNIczA+coe1AG+PZ238UHzcb1Q=;
        b=FW2paUvayBOMuagsud47/pvm86lDq+Z0WtfikjVkUkPz1xmIlkHgHCvgEjjS4955pb
         /VqQ69prX2gTI0TGH4I/5ZIrkUR7g905C8KOOA8PNQ/fCmqH4xSMBpWnRhxjXha3srYH
         PGRI8/W++SaOMdku7G7v2hw3ydKPczazoXm2Bzu0H+ALhBgOpZqlRECdbDUGscFa30Hs
         4iyEQhh7OlgEYC2Q7Xk+Cs11DA7uJo5V4/NhHfxHfzJzPlCan+KbJI4uwW1mIfhGKtoz
         olCO+7F8zSCESGnet8InVE8vce9qGec6q+hzjbf9NLO9lWtsG8rQ+OTlDcGcp8uuuDo/
         j/FQ==
X-Gm-Message-State: AOAM533CfdozlPll2dlrkgi8FAZaNNf1GiFSMlfFaR41ZFPAbO2BK7g7
        QToCjcS5giv9cusJJJ97EOKCRHFtLdV8TeeFYh/Rhs3DINs=
X-Google-Smtp-Source: ABdhPJwVSrVFt8h6RLTaX2iHKFpjDUUs6+lyuecQrnDycv2udvmf60ZeGbmWaVyY6pDPKclA8aYcwdbwcTHcLhM3mkI=
X-Received: by 2002:a05:6830:1f0a:: with SMTP id u10mr20330793otg.53.1629686687607;
 Sun, 22 Aug 2021 19:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210809150738.150596-1-yangx.jy@fujitsu.com> <CAD=hENd6StySon04rW1CPeJbN1KFPDDP1JFsYNBxXNYYegtF5A@mail.gmail.com>
 <6112A9FA.2050300@fujitsu.com> <CAD=hENdB6chvVtzgcYunhTNuHDGbYi8=ePnGKhOwuF83HY8O1w@mail.gmail.com>
 <611B08D8.90605@fujitsu.com>
In-Reply-To: <611B08D8.90605@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 23 Aug 2021 10:44:35 +0800
Message-ID: <CAD=hENeOka=Fm5WqyFK3mY27t8wRqt4uZ0gQ5GJ027KhZcQVuQ@mail.gmail.com>
Subject: Re: [PATCH v2] providers/rxe: Set the correct value of resid for
 inline data
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 17, 2021 at 8:54 AM yangx.jy@fujitsu.com
<yangx.jy@fujitsu.com> wrote:
>
> On 2021/8/16 15:47, Zhu Yanjun wrote:
> > On Wed, Aug 11, 2021 at 12:33 AM yangx.jy@fujitsu.com
> > <yangx.jy@fujitsu.com>  wrote:
> >> On 2021/8/10 11:40, Zhu Yanjun wrote:
> >>> On Mon, Aug 9, 2021 at 10:43 PM Xiao Yang<yangx.jy@fujitsu.com>  wrote:
> >>>> Resid indicates the residual length of transmitted bytes but current
> >>>> rxe sets it to zero for inline data at the beginning.  In this case,
> >>>> request will transmit zero byte to responder wrongly.
> >>> What are the symptoms if resid is set to zero?
> >> Hi Yanjun,
> >>
> >> You can construct code by the attached patch and then run
> >> rdma_client/server to reproduce the issue.
> >>
> >> If resid is set to zero, running rdma_client/server:
> >> --------------------------------
> >> # ./rdma_client -s 10.167.220.99 -p 8765
> >> rdma_client: start
> >> rdma_client: end 0
> >>
> >> # ./rdma_server -s 10.167.220.99 -p 8765
> >> rdma_server: start
> >> wc.byte_len 0 recv_msg bbbbbbbbbbbbbbbb
> >> rdma_server: end 0
> >> --------------------------------
> >>
> >> rdma_client sends zero byte instead of 16 btyes to rdma_server.
> >> rdma_server receives zero byte instead of 16 btyes from rdma_client.
> >>
> >> Please also see the logic about resid in kernel, for example:
> >> --------------------------------
> >> int rxe_requester(void *arg)
> >> {
> >> ...
> >> payload = (mask&  RXE_WRITE_OR_SEND) ? wqe->dma.resid : 0;
> >> ...
> >> skb = init_req_packet(qp, wqe, opcode, payload,&pkt);
> >> ...
> >> }
> >> --------------------------------
> >>
> >> Best Regards,
> >> Xiao Yang
> > Follow your steps on the latest rdma-core and linux upstream,
> > make tests with the followings:
> > "
> > diff --git a/librdmacm/examples/rdma_client.c b/librdmacm/examples/rdma_client.c
> > index c27047c5..6734757b 100644
> > --- a/librdmacm/examples/rdma_client.c
> > +++ b/librdmacm/examples/rdma_client.c
> > @@ -52,6 +52,7 @@ static int run(void)
> >          struct ibv_wc wc;
> >          int ret;
> >
> > +       memset(send_msg, 'a', 16);
> >          memset(&hints, 0, sizeof hints);
> >          hints.ai_port_space = RDMA_PS_TCP;
> >          ret = rdma_getaddrinfo(server, port,&hints,&res);
> > diff --git a/librdmacm/examples/rdma_server.c b/librdmacm/examples/rdma_server.c
> > index f9c766b2..afa20996 100644
> > --- a/librdmacm/examples/rdma_server.c
> > +++ b/librdmacm/examples/rdma_server.c
> > @@ -132,6 +132,7 @@ static int run(void)
> >                  goto out_disconnect;
> >          }
> >
> > +       printf("wc.byte_len %u recv_msg %s\n", wc.byte_len, recv_msg);
> >          ret = rdma_post_send(id, NULL, send_msg, 16, send_mr, send_flags);
> >          if (ret) {
> >                  perror("rdma_post_send");
> > "
> > The followings are results:
> >
> > # ./build/bin/rdma_server -s 10.238.154.61 -p 5486&
> > [1] 10812
> > # rdma_server: start
> >
> > # ./build/bin/rdma_client -s 10.238.154.61 -p 5486&
> > [2] 10815
> > # rdma_client: start
> > wc.byte_len 16 recv_msg aaaaaaaaaaaaaaaa<--------------it seems
> > that inline is 16?
> > rdma_server: end 0
> > rdma_client: end 0
> > [1]-  Done                    ./build/bin/rdma_server -s 10.238.154.61 -p 5486
> > [2]+  Done                    ./build/bin/rdma_client -s 10.238.154.61 -p 5486
> >
> > What does your commit fix?
> Hi Yanjun,
>
> You missed the change that sets resid to zero on purpose:
> -------------------------------------------------------------
>
> diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
> index 3c3ea8bb..ed5479fe 100644
> --- a/providers/rxe/rxe.c
> +++ b/providers/rxe/rxe.c
> @@ -1492,7 +1492,7 @@ static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
>                 wqe->iova       = ibwr->wr.rdma.remote_addr;
>
>         wqe->dma.length         = length;
> -       wqe->dma.resid          = length;
> +       wqe->dma.resid          = 0;
>         wqe->dma.num_sge        = num_sge;
>         wqe->dma.cur_sge        = 0;
>         wqe->dma.sge_offset     = 0;
>
> -------------------------------------------------------------
> Note:
> It is also ok to remove "wqe->dma.resid = length" here because resid has
> been set to zero before.
>
> With the change, running rdma_client/server will show the impact.

With the original source code, the rdma_server/rdma_client can work well.

Why "wqe->dma.resid          = length;" is replaced by "wqe->dma.resid
         = 0;", then this problem appears?

Thanks
Zhu Yanjun


>
> I didn't use new API(e.g. ibv_wr_set_inline_data, ibv_wr_send) to create
> a new test
> but it is enough to show the impact of resid == 0 by doing some changes
> on rxe and
> rdma_client/server.
>
> Best Regards,
> Xiao Yang
> > Zhu Yanjun
> >
> >>> Thanks
> >>> Zhu Yanjun
> >>>
> >>>> Resid should be set to the total length of transmitted bytes at the
> >>>> beginning.
> >>>>
> >>>> Note:
> >>>> Just remove the useless setting of resid in init_send_wqe().
> >>>>
> >>>> Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex verb")
> >>>> Fixes: 8337db5df125 ("Providers/rxe: Implement memory windows")
> >>>> Signed-off-by: Xiao Yang<yangx.jy@fujitsu.com>
> >>>> ---
> >>>>   providers/rxe/rxe.c | 5 ++---
> >>>>   1 file changed, 2 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
> >>>> index 3c3ea8bb..3533a325 100644
> >>>> --- a/providers/rxe/rxe.c
> >>>> +++ b/providers/rxe/rxe.c
> >>>> @@ -1004,7 +1004,7 @@ static void wr_set_inline_data(struct ibv_qp_ex *ibqp, void *addr,
> >>>>
> >>>>          memcpy(wqe->dma.inline_data, addr, length);
> >>>>          wqe->dma.length = length;
> >>>> -       wqe->dma.resid = 0;
> >>>> +       wqe->dma.resid = length;
> >>>>   }
> >>>>
> >>>>   static void wr_set_inline_data_list(struct ibv_qp_ex *ibqp, size_t num_buf,
> >>>> @@ -1035,6 +1035,7 @@ static void wr_set_inline_data_list(struct ibv_qp_ex *ibqp, size_t num_buf,
> >>>>          }
> >>>>
> >>>>          wqe->dma.length = tot_length;
> >>>> +       wqe->dma.resid = tot_length;
> >>>>   }
> >>>>
> >>>>   static void wr_set_sge(struct ibv_qp_ex *ibqp, uint32_t lkey, uint64_t addr,
> >>>> @@ -1473,8 +1474,6 @@ static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
> >>>>          if (ibwr->send_flags&  IBV_SEND_INLINE) {
> >>>>                  uint8_t *inline_data = wqe->dma.inline_data;
> >>>>
> >>>> -               wqe->dma.resid = 0;
> >>>> -
> >>>>                  for (i = 0; i<  num_sge; i++) {
> >>>>                          memcpy(inline_data,
> >>>>                                 (uint8_t *)(long)ibwr->sg_list[i].addr,
> >>>> --
> >>>> 2.25.1
> >>>>
> >>>>
> >>>>
