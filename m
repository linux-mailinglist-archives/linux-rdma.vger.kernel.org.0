Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EAD2D5ECA
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Dec 2020 15:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgLJO62 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Dec 2020 09:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbgLJO53 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Dec 2020 09:57:29 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2C0C0613CF
        for <linux-rdma@vger.kernel.org>; Thu, 10 Dec 2020 06:56:49 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id u19so5808593edx.2
        for <linux-rdma@vger.kernel.org>; Thu, 10 Dec 2020 06:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZL5eMnJUZR33II2tRNEvHV28YGyV0efiJaemSe8WAL8=;
        b=akIU4qVngXp7tUxsTpmsploSNjsFnVTgliaKCHs2wM5h2N2p5Xd+m9mEqSPvN0u8GF
         4Ng44A0bv8WlQdrthC9XeSLV5M9krm9sRVWDqeeSDKz5ezOMoyecZ4m5zF0sP1GMcUaB
         LMgLx8LqDYrw8TIf9jlQsyDfK63qvpDFPYCETvNt5GHpiNN/jhEPgMLlsNEPrZqxT8aB
         nrDcJCT1Ac6HTVxf7qvmysQv+WhvqnV3gvGGy2DHM9cL83tJ6XzIpNgDcaNxki17Erus
         yibBkCqzFSZJwpaIMWGOwaLMytZHDKLwBA41xV/vVpX1tSUnrdnsrvW+IiVbbHBS9bUY
         xglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZL5eMnJUZR33II2tRNEvHV28YGyV0efiJaemSe8WAL8=;
        b=Wp0LUBTRIjTRz8BR7ThJCQ+ufjl0rJjD2/isUSZQFRfm/RGaPDrSrCtiZLheJammCW
         xPxKfGoSrwXzUOj+mzirOsKX+bnfU0gssUlSl6J6c9lpOXxkHAV67674+Y1emc6znP6/
         0Ov6+3pe/j+oUhnYt7zvCIreSyBa+nqabfPg7HFueO9O0vq/sp7ErXsBn7dczysLi3M8
         7gZlzdp0G/f9CQLHf4CjYXZuqB9ZvJaWSEHdvs7Hsa2Y4G+l1p/XRMru7k5HRe2s80M/
         Qwq7OYsC2ewHeqyNUleOjb6Px3LjHeQg+QJvekFTPlwEWAxz1X9Q+F5cQNQqRGERs36g
         VJ9g==
X-Gm-Message-State: AOAM531j9B4rXRCZJwBsPu/fBYvXlsS9GKRAej2OfonCpxiClYpHx3xj
        5Y/ecfljoqnkGWRginb2qbNLMhaLwVMk//7Kzlls+70ttxbc2Q==
X-Google-Smtp-Source: ABdhPJw5auWCqQHSJm24bEJ2kXtOw4b4XpqDDSCaH0x+ylCi8syeGkKj4TMOwTEOtK/X5cOUD5/hLMvmLVUl/5xZDCs=
X-Received: by 2002:a05:6402:a53:: with SMTP id bt19mr7282780edb.104.1607612207423;
 Thu, 10 Dec 2020 06:56:47 -0800 (PST)
MIME-Version: 1.0
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com> <20201209164542.61387-3-jinpu.wang@cloud.ionos.com>
In-Reply-To: <20201209164542.61387-3-jinpu.wang@cloud.ionos.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 10 Dec 2020 15:56:15 +0100
Message-ID: <CAMGffE=_axtHU=pAV3qx5FVY2pB786z3kffQwDzinOaH=yS5Ag@mail.gmail.com>
Subject: Re: [PATCH for-next 02/18] RMDA/rtrs-srv: Occasionally flush ongoing
 session closing
To:     linux-rdma@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 9, 2020 at 5:45 PM Jack Wang <jinpu.wang@cloud.ionos.com> wrote:
>
> If there are many establishments/teardowns, we need to make sure
> we do not consume too much system memory. Thus let on going
> session closing to finish before accepting new connection.
>
> Inspired by commit 777dc82395de ("nvmet-rdma: occasionally flush ongoing controller teardown")
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> Reviewed-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Please ignore this one, it could lead to deadlock, due to the fact
cma_ib_req_handler is holding
mutex_lock(&listen_id->handler_mutex) when calling into
rtrs_rdma_connect, we call close_work which will call rdma_destroy_id,
which
could try to hold the same handler_mutex, so deadlock.

Sorry & thanks!

Jack

> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index ed4628f032bb..0a2202c28b54 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1791,6 +1791,10 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
>                 err = -ENOMEM;
>                 goto reject_w_err;
>         }
> +       if (!cid) {
> +               /* Let inflight session teardown complete */
> +               flush_workqueue(rtrs_wq);
> +       }
>         mutex_lock(&srv->paths_mutex);
>         sess = __find_sess(srv, &msg->sess_uuid);
>         if (sess) {
> --
> 2.25.1
>
