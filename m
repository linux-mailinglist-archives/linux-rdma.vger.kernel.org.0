Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559D21ACF4E
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 20:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbgDPSEL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 14:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727794AbgDPSEK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Apr 2020 14:04:10 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51E1C061A0C
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2020 11:04:09 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id i19so14284286qtp.13
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2020 11:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=II2U/kfuhY0DimXhIK7//OXTDXoUWk9NqOuzTOrQ3zc=;
        b=K7rOz/Ul3kJ18mXRQ9MB1Mx/3EIQ7bJ3g9MYdqKH1dKjAn5Rkk898DkvYOBZYo6D8K
         Xf6KHBRVFSyXk9xq+vPngA06JAZ8KgITKH/gIuCLqS/5aChlr1PFBSva5CNojKo1q8/o
         ySNG8shBwNZkE/xI2EFWZzoDu2WKqMAoZh3j83+0KpD7B5YMBtJFZfn65M9osr9l4KQC
         oV9DMWXmF/eip+z0rNhKSjvK0RqtsrZHj9F/o1ltJPZRmjWRmRKFESguNGalkhG0I6EH
         tN4EKVcu1Dcfz0KRknCFfzZ7h+KdQ/+NaawmixgnFY9wmz96oN1ruD98bWwzfM3xyblU
         ZaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=II2U/kfuhY0DimXhIK7//OXTDXoUWk9NqOuzTOrQ3zc=;
        b=B7JUI18M/1lPrlGtybolCGbNKXQXS1B/u5tDd9rlVR8saggr7/SFpnZWW0tmOxtG6A
         LnPtZsMY6Lahgj66LSO34fObyVnXwOb7AnZdEcL7wleu6I98/NKRgM5UTOhJ+R48DxEB
         hal4EtF0AVsTTWBEFpttwP7ZDZf+T8DaspG1FZ0Iq3ikecTBH07o6Pn8BBqHwCPaChUL
         w1hhTqPbvm9oWjSA4QRYlX28hRJpvmOu6KBI0poCRCFh/Fceu0bGS4KF4nR5OshLKoJg
         sWBocnlrLSjPyeMfRTDerjpnMKB8eMsYmGCjCY6M0+hjSuvvaQlBjs58pT+Eiazhyk3L
         gUkQ==
X-Gm-Message-State: AGi0PuZX6k4M8S2NuCn2xnUQj3/xPDusvSF2OZq/hrTil4WqDXgXyizS
        01dHP0DAzC1K/K0zLwopm760hg==
X-Google-Smtp-Source: APiQypIRZRRAvnylEVMjz75JqDvlep9Ti+psvEPG8JpHmw1kN3WVRDfZsHwlmAHvcIX2hToaUmfjPA==
X-Received: by 2002:ac8:1b70:: with SMTP id p45mr27774026qtk.258.1587060248824;
        Thu, 16 Apr 2020 11:04:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 134sm2463837qki.16.2020.04.16.11.04.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Apr 2020 11:04:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jP8rv-00068z-F1; Thu, 16 Apr 2020 15:04:07 -0300
Date:   Thu, 16 Apr 2020 15:04:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [RFC PATCH 1/3] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20200416180407.GV5100@ziepe.ca>
References: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
 <1587056973-101760-2-git-send-email-jianxin.xiong@intel.com>
 <20200416180201.GH1309273@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416180201.GH1309273@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 16, 2020 at 09:02:01PM +0300, Leon Romanovsky wrote:

> > diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
> > index ade8638..1dcfc59 100644
> > +++ b/drivers/infiniband/Kconfig
> > @@ -63,6 +63,16 @@ config INFINIBAND_ON_DEMAND_PAGING
> >  	  memory regions without pinning their pages, fetching the
> >  	  pages on demand instead.
> >
> > +config INFINIBAND_DMABUF
> 
> There is no need to add extra config, it is not different from any
> other verbs feature which is handled by some sort of mask.

That works too, but then it infiniband_user_mem needs the 
 depends on DMABUF || !DMABUF construct

> > +	if (access & IB_ACCESS_ON_DEMAND)
> > +		return ERR_PTR(-EOPNOTSUPP);
> 
> Does dma-buf really need to prohibit ODP?

ODP fundamentally can only be applied to a mm_struct

Jason
