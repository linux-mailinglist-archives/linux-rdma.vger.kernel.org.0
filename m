Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CE834F71A
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 05:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhCaDEf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Mar 2021 23:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbhCaDEM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Mar 2021 23:04:12 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6934C061574
        for <linux-rdma@vger.kernel.org>; Tue, 30 Mar 2021 20:04:11 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so17624339ote.6
        for <linux-rdma@vger.kernel.org>; Tue, 30 Mar 2021 20:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8omA/YSqx4wTGJFmK0esOSMI5XQV9zFKyIgHeFad04=;
        b=QS1QE7VSBBicOSGxUZ6vT3TBCAqxZYJCkRasWP2+IsPrhqeZPLWI/obqfVe7KW415P
         hHEgh6VlTSoVnE+0ByXt7utwuwhVcXTcwTwEY/jex3mu6L4n3ey70U+eiFSQMkpsPJO7
         XinMezRt9vsBHI+9ItBIU/XqVbRsIJGInY8yJJTSJB0HtHDL+9uuVheU/5KoBAXqdk4A
         HpNnYft8skCGrxDGofPg2CR1mbVKQHuSidwwTcbWTOXz8Kq2fj2E8BaghynWqdVRtXhp
         9q8FE1HfJCohdS19EiQaCDf8C5NC75X/PPyBVLNF1MryMljqJH7z0e+KtG0n9WdDOHoZ
         sJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8omA/YSqx4wTGJFmK0esOSMI5XQV9zFKyIgHeFad04=;
        b=Hj9peL2sDWV4sJ1LbRsfYUMTWiW2TUCUgYJKoOHo4lcXJ28mZdrBb1uAVZSAr2vj+h
         /E8SN8oPS4UTJmB+S7G+bn/+2DgRStnZdXp5ioBym1Dmm2MaGJYQoahOsOsZBCdoHo9p
         7y5CbPl1MAHtT3kePGtv8FNqDRdyi+qBcYUf7qCzX6IhJLXm3u1AxtKAWNiSTzXrL2Qa
         Ky35JoHV1A15IluLIyfAy+slkrdu8zNJcHSXMQ79oobDQlkuNfrJd6PRKReP+wD7OGmz
         GsBOdllT3Avh23EkGlXhEoRmycyJs2ZBPPcyraQmBjlid1blbH8oQxLSYnmmeN1IEkQB
         eEvg==
X-Gm-Message-State: AOAM530lESkmVBC6Da4nXngNe5hiVBW6OzZasNsA5NdONrU/XNmotqMs
        0bfh0YyEyxRPy8w0pE3125M0nnVLemwmA0obIns=
X-Google-Smtp-Source: ABdhPJyg92emRJZGF7WQ3vdDVixCIl5Gzq+O0H9r+3B3dBLoWBzLz21GqXSI6GQ+POFwZB0NtgawS8PCVwlNtxI05os=
X-Received: by 2002:a9d:28d:: with SMTP id 13mr873278otl.278.1617159851417;
 Tue, 30 Mar 2021 20:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210326024405.3870-1-yanjun.zhu@intel.com>
In-Reply-To: <20210326024405.3870-1-yanjun.zhu@intel.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 31 Mar 2021 11:04:00 +0800
Message-ID: <CAD=hENcqV+9iTi-EzX7axRwhGXPT0XffzL0tjDv4RrO3_c9A6w@mail.gmail.com>
Subject: Re: [PATCH 1/1] RDMA/addr: Disable ipv6 features when ipv6.disable
 set in cmdline
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 25, 2021 at 6:19 PM Zhu Yanjun <yanjun.zhu@intel.com> wrote:
>
> From: Zhu Yanjun <zyjzyj2000@gmail.com>
>
> When ipv6.disable=1 is set in cmdline, ipv6 is actually disabled
> in the stack. As such, the operations of ipv6 will fail.
> So ipv6 features in addr should also be disabled.
>
> Fixes: caf1e3ae9fa6 ("RDMA/core Introduce and use rdma_find_ndev_for_src_ip_rcu")
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>

Hi, Jason

Gently ping

> Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
>  drivers/infiniband/core/addr.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> index 0abce004a959..6fa57b83c4b1 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -257,6 +257,9 @@ rdma_find_ndev_for_src_ip_rcu(struct net *net, const struct sockaddr *src_in)
>                 break;
>  #if IS_ENABLED(CONFIG_IPV6)
>         case AF_INET6:
> +               if (!ipv6_mod_enabled())
> +                       return ERR_PTR(-EPFNOSUPPORT);
> +
>                 for_each_netdev_rcu(net, dev) {
>                         if (ipv6_chk_addr(net,
>                                           &((const struct sockaddr_in6 *)src_in)->sin6_addr,
> @@ -424,6 +427,9 @@ static int addr6_resolve(struct sockaddr *src_sock,
>         struct flowi6 fl6;
>         struct dst_entry *dst;
>
> +       if (!ipv6_mod_enabled())
> +               return -EADDRNOTAVAIL;
> +
>         memset(&fl6, 0, sizeof fl6);
>         fl6.daddr = dst_in->sin6_addr;
>         fl6.saddr = src_in->sin6_addr;
> --
> 2.27.0
>
