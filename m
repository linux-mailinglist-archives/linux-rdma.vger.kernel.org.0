Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3A861EAD7
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 07:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiKGGRK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 01:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKGGRJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 01:17:09 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5C6FCD7
        for <linux-rdma@vger.kernel.org>; Sun,  6 Nov 2022 22:17:04 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id io19so10166993plb.8
        for <linux-rdma@vger.kernel.org>; Sun, 06 Nov 2022 22:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gH3TGuqLoLrHT9+v553OeYMbQk/YT2us8gsqUAag9ns=;
        b=Rijy01KuTj+k/8Efs4HOJZxckIVRe0CEDhKnNQCl5fj6NVBgg11HtMPW3bk7E/MBab
         56yyfWrFK/6YH9nWf2MW3VbR94zb9ArRAYFX0pNaN6tAy09hxrZlrAGNfR8L550+KM5W
         F6gCIsBcEQHDd/FL25q73qzY7NDcSB1X09UUhwL+s6PLWIH1kgeKWEsUTZvruv3yD8XI
         3T1Br/XGSHxQa3QEFBV0CK8w4EjkdD8B1277N3qz9NgyuH+BVk+iTRmnjMt7P37vWQUV
         3JevAtzgUNuErkVlCW5eyctZVpCv3+LPmYx/y+yNW/7OxsmxfzBG90oRzAuWT0cLm/Ef
         zk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gH3TGuqLoLrHT9+v553OeYMbQk/YT2us8gsqUAag9ns=;
        b=xYJgkoRdz8uH4UCgQ3tDCnvXAec5lgRasorxp3c407wbPGqyzszNp8RcXKMVMRn0nb
         C5MoiHQ/O9qQJz5PNYe9rYumbxetTB859bYKlZLPf+v176VkDwJAqUhl66BpU1aO4HY0
         RP4I9pFhLb6hQvAxI200LzEdSiHI5O9Vmc5/bBtN1ZWYMywoLa9rcMBMB62Vt5yJWrCa
         dq7j3JUMFTadgvX+agw+Ed69eP8JdeV4qRQXDlakwfXCtcrSoUNP9YjYN3Rc42M6EnhR
         VwxP6fsyGB6jLi3uq6oPovvKL7pdBRy+p+GfOPjgHukiUP2OTr6PSCJ/DkNECiOLyxj3
         0bxg==
X-Gm-Message-State: ACrzQf04Sm+xBk+CWWKFJPPU4dH2gYLBmDNrTI10IegnltrR2ZRX5R4D
        igw720bnJd1ZvQF0VhQYwMOGexjjkYBVIpYqoxA=
X-Google-Smtp-Source: AMsMyM4sOtk8ANz5BwLmb2yM92NoCbKZf3aKeC/YZNzvN3FsfGkoiFRpjmuTZby9Hb3kYLStFqFsfnQrn0PQ9ALX84I=
X-Received: by 2002:a17:902:f78b:b0:17f:9c94:b247 with SMTP id
 q11-20020a170902f78b00b0017f9c94b247mr47497694pln.137.1667801824378; Sun, 06
 Nov 2022 22:17:04 -0800 (PST)
MIME-Version: 1.0
References: <20221107055338.357184-1-matsuda-daisuke@fujitsu.com>
In-Reply-To: <20221107055338.357184-1-matsuda-daisuke@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 7 Nov 2022 14:16:52 +0800
Message-ID: <CAD=hENfZQg-id+Zb1oLNfRf9m0373hhME94M2aBAetjrF+-EnQ@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/rxe: Implement packet length validation on responder
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     leonro@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        lizhijian@fujitsu.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 7, 2022 at 1:54 PM Daisuke Matsuda
<matsuda-daisuke@fujitsu.com> wrote:
>
> The function check_length() is supposed to check the length of inbound
> packets on responder, but it actually has been a stub since the driver was
> born. Let it check the payload length and the DMA length.
>
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
> FOR REVIEWERS
>   I referred to IB Specification Vol 1-Revision-1.5 to create this patch.
>   Please see 9.7.4.1.6 (page.330).
>
> v2: Fixed the conditional for 'last' packets. Thanks, Zhijian.

It had better send the v2 patch in a new mail thread.

Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

>
>  drivers/infiniband/sw/rxe/rxe_resp.c | 34 ++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index c32bc12cc82f..382d2053db43 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -393,16 +393,36 @@ static enum resp_states check_resource(struct rxe_qp *qp,
>  static enum resp_states check_length(struct rxe_qp *qp,
>                                      struct rxe_pkt_info *pkt)
>  {
> -       switch (qp_type(qp)) {
> -       case IB_QPT_RC:
> -               return RESPST_CHK_RKEY;
> +       int mtu = qp->mtu;
> +       u32 payload = payload_size(pkt);
> +       u32 dmalen = reth_len(pkt);
>
> -       case IB_QPT_UC:
> -               return RESPST_CHK_RKEY;
> +       /* RoCEv2 packets do not have LRH.
> +        * Let's skip checking it.
> +        */
>
> -       default:
> -               return RESPST_CHK_RKEY;
> +       if ((pkt->opcode & RXE_START_MASK) &&
> +           (pkt->opcode & RXE_END_MASK)) {
> +               /* "only" packets */
> +               if (payload > mtu)
> +                       return RESPST_ERR_LENGTH;
> +       } else if ((pkt->opcode & RXE_START_MASK) ||
> +                  (pkt->opcode & RXE_MIDDLE_MASK)) {
> +               /* "first" or "middle" packets */
> +               if (payload != mtu)
> +                       return RESPST_ERR_LENGTH;
> +       } else if (pkt->opcode & RXE_END_MASK) {
> +               /* "last" packets */
> +               if ((payload == 0) || (payload > mtu))
> +                       return RESPST_ERR_LENGTH;
> +       }
> +
> +       if (pkt->opcode & (RXE_WRITE_MASK | RXE_READ_MASK)) {
> +               if (dmalen > (1 << 31))
> +                       return RESPST_ERR_LENGTH;
>         }
> +
> +       return RESPST_CHK_RKEY;
>  }
>
>  static enum resp_states check_rkey(struct rxe_qp *qp,
> --
> 2.31.1
>
