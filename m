Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896E92B12F6
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Nov 2020 01:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgKMABj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 19:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKMABi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 19:01:38 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC92C0613D1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 16:01:38 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 11so7344818qkd.5
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 16:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RltXDH0FgaRusmPo4cNOYiqkUGtOvZLa8FgaLyW6/QQ=;
        b=cRbBUJPdHSqlA7MgYLSCQ680bqlGr2mKz4/cUeKhmyGfojLITJ/VAA6Bp+Kee/1RG8
         VKHHUMvoub+mAFbhoEf6SR8HpAi8V+lg4/JuxFOdnPszM6ZfMzT2tC1xBTRcoH3W3EAL
         IGAZRrtSHqyu0iqJXwUdou0hneYFtMmWNPuVeCjIX5rBlWqPzm2UKZ5QjVzWHOtfuZHN
         IvvwA9AGWC3yb/RK1Uw5jyu4bzgd6figaoSn7H8QUd3ITUeD1pqbw0fBN79eMXsc3EgN
         xeGjquQVyFqpAohk7NbRTvWZkm+j1aVjgln4h/BCwPTcgWLqD/SCNxyu1gNBhkJVaSQ+
         UBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RltXDH0FgaRusmPo4cNOYiqkUGtOvZLa8FgaLyW6/QQ=;
        b=ob7cNoLc2W+hDftYhniZZq44uSqfcr1++FLQfwsSNuC0tSEmVIhmAuquYcUjO3Gq6F
         bvvfnI94B9fLHLF9GxXIweoDtCXxm18u4Sosn0iHCGwy09wXn2Dmf62Z+wL8yhyNZixw
         ArQ8GcJ5/BqxsgBdGpnX6eNP8aGrG3R3EYRs8EhGmUmD0uewLsVBJ5+j8YtAdaLC9t50
         yNPXvxRf/GMp6qJHaz4hUkxaah1ibTGSXGqJsiVyd5bdeZfL9HH89h6mStZUXZX90Lgt
         RMjlC1GB7HYSo0Dve8iJaU47KGdzc1o/LbRkXBIVGwBsZ08hEaiXb+39QG4dYWmkjllj
         tjuQ==
X-Gm-Message-State: AOAM5327g0TSCkmqcGs0JjvZOcP3MAfb/C12kqQvfAtpFxJ9y6h27jxH
        LnMfCl+7M4+pxb15XHvSbVL/bRai/1UhYCai
X-Google-Smtp-Source: ABdhPJy/pDQ9Eqqb9pwaxGOwE/6Z10O6Gyf0jdFoMNxRg3i5i4P4RGk7l9ia9zNStnowU5Jnza1O9w==
X-Received: by 2002:a37:4bc1:: with SMTP id y184mr2421639qka.278.1605225697395;
        Thu, 12 Nov 2020 16:01:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 203sm5898928qkd.25.2020.11.12.16.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 16:01:36 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kdMX2-004Bpq-6S; Thu, 12 Nov 2020 20:01:36 -0400
Date:   Thu, 12 Nov 2020 20:01:36 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, dledford@redhat.com,
        Jann Horn <jannh@google.com>, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH for-rc v2] IB/hfi1: Move cached value of mm into handler
Message-ID: <20201113000136.GW244516@ziepe.ca>
References: <20201112025837.24440.6767.stgit@awfm-01.aw.intel.com>
 <20201112171439.GT3976735@iweiny-DESK2.sc.intel.com>
 <b45c2303-a78e-a3b6-fcd2-371886caf788@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b45c2303-a78e-a3b6-fcd2-371886caf788@cornelisnetworks.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 12, 2020 at 05:06:30PM -0500, Dennis Dalessandro wrote:
> On 11/12/2020 12:14 PM, Ira Weiny wrote:
> > On Wed, Nov 11, 2020 at 09:58:37PM -0500, Dennis Dalessandro wrote:
> > > Two earlier bug fixes have created a security problem in the hfi1
> > > driver. One fix aimed to solve an issue where current->mm was not valid
> > > when closing the hfi1 cdev. It attempted to do this by saving a cached
> > > value of the current->mm pointer at file open time. This is a problem if
> > > another process with access to the FD calls in via write() or ioctl() to
> > > pin pages via the hfi driver. The other fix tried to solve a use after
> > > free by taking a reference on the mm. This was just wrong because its
> > > possible for a race condition between one process with an mm that opened
> > > the cdev if it was accessing via an IOCTL, and another process
> > > attempting to close the cdev with a different current->mm.
> > 
> > Again I'm still not seeing the race here.  It is entirely possible that the fix
> > I was trying to do way back was mistaken too...  ;-)  I would just delete the
> > last 2 sentences...  and/or reference the commit of those fixes and help
> > explain this more.
> 
> I was attempting to refer to [1], the email that started all of this.
> 
> > > 
> > > To fix this correctly we move the cached value of the mm into the mmu
> > > handler struct for the driver.
> > 
> > Looking at this closer I don't think you need the mm member of mmu_rb_handler
> > any longer.  See below.
> 
> We went back and forth on this as well. We thought it better to rely on our
> own pointer vs looking into the notifier to get the mm. Same reasoning for
> doing our own referecne counting. Question is what is the preferred way
> here. Functionally it makes no difference and I'm fine going either way.

Use the mm pointer in the notifier if you have a notifier registered,
it is clearer as to the lifetime and matches what other places do

> That's the question. It does make sense to do that if we are sticking iwth
> the notifier's reference vs our own explicit one. I'm not 100% sold that we
> should not be doing the ref counting and keeping our own pointer. To me we
> shoudln't be looking inside the notifer struct and instead honestly there
> should probably be an API/helper call to get the mm from it. I'm open to
> either approach.

The notifier is there to support users of the notifier, and nearly all
notifier users require the mm at various points.

Adding get accessors is a bit of a kernel anti-pattern, this isn't Java..

Jason
