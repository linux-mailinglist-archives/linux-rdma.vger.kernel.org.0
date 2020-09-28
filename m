Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C1D27AE2B
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Sep 2020 14:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgI1Muo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Sep 2020 08:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgI1Muo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Sep 2020 08:50:44 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0472C061755
        for <linux-rdma@vger.kernel.org>; Mon, 28 Sep 2020 05:50:43 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b2so576831qtp.8
        for <linux-rdma@vger.kernel.org>; Mon, 28 Sep 2020 05:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pv4XmF7mc9RmbTCsqyk0z6uvnXQM54wLYpH0aDCPch0=;
        b=Iusv10x0oagbem5kuq+PMXhgZyZ6o2nCXR02xi7KJXvxDUxnIkEY5aBVc0c88ICeIS
         gGyGXDjLulwMpOiKVoZuykQdJGrG7dde8D6pePKUPuSHJihlN1N08c6HhuN+Z9iTBxJy
         4Hz4G90FZzENM7MKAbsgsjegVtukSxBN09Hmtrov7DEvOKICxtzFo/YzJcw8IhjM0TEt
         2KF3YEw/PSy/72HKHbsh7vEP6hVi221OgPAfhaWlbSZFqohh6lb8H/R62YDTaiVLvUjV
         E77fcUEzcIjmLnpxRPLokCpNb66UnTjAegN4rNIfNAnxSL9ME0JsgoiClhISEYh0tnSv
         zZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pv4XmF7mc9RmbTCsqyk0z6uvnXQM54wLYpH0aDCPch0=;
        b=WzhiLcLELYTUIcbzjmVOyMwWuwU7P6O3vEUAXniHE+SZhTEVGJs3vQlbCU0TkLlQ8o
         rg4jVJbmK2vTLjuqZNVVeOlfko6wqiEO7L55wd8ix+cAXUqg5pUgNlj9XgbQBD246XOv
         w8PGuiiPrkgvVUpdwtZhxLN9BhMCBqhIiQ2EULAOx+/wzW7ZXilpucprqtGUpLU+mNKO
         fCX1abW53CLJp5V7NxDc5Cm34DSqUyqQoXG8qyH7mJr2I0K0RsFzHeYMqfqcMdDkfcxp
         EYDrFrnimsh0T3AltH3Bndk2/S0/bhW16/lNYuf++kPLJGRNc/dgJIiOwiJAjDq0EpUN
         hkbw==
X-Gm-Message-State: AOAM532f5lond80fPQ/v6QlNQEy7UaUPsLRXytOgevJvvbB+sO6iLXbw
        creDsutEjAe/LfZwJsTF78LttA==
X-Google-Smtp-Source: ABdhPJyizgXViFdCYmdNSqykOpt1uupOz+cBayg8lfM7teVNwSr0CAkF5LHGV7VYphQVzeEKRLvIJA==
X-Received: by 2002:ac8:1b92:: with SMTP id z18mr1291298qtj.265.1601297443117;
        Mon, 28 Sep 2020 05:50:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id w2sm838556qki.115.2020.09.28.05.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 05:50:42 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kMsc6-001ugT-15; Mon, 28 Sep 2020 09:50:42 -0300
Date:   Mon, 28 Sep 2020 09:50:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     liweihang <liweihang@huawei.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Remove unused variables and
 definitions
Message-ID: <20200928125042.GO9916@ziepe.ca>
References: <1601200341-7924-1-git-send-email-liweihang@huawei.com>
 <20200928115547.GL9916@ziepe.ca>
 <191e848eff4840ef80d9fbb0eab064a8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <191e848eff4840ef80d9fbb0eab064a8@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 28, 2020 at 12:27:56PM +0000, liweihang wrote:
> On 2020/9/28 19:55, Jason Gunthorpe wrote:
> > On Sun, Sep 27, 2020 at 05:52:21PM +0800, Weihang Li wrote:
> >> From: Lang Cheng <chenglang@huawei.com>
> >>
> >> Some code was removed but the variables were still there, and some
> >> parameters have been changed to be queried from firmware. So the
> >> definitions of them are no longer needed.
> >>
> >> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> >> Signed-off-by: Weihang Li <liweihang@huawei.com>
> >>  drivers/infiniband/hw/hns/hns_roce_device.h | 8 --------
> >>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 2 --
> >>  2 files changed, 10 deletions(-)
> > 
> > Should have a fixes for the patch that removed the code
> > 
> > Jason
> > 
> 
> Hi Jason,
> 
> Thanks for the comment. But I'm confused about when we should add
> fixes tag.
> 
> For example, The only purpose of this patch is to remove redundant
> macro definitions, the macros to be removed belong to 4 different
> former patches, so we have to add 4 lines of fixes. It seems difficult
> to merge this one back to previous versions of kernel.

You can just list all four patches

Jason
