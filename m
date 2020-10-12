Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E7928B61A
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 15:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgJLNX3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 09:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgJLNX3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 09:23:29 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE08C0613D0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:23:29 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id md26so23108329ejb.10
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wzw9uHPbheR0zWyiHfRvEQEOYXd26owdvMlRLTJqgWc=;
        b=g5CT5IpqsowSApaFGJE82tfi7oxYqtTg8/O3DrdtpDCynpRjYWR2tIHl9zEf9OKyhG
         zI71AkiyiLoz5UarbE/uR/EFNkRGqkewJGZX1BdmdAce1kJAyOWyEAGDCQqxas2H2Nr4
         TYmzZzTxCXfk7vi7bJyUL5pbDe8EnXgD1bbbVX4pb9QI+YNCv4A/pYxFAHVRSiZ63hZT
         VCjw8LK48H9DDd3vdX6eD2WJF0SmDlK2mNLhzhMnH7jjCUAiTdC4gCRtirARFYz5t18H
         w5nv9xuSclNmfyPZmtYmeOZpz83GEyayznKkoYDVaF2mF4WSdimnDTi4zY1W7EvrK726
         wxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wzw9uHPbheR0zWyiHfRvEQEOYXd26owdvMlRLTJqgWc=;
        b=CCAcrBoxtgISW6+M9yPelOCxPdm6HhfBWh12SxuSJ/IpQ2so2vpVqw2G3FFmyVl2+u
         it5sqzDkr7Y6a3IYcYu3XtYbtXG0xD6d1I8BPqxGZelkK5fcvwd9QI6vZyPQV1cTVFWO
         1ZfyUjt4y4CLPMRc4anojBmBIbOt6In7iG3Fl5S5o/qCoGcgpaYj5ucjPwoP8phHe84Y
         dGKgAIVjHQ/D5Lfw1Ut35Li5JWqkOPlXCre1mkBfXuoRudPc5Aq80/Ajl62dOXhnEthK
         OX6FsGyE0/PpGqzTOCW3Y0RiBKSJM7OpiUoeaWmQSUoZKy9C6/JAZstbHMW7ipVgWi/7
         +hzg==
X-Gm-Message-State: AOAM53357F83gjHBrudWfXJzoWmueKQW1p+oplsA0H9KMw7jg4c5128x
        M796yy5tqxFVBYPDDXeXZkC9zGUUCMfXXUzgHGB6EBWk8UQ=
X-Google-Smtp-Source: ABdhPJzui6OQArXA+5mKQ42w0i4BP9IcZnUTefBgGxa0LEpX05kAKUVXe9fU5OyDrnlyhvBM1AJlaVZD66QSbbGeKOk=
X-Received: by 2002:a17:906:388:: with SMTP id b8mr26506609eja.62.1602509007832;
 Mon, 12 Oct 2020 06:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com> <20201012131814.121096-9-jinpu.wang@cloud.ionos.com>
In-Reply-To: <20201012131814.121096-9-jinpu.wang@cloud.ionos.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 12 Oct 2020 15:23:16 +0200
Message-ID: <CAMGffE=ouR_qsaW5W_5EOeraHc-MaEnk_YnNtJbiPjb9NQT8Hw@mail.gmail.com>
Subject: Re: [PATCH for-next 08/13] RDMA/ibtrs-clt: missing error from rtrs_rdma_conn_established
To:     linux-rdma@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 12, 2020 at 3:18 PM Jack Wang <jinpu.wang@cloud.ionos.com> wrote:
>
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
>
> When rtrs_rdma_conn_established returns error (non-zero value),
> the error value is stored in con->cm_err and it cannot trigger
> rtrs_rdma_error_recovery. Finally the error of rtrs_rdma_con_established
> will be forgot.
>
> Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
sorry, forgot to change the subject line to rtrs.
Jason, do you want a resend with the fixed subject.
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 7764a01185ef..f63f239bbf55 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1822,8 +1822,8 @@ static int rtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
>                 cm_err = rtrs_rdma_route_resolved(con);
>                 break;
>         case RDMA_CM_EVENT_ESTABLISHED:
> -               con->cm_err = rtrs_rdma_conn_established(con, ev);
> -               if (likely(!con->cm_err)) {
> +               cm_err = rtrs_rdma_conn_established(con, ev);
> +               if (likely(!cm_err)) {
>                         /*
>                          * Report success and wake up. Here we abuse state_wq,
>                          * i.e. wake up without state change, but we set cm_err.
> --
> 2.25.1
>
