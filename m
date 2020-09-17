Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C156D26E40B
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 20:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgIQSiS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 14:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgIQRZK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Sep 2020 13:25:10 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7ABC06174A
        for <linux-rdma@vger.kernel.org>; Thu, 17 Sep 2020 10:24:53 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cv8so1367507qvb.12
        for <linux-rdma@vger.kernel.org>; Thu, 17 Sep 2020 10:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qnISMbW3nm4yggbOBgqyVMEyiRIror+WZEAjWJm/K2g=;
        b=FgfHEC+paMaduo6pBiGfkE6HvXXKKjAXDfribiWG8g4jTuepijvRaEFw+U+dfXI5oo
         OJL4xOE4CizfEM/4FWvJAG4beepZ2VRh626USUpegbA0MWIvyPkWb1ogt8sXzndhQEfV
         5FV6VLMO4GQ2Zvzwu9bdBiiY9SrU1s9ehrpmJcZD8t23FjgQ61jVLKYlaXgdUBeSK/cB
         DAnDPvvilysMmI7oWRL+vD4bEodstP5lgTEHQFP/Ut0ngu0vMuhDk99Q8bVXK5rcR1tg
         0mFZeVCzJJrRJD+5LBgOQRWQKsloBbweX4HVZaSGNEPEa7phLjn0k5d3jKDAQQ0NF/r1
         3YZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qnISMbW3nm4yggbOBgqyVMEyiRIror+WZEAjWJm/K2g=;
        b=mHLeQGkzcXXYk38q4ImBrYis5a7slHfIwzu42Rg+Ig8J6ju8skZcANcSlUjnPWO8o4
         ocRXuPM8rvcJIGjIWhBMsQnZJUGVuPQ9EcG9ngfSafKk/lEc5oegSYcnloz1067Kasmc
         QoYAAXDnvveHFytjEh3TtWsCAbGgLAwzq2KJxgvyw4j5v2IyAzlMYBI+dH99jwSj7hhS
         01otR/N6IwgkrtYhVnkkSygjH32iDLeHKIc5rb3auCzjmo8FExKe5f3zMxXohI8WiVhL
         pgyM1vJw2JKLqZQqXWvL8uXCnKEAqGxBtC7aMzyQBDTqAXpqwUpwaGV6CdhZW17oeufG
         lzkQ==
X-Gm-Message-State: AOAM531Qafy7W3EYYRkT4b7uKyUNLZzVwsmR6+8ybBJJkOZQ2sdgA7EA
        NJkvrlBM4BQWM3FTjQwg235K1g==
X-Google-Smtp-Source: ABdhPJxT+y+sQqjzbnRyXv8mTryKXanFEp2eAHIugZuaFmBoM8WwlSxulEay3IkHrwXW7q8cM9fRDg==
X-Received: by 2002:a0c:a990:: with SMTP id a16mr12961214qvb.59.1600363493126;
        Thu, 17 Sep 2020 10:24:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id o26sm254821qtb.24.2020.09.17.10.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 10:24:52 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kIxeN-000akx-Ni; Thu, 17 Sep 2020 14:24:51 -0300
Date:   Thu, 17 Sep 2020 14:24:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/mlx5: fix type warning of sizeof in
 __mlx5_ib_alloc_counters()
Message-ID: <20200917172451.GK8409@ziepe.ca>
References: <20200917082926.GA869610@unreal>
 <20200917091008.2309158-1-liushixin2@huawei.com>
 <20200917090810.GB869610@unreal>
 <20200917123806.GA114613@nvidia.com>
 <20200917170511.GI869610@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917170511.GI869610@unreal>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 17, 2020 at 08:05:11PM +0300, Leon Romanovsky wrote:
> On Thu, Sep 17, 2020 at 09:38:06AM -0300, Jason Gunthorpe wrote:
> > On Thu, Sep 17, 2020 at 12:08:10PM +0300, Leon Romanovsky wrote:
> > > On Thu, Sep 17, 2020 at 05:10:08PM +0800, Liu Shixin wrote:
> > > > sizeof() when applied to a pointer typed expression should give the
> > > > size of the pointed data, even if the data is a pointer.
> > > >
> > > > Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> >
> > Needs a fixes line
> >
> > > >  	if (!cnts->names)
> > > >  		return -ENOMEM;
> > > >
> > > >  	cnts->offsets = kcalloc(num_counters,
> > > > -				sizeof(cnts->offsets), GFP_KERNEL);
> > > > +				sizeof(*cnts->offsets), GFP_KERNEL);
> > >
> > > This is not.
> >
> > Why not?
> 
> cnts->offsets is array of pointers that we will set later.
> The "sizeof(*cnts->offsets)" will return the size of size_t, while we
> need to get "size_t *".

Then why isn't a pointer to size **?

Something is rotten here

Jason
