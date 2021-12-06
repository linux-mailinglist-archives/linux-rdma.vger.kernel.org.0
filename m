Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D3546A914
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 22:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243937AbhLFVK0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 16:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350143AbhLFVK0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 16:10:26 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A137C061746
        for <linux-rdma@vger.kernel.org>; Mon,  6 Dec 2021 13:06:57 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id p19so12167061qtw.12
        for <linux-rdma@vger.kernel.org>; Mon, 06 Dec 2021 13:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xcamdCOpv2xLzvV8MbrDO9wZViP9l+xXiD+x5Bw6fXM=;
        b=dNmu46bYRehJqMST47J1hOjStBRrqfUg92qY3t7B0xhVPEGMAIG9spIHnMrLj8w8cg
         SD0UOJfjNs7fjFyGIftQ+La5EiTUnBosNpFdZYu72+Xtv91+Qvp/rkkwT6CGUZ0vvfsw
         X8ZUaRmMYBdJxpGqBscAsf6dEyXKiO8lEf7RTbCo41CJEeRaEevKaaQdP2ux6Ykg3Fo+
         IyMxDwgg0RD3gsTi85N6TnOwPSfDVnKedugQkgv8KTeH2KpjWIGOgVhsFPLSOZhOFvYp
         /htgpm+F60LYdwBt4fsHEskKF9hKobZVJPHxoA9+c+43vBg5ppnENSDMHOnCd8Q95Iu3
         OCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xcamdCOpv2xLzvV8MbrDO9wZViP9l+xXiD+x5Bw6fXM=;
        b=FfWAdSCJWask3BSeZOPGlwsAo7XQgKx9o9V4IllV83pU8h1epDu+n0HnTQYsK8qlZy
         Ls8WQFh3jb6FgAn2cJBgi/TZu3L3ryIvWHPcrSiRmTZEx7wpPYMGv71kYwpoDPDlowsp
         vK9OpdxO1QQ5JkAYIqJUM0hkvGQKnbelO24LbkRj3RX6WbEVuocwqJPGusaYum7+QG7h
         CLHUylZ3OY4sL7pG0WVrnikd9G13S0/lK869RB96fkHTDqDKlWJMx7TyGku8b6IePe+M
         DOj2ywANd/4Pnt6dHPs/+rvOW0NL74sbZVRiTqt7WlAgWfp9p1JQczwZw/YKDD0T1jEt
         YP5w==
X-Gm-Message-State: AOAM531VC9oIJJkfTm2N1gQo60/xH2A3oF3V7sGLQDa4joOoA50Z9jSJ
        dsBrbqOz6ikjh3e0WGoxgeBlz+NBvz3heg==
X-Google-Smtp-Source: ABdhPJxL404eE2qP7Aesvd4LE761YqbV9hX0swZjGirvrFZP7RsZ9f2DGA3X9e6rdFqb10MvCHhgcA==
X-Received: by 2002:ac8:5f84:: with SMTP id j4mr43777418qta.271.1638824816390;
        Mon, 06 Dec 2021 13:06:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id f34sm8655551qtb.7.2021.12.06.13.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 13:06:56 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1muLCJ-0093lp-6F; Mon, 06 Dec 2021 17:06:55 -0400
Date:   Mon, 6 Dec 2021 17:06:55 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>
Subject: Re: [PATCH for-next] RDMA/qedr: Fix reporting max_{send/recv}_wr
 attrs
Message-ID: <20211206210655.GR5112@ziepe.ca>
References: <20211206201314.124947-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206201314.124947-1-kamalheib1@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 06, 2021 at 10:13:14PM +0200, Kamal Heib wrote:
> Fix the wrongly reported max_send_wr and max_recv_wr attributes for user
> QP by making sure to save their valuse on QP creation, so when query QP
> is called the attributes will be reported correctly.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 2 ++
>  1 file changed, 2 insertions(+)

Fixes line?

Jason
