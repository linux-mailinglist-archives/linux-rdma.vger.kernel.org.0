Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7DC251C0D
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 17:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHYPTE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 11:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgHYPTD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 11:19:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33BEC061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 08:19:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x7so7057063wro.3
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 08:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kRx01UfG8ly6dGwMuIBzxZRvnLQvgIEC5t1lZdXtDOk=;
        b=jLFPYBPD7cY7PB/D4dxHW4cK8Kb2jiWeO7vmX0jaDJ+5UrLqjCU62qRdNIIGBqLRNy
         uH97EdY+fAzTYNGqqyuDOXBvyPDqxwcyf5sPLyRJtKRaTIHi8Iat8gDUcSrx5x3uNIQI
         VlteczF/a8izl6jencMQRRQhfdULs1bYxLt9KIEI2Oenlq7pAJG1Akjei7V+9XjcVZWI
         5A/exuGEOYLkuA3odCbPZOTJuEt1lQPkmRLcXD+DR4IHz1UTk8ATCtRBNAQv8iq0xznC
         R2gumHGTetGz+8pDOYAIdJ4ywOX8Kh63iMc9wFVHGfeNFqJVcxFaMGlwm2YCnIanVDCU
         6QTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kRx01UfG8ly6dGwMuIBzxZRvnLQvgIEC5t1lZdXtDOk=;
        b=oul3+dDtt9mpIdHfA0wcCwrehuTYQ+E6nnk/jZN9ElnpJk1NvpmfVI7aAXHfQ/ZTVH
         v9ntx4XxbLSpsgPB9lwNpZpqsDh3hc+Vu+v72XC9JIoynUBsF0p9pBetaTIFq3jqjwKn
         9PO0lFE1Ami7e4ZIpjhw8s7mzoiM/1rzs+xNgm5cVAmvk/kWYZNE9TVu73TpaM0IoZ5d
         IdXV5YQJbmzyRd1+8X9vvnXF5QFJeMflRxfnIbL6bRYWa1S+M075bfOqV5U/Oih9GbNB
         Z7ZBqdXD9bQdRFGTWLTFDT1zbBpRLq83so/tUiyDueMILfOIx2LW4k5XR0hktuzp9ODB
         GnHA==
X-Gm-Message-State: AOAM533BWMfldzHMh2/UDGfMVGffj8WAX/KGosvhow04ex8VqbfgDpAp
        OqCoPQFUOZVL1r5OrwfqTFQ=
X-Google-Smtp-Source: ABdhPJxafW8Dpl58+h5TH0qaAtOcDYL2Ire/VivYArn5J5Yp19KPEzlt+lEQt2oFXYfBNNZXxwb3Ng==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr10955746wrm.113.1598368741518;
        Tue, 25 Aug 2020 08:19:01 -0700 (PDT)
Received: from kheib-workstation ([37.142.0.228])
        by smtp.gmail.com with ESMTPSA id 124sm6766151wmd.31.2020.08.25.08.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 08:19:00 -0700 (PDT)
Date:   Tue, 25 Aug 2020 18:18:58 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH v3 for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
Message-ID: <20200825151858.GA254017@kheib-workstation>
References: <20200824155220.153854-1-kamalheib1@gmail.com>
 <ee809280-48d2-a5cc-c1a1-521ba58636b1@acm.org>
 <20200824165111.GE24045@ziepe.ca>
 <20200825093624.GB194958@kheib-workstation>
 <20200825132557.GH24045@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825132557.GH24045@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 10:25:57AM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 25, 2020 at 12:36:24PM +0300, Kamal Heib wrote:
> > On Mon, Aug 24, 2020 at 01:51:11PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Aug 24, 2020 at 09:41:14AM -0700, Bart Van Assche wrote:
> > > > On 8/24/20 8:52 AM, Kamal Heib wrote:
> > > > > +bool rxe_is_loaded;
> > > > 
> > > > The name of this variable seems wrong to me. My understanding is that rxe_module_init() is
> > > > called whether or not rxe has been built as a module. Consider renaming this variable into
> > > > e.g. "rxe_initialized".
> > > > 
> > > > > diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> > > > > index ccda5f5a3bc0..12c7ca0764d5 100644
> > > > > +++ b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> > > > > @@ -61,6 +61,11 @@ static int rxe_param_set_add(const char *val, const struct kernel_param *kp)
> > > > >   	struct net_device *ndev;
> > > > >   	struct rxe_dev *exists;
> > > > > +	if (!rxe_is_loaded) {
> > > > > +		pr_err("Please make sure to load the rdma_rxe module first\n");
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > >   	len = sanitize_arg(val, intf, sizeof(intf));
> > > > >   	if (!len) {
> > > > >   		pr_err("add: invalid interface name\n");
> > > > 
> > > > The above message is misleading. Consider changing it into e.g. the following:
> > > > 
> > > >     Please wait until initialization of the rdma_rxe module has finished.
> > > 
> > > How about "Module parameters are not supported, use rdma link add"
> >
> > I don't think so, This patch is targeted to for-rc (stable) and the
> > support of "rdma link add" is not part of all the stable versions.
> 
> then add "or rxe_cfg"
>
Done.

Thanks,
Kamal

> Jason
