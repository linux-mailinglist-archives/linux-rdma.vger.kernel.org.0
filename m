Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7627337B43F
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 04:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhELCqg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 22:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELCqf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 May 2021 22:46:35 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0604C061763
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 19:45:28 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so15352764oto.0
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 19:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TQPv4sd6wol2MmhFzNAj7tufTKys/Y2hVpNqb63vOU4=;
        b=FNtC73b5l6i/E8Ykqpumcwfsex/j/yT6c1uLckIfFEdyUHRNi8mZycB3pDX9sR/WKX
         HXDRTi0YIoIlCO5pyRYNQPI8wshzRRGdyZk4De2GvH0/8pJdAQBV58QNcFoBDoamF9Ob
         WWux1E8IpDs75CRvZB2s1Gdp40G8KOsgGo5LFGpuv5C10axkVZB6IUCVim9T3QnpHUba
         uDGsIpTEsmuSQN7fLPnd4LVH2jpV5N299eyf4wh1E/qDlfQDlpndnsQH2OkLdgACTSYu
         ZlUPAKqWFi36IBFPftLD8nVI+nyjUz2IDBxo4w528NZQCS3EukEpvtM9/8oeAWnPe5s/
         2SOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TQPv4sd6wol2MmhFzNAj7tufTKys/Y2hVpNqb63vOU4=;
        b=Yr5MIVQz0RP2TKUpdMpibF1jNkO8m/ZOVPnAVj9yjjknNYab1OvKZVStdOH+yut4Ex
         i+pUoj7LJLn6TFoUeM60B/Wnv6/JDBRXBDkeudN3EJHAGWJE0I0HQqYsYSIt8ROzU3NJ
         puO7MBQTkwGR9FmVuu624hWEDMiuggMsBqTCOgQwYynI5B4eyBSwvnGFTOJaB4+cn3Tm
         YE/93AP4eB4ePC2oe+Xk+r+1YFGGKdZEShuDS6QDhCY6PflEdnfu0HlaZ0m97zrNhEc7
         zlRGzE4mzI7264ts/EOD8NR/tbm/nKlqSexMLbIGgBnfFz65eieWVp8Bs7/KY+gs21Fr
         SeNQ==
X-Gm-Message-State: AOAM530Xurj+fhx3peUnEtAdpApmKF+/bJba+ORd4wTlHvzAx3fJj/JD
        FpaNEXWqae2dtXC8j1jSoUJxUVrYt25NBk2mBCE=
X-Google-Smtp-Source: ABdhPJxGrvi8o+uWOR01jSzOMi351nLZHSmrxrT9Xj0EOn7aP6ubBKmD+ZvGwv+x6KLhfthgB8suH9OMuTszs4qeMAQ=
X-Received: by 2002:a9d:614b:: with SMTP id c11mr28725989otk.59.1620787528276;
 Tue, 11 May 2021 19:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210510084235.223628-1-yanjun.zhu@intel.com>
In-Reply-To: <20210510084235.223628-1-yanjun.zhu@intel.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 12 May 2021 10:45:17 +0800
Message-ID: <CAD=hENfbmEasEY4n7fN9NV4HjQWOPE6kJRROYWn+q_j33JOwHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] RDMA/rxe: remove the unnecessary break
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 10, 2021 at 12:18 AM Zhu Yanjun <yanjun.zhu@intel.com> wrote:
>
> From: Zhu Yanjun <zyjzyj2000@gmail.com>
>
> In the final default, the break is not necessary.

Hi, Jason Gunthorpe and Leon Romanovsky

Gently ping

Zhu Yanjun
>
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 34ae957a315c..00588735744f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -186,7 +186,6 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
>
>         default:
>                 qp->ibqp.qp_num         = qpn;
> -               break;
>         }
>
>         INIT_LIST_HEAD(&qp->grp_list);
> --
> 2.27.0
>
