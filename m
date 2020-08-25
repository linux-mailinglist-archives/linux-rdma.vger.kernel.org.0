Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2104251982
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 15:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgHYN0B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 09:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgHYN0A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 09:26:00 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED033C061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 06:25:59 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id v2so10371977ilq.4
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 06:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vGFZ1GigmB4VbPvA/eLO+saugx0ctCKcTrNRsaN1JH8=;
        b=AmRu38IcGj40Sih7BnddB6/1gHoBIJX100LTOCBt82AQKDu33IB1WynsjLIfRLSnc5
         DazchNPaUgyGwU2tNypeF96FSj6D12HZEgBMEGXv5vJ9NYQUSJ7yWyIqQbdd9IwDp1UV
         O04AM3cX3ASwNeUaCaGvbNNsJLI+QYsStxKMLTVy5PJmTNn64BhzGFXPJ7Ixe7LVdfQp
         O7az0TyGOhlEV0Q+Gh0UUYGXPH1Ps5rarB0EKVVGZjbNr8YvJXkJFFvwBja/SyZeItGh
         S4Z7tCx4hPYcQcwDu4LKxzQhI2tJVh4FqeH957QpN+x/Ie5Z/2GmpX2eh+YhZz1tyQNH
         5jUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vGFZ1GigmB4VbPvA/eLO+saugx0ctCKcTrNRsaN1JH8=;
        b=kqFq+h4wMJPsgNYQ0J9fCoEJ4jRmIb1+LOaNHa7M3mk7oyyr0ZBZY25DBCDDmMw1Ul
         sq1zMbh15XqdGR7nl4g94kriCofuMCtW9f2zkFtY8C2py9uQuWWv5OgyL1PYrDuoS5/x
         A0bawARCQCVL7vC1qfgkQxLf0ZNQW+RiMi97dVyAkb6bExXIyGt2KaH82Omx8Bx8w6FS
         Mo9hCf6MS07EaBnnCSt9KRZ+fL7rLxQoYGn4uWpbVg9I6kU0FcPSWKrQPdKDYtjI3rTo
         sauHOEimAPsna3STiagAIgVpUOHLGlqvJcZgzP0rEhWx/lA5zI2L8gVSKU1XrDxpFyBC
         4n/g==
X-Gm-Message-State: AOAM531t8nFgf4X0fZUjgJVYZJRU0/Yjy2t4QAqCNjt+l4toLg2lYRwd
        kCYCIO9SBb0l/38uUGSfCnm33XLiDUFtng==
X-Google-Smtp-Source: ABdhPJzp0Mbv17c6WYoSdkGJMu9wawQRLM1oPX6r79Iiy+1Attc9Hp5LZBHGB6oKtKAzcZwTbUuXUg==
X-Received: by 2002:a92:d306:: with SMTP id x6mr9713355ila.229.1598361959278;
        Tue, 25 Aug 2020 06:25:59 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id 3sm9355310ily.31.2020.08.25.06.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 06:25:58 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kAYxZ-00EYNV-3U; Tue, 25 Aug 2020 10:25:57 -0300
Date:   Tue, 25 Aug 2020 10:25:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH v3 for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
Message-ID: <20200825132557.GH24045@ziepe.ca>
References: <20200824155220.153854-1-kamalheib1@gmail.com>
 <ee809280-48d2-a5cc-c1a1-521ba58636b1@acm.org>
 <20200824165111.GE24045@ziepe.ca>
 <20200825093624.GB194958@kheib-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825093624.GB194958@kheib-workstation>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 12:36:24PM +0300, Kamal Heib wrote:
> On Mon, Aug 24, 2020 at 01:51:11PM -0300, Jason Gunthorpe wrote:
> > On Mon, Aug 24, 2020 at 09:41:14AM -0700, Bart Van Assche wrote:
> > > On 8/24/20 8:52 AM, Kamal Heib wrote:
> > > > +bool rxe_is_loaded;
> > > 
> > > The name of this variable seems wrong to me. My understanding is that rxe_module_init() is
> > > called whether or not rxe has been built as a module. Consider renaming this variable into
> > > e.g. "rxe_initialized".
> > > 
> > > > diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> > > > index ccda5f5a3bc0..12c7ca0764d5 100644
> > > > +++ b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> > > > @@ -61,6 +61,11 @@ static int rxe_param_set_add(const char *val, const struct kernel_param *kp)
> > > >   	struct net_device *ndev;
> > > >   	struct rxe_dev *exists;
> > > > +	if (!rxe_is_loaded) {
> > > > +		pr_err("Please make sure to load the rdma_rxe module first\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > >   	len = sanitize_arg(val, intf, sizeof(intf));
> > > >   	if (!len) {
> > > >   		pr_err("add: invalid interface name\n");
> > > 
> > > The above message is misleading. Consider changing it into e.g. the following:
> > > 
> > >     Please wait until initialization of the rdma_rxe module has finished.
> > 
> > How about "Module parameters are not supported, use rdma link add"
>
> I don't think so, This patch is targeted to for-rc (stable) and the
> support of "rdma link add" is not part of all the stable versions.

then add "or rxe_cfg"

Jason
