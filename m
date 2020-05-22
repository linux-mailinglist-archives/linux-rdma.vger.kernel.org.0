Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731E81DEF72
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 20:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbgEVSq7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 14:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730810AbgEVSq6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 May 2020 14:46:58 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A55C061A0E
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 11:46:58 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v4so9116498qte.3
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 11:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WjxNk9cWcCPUPQ+MniBt6co28/chBR/GdxG36DCZBOQ=;
        b=eUiWtGKsArQesvhODjf7lC+za7ZfVFxWlDwY6JPWoIUzKTLmMj1uvOlCXVTUKKuQgv
         Mihz8B1rTXTz6VGPt87cTb9gubFj6SSAEqgovFsEFm8yjWCPvrvq6fxedSGY8CjfBInA
         2F4B9SkCJoMhxSYlEFBE1Qrq6ql/OKqXe6yAGMyWYemO958nj3wMqPy6lZzf5PVYH/Rd
         DbYWHyeZ/j5vjVuFp2+B/oIKnH9H00RK2J5hbfyY4uNImFt/q//PyREdezPo9JBEejLM
         Ahn9FxM4gY/+Y65TMgYxkYCiE3XILLmcVAiGZO3LM5LeuxzJNH/97mBIooXqmHcnP7rf
         gxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WjxNk9cWcCPUPQ+MniBt6co28/chBR/GdxG36DCZBOQ=;
        b=a/wELrsoxbT6lRHeud1yFqCBin/uRXePU4OYCgtVZ9kZhMiw8dSrQVwpFDXcgIxaEd
         NCrrRTK92LGm0SFZWf3GasKssoxOdesAKhQiVSTjM7EL0csFDEt13l8S6J+AIVpojOcq
         pACuG620K3oML4SwRYGGU/1l3q1PYIYF6ISwJ8CDSwwW68PjvN33+a0IghsCjPrSl7fq
         J7K059Yn5xOVvimd6OqIOyq5mw3TIrmWnfr9XuspTrxeDc99ooGwFcGs9TVLc9Qh6BeD
         1Ozh/bcJwadK+fbmm6WIu+yB+DYiPdMqZTt7v9c76ofnm0ZA/fwTaJTxmdw1DnYK5pTs
         sC+w==
X-Gm-Message-State: AOAM5302p+BYVtMqX3a5jMF9LVa/Dj7bypbigDWYb6Ib4uwGX7a64Yc3
        tJ/4HBl0abKo81mGa42FjIpdLr8bSRE=
X-Google-Smtp-Source: ABdhPJxl7N1xZdAfJebgIosQNdMZTf/04ueixTtuJZy7KBbDfhxf9GhnCN1hFHwQjsxSoybhhuRtig==
X-Received: by 2002:ac8:108b:: with SMTP id a11mr17805069qtj.173.1590173217684;
        Fri, 22 May 2020 11:46:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id u41sm9215212qte.28.2020.05.22.11.46.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 May 2020 11:46:57 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jcCh6-0001VK-M7; Fri, 22 May 2020 15:46:56 -0300
Date:   Fri, 22 May 2020 15:46:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] IB/cma: Fix ports memory leak in cma_configfs
Message-ID: <20200522184656.GA5742@ziepe.ca>
References: <20200521072650.567908-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521072650.567908-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 21, 2020 at 10:26:50AM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> The allocated ports structure in never freed. The free function
> should be called by release_cma_ports_group, but the group
> is never released since we don't remove its default group.
> 
> Remove default groups when device group is deleted.
> 
> Fixes: 045959db65c6 ("IB/cma: Add configfs for rdma_cm")
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/cma_configfs.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied to for-next, thanks

Jason
