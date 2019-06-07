Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAF339830
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 00:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfFGWGY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 18:06:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43297 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfFGWGY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 18:06:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id 16so2988213ljv.10
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 15:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7UWYaKzZEtXuaxJwJzSC3OWehwEB/n9ql+PmX3iEbFc=;
        b=IXRXXYLjlXhkS7yvhzoYrp+YIYuNj8w+FKvrC2tbRiW0c/0o8dRW8aDCyUkwFWzE/z
         /YJtG4/7E6x8p7aeeTjHwUD+oOzcin26LtKwS/wxd0ElDf+AxtFBCcpbr3rFGlqL2QkO
         annY8RhMfQ/yEquJ2BJvQFemzB095m8iLIKkDZUB0xq71t8R9eVEu667+JgcYBTdImY+
         ubTPhYaxG8U+XvWiy1VeaxHA/JGMBDnE7er/xvmG9dGaM3hCKLub403mntSllA90kI0K
         yE/wisp+efrCTrhv8ade8ujVMfWOTLSWJqv6ftXcXNCZyqKsNqtBiWB4mj7QGdKBqH3H
         yZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7UWYaKzZEtXuaxJwJzSC3OWehwEB/n9ql+PmX3iEbFc=;
        b=mP8bamH+8nHa4qpyel24vD0acUlLwPm7Uwl2qqPH7pSlJUUYKINS9sGj9cWyrE4JJ5
         a/s5+gb2m6BrEAusZIgWwe22fzDKaof9Fs9wjjcUP+vukIuRSFNjUiC5WkM/boxW+ldK
         diJh4mIT7fuP+EAwrGHJ/qb8Kyjz0LET4eK7GYWeflkoopdVE7MVclCooJ6ny2c7oHo0
         mvQ6G05ZCthSruF4blbpm6h3uBxPwMu4FmKRZ2BecKsKGGwiBi7mrVmUT6dThrl0BJWZ
         YaSc7UHWWqO91aidrCkmzApMd6/MMCMGDNz5yG6rb2gyeTBKq60SHiw239NG/bIafHwR
         s0og==
X-Gm-Message-State: APjAAAXS+YjwpvHWKcWr8LaSc3dJEnkchJMqcdbzRpJxHrDDhwmSRV7y
        76079FRTMDECj+ypid0pR43Uy+Gfu1BjqsxtZTE=
X-Google-Smtp-Source: APXvYqwBeEPN7kLgMnERE0EV7XcHl9B9PjKXKhgkNCm9ydhdQJSENk3Qi8H9gBVf130eoY4SU8M3FQfw0DAJrGoOB1o=
X-Received: by 2002:a2e:a311:: with SMTP id l17mr8533284lje.214.1559945182726;
 Fri, 07 Jun 2019 15:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190606184438.31646-1-jgg@ziepe.ca> <20190606184438.31646-11-jgg@ziepe.ca>
In-Reply-To: <20190606184438.31646-11-jgg@ziepe.ca>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 8 Jun 2019 03:41:27 +0530
Message-ID: <CAFqt6zafAR3fqvKCTCLmGNVfbSP80KqqR8cT0bUj4CW4scgxpQ@mail.gmail.com>
Subject: Re: [PATCH v2 hmm 10/11] mm/hmm: Do not use list*_rcu() for hmm->ranges
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 7, 2019 at 12:15 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> This list is always read and written while holding hmm->lock so there is
> no need for the confusing _rcu annotations.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  mm/hmm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/hmm.c b/mm/hmm.c
> index c2fecb3ecb11e1..709d138dd49027 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -911,7 +911,7 @@ int hmm_range_register(struct hmm_range *range,
>         mutex_lock(&hmm->lock);
>
>         range->hmm =3D hmm;
> -       list_add_rcu(&range->list, &hmm->ranges);
> +       list_add(&range->list, &hmm->ranges);
>
>         /*
>          * If there are any concurrent notifiers we have to wait for them=
 for
> @@ -941,7 +941,7 @@ void hmm_range_unregister(struct hmm_range *range)
>                 return;
>
>         mutex_lock(&hmm->lock);
> -       list_del_rcu(&range->list);
> +       list_del(&range->list);
>         mutex_unlock(&hmm->lock);
>
>         /* Drop reference taken by hmm_range_register() */
> --
> 2.21.0
>
