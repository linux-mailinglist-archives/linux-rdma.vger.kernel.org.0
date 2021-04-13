Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136B535E023
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 15:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbhDMNeX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 09:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbhDMNeW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Apr 2021 09:34:22 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AB1C061574
        for <linux-rdma@vger.kernel.org>; Tue, 13 Apr 2021 06:34:01 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c123so12951330qke.1
        for <linux-rdma@vger.kernel.org>; Tue, 13 Apr 2021 06:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ol3ASvhAwQOu79uFL+Cy6tkommWA1lm3vNzN2JnAzJc=;
        b=e9CUIIhOApot2KLCBo+HYoUWX+WACmZyv1z97wr869RkKYYDHdc6awKRq8dZfADSyz
         Q2YyoYQQI86xw+8Mn8OMbRTOQl8k2W2tdFmUeDMBL3/sn656PIBIjwJ5t+Tkpx9prxsq
         k7UvWnHfgjb68Ig7RlM7HuQlnz5FyPgFXAvWZJO7oPC4v1PJf7wnmkrXCoSM2fV+rGEe
         0PA6l0WALi4DyTvIcz7Zia6FHmhTcsAdB/qN+/sdLsjIR/tvstC0B1dVTsRm1IlxLsYI
         ZgQXzMlXUoO84jw3SKTlUBM3pe76/LHavWSc+LKJhwVfbX6EZzdlJjoZM2bcm7cza1bl
         2K2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ol3ASvhAwQOu79uFL+Cy6tkommWA1lm3vNzN2JnAzJc=;
        b=n1i4VcE7iNeqXHSGc8TsjNPIl1ow/puQLpEvjazs4fu6NXViQ94wTA7/AvXEp3RRnp
         1q6uJojShJaASutqnbpacqRQX7PpSyjvczA9jyvSi9ERD6EMsd0065iTPp/R+PN5gRjW
         ioVGfVmKIsDQGsqRD5rniedLSIsVeufSAAW8WenPJB6CYrfQdKrbnE65aLdmCqjJqSbq
         7nj7ci7n633eEhaIXxvI0ib0OG8zTB2HqkV26xgFgmJdGZMIXj5ygPC9QcEN61VeUKJO
         y9NmjVrIWYjKsVT1qFhWZ6V4nONz6BWXTZO1bsQLKJhM+DJTqmp2iclqf+A+0YbROOhd
         YJDg==
X-Gm-Message-State: AOAM531HoyfLZjpPqxq76YRtO3MBNAgG8ML5EPa48c6BPHkOG7nxIQvf
        b9nkgMmrRxUuv6E0URhQnegMk6wPhnrt1KP1
X-Google-Smtp-Source: ABdhPJwsdUB/vtuwLwYWU+BiznBk1o/0xd62inXkEnmDLWfy9FwdkckHUotkubjHJYa3Aa5p1KI9ww==
X-Received: by 2002:a05:620a:1107:: with SMTP id o7mr32711676qkk.188.1618320840976;
        Tue, 13 Apr 2021 06:34:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id y15sm860640qkp.17.2021.04.13.06.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 06:34:00 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lWJB1-005HHV-Eg; Tue, 13 Apr 2021 10:33:59 -0300
Date:   Tue, 13 Apr 2021 10:33:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org, leon@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: KASAN: use-after-free Read in cma_cancel_operation, rdma_listen
Message-ID: <20210413133359.GG227011@ziepe.ca>
References: <CACkBjsY5-rKKzh-9GedNs53Luk6m_m3F67HguysW-=H1pdnH5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACkBjsY5-rKKzh-9GedNs53Luk6m_m3F67HguysW-=H1pdnH5Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 13, 2021 at 11:36:41AM +0800, Hao Sun wrote:
> Hi
> 
> When using Healer(https://github.com/SunHao-0/healer/tree/dev) to fuzz
> the Linux kernel, I found two use-after-free bugs which have been
> reported a long time ago by Syzbot.
> Although the corresponding patches have been merged into upstream,
> these two bugs can still be triggered easily.
> The original information about Syzbot report can be found here:
> https://syzkaller.appspot.com/bug?id=8dc0bcd9dd6ec915ba10b3354740eb420884acaa
> https://syzkaller.appspot.com/bug?id=95f89b8fb9fdc42e28ad586e657fea074e4e719b

Then why hasn't syzbot seen this in a year's time? Seems strange
 
> Current report Information:
> commit:   89698becf06d341a700913c3d89ce2a914af69a2

What commit is this?

Jason
