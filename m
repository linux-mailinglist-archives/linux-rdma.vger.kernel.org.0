Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D750570F376
	for <lists+linux-rdma@lfdr.de>; Wed, 24 May 2023 11:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjEXJve (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 May 2023 05:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjEXJvP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 May 2023 05:51:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0F01A8
        for <linux-rdma@vger.kernel.org>; Wed, 24 May 2023 02:51:07 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96fb1642b09so104363666b.0
        for <linux-rdma@vger.kernel.org>; Wed, 24 May 2023 02:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684921865; x=1687513865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1jpjib+tNQVBaR6kxvBaC8Vwucr/4Np/8sge8cJPCg=;
        b=b9yml321uL5OeKHXZDQgWRi7kZ4MLT40Vmm9GGAKvlCwxagScFlw00UMncMbcMtKHk
         LTy3Bc1SJiFMvcogavpUxsqViJ9Iks088iQGIZoTx2EoHHENtuOguElQbf/0fdNkFFr/
         qx3Wn3LLZCWHgwT4z+8b2xHblhjm6mjgeuPq2YpRsnI30iufRB11yFqS/fYM2mZ2NB+Z
         9ykTMwCG+t9BBhVVrmELAqgimjg6CR8ncHrPYRjpm4dSUnBPj0/XfCYp0U2waaFitm70
         NCw3KzPPrjXfi9ZhjvUVZpfVWMG4VANLeE2pDIFfdOVbTwKFKssPqWXVa44YyA0tGoRt
         zdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684921865; x=1687513865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1jpjib+tNQVBaR6kxvBaC8Vwucr/4Np/8sge8cJPCg=;
        b=ZGlP4oOHijqicUmjBYbA5rdI2MBiA+ViNmsIWgaP0ZbC+60BPhxG+FxreT3ZQNeBo/
         MsveG615IpGqDZ1ywXSMatvYLkJIdh2g+rTwtfXsV7Tba53pbzGo4LMupZ+ybZITXz1L
         DzAdAMYW2e1sp8k9rrwbwu743blwgmbdrice+w5mn2RqJkKJLPWd8SLEMLDFdltdp658
         rGp65dq27Anxcp1F6C5D9QE6Vyg4jNVkXLKrGJY6Qe2EHiKJnLjBAaEBXxqiq37N2hJl
         KOPQoI9QicajTdr7LUjQVSD5ph4SqZBY8HIOlTXkTKtFZPnoTYflfn5xG1SFuDicnRgb
         ZwGA==
X-Gm-Message-State: AC+VfDxcN9ewgJgGkY6cdCUuFBq+PegAdggFNNmlkCeCdr+OMLuq7KdB
        xgTGpDlai0b+vGHqPMtdItBgiAy4bHOlEPH4z+SeqRvX4UE=
X-Google-Smtp-Source: ACHHUZ6s0S/1dO/houXsO5ZN/nQVz2CqulTZcQJuDSglYkxnebKdM9vDkjppR74DTwzzE/sxBy3eQyxJUwr0+8N73IQ=
X-Received: by 2002:a17:907:9606:b0:96f:e5af:ac5f with SMTP id
 gb6-20020a170907960600b0096fe5afac5fmr9558140ejc.47.1684921865322; Wed, 24
 May 2023 02:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <4f20ffc5-b2c4-0c11-2883-a835caf01a94@suse.com>
In-Reply-To: <4f20ffc5-b2c4-0c11-2883-a835caf01a94@suse.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 24 May 2023 17:50:52 +0800
Message-ID: <CAD=hENd_yLC9TguwabGjDzbXmjiqJMShSD94+fqLe75mtMkWqA@mail.gmail.com>
Subject: Re: [PATCH 1/1] RDMA/rxe: remove dangling declaration of rxe_cq_disable
To:     Nicolas Morey <nmorey@suse.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 24, 2023 at 4:52=E2=80=AFPM Nicolas Morey <nmorey@suse.com> wro=
te:
>
> rxe_cq_disable has been removed but not its declaration.
> Fixes: 78b26a335310 ("RDMA/rxe: Remove tasklet call from rxe_cq.c")
>
> Signed-off-by: Nicolas Morey <nmorey@suse.com>

In the subject "RDMA/rxe: remove dangling declaration of rxe_cq_disable"
"remove dangling ..." should be "Remove dangling ..."

Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/=
rxe/rxe_loc.h
> index 804b15e929dd..666e06a82bc9 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -31,8 +31,6 @@ int rxe_cq_resize_queue(struct rxe_cq *cq, int new_cqe,
>
>  int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited);
>
> -void rxe_cq_disable(struct rxe_cq *cq);
> -
>  void rxe_cq_cleanup(struct rxe_pool_elem *elem);
>
>  /* rxe_mcast.c */
> --
> 2.39.1.1.gbe015eda0162
>
