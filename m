Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E3F399663
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 01:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhFBXdn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 19:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhFBXdn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Jun 2021 19:33:43 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3023C06174A
        for <linux-rdma@vger.kernel.org>; Wed,  2 Jun 2021 16:31:46 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o27so4211183qkj.9
        for <linux-rdma@vger.kernel.org>; Wed, 02 Jun 2021 16:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iBRXvb4CVhDNCZovMRHGqhARcL8Ag6Ys+ACP65LMVjQ=;
        b=Tf7R+zAydNZSuHSWfC4lPJmLXwnxdT/WGz+K3reUpt6v7/ShyPbO5nOPoTTNSLAqEy
         I8x0HH3YCL9uoWZ5TXrFCZZMVXfK80a+F9E6+EZpReZHATctP0/ZDZupjkdw2WluU7wG
         QjdA9Am2ATXiGJd4HN7lKHr0l9SjaKAc/Ia10JybyuVc6hUUxTegTSNznGBpnnsDtKVt
         lDj32a6z/z8CeexNLsNZ6505A2ACMMSmA5pCCqLB184Bmllv8ikAV46K9yfXOGYE5Mlh
         GIKa9/4CbnvMBR6y7I0dM2legB9cQTtuhykH4Yt22AJ471SGa0pKf7w4gHPj4RgC6NXM
         F3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iBRXvb4CVhDNCZovMRHGqhARcL8Ag6Ys+ACP65LMVjQ=;
        b=NIzDmctdUVGCtGctxbHQttJYIsqEJdFiadOqBC81y8R74aNtVUfw4xMChGMuLRXg7l
         igN48q8pyKaHoVCWSBy2JRQfpYkxei7LXoTUT09CXhPhbX3zk4I+5yRXi4sYmeXTvWYV
         JuO1mHk8s38Fop3duBOmOXpXK3Tc601Q2QhjxN/v+TPnarXJJNYxuLWs7A0wpTRhCEzz
         WgvXR4Ou/UjM2gpqvz9zw4tSlRepHQYcJ2CpmbCsHe9lv/Ggk68LGavLkqs0OWcvr78K
         c5bxBqjNj5ZZpCkFOu1cC0u3nZeWD5leSvZpA/03L+/kUTw3h/AtcmBwVI7Z6VAd9ocF
         4OnA==
X-Gm-Message-State: AOAM531vDmSKrhAklZPVbg3CvAqz9LVIiIgdF60spDme4/+rJkcdrS7O
        RN/ytgdjx3C+5jXmgAym33AFVQ==
X-Google-Smtp-Source: ABdhPJxI9umDCXwDxklj2NtqSIbVMfDn48XRZSiTXL/2FxPT2cevmZYvO3zSULt+WkMGpDbo3NCD9w==
X-Received: by 2002:a05:620a:a08:: with SMTP id i8mr22591629qka.221.1622676705854;
        Wed, 02 Jun 2021 16:31:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id m10sm793753qtq.62.2021.06.02.16.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 16:31:45 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1loaKu-000nhH-F9; Wed, 02 Jun 2021 20:31:44 -0300
Date:   Wed, 2 Jun 2021 20:31:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix failure during driver load
Message-ID: <20210602233144.GO1096940@ziepe.ca>
References: <CAD=hENe9O+3Z9ck6G5+t9RaVpbqUL-edfa+b1-Ki5NZO0eJPPA@mail.gmail.com>
 <8649FCE4-EAEE-4DA9-AF51-FC6329F67C43@gmail.com>
 <CAD=hENdazayh5wmjd=3shHMVrNMrMw40qFdDFbkTqtaST46o8A@mail.gmail.com>
 <YLX5PLZjjoRiDNGN@kheib-workstation>
 <CAD=hENc2v4j9KyAL_La9tZcFzzcGyJdnw=5gwxwyekDxD7aOqA@mail.gmail.com>
 <20210601170132.GN1096940@ziepe.ca>
 <YLeDL+Omy8QdI+Q+@kheib-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLeDL+Omy8QdI+Q+@kheib-workstation>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 02, 2021 at 04:10:07PM +0300, Kamal Heib wrote:

> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 01662727dca0..144d9e1c1c3d 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -208,6 +208,11 @@ static struct socket *rxe_setup_udp_tunnel(struct net *net, __be16 port,
>         /* Create UDP socket */
>         err = udp_sock_create(net, &udp_cfg, &sock);
>         if (err < 0) {
> +               if (ipv6 && (err == -EAFNOSUPPORT)) {
> +                       pr_warn("IPv6 is not supported can not create UDP socket\n");
> +                       return NULL;
> +               }
> +

I would put this test in rxe_net_ipv6_init. returning errptr, null or
a valid pointer is a bit too ugly

>                 pr_err("failed to create udp socket. err = %d\n",
>                 err);

And delete some of this needless debugging

Jason
