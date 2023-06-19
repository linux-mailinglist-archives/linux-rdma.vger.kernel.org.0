Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06032735FE9
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 00:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjFSWp4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jun 2023 18:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFSWpz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jun 2023 18:45:55 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D625E54
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jun 2023 15:45:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-988b204ce5fso192299266b.3
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jun 2023 15:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687214753; x=1689806753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krTrBmjYSxu+Ew7AG3UlnUcV48xwQHbs+LR6+ERoThI=;
        b=Y4hIp+ua6fn8Wb/riaRfBwpbuirJYBztEIpkefyz1EX02F9NaDE843YsOxMhe9uAK7
         JeGCNYjoeMvY/bAmGbP5QqkdbB+FyOiGZu7PeZcewoILbfybs2ekfc9vXrNgTWvAIzju
         UzDfQGSOGxYi8ddH/yFf1gGoixQfpuDgy5GvXwtSZHaDCN3aPr9KJRgCbtdN2xxrwKnD
         MVC9au8ELWq0tFDim75FO4ANz15mQK5nZ9wxkSxz2hrljWaCVpQSHiDQjPVA8jwdxkCv
         YVm60gJYADFbavW2xd3vS5DHwN30Njz4+8N3znU96pZix77tXE5flklrmNfx4dLUJ7IC
         S1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687214753; x=1689806753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krTrBmjYSxu+Ew7AG3UlnUcV48xwQHbs+LR6+ERoThI=;
        b=Fr4wU2zJcDpORGc7X0q7/Kg9Z2iFL+Iboi2GPa0cq9maSqIZ+yGBlCFDZ3koHVBSB8
         gDhXSDZmCNv3WcyJaR0DN2T50oOjueaNS+H2WrjbCGN/fgOaMmMfG7ZqLKFGdze2kIdJ
         q40AkXY/zj3duFJ800I9v1NWdQuv62SP44o4fLKPJzTir/G6UvbAp/YiwK301+SkTB2i
         +WRBkNPEnyVtXVQOFk9vQTxrzs8uxZivt7eyCOq4E1+ph0karnouP+GmWdATCVgKu+GV
         qoOlmXJDn4iudltk8jIttS7LdgGLxTgmJJRK2+7J5LkHMy7U7hstB2QKmBBX4fSFLWjk
         vJ9A==
X-Gm-Message-State: AC+VfDy4XTtCixqCLFKA8lBkZvcachLRHJmAZFzWTVKkbfzvoeNPYgvJ
        I6N6UsZeJZLoRxKmXpOurZcn833HgJSAMNIATq4=
X-Google-Smtp-Source: ACHHUZ6gtUrTqRUZMWytb03G5KJN18mE9okRfNXBIr61VhBbqnGpvYmSvJ0gmydRG+JT7C2fKP9XZcz5k4gK2vMgajY=
X-Received: by 2002:a17:906:7943:b0:987:e23f:6d7a with SMTP id
 l3-20020a170906794300b00987e23f6d7amr6335169ejo.25.1687214752842; Mon, 19 Jun
 2023 15:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230619202110.45680-1-rpearsonhpe@gmail.com>
In-Reply-To: <20230619202110.45680-1-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 20 Jun 2023 06:45:40 +0800
Message-ID: <CAD=hENcSotJ7EMe_4xbw4=1MeQARV2Us8mhBUPqe-+wPz=V+gw@mail.gmail.com>
Subject: Re: [PATCH for-next 0/3] RDMA/rxe: Fix error path code in rxe_create_qp
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org,
        syzbot+2da1965168e7dbcba136@syzkaller.appspotmail.com
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

On Tue, Jun 20, 2023 at 4:21=E2=80=AFAM Bob Pearson <rpearsonhpe@gmail.com>=
 wrote:
>
> If a call to rxe_create_qp() fails in rxe_qp_from_init()
> rxe_cleanup(qp) will be called. This code currently does not correctly
> handle cases where not all qp resources are allocated and can seg
> fault as reported below. The first two patches cleanup cases where
> this happens. The third patch corrects an error in rxe_srq.c where
> if caller requests a change in the srq size the correct new value
> is not returned to caller.
>
> Reported-by: syzbot+2da1965168e7dbcba136@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-rdma/00000000000012d89205fe7cfe00@g=
oogle.com/raw
> Fixes: 49dc9c1f0c7e ("RDMA/rxe: Cleanup reset state handling in rxe_resp.=
c")
> Fixes: fbdeb828a21f ("RDMA/rxe: Cleanup error state handling in rxe_comp.=
c")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>

Can not apply these commits to Linux 6.4-rc7.

Zhu Yanjun

>
> Bob Pearson (3):
>   RDMA/rxe: Move work queue code to subroutines
>   RDMA/rxe: Fix unsafe drain work queue code
>   RDMA/rxe: Fix rxe_modify_srq
>
>  drivers/infiniband/sw/rxe/rxe_comp.c |   4 +
>  drivers/infiniband/sw/rxe/rxe_loc.h  |   6 -
>  drivers/infiniband/sw/rxe/rxe_qp.c   | 163 ++++++++++++++++++---------
>  drivers/infiniband/sw/rxe/rxe_resp.c |   4 +
>  drivers/infiniband/sw/rxe/rxe_srq.c  |  55 +++++----
>  5 files changed, 150 insertions(+), 82 deletions(-)
>
>
> base-commit: 830f93f47068b1632cc127871fbf27e918efdf46
> --
> 2.39.2
>
