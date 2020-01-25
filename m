Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBE7149778
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jan 2020 20:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgAYTg5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Jan 2020 14:36:57 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41193 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgAYTg5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 25 Jan 2020 14:36:57 -0500
Received: by mail-yb1-f194.google.com with SMTP id z15so2833925ybm.8
        for <linux-rdma@vger.kernel.org>; Sat, 25 Jan 2020 11:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/jkLNv4P9QzsHvGacFj4paH67im03/BWQoVxLJL/l4k=;
        b=FYEqJiULsKV3rEyEmrBwJcJE+3Vaqqm6p0vO+jVSnT9LAeMG/c2SYbklbCnv3W0AA3
         fHGiFR71TW7rL6EenkNOGJubHSUzMWGr8H0hXiyJHWHxiBBsWhqCJjItr7aRmZDVWkUH
         eda5M71knTAVAjkNeJeW0fSogSiPEtEqBgKiz8wIcAU1N88gvcYaU/8hQBSRLd7LYgXA
         Ga2lR5YUMCrnqp6FjBUruin3YrLcWKwSgyvzik9HfKUVs8DqmqU1LWnGL7OLFQJB7ITr
         QGgkzBgewa3A9JeLWoNYncVD+bgadUCnVHalhGc/bMW/zx0CCSyX2P3ydh+PpZnVFxMt
         fYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/jkLNv4P9QzsHvGacFj4paH67im03/BWQoVxLJL/l4k=;
        b=TzBzl1nODPr0j2DReoiAbG/kABShStlBtfNPW15N/YFBbjLdFZAjNo/CzT+cmu/vhm
         qFjvQ78AdUVs+LMKic+sfd6260XlkYRZRRhZCaXyCuljaZbQyWl84ns0NOv79aQBUjMr
         MARELCUvGdEsLZNnl7DjGAgZPDnvxa/xzXdJwpHm+cPO1uzWgzPLd5jcu195tGfyttwb
         zpYK10P3WZzkcKlPYcoLknxGheanRdwkAOH9olTcHTw9ro30B4v2aKL9TmE+uy2TBNDL
         0nlI/xB0V4MqmpVdV5soLMsSHNyTTi1X+lGTLChkRHF92GouX9LK42F8kV0emKNtmgQL
         wR7g==
X-Gm-Message-State: APjAAAXcBa8jHanE/e5hWHx0Sjjt9lNSmQK9Pgvv31YOY9yX/bYxg5r/
        q/kRdy8D3H+3DZZdznm8ktrDTA==
X-Google-Smtp-Source: APXvYqwxNUIOOcm3QO0hrnxz+PMfU5VyAecAS0T8mroEGU6CHKYRBISgpz3GeZHwzJ8mh3eHX6guJw==
X-Received: by 2002:a25:aa43:: with SMTP id s61mr7054535ybi.407.1579981016669;
        Sat, 25 Jan 2020 11:36:56 -0800 (PST)
Received: from ziepe.ca ([199.167.24.140])
        by smtp.gmail.com with ESMTPSA id g5sm4455303ywk.46.2020.01.25.11.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Jan 2020 11:36:56 -0800 (PST)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ivREi-00080O-F8; Sat, 25 Jan 2020 15:36:52 -0400
Date:   Sat, 25 Jan 2020 15:36:52 -0400
From:   Jason <jgg@ziepe.ca>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] IB/hfi1: Fix logical condition in msix_request_irq
Message-ID: <20200125193652.GA30707@jggl>
References: <20200116222658.5285-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116222658.5285-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 16, 2020 at 03:26:58PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/infiniband/hw/hfi1/msix.c:136:22: warning: overlapping
> comparisons always evaluate to false [-Wtautological-overlap-compare]
>         if (type < IRQ_SDMA && type >= IRQ_OTHER)
>             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
> 
> It is impossible for something to be less than 0 (IRQ_SDMA) and greater
> than or equal to 3 (IRQ_OTHER) at the same time. A logical OR should
> have been used to keep the same logic as before.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/841
> Fixes: 13d2a8384bd9 ("IB/hfi1: Decouple IRQ name from type")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/infiniband/hw/hfi1/msix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
