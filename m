Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A00C4A8BD3
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Feb 2022 19:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbiBCSlh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Feb 2022 13:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiBCSlf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Feb 2022 13:41:35 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE45AC061714
        for <linux-rdma@vger.kernel.org>; Thu,  3 Feb 2022 10:41:34 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id w8so2771551qkw.8
        for <linux-rdma@vger.kernel.org>; Thu, 03 Feb 2022 10:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tkA/XRfwm5fMMrupke4tcP8OUjUi0tMTXg0oPCP3EFs=;
        b=B/eh+vre6hrq2/VHMCgkl6Skoj+z/40B+3Zcvxag/ykWpSbasDJ7Fy+4kw2lqsjJk8
         Jk6Bc9gcF2ADUQRG7EQzaVDfcDzTzI/aG5214XcwpXePZe9+d1w43xW+fDZ8H6kKe6nL
         0OhL7OzTpQJ6I1c0+zgePAUfUW0yHmL4WrSKj9zwIQ/G7aHiXjetBqfbZCKlmfap/nNo
         96jYv7FdJR/8a2Qs861Qf3co2vdoCd9cBS3kveI7T3PONW0tw/qbJePxr7ABPG4H0TQJ
         HMdhL1MLvHKbx//lAmJB/mynwuf3dK9uydZEwTexGd9ue8p94za1+eV3mNHqrWN09Oyc
         23UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tkA/XRfwm5fMMrupke4tcP8OUjUi0tMTXg0oPCP3EFs=;
        b=mBlPkNmQQEcXvunOGYZLrodc1b5BV8bo+Yx2MZ6OgEt8lkYC3XBL4doM/ebr5z163T
         BsBqXZxyvBFn3yr/qSanwt+3g2VPb+W2YIxUFStH8TuvM7zaYjKqXZXRh26n+LkWJ3wA
         Q2Mw5gGJDM0xd6ofeHo43GBCc1Xq365UvtETyWvJvj2oO2CKC57TK68HO87SShbESgev
         ixKJSCFgQT3V2J83BEEGOLwonsh3Li656QaOm4ZZHl3yUBwe7c/v3I8mJdmxxAljLh8k
         0wP0FbVsOmBNBcpNtfNBVCiO03r1HBo333jJ7izSWXAf1YNGhhrlz9BAlZTbPL8Lj6dF
         yMYg==
X-Gm-Message-State: AOAM530WYofg9jhrAjDJR9GGpv3oq/lfCP9pfOoG4SOc5jtwdbPgGnMK
        HvrfoYkVnUKfGiXhU2FDYL6SUg==
X-Google-Smtp-Source: ABdhPJybXqkfBktaohx5yB1hsZb6kOZy7XeKyjz11O02/Ws4zc0yTMve6Jh1omAKrIS646ZDJrDfKg==
X-Received: by 2002:a37:a2c5:: with SMTP id l188mr24464927qke.16.1643913693837;
        Thu, 03 Feb 2022 10:41:33 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id l9sm2641869qkp.38.2022.02.03.10.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 10:41:33 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nFh2y-00BJyW-PS; Thu, 03 Feb 2022 14:41:32 -0400
Date:   Thu, 3 Feb 2022 14:41:32 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Haimin Zhang <tcs.kernel@gmail.com>,
        Weihang Li <liweihang@huawei.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Don Hiatt <don.hiatt@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Dasaratharaman Chandramouli 
        <dasaratharaman.chandramouli@intel.com>,
        linux-rdma@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH] RDMA/ucma: fix a kernel-infoleak in ucma_init_qp_attr()
Message-ID: <20220203184132.GC8034@ziepe.ca>
References: <20220203180936.GA28699@kili>
 <YfweSEOubl1O2VXD@unreal>
 <YfwfYfogp69yg1rF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfwfYfogp69yg1rF@kroah.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 03, 2022 at 07:30:57PM +0100, Greg KH wrote:
> On Thu, Feb 03, 2022 at 08:26:16PM +0200, Leon Romanovsky wrote:
> > On Thu, Feb 03, 2022 at 09:14:47PM +0300, Dan Carpenter wrote:
> > > From: Haimin Zhang <tcs.kernel@gmail.com>
> > > 
> > > The ib_copy_ah_attr_to_user() function only initializes "resp.grh" if
> > > the "resp.is_global" flag is set.  Unfortunately, this data is copied to
> > > the user and copying uninitialized stack data to the user is an
> > > information leak.  Zero out the whole struct to be safe.
> > > 
> > > Fixes: 4ba66093bdc6 ("IB/core: Check for global flag when using ah_attr")
> > > Reported-by: TCS Robot <tcs_robot@tencent.com>
> > > Signed-off-by: Haimin Zhang <tcs.kernel@gmail.com>
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Resending through the regular lists.
> > > 
> > > I added parentheses around the sizeof to make checkpatch happy.
> > > s/sizeof resp/sizeof(resp)/.
> > > 
> > >  drivers/infiniband/core/ucma.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > The change is ok, but I prefer to initialize to zero as early as possible.
> > 
> > diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> > index 2b72c4fa9550..6d801ed2e46b 100644
> > +++ b/drivers/infiniband/core/ucma.c
> > @@ -1211,9 +1211,9 @@ static ssize_t ucma_init_qp_attr(struct ucma_file *file,
> >                                  int in_len, int out_len)
> >  {
> >         struct rdma_ucm_init_qp_attr cmd;
> > -       struct ib_uverbs_qp_attr resp;
> > +       struct ib_uverbs_qp_attr resp = {};
> >         struct ucma_context *ctx;
> > -       struct ib_qp_attr qp_attr;
> > +       struct ib_qp_attr qp_attr = {};
> 
> Will that catch all of the padding in the structure?  This seems to come
> up a lot and I never remember...

Yes, last time you asked we went over it.

Jason
