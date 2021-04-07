Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8883567DD
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 11:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbhDGJYV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 05:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbhDGJYB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Apr 2021 05:24:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D69C061756
        for <linux-rdma@vger.kernel.org>; Wed,  7 Apr 2021 02:23:51 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h10so19934441edt.13
        for <linux-rdma@vger.kernel.org>; Wed, 07 Apr 2021 02:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bT9O3yxb3U2ZpSof5+/N3iavOsv/hQGWC8I1eC41IFU=;
        b=cVLGUmU+lpnnJ9g25Q/MCbUqMvwlYuxr2Pqg/309p29MOBqrgSBb0OP03J74YPm4hA
         0eaF0cjARvTph7+fQ1wtVIQMesA28fIeA1LThFKjVr0l7pwsiV4E4QOWUXhAnnsvYSEM
         8yjGPsBj+AU88b3mY+8djUAOhAlumKVD/k7MdVEAxh8akic3+mU5MAnsU/Qvje7K8F1g
         TiIMWUb6TDceAwHwuUtO8irzpkcawYPqwoZvaXGT1Ehkx1kzDhA2ocJ/Zc43izmHuYS2
         QwHlzdMHE16NNa3OYruKeLo30MhXL9Z0B4nk8ucnPl6fspPKI9bLc+qYOccSxygrnJE5
         T/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bT9O3yxb3U2ZpSof5+/N3iavOsv/hQGWC8I1eC41IFU=;
        b=esm4tUa2wii5KfQ85+Z13TWeTUPLoqLRvDzaBKSdOoJ4G/beXXwMVBC8CuTAvvcHOP
         xjnvZIOj7IoJEr0XYHWH38mDIQg1g9e6N2/MfgaG9CJPS+3wo6++d52QjK0A75DWaEZv
         RGZmjyMC7eeFGg/BGVbktXGGeRX8DrUUKH+6cUC4kpBcgQblTqzaCFr3I3QQj09klpz6
         WZyIIjr5LSOGAdECTZZyjZ2M382jvwYRVesXF88CPIsJ2uFfBnr/i60WliU8Zw90Kf/p
         cE8QtLRwoJtBD5Es2YTiqoa2k2wUE7MTBpZ6wW1IDahfbRYYCjodc8zXBlEnTF5j4xfR
         8c8A==
X-Gm-Message-State: AOAM532smizfjNRaqb6eRCyQWLsS0YcnYpBiPpCXIfiA8gXK7qrROjLA
        Uv1yLfQ6AN8Zm0EX3cTwW5QbGK+cK8CX2kXbHKm22A==
X-Google-Smtp-Source: ABdhPJzw84Ds1WD+MpLVZj+P3UsxFwSP756RnONErJfy8gfHxhqqD52dlXDWfAR/2M2YaYMoR82XAmzl3gqp+1xec0M=
X-Received: by 2002:a05:6402:4388:: with SMTP id o8mr3206234edc.262.1617787430105;
 Wed, 07 Apr 2021 02:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210406120553.197848-1-gi-oh.kim@ionos.com> <20210406120553.197848-2-gi-oh.kim@ionos.com>
In-Reply-To: <20210406120553.197848-2-gi-oh.kim@ionos.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 7 Apr 2021 11:23:39 +0200
Message-ID: <CAMGffEn47V33+EwLXyDiKcZ6zMvD-QufAAfPcVgHNGveKrkR+A@mail.gmail.com>
Subject: Re: [PATCH 1/4] RDMA/rtrs-clt: Add a minimum latency multipath policy
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 6, 2021 at 2:06 PM Gioh Kim <gi-oh.kim@ionos.com> wrote:
>
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
>
> This patch adds new multipath policy: min-latency.
> Client checks the latency of each path when it sends the heart-beat.
> And it sends IO to the path with the minimum latency.
>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 18 +++++--
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 57 +++++++++++++++++++-
>  drivers/infiniband/ulp/rtrs/rtrs-clt.h       |  1 +
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h       |  2 +
>  drivers/infiniband/ulp/rtrs/rtrs.c           |  3 ++
>  5 files changed, 77 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> index c502dcbae9bb..bc46b7a99ba0 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> @@ -101,6 +101,8 @@ static ssize_t mpath_policy_show(struct device *dev,
>         case MP_POLICY_MIN_INFLIGHT:
>                 return sysfs_emit(page, "min-inflight (MI: %d)\n",
>                                   clt->mp_policy);
> +       case MP_POLICY_MIN_LATENCY:
> +               return sprintf(page, "min-latency (ML: %d)\n", clt->mp_policy);
sysfs_emit should be used here, Gioh please fix it.

Thanks
