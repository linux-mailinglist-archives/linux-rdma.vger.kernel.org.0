Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DB63ECFA3
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Aug 2021 09:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbhHPHs1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Aug 2021 03:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbhHPHsZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Aug 2021 03:48:25 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65935C061764
        for <linux-rdma@vger.kernel.org>; Mon, 16 Aug 2021 00:47:48 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so19930974oth.7
        for <linux-rdma@vger.kernel.org>; Mon, 16 Aug 2021 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnGIOBseYpp3kgTsuAQB/lbVUGgkNrUWpe2aW06lmJY=;
        b=U7XhoTgoQnoSKB3gvkJVoVbmEu3/7D2BhlrysEpQm0MID7IzbptOr0KZ+PoYXvr4+I
         omoFSgRNzEK7mI0hajg2x9qGoMZRiB6uXzijxhuztvdPr265M/qRU+xovTo3s5nrsKCW
         7Qtj871XLHsjdIAyvlDvH2uWlyy533M/fXBFVxH5Vhe0284NKH8naR2460sO0uKH8T6y
         1sAYdRT1ONJAmocNJtz5rQCFz+4cs6vB9p1Oh+p8EqNkbw54+REaj6d89uxMIiwh3XLR
         wvA1V1ynUPEGZPEQ0dKyRLTRnck07qv+/3KcXLbso/kEhQUbas94mOQeGNLjztTavytd
         Ks8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnGIOBseYpp3kgTsuAQB/lbVUGgkNrUWpe2aW06lmJY=;
        b=a6DjE5GmggXH0/STiwAwJE702QYt3IukkUGudT17ggxKfJX4pC2Iqj66guKEtY3xzr
         3IqdLPP7Bn0i4/EoAQMc0BAK51RtJBEmdxmSWXlG/OVgfsyEq058gyvtACt7MGMBQ/mQ
         a3pCY6FKhhYvZ+BvkaOBlHfU8U0ls6sYzN7QHSpr4wbefNJ+Brc4igGXBUtX9gQBQRbw
         ssTvCrDJ++vsXB4xH3/Ce3W58ZbneLVS01zRf6Nl41DrnPp1pdyL6DFH156Mdl1xuqi8
         oLuCvM0ZXNfjGXgBd+l1qu3T7Gwgtk29GANP8ws/sZro+jwf3i1PZoOw7DmzdujqmUlr
         L6HQ==
X-Gm-Message-State: AOAM5310F9qVlH3ll6Jx/eEQQNBWsqix50+PN4ynaG/0yzf7Ml5JoOTa
        GQcxbRgFxHOql2mtZsVhUEWUa18lCza5wBlDlJU=
X-Google-Smtp-Source: ABdhPJx5N/y/k76fXH5qJLh2zviIdE/WnUmYjyoNfkHUyh/nEDNhogtMvdjbXlSORfCg6+mPObjRJEGI+MDPUfasxPI=
X-Received: by 2002:a05:6830:149a:: with SMTP id s26mr6887968otq.59.1629100067461;
 Mon, 16 Aug 2021 00:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210809150738.150596-1-yangx.jy@fujitsu.com> <CAD=hENd6StySon04rW1CPeJbN1KFPDDP1JFsYNBxXNYYegtF5A@mail.gmail.com>
 <6112A9FA.2050300@fujitsu.com>
In-Reply-To: <6112A9FA.2050300@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 16 Aug 2021 15:47:36 +0800
Message-ID: <CAD=hENdB6chvVtzgcYunhTNuHDGbYi8=ePnGKhOwuF83HY8O1w@mail.gmail.com>
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

On Wed, Aug 11, 2021 at 12:33 AM yangx.jy@fujitsu.com
<yangx.jy@fujitsu.com> wrote:
>
> On 2021/8/10 11:40, Zhu Yanjun wrote:
> > On Mon, Aug 9, 2021 at 10:43 PM Xiao Yang <yangx.jy@fujitsu.com> wrote:
> >> Resid indicates the residual length of transmitted bytes but current
> >> rxe sets it to zero for inline data at the beginning.  In this case,
> >> request will transmit zero byte to responder wrongly.
> > What are the symptoms if resid is set to zero?
> Hi Yanjun,
>
> You can construct code by the attached patch and then run
> rdma_client/server to reproduce the issue.
>
> If resid is set to zero, running rdma_client/server:
> --------------------------------
> # ./rdma_client -s 10.167.220.99 -p 8765
> rdma_client: start
> rdma_client: end 0
>
> # ./rdma_server -s 10.167.220.99 -p 8765
> rdma_server: start
> wc.byte_len 0 recv_msg bbbbbbbbbbbbbbbb
> rdma_server: end 0
> --------------------------------
>
> rdma_client sends zero byte instead of 16 btyes to rdma_server.
> rdma_server receives zero byte instead of 16 btyes from rdma_client.
>
> Please also see the logic about resid in kernel, for example:
> --------------------------------
> int rxe_requester(void *arg)
> {
> ...
> payload = (mask & RXE_WRITE_OR_SEND) ? wqe->dma.resid : 0;
> ...
> skb = init_req_packet(qp, wqe, opcode, payload, &pkt);
> ...
> }
> --------------------------------
>
> Best Regards,
> Xiao Yang

