Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC8A2C4BBB
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 01:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgKZAAJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Nov 2020 19:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgKZAAI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Nov 2020 19:00:08 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C207BC0613D4
        for <linux-rdma@vger.kernel.org>; Wed, 25 Nov 2020 16:00:08 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id b144so123423qkc.13
        for <linux-rdma@vger.kernel.org>; Wed, 25 Nov 2020 16:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aKREM2LgpMemUitVe/ytv0SNKTIU13b/oPWuoX/JrCo=;
        b=UttOmsa4CIydIMlhmsf+mpL72ekN6XdJOKccupwa26yJabJffqzdKBszOdiAbyFnGb
         ycNvKmzKgO/6k7UOTismxzLPG6MKyJbVL5m2nXz60k8IZs91HAkIMmU1uydZP7woxuG7
         l4OEfrFRVONn5MZPaTjaF20xCPoTqyDOzK6n/GUx/cSR5CQfkIyFr/upm3oAOylDx5JM
         l/zDPZx6C2KT3uUV9+zFmcgPMSRoOloe9DmysxoEzrKgEo+s++Kc0svlJbDfURC4v+Cq
         ub/7SuADkb1ureevd8MfjBism6Dar2B6r6YV25fT8w2YFI83MHU4Dz+EbP9ZWRIaRAa/
         sjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aKREM2LgpMemUitVe/ytv0SNKTIU13b/oPWuoX/JrCo=;
        b=hksZ2CZ7EmPAIIIM6xYsVcileygQ7pG+nmGEvsUfY29rQHPYL8O7hsz2aX26NBLbpO
         C5K66MiCmIOS5DelvHbLyZlM73u27wTMnUjKCbC/+fa/TI+XDm+YA3n+5r0M4wmYbEyr
         qiL9dMNawLrgUf2r15wMUW13jOg20C4f9Ov2ow/p0TA/W//ru9qlYCKLLeYk4hxGgX+M
         jm6Mc5O1crw947g9C+EEBu7B/izsnbanG5HAi9sJAwjQo0eGliiB8YuomGMEG08s9RBJ
         LzDEhPTeRkt33plsBNJubr7TsVsllwXTCV5GNSrCv1lKupjKlfVlsSosY1HL9xeqf9am
         ROqQ==
X-Gm-Message-State: AOAM533u3kr7lxMilorPaSpAOgu2ZNhR524HczThRntnZmnjVp10U/Y+
        QMPGIjZ3fkfD7QPxagzFhApVxQ==
X-Google-Smtp-Source: ABdhPJy1oVswPNBIIEJRUXD9FYrqhWOv9OYbhoFw/mv9TlO+58lJs34Ve3mm23XrkxmRLPwP8foi1g==
X-Received: by 2002:a37:65d2:: with SMTP id z201mr565748qkb.403.1606348808101;
        Wed, 25 Nov 2020 16:00:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id m62sm889145qkb.91.2020.11.25.16.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 16:00:07 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ki4hi-001QF8-L6; Wed, 25 Nov 2020 20:00:06 -0400
Date:   Wed, 25 Nov 2020 20:00:06 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH rdma-core 3/5] pyverbs: Add dma-buf based MR support
Message-ID: <20201126000006.GS5487@ziepe.ca>
References: <1606153984-104583-1-git-send-email-jianxin.xiong@intel.com>
 <1606153984-104583-4-git-send-email-jianxin.xiong@intel.com>
 <20201123180504.GA244516@ziepe.ca>
 <20201124151658.GT401619@phenom.ffwll.local>
 <MW3PR11MB45554AAEB1C370A78EB87816E5FB0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20201125105041.GX401619@phenom.ffwll.local>
 <20201125121456.GM5487@ziepe.ca>
 <MW3PR11MB4555A91A6CF5D23AD538EF34E5FA0@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB4555A91A6CF5D23AD538EF34E5FA0@MW3PR11MB4555.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 25, 2020 at 07:27:07PM +0000, Xiong, Jianxin wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Wednesday, November 25, 2020 4:15 AM
> > To: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Xiong, Jianxin <jianxin.xiong@intel.com>; Leon Romanovsky <leon@kernel.org>; linux-rdma@vger.kernel.org; dri-
> > devel@lists.freedesktop.org; Doug Ledford <dledford@redhat.com>; Vetter, Daniel <daniel.vetter@intel.com>; Christian Koenig
> > <christian.koenig@amd.com>
> > Subject: Re: [PATCH rdma-core 3/5] pyverbs: Add dma-buf based MR support
> > 
> > On Wed, Nov 25, 2020 at 11:50:41AM +0100, Daniel Vetter wrote:
> > 
> > > Yeah imo makes sense. It's a bunch more code for you to make it work
> > > on
> > > i915 and amd, but it's not terrible. And avoids the dependencies, and
> > > also avoids the abuse of card* and dumb buffers. Plus not really more
> > > complex, you just need a table or something to match from the drm
> > > driver name to the driver-specific buffer create function. Everything
> > > else stays the same.
> > 
> > If it is going to get more complicated please write it in C then. We haven't done it yet, but you can link a C function through cython to the
> > python test script
> > 
> > If you struggle here I can probably work out the build system bits, but it should not be too terrible
> 
> Thanks Daniel and Jason. I have started working in this direction. There should be no
> technical obstacle here. 

Just to be clear I mean write some 'get dma buf fd' function in C, not
the whole test

Jason
