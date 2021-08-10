Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB553E5190
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Aug 2021 05:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236696AbhHJDlI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Aug 2021 23:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhHJDlH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Aug 2021 23:41:07 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155DCC0613D3
        for <linux-rdma@vger.kernel.org>; Mon,  9 Aug 2021 20:40:46 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id y18so26945108oiv.3
        for <linux-rdma@vger.kernel.org>; Mon, 09 Aug 2021 20:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FF6iVliOM0JufIngiGfFZZPG2f3EBRnmy4ZEF/aR4Fo=;
        b=gu5cldbQgnRTi2NQv/lfeaIrVCRY5PveLvaOPVI6u1EyHDxVjLVYGeg1Yc3UDGgglb
         Pq+vQ9N2WXCPfm1Io57SiETLTz8wJY9coSOTIEaLDFmb1T/VRytkmZJajAryddgoYU3e
         LjVv7g6SHsxnLVLBD1RirXxCGrCAv92xnozPhliJdMRLuFsXLTeaw6frNpSaCSz2qniz
         0by55fyLbcnLyfcnyUy98jk7LAj7VgMhP7tx9wn/isKA6mv8SxFdL8phz8UZwbXrc2O9
         GakfqNVC42+8+GceOY0B7q5796JcBIy217qI4rwEPE1TUVhp1t/18roeb06grfIyprcg
         +zzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FF6iVliOM0JufIngiGfFZZPG2f3EBRnmy4ZEF/aR4Fo=;
        b=fDVyj47EWEZznYzhLNUt2AqXgXybX5Wm+Bpo1Mia98vWM9f9v3G4vbt/VUN0UvL6HF
         W4dUMzFxxmpXYzh7vb+4wa0pEax1vuynQ3hO31bbJ3xwpMXZ+hpWvUdIR19B4BZGWvFl
         PoMaMd3zK0kRLUbdOlZ7V9xmVa5MQcEgVVogcr2hfhDdnpW6A+8nBXMhiE4b5jyeyfxo
         iDMCdS43QvQZr6GOgy2Ry7SfMsP+LXkZp1oPoXhN8jB+iZLudLT9yS8WnVKFmioMW8UJ
         Dilw0qhVUS3YXCu/OOcfhfIv/UKuD54bLKTkbC+6Ixugsk60tQg5IkwfSVcKOkF3CPzC
         3o0w==
X-Gm-Message-State: AOAM531WzZpceEOcHID+4AymZPM4pkd90p9C0G/2cre/DgLHn87ojzMx
        MUfjycjfXrRNp6/ZkqvWgREQYrVvH3hvtwLqEWw=
X-Google-Smtp-Source: ABdhPJzk6n7HIKTKbYNbyoLynPGss1+kEOJEfOQ02615he6UhnqH2rN3aHRPmWWxCLPzfcemU6yj2Cp/wcmLVDVAzmU=
X-Received: by 2002:a05:6808:490:: with SMTP id z16mr1869402oid.89.1628566845490;
 Mon, 09 Aug 2021 20:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210809150738.150596-1-yangx.jy@fujitsu.com>
In-Reply-To: <20210809150738.150596-1-yangx.jy@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 10 Aug 2021 11:40:34 +0800
Message-ID: <CAD=hENd6StySon04rW1CPeJbN1KFPDDP1JFsYNBxXNYYegtF5A@mail.gmail.com>
Subject: Re: [PATCH v2] providers/rxe: Set the correct value of resid for
 inline data
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 9, 2021 at 10:43 PM Xiao Yang <yangx.jy@fujitsu.com> wrote:
>
> Resid indicates the residual length of transmitted bytes but current
> rxe sets it to zero for inline data at the beginning.  In this case,
> request will transmit zero byte to responder wrongly.

What are the symptoms if resid is set to zero?

Thanks
Zhu Yanjun

>
> Resid should be set to the total length of transmitted bytes at the
> beginning.
>
> Note:
> Just remove the useless setting of resid in init_send_wqe().
>
> Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex verb")
> Fixes: 8337db5df125 ("Providers/rxe: Implement memory windows")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  providers/rxe/rxe.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
> index 3c3ea8bb..3533a325 100644
> --- a/providers/rxe/rxe.c
> +++ b/providers/rxe/rxe.c
> @@ -1004,7 +1004,7 @@ static void wr_set_inline_data(struct ibv_qp_ex *ibqp, void *addr,
>
>         memcpy(wqe->dma.inline_data, addr, length);
>         wqe->dma.length = length;
> -       wqe->dma.resid = 0;
> +       wqe->dma.resid = length;
>  }
>
>  static void wr_set_inline_data_list(struct ibv_qp_ex *ibqp, size_t num_buf,
> @@ -1035,6 +1035,7 @@ static void wr_set_inline_data_list(struct ibv_qp_ex *ibqp, size_t num_buf,
>         }
>
>         wqe->dma.length = tot_length;
> +       wqe->dma.resid = tot_length;
>  }
>
>  static void wr_set_sge(struct ibv_qp_ex *ibqp, uint32_t lkey, uint64_t addr,
> @@ -1473,8 +1474,6 @@ static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
>         if (ibwr->send_flags & IBV_SEND_INLINE) {
>                 uint8_t *inline_data = wqe->dma.inline_data;
>
> -               wqe->dma.resid = 0;
> -
>                 for (i = 0; i < num_sge; i++) {
>                         memcpy(inline_data,
>                                (uint8_t *)(long)ibwr->sg_list[i].addr,
> --
> 2.25.1
>
>
>
