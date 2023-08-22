Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA182783CCB
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 11:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbjHVJZH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 05:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjHVJZG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 05:25:06 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D602A189;
        Tue, 22 Aug 2023 02:25:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9936b3d0286so568927866b.0;
        Tue, 22 Aug 2023 02:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692696303; x=1693301103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRSOtgt3Vby9eqy0yWUkCyYdHXwqdxVqyObuFoaTemo=;
        b=ObgTZDKguwke4T5Zf8kKEnhKE4UIqdSXzpaJfrCDpke1u3ndYxtBqFu+TFPfjG+vDg
         pUT2UFt93Zw7u9ApUvDVKT3aCXSlh358wC0UPAEDJoKWvhkUJNiQQkCmay+KP86/JwUb
         NfS2FJVtkOOPHrNITUTvzz47x3Suh+60SeGDiPThjFXbjrwwMJcCS+TiDhSvuh0Uo8hf
         H7WC7gjWN/rImkNs6zATk2Fvalr2a3o7g1YY4o3/jVrfdGgJ1rUzBLKZxZjHXhjwQ06B
         7B4Ou6h/J3djkBoFfHH05jqAfKW2pNxeX5X6KcNgVJvrt3dDDh7sq1FrHkl8RrRnjsu+
         OYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692696303; x=1693301103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRSOtgt3Vby9eqy0yWUkCyYdHXwqdxVqyObuFoaTemo=;
        b=fPrw2+uLjqTasJKVPWeH5Ja0FV0GCZ+bupmB+B5bwYEXLqWQIUOTvdUZUVu3AvdI/D
         NR7LpAW9EhSErlv66xRBnpw85Q+4JQbHaukV5bXC/pcN8dKXzlLaGxqgp67bN6KH800t
         c4nMErjPRp1Se9W01EHT/VHAP5HbPyTrsL51luCO8StnEx2IDe0Cb0U5iht4pqqewsHy
         RQcfO1Ls7lXUsN0B1QYqN2hRHwdPJJe/J11/74WPazTyryddV6ERrMrhsQj4e5R8LI1Z
         Y2bY7Ax2Z2+inL3t9GR1It//c+oJR7SLrz/e9q5SxB6F9PitOC1Xx1AM+XO7MoX/HAXD
         6DBg==
X-Gm-Message-State: AOJu0YzcsDWvYwcSxFGnmPuci4uVL2WRnhcBgtPPIEgXzFBN2qP1JCEE
        +Aq3qT82B4LtWt+xft0NNFZ5Xp0SNP5OiCQY2s0XXzEz1JU=
X-Google-Smtp-Source: AGHT+IGyD4a+edxFmLrff+DEncK1PS54etkRTByZnX+xHsb2yNlYTPAwFW6vDAF+15L0ERmSMHFQ5mvMNKT4v320Cg4=
X-Received: by 2002:a17:906:8a67:b0:99d:dff6:40a0 with SMTP id
 hy7-20020a1709068a6700b0099ddff640a0mr6870470ejc.13.1692696302538; Tue, 22
 Aug 2023 02:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230822091304.7312-1-roheetchavan@gmail.com>
In-Reply-To: <20230822091304.7312-1-roheetchavan@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 22 Aug 2023 17:24:50 +0800
Message-ID: <CAD=hENezAN2ZPRP2e6-RYZQVtfS-6FhRrv5XGsUs5PwKTr9xnw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Fix redundant break statement in switch-case.
To:     Rohit Chavan <roheetchavan@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 22, 2023 at 5:13=E2=80=AFPM Rohit Chavan <roheetchavan@gmail.co=
m> wrote:
>
> Removed unreachable break statement after return.
>
> Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>

Thanks a lot.
Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/s=
w/rxe/rxe_verbs.c
> index 903f0b71447e..48f86839d36a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -798,7 +798,6 @@ static int init_send_wr(struct rxe_qp *qp, struct rxe=
_send_wr *wr,
>                         rxe_err_qp(qp, "unsupported wr opcode %d",
>                                         wr->opcode);
>                         return -EINVAL;
> -                       break;
>                 }
>         }
>
> --
> 2.30.2
>
