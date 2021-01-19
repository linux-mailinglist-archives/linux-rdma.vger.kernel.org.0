Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039202FBEC7
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 19:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389030AbhASST3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 13:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392524AbhASSR5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jan 2021 13:17:57 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A705C061794
        for <linux-rdma@vger.kernel.org>; Tue, 19 Jan 2021 10:17:16 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id p5so9587887qvs.7
        for <linux-rdma@vger.kernel.org>; Tue, 19 Jan 2021 10:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xe5OFFqXJOpZrf1RLwm8O32rAqSG/3wjoFtUA7SKQys=;
        b=Cu9pQdgkuPmGsFfK1Bhot2GEDj34YX1UgywSUTlAnfjohEWUJcdw+iydHBAK385oP1
         Aon6yUBiuqKBJyOIdmjXm9R9+pwFK1YM6ancISnFbej5qVTRjaAbtoXHhnSCihZ0idpY
         SKse4iqkAvOCevShsndb3tq/GBo/VVzIj06N5mXpU32g2HE0TAwRq/I1cpBZ8fPleUsa
         LtFWoa9cvTJigy1WSHjsTCqUP1WXBPp/oFQ1FmgktRV7Y3nwsRJIaT/QLxF3dAIRsx/H
         dnBrbBD3QVcioOWh2VJck5oLCvv8jfJ/t5toQlSIr58Wlgkksz0jcLXApcGe9Am4Bjkx
         aaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xe5OFFqXJOpZrf1RLwm8O32rAqSG/3wjoFtUA7SKQys=;
        b=b1bsuA3D12s/t3Ls1VjEFQr0Rxa1X1waYl/5MQoXgEVP9oG6HZ4HoaXL6OSTQeP+pd
         RdDR8hVYhtxtXnBWDZ7ZNLjiNYUVYfzRuH9PqcFy9KxPjMNCXM7NJeHUABf9JktsqGAy
         r7Y6+gS2L4P6jKp68KIKLenFUz9p544VCqMN+wFtRhl6M7H7Me0/gXEOxiK+DkDHerbD
         StlwBpZKpJVIJ91bHUJGz0+83YPiiZEr2IdGjLxvPA7apT4WkaiN8ER+d6n3Kbm3uQR1
         j/hBOspZzTOgaWcVjbv1zUqrqsibNq3ECA60RTTi/8VDSNCl+dm8jhnY1EelUh7Rqru+
         NqmA==
X-Gm-Message-State: AOAM530h/9ekuL1q9S1ML4ff3zIgsq5CZgyA9t3GlqXHgCI/xfusaDNe
        YeVADEkNwhqJsDS/LeRyCOIeYw==
X-Google-Smtp-Source: ABdhPJyeOj0cdYmfZSjIN+M4tTaXUXGkK5bEWqkePXdbU3A+6DIKwM6G35J8cfVSNYvzxhuLPBTc/w==
X-Received: by 2002:a0c:a525:: with SMTP id y34mr5711355qvy.37.1611080235780;
        Tue, 19 Jan 2021 10:17:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id f134sm13257161qke.23.2021.01.19.10.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 10:17:15 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l1vZ4-003pQw-MM; Tue, 19 Jan 2021 14:17:14 -0400
Date:   Tue, 19 Jan 2021 14:17:14 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bodo Stroesser <bostroesser@gmail.com>
Cc:     Douglas Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, ddiss@suse.de, bvanassche@acm.org
Subject: Re: [PATCH v6 1/4] sgl_alloc_order: remove 4 GiB limit, sgl_free()
 warning
Message-ID: <20210119181714.GA909645@ziepe.ca>
References: <20210118163006.61659-1-dgilbert@interlog.com>
 <20210118163006.61659-2-dgilbert@interlog.com>
 <20210118182854.GJ4605@ziepe.ca>
 <59707b66-0b6c-b397-82fe-5ad6a6f99ba1@interlog.com>
 <20210118202431.GO4605@ziepe.ca>
 <7f443666-b210-6f99-7b50-6c26d87fa7ca@gmail.com>
 <20210118234818.GP4605@ziepe.ca>
 <6faed1e2-13bc-68ba-7726-91924cf21b66@gmail.com>
 <20210119180327.GX4605@ziepe.ca>
 <7ba5bfdf-6bc2-eddb-4c26-133c1bc08a33@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ba5bfdf-6bc2-eddb-4c26-133c1bc08a33@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 19, 2021 at 07:08:32PM +0100, Bodo Stroesser wrote:
> On 19.01.21 19:03, Jason Gunthorpe wrote:
> > On Tue, Jan 19, 2021 at 06:24:49PM +0100, Bodo Stroesser wrote:
> > > 
> > > I had a second look into math.h, but I don't find any reason why round_up
> > > could overflow. Can you give a hint please?
> > 
> > #define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
> >                                                      ^^^^^
> > 
> > That +1 can overflow
> 
> But that would be a unsigned long long overflow. I considered this to
> not be relevant.

Why not? It still makes nents 0 and still causes a bad bug

Jason
