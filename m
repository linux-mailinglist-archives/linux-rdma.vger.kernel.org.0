Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA821DA5D4
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 01:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgESXwd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 19:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgESXwd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 19:52:33 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502C8C061A0F
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 16:52:33 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id i14so1815301qka.10
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 16:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0w5Q0s8R2YEA3g1NY8XrirtV4Lvn0PXi0qUKfjx3g8I=;
        b=jGdRfWODW/6EjBqooVOhtZrJh6yxWrpPId4S+vwSV/ouSCf853YEfbk7nnJEzfRP9D
         OJYu6vayBWJBkcm1NUWfQMVQDwvSpNUvxcwPnoP3QkpUmF+PSC66htu0+V0HiWLXpWaK
         SvKJ5L7OSkHzBFtpx75tK8HW68Sq6teAhd9XZRxuVrdeFD/0ii9SBeghVb5WBbt3XHyd
         rcDWFEVu8E8INPSLr9llyaqc1LUnAsDvY3Q4LpNhYv3pp268dxKKuC6CY8gM6ha0k5J9
         ivrGgCTKUdreVEsLkKgB5lJSim+9dauzI07OE7lBn6/Zc0WW6ErIHjqVtKDqETcOgaqZ
         gGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0w5Q0s8R2YEA3g1NY8XrirtV4Lvn0PXi0qUKfjx3g8I=;
        b=EyPM4uR+DSQTNez33+MPTK+ahVnBy6lLcFFf8PBVRPVbtiJLdIlxbGY5x26slvy7Rw
         G8DT0vveh7t4HV4jxhJfZL575Qj4khMNQoqC/mJvmhND35o3mxm49wL5d0V77AkAgcTu
         AGivC0Ls/a4ukBw8sECyh7xFObixjf15SBJeflZbzClWl4S5jW7By5nPBR5bOkGWVkaI
         vikfGL7k+p4TVK0P8sl/ouzCfn8hLr6meRO5UzkzrCIGsNcYBtb/nPYguzwSgJD1Np1+
         GdoCpeVTxgrJTw1uqFAR4v+Uh1E0hCE9fNDJ9/XGUhd4EBHDSoFavxOMseXHuVvGI/Cv
         j7ng==
X-Gm-Message-State: AOAM531xOqHf2B1OQ8judY2bNcAfQxiXHYqz4eRdAT2PhiQV1KsLXQtA
        kMW5qcHnBNrbKjSicVxjC193Sw==
X-Google-Smtp-Source: ABdhPJxEnvKvWp4JmgpC+vWG3nvTDPBBagW65uaps4SG5a24Zu4zPDQ8CAbK/+1jU8D7XBxg+INztQ==
X-Received: by 2002:a37:b144:: with SMTP id a65mr2023826qkf.462.1589932352377;
        Tue, 19 May 2020 16:52:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id y23sm1232277qta.37.2020.05.19.16.52.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 16:52:32 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbC2B-0008Bd-IO; Tue, 19 May 2020 20:52:31 -0300
Date:   Tue, 19 May 2020 20:52:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] RDMA/siw: Replace one-element array and use
 struct_size() helper
Message-ID: <20200519235231.GA31402@ziepe.ca>
References: <20200519233018.GA6105@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519233018.GA6105@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 19, 2020 at 06:30:18PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of one-element arrays in the following
> form:
> 
> struct something {
>     int length;
>     u8 data[1];
> };
> 
> struct something *instance;
> 
> instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> instance->length = size;
> memcpy(instance->data, source, size);
> 
> but the preferred mechanism to declare variable-length types such as
> these ones is a flexible array member[1][2], introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on. So, replace
> the one-element array with a flexible-array member.
> 
> Also, make use of the new struct_size() helper to properly calculate the
> size of struct siw_pbl.
> 
> This issue was found with the help of Coccinelle and, audited and fixed
> _manually_.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/infiniband/sw/siw/siw.h     | 2 +-
>  drivers/infiniband/sw/siw/siw_mem.c | 5 +----
>  2 files changed, 2 insertions(+), 5 deletions(-)

Applied to for-next, thanks

Jason
