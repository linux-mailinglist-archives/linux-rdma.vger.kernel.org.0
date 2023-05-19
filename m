Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F247708E39
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 05:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjESDQn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 May 2023 23:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjESDQm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 May 2023 23:16:42 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6131DA6
        for <linux-rdma@vger.kernel.org>; Thu, 18 May 2023 20:16:41 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-510eb3dbaaeso2126624a12.1
        for <linux-rdma@vger.kernel.org>; Thu, 18 May 2023 20:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684466200; x=1687058200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ak1C/iII17LGXoPirdkkIyP37aBeYVhkHe1s1jBGsxk=;
        b=CR6Ve6slzItO7/hu9Hu63ekkKPptSwrevovX9MYAg1u8XthZ9pFhEo9eiwwY2L9I8A
         XcQZIprC2qKNazuXyZ4W05YT74JQzPuVw+1pzWe7VbyR0G90DMP0mhLc1IIGqwv/s/GS
         o/SrUvQF1P4rXOjn1Lk+rhPhKq7DuIa2mH6Z0jIK0+wgLliHarYfWsZhXGTvqLZUTteK
         KIOyjVMI/OCHutJB3AoPJgDFZsYkHKO00AYT2t0bDtihEQfOhfuh93PgHgqNb4/kvFAf
         PD7gBgr7dTTOiJ730SShsa7m4Cx37+jtmJfmR57rnJGiT3LWU11tqNqadsy1THB4buqG
         MxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684466200; x=1687058200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ak1C/iII17LGXoPirdkkIyP37aBeYVhkHe1s1jBGsxk=;
        b=EEPI8BNha8+VxEaQvOixm2gdhyhtvJLiupvlzGOcl46kwYGP+/Vu+Ax60gbZ0vf9kH
         +YJX2o0K1JC4EL7GJSDmSeDS4C/pmME4+OQmdKQU/jKEuvjgkmFiZ4oyDlUwjY4eDt7s
         g7Stealp2AZPtv1wWXJMIAV5nsaz8Ks4QX6q21DFFcICgCmdk3bRhoGIVWtcBa/zQ9Ew
         Is7/X9WiEJHUxrSLXsQmHLXBTeI5+azhDnadiZYmZBAMlljbhgN9yLQ4hZBZ4lICBf6N
         xfZgy4/e7ZOqKSVjzYa+Mb0ooejCkeBDF6Odh+Z1XIt373Rp4O8JDdUGU6hglaSlu7F+
         5YCQ==
X-Gm-Message-State: AC+VfDxIEC8uENKzELs6sUzkIAgmFaAc0IxT0M4DftQiMqn8kqpbtufu
        Pbwfd6faxkdJ2Nur7wlEpvUCnlnYnTcELGxxNaA=
X-Google-Smtp-Source: ACHHUZ5no7nTgwUOeEv5lA2CVjXDJ/93F4x0mX2vjq76NJRD1qZ32BSEpjcj0JQ0+Sk3hkdr+7r916Kk0iNYWt8AQDY=
X-Received: by 2002:a17:907:a4c:b0:96a:2210:add8 with SMTP id
 be12-20020a1709070a4c00b0096a2210add8mr179456ejc.8.1684466199493; Thu, 18 May
 2023 20:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230518070027.942715-1-matsuda-daisuke@fujitsu.com>
In-Reply-To: <20230518070027.942715-1-matsuda-daisuke@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 19 May 2023 11:16:27 +0800
Message-ID: <CAD=hENcL5C-Z5O+BYqEiVjd1JxEnsrZqHr96uBvJtCbx2L5tmA@mail.gmail.com>
Subject: Re: [PATCH jgg-for-next] RDMA/rxe: Fix comments about removed tasklets
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com, rpearsonhpe@gmail.com,
        leonro@nvidia.com
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

On Thu, May 18, 2023 at 3:00=E2=80=AFPM Daisuke Matsuda
<matsuda-daisuke@fujitsu.com> wrote:
>
> The commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks")
> removed tasklets and replaced them with a workqueue, but relevant comment=
s
> are still remaining in the source code.
>
> Fixes: 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks")
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Thanks.
Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun
> ---
>  drivers/infiniband/sw/rxe/rxe_comp.c  | 2 +-
>  drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
>  drivers/infiniband/sw/rxe/rxe_req.c   | 2 +-
>  drivers/infiniband/sw/rxe/rxe_resp.c  | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw=
/rxe/rxe_comp.c
> index db18ace74d2b..0c0ae214c3a9 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -826,7 +826,7 @@ int rxe_completer(struct rxe_qp *qp)
>         }
>
>         /* A non-zero return value will cause rxe_do_task to
> -        * exit its loop and end the tasklet. A zero return
> +        * exit its loop and end the work item. A zero return
>          * will continue looping and return to rxe_completer
>          */
>  done:
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/s=
w/rxe/rxe_param.h
> index 7b41d79e72b2..d2f57ead78ad 100644
> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> @@ -112,7 +112,7 @@ enum rxe_device_param {
>         RXE_INFLIGHT_SKBS_PER_QP_HIGH   =3D 64,
>         RXE_INFLIGHT_SKBS_PER_QP_LOW    =3D 16,
>
> -       /* Max number of interations of each tasklet
> +       /* Max number of interations of each work item
>          * before yielding the cpu to let other
>          * work make progress
>          */
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/=
rxe/rxe_req.c
> index 65134a9aefe7..400840c913a9 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -853,7 +853,7 @@ int rxe_requester(struct rxe_qp *qp)
>         update_state(qp, &pkt);
>
>         /* A non-zero return value will cause rxe_do_task to
> -        * exit its loop and end the tasklet. A zero return
> +        * exit its loop and end the work item. A zero return
>          * will continue looping and return to rxe_requester
>          */
>  done:
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw=
/rxe/rxe_resp.c
> index 68f6cd188d8e..b92c41cdb620 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -1654,7 +1654,7 @@ int rxe_responder(struct rxe_qp *qp)
>         }
>
>         /* A non-zero return value will cause rxe_do_task to
> -        * exit its loop and end the tasklet. A zero return
> +        * exit its loop and end the work item. A zero return
>          * will continue looping and return to rxe_responder
>          */
>  done:
> --
> 2.39.1
>
