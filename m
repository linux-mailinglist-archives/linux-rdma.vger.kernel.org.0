Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182DF2503D0
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 18:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgHXQvb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 12:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbgHXQvO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 12:51:14 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796E1C061573
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 09:51:13 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id b2so4030907qvp.9
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OSKuWhQnkMp+YHO7RV6FSMx9+oS5PRbx579TQZUeiZU=;
        b=V/viNrUZgImNHG5u0JYPyHKwiiFVmzxnC0HfuMryIUNgrKefsOmcermtinEAEVm6tb
         WFE8l02w0OZeyz3c8YZR2qkeK+KDXDiOLM+ucboc8hh6jeSwoyuLN5bC+smXZUz7NmxB
         gJb4WjJD77h+CanDquoukAppBlsS48MGZXiANboYTUj/EJNdLnDNFDUPNgIQzoMtVVqs
         WyL3On7QGc12r364C2GGYeeBGg4Tqg2AAQl6+KQo1t780owNFePFdTqmS3o+ci2U0PjF
         s2CQVIko+g3MumCxI7pYHYmDEX+yfYwzmM/oygKBdT7qCVT3FaFeAp4R0ATDLDdUJO9X
         pMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OSKuWhQnkMp+YHO7RV6FSMx9+oS5PRbx579TQZUeiZU=;
        b=Rwf+9FkVjv/1LAlHmCSaTTF0L+ynCSOHYda84r76IuOp0z0LtDRYCttmN0/MgJky86
         7IrbkJDMxmTi9PbKJRV2lS4e7Zny4A65hB2yw04vpSasSSfo52ZDvT5A9SD/ziv1dA+3
         SkAjOOHrq+xmRNthvH7/OCDm+cMpQxkoltJ3N5/uZWRk254lQiIMKolIa8cZXl0hDgIc
         IzU35DKgTeZEJJWe4K72fk75xfM4njPCJJGtwx5GlvSCGeZMGu/3ivrEsUiilBaE8OZf
         RvWbwk6CCldaQltuIB2rykoW6LCqzE1KS4M+aeJcxmJbCSwvH0BjqGE03BlSZHZw00kb
         Pb1Q==
X-Gm-Message-State: AOAM532wWacU1Ht51x2QxxmHDAhBoJUK0Jr5CHUAfpbLSZDeoWhp46ZR
        WIfW8rawmFRs3DRks6SWo84IZg==
X-Google-Smtp-Source: ABdhPJxdK26EuOe5QDJ/7i8bi4eTQMVbMOGRvMFz6onqMrhg1D4X/KRa0w/CF0qPw3iT7EtsScAl1Q==
X-Received: by 2002:a05:6214:8a:: with SMTP id n10mr5722822qvr.13.1598287872747;
        Mon, 24 Aug 2020 09:51:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id a67sm9836439qkd.40.2020.08.24.09.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 09:51:11 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kAFgd-00DLYc-A6; Mon, 24 Aug 2020 13:51:11 -0300
Date:   Mon, 24 Aug 2020 13:51:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Kamal Heib <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH v3 for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
Message-ID: <20200824165111.GE24045@ziepe.ca>
References: <20200824155220.153854-1-kamalheib1@gmail.com>
 <ee809280-48d2-a5cc-c1a1-521ba58636b1@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee809280-48d2-a5cc-c1a1-521ba58636b1@acm.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 24, 2020 at 09:41:14AM -0700, Bart Van Assche wrote:
> On 8/24/20 8:52 AM, Kamal Heib wrote:
> > +bool rxe_is_loaded;
> 
> The name of this variable seems wrong to me. My understanding is that rxe_module_init() is
> called whether or not rxe has been built as a module. Consider renaming this variable into
> e.g. "rxe_initialized".
> 
> > diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> > index ccda5f5a3bc0..12c7ca0764d5 100644
> > +++ b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> > @@ -61,6 +61,11 @@ static int rxe_param_set_add(const char *val, const struct kernel_param *kp)
> >   	struct net_device *ndev;
> >   	struct rxe_dev *exists;
> > +	if (!rxe_is_loaded) {
> > +		pr_err("Please make sure to load the rdma_rxe module first\n");
> > +		return -EINVAL;
> > +	}
> > +
> >   	len = sanitize_arg(val, intf, sizeof(intf));
> >   	if (!len) {
> >   		pr_err("add: invalid interface name\n");
> 
> The above message is misleading. Consider changing it into e.g. the following:
> 
>     Please wait until initialization of the rdma_rxe module has finished.

How about "Module parameters are not supported, use rdma link add"

Jason
