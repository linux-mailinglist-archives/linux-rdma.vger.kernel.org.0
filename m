Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937EF4D3F43
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Mar 2022 03:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbiCJCeC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Mar 2022 21:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiCJCeB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Mar 2022 21:34:01 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4598CD4474
        for <linux-rdma@vger.kernel.org>; Wed,  9 Mar 2022 18:33:01 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id w12so7014041lfr.9
        for <linux-rdma@vger.kernel.org>; Wed, 09 Mar 2022 18:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q/Fi8rD4tewA9Fw4AQeKZTijqin/VTxawjgZ++UbpX8=;
        b=FI1wtNFy49tb/kfco/puJPvCVMznKGY0i9Q1DWGFtBQx/KddcIC48lDJyE+YvwbFbx
         ttL5KPiTlFleb8R12fqH25IFeOAbyPmpkiYeKPu8p7xlAcDjb7CKQGrseccKkG9dgslv
         vmR3tAyDYpKo1wWpS9W8V5RN4iSlfUIAvZUSD1Oxg0oLG2w4RcWYGF8fMBgTwXNNrOCp
         CsxC4LeX/7MZXhZiu5QpBEh4o8Urn96EZFMij0OVIxFQ1Jz5tGIxxD+bLZC18LCxUowc
         6zF/6KE/SaTQT5pQAAUqreuWpf7Pf9AFl64G/zDKGuMLMXxzmm9sNrqoL4nImqq84s12
         UVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q/Fi8rD4tewA9Fw4AQeKZTijqin/VTxawjgZ++UbpX8=;
        b=NbeqkxBprujrH+Kjq80qt79n+N0GUc8DYY5goUitny5QPj4cSCauKKn57i5S2aGlQC
         JIR6ekagOm3H+4crqPY10aBgaF3kYU/7zL2LbAryxvAwccnR8RKgIj0wC/lLL2vcwEgv
         HsoILQxUf5KoOpKvAgJwNmMdleuj6bZiKTGe8GEBp2JZx2EADpgvU3kuyxqy6gO6LEQ8
         +JWY9V4lojZb98aOmPMMvfqCwQ//RIhfpswMZBbOn7JC/vGMWyeLTWbV/THHax2TdNSV
         XX6EYs5pDjKYNWFtolWxjfZ5yFtYbneDG7RAL/NwsVPT3p0kj0U2BG6Omdlb6juOIA3w
         Q8/A==
X-Gm-Message-State: AOAM531biw2/Dym9HYVqKd+bG1GP/xf2OvY2g2gezIUSJ2+flWKC2oNs
        HRtLnjETynezpeoEv3i7M8EiuujNuCuSmQuiAecewZ1p
X-Google-Smtp-Source: ABdhPJy1mkKG1Bj7Jwg/CN1YcmtuMWZtnKHzhDjpKQzZzeF/NRwMTpr0FeZWi7IPUUocXnhtIqN3ZUdpyTr7NvzXKps=
X-Received: by 2002:a05:6512:228b:b0:448:246d:97d with SMTP id
 f11-20020a056512228b00b00448246d097dmr1578185lfu.94.1646879579512; Wed, 09
 Mar 2022 18:32:59 -0800 (PST)
MIME-Version: 1.0
References: <20220307145047.3235675-1-cgxu519@mykernel.net> <20220307145047.3235675-2-cgxu519@mykernel.net>
In-Reply-To: <20220307145047.3235675-2-cgxu519@mykernel.net>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 10 Mar 2022 10:32:47 +0800
Message-ID: <CAD=hENfrkApGJnb+QO6bFhtVOFRdPRsUA+6v2xOHbQCvO2eEfQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] RDMA/rxe: remove useless argument for update_state()
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 7, 2022 at 10:51 PM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> The argument 'payload' is not used in update_state(),
> so just remove it.
>
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index b28036a7a3b8..a3c78b4ac9f1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -540,7 +540,7 @@ static void rollback_state(struct rxe_send_wqe *wqe,
>  }
>
>  static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
> -                        struct rxe_pkt_info *pkt, u32 payload)
> +                        struct rxe_pkt_info *pkt)
>  {
>         qp->req.opcode = pkt->opcode;
>
> @@ -747,7 +747,7 @@ int rxe_requester(void *arg)
>                 goto err;
>         }
>
> -       update_state(qp, wqe, &pkt, payload);
> +       update_state(qp, wqe, &pkt);
>
>         goto next_wqe;
>
> --
> 2.27.0
>
>