Follow your steps on the latest rdma-core and linux upstream,
make tests with the followings:
"
diff --git a/librdmacm/examples/rdma_client.c b/librdmacm/examples/rdma_client.c
index c27047c5..6734757b 100644
--- a/librdmacm/examples/rdma_client.c
+++ b/librdmacm/examples/rdma_client.c
@@ -52,6 +52,7 @@ static int run(void)
        struct ibv_wc wc;
        int ret;

+       memset(send_msg, 'a', 16);
        memset(&hints, 0, sizeof hints);
        hints.ai_port_space = RDMA_PS_TCP;
        ret = rdma_getaddrinfo(server, port, &hints, &res);
diff --git a/librdmacm/examples/rdma_server.c b/librdmacm/examples/rdma_server.c
index f9c766b2..afa20996 100644
--- a/librdmacm/examples/rdma_server.c
+++ b/librdmacm/examples/rdma_server.c
@@ -132,6 +132,7 @@ static int run(void)
                goto out_disconnect;
        }

+       printf("wc.byte_len %u recv_msg %s\n", wc.byte_len, recv_msg);
        ret = rdma_post_send(id, NULL, send_msg, 16, send_mr, send_flags);
        if (ret) {
                perror("rdma_post_send");
"
The followings are results:

# ./build/bin/rdma_server -s 10.238.154.61 -p 5486&
[1] 10812
# rdma_server: start

# ./build/bin/rdma_client -s 10.238.154.61 -p 5486&
[2] 10815
# rdma_client: start
wc.byte_len 16 recv_msg aaaaaaaaaaaaaaaa    <--------------it seems
that inline is 16?
rdma_server: end 0
rdma_client: end 0
[1]-  Done                    ./build/bin/rdma_server -s 10.238.154.61 -p 5486
[2]+  Done                    ./build/bin/rdma_client -s 10.238.154.61 -p 5486

What does your commit fix?

Zhu Yanjun

> > Thanks
> > Zhu Yanjun
> >
> >> Resid should be set to the total length of transmitted bytes at the
> >> beginning.
> >>
> >> Note:
> >> Just remove the useless setting of resid in init_send_wqe().
> >>
> >> Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex verb")
> >> Fixes: 8337db5df125 ("Providers/rxe: Implement memory windows")
> >> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> >> ---
> >>  providers/rxe/rxe.c | 5 ++---
> >>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
> >> index 3c3ea8bb..3533a325 100644
> >> --- a/providers/rxe/rxe.c
> >> +++ b/providers/rxe/rxe.c
> >> @@ -1004,7 +1004,7 @@ static void wr_set_inline_data(struct ibv_qp_ex *ibqp, void *addr,
> >>
> >>         memcpy(wqe->dma.inline_data, addr, length);
> >>         wqe->dma.length = length;
> >> -       wqe->dma.resid = 0;
> >> +       wqe->dma.resid = length;
> >>  }
> >>
> >>  static void wr_set_inline_data_list(struct ibv_qp_ex *ibqp, size_t num_buf,
> >> @@ -1035,6 +1035,7 @@ static void wr_set_inline_data_list(struct ibv_qp_ex *ibqp, size_t num_buf,
> >>         }
> >>
> >>         wqe->dma.length = tot_length;
> >> +       wqe->dma.resid = tot_length;
> >>  }
> >>
> >>  static void wr_set_sge(struct ibv_qp_ex *ibqp, uint32_t lkey, uint64_t addr,
> >> @@ -1473,8 +1474,6 @@ static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
> >>         if (ibwr->send_flags & IBV_SEND_INLINE) {
> >>                 uint8_t *inline_data = wqe->dma.inline_data;
> >>
> >> -               wqe->dma.resid = 0;
> >> -
> >>                 for (i = 0; i < num_sge; i++) {
> >>                         memcpy(inline_data,
> >>                                (uint8_t *)(long)ibwr->sg_list[i].addr,
> >> --
> >> 2.25.1
> >>
> >>
> >>
>
