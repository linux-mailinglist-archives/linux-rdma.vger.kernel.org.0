Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E5425157B
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 11:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgHYJgb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 05:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbgHYJg2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 05:36:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94876C061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 02:36:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so12000298wrl.4
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 02:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ibDaMKfhwUNpz5TuVKQCR+hy6XQPD5VBmWzDHWIxwN8=;
        b=n0bwc7YM7znELSly6j/c/QRzbkSrELLF2DTEHghLYJm4rThk7uhBCeN07T1sy6DXpb
         HCXIfetudEuAhDJrF5kVkMz4g9ZYAV9XscU5WLAhzltnzFN16pSftOomuPNSS4zUREi6
         QJ5joXD5p1wGGkXmdLbdyrhPRxLyw1WgRsqJuA7pyzhmZbuKDj36Er0xJz6o0YxuUaym
         JG+cw5OfrP5ezTCG1ZENnjRmyBymT3CfEp+0M6rFPltjbqbXOAmGRPn9xi9GRwL+XIX0
         mM2Wy2wEqKgT5VR9obFNbf6fTiwlVMcIq7+ksUQHv24BlnHOxORd49CmCw66TLlV8bDr
         CWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ibDaMKfhwUNpz5TuVKQCR+hy6XQPD5VBmWzDHWIxwN8=;
        b=isXye1WUPwQ3eAHkpStxu8tZ3qsIVtIqnY84E1BNrsqHa/glYXO8EOPJWeCNDXGtko
         ZEBBDS9F1PN/3xFH+HA1L9ZJnNBZixu6AAHlIAyVZCBJv+BQdROnR2WKrBA6BMf8IJfo
         RTHtbE+mI89Hbm+EFxFTVByJFNq+SkiPkatqhRly28uWXKDx4HqCvs8vu3Ac6q/wZFF1
         P6PaA5ZhWbfu2GkQswkrAZfHvlf0MVI+19+BF7FQGuLE/H3R5t1xTW3VSEz9G+E/xz5s
         LdPwapVr72dfwc35+M6pRz2tsqc2FdEjGss9MexIpirNSYfb/5YcImhyRyNqlb+m5r9P
         J11A==
X-Gm-Message-State: AOAM533k7XMAGOhHKQo8OjaxAk2mu2mmJbdKtWa8zFUByiuR5s/hWoGo
        lg1Y8sskXEiT/PrLh+Bj218=
X-Google-Smtp-Source: ABdhPJxbjnVvb6p6rQO2GQKUW139F0lVKvcDzkUonDlaPCP0aYYFSqxKiD2wJwwVWf1nL7CLUvdEbw==
X-Received: by 2002:a5d:4b0c:: with SMTP id v12mr9793475wrq.199.1598348187267;
        Tue, 25 Aug 2020 02:36:27 -0700 (PDT)
Received: from kheib-workstation ([37.142.0.228])
        by smtp.gmail.com with ESMTPSA id s16sm4874872wme.13.2020.08.25.02.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 02:36:26 -0700 (PDT)
Date:   Tue, 25 Aug 2020 12:36:24 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH v3 for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
Message-ID: <20200825093624.GB194958@kheib-workstation>
References: <20200824155220.153854-1-kamalheib1@gmail.com>
 <ee809280-48d2-a5cc-c1a1-521ba58636b1@acm.org>
 <20200824165111.GE24045@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824165111.GE24045@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 24, 2020 at 01:51:11PM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 24, 2020 at 09:41:14AM -0700, Bart Van Assche wrote:
> > On 8/24/20 8:52 AM, Kamal Heib wrote:
> > > +bool rxe_is_loaded;
> > 
> > The name of this variable seems wrong to me. My understanding is that rxe_module_init() is
> > called whether or not rxe has been built as a module. Consider renaming this variable into
> > e.g. "rxe_initialized".
> > 
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> > > index ccda5f5a3bc0..12c7ca0764d5 100644
> > > +++ b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> > > @@ -61,6 +61,11 @@ static int rxe_param_set_add(const char *val, const struct kernel_param *kp)
> > >   	struct net_device *ndev;
> > >   	struct rxe_dev *exists;
> > > +	if (!rxe_is_loaded) {
> > > +		pr_err("Please make sure to load the rdma_rxe module first\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > >   	len = sanitize_arg(val, intf, sizeof(intf));
> > >   	if (!len) {
> > >   		pr_err("add: invalid interface name\n");
> > 
> > The above message is misleading. Consider changing it into e.g. the following:
> > 
> >     Please wait until initialization of the rdma_rxe module has finished.
> 
> How about "Module parameters are not supported, use rdma link add"
> 
I don't think so, This patch is targeted to for-rc (stable) and the
support of "rdma link add" is not part of all the stable versions.

Thanks,
Kamal

> Jason
