Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188E7251E39
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 19:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgHYR0e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 13:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHYR0d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 13:26:33 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953D9C061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 10:26:33 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c6so11068041ilo.13
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 10:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lVxzgBFg2Gb0nrnxquHx+umG95upIqb/sNCWVJ0TVAQ=;
        b=UUJsadPX64x7S3vJsZAyzUKf3KfcL2oK+IppjYH03BZacVg44v5ZS98zn0VzCyrCbw
         3yjVbZNiZuIx31BQcMuNPKizNNORMs0kWyGM8ShxbHrX/WkD19RmNd4S9uZNrHhv8LMU
         7r9u9StLsEK2h5xHXw2vTBz+6rdoZupPDOJ1EssCYTp55PoQYh8KuY654UQ92leEm+lu
         /TjBJ9I5lewRWYWW1NVyAABTl/CXYPOasBl9RHmBFwMFLVPPHR9UT9tIyoqKffuFVojN
         iYD8l5v+phCjMIFjx7lg/Knnt8BnnKlH3Q3N5d2WZvOSXP2IHGLs9WQGVUdzJYncohTq
         KhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lVxzgBFg2Gb0nrnxquHx+umG95upIqb/sNCWVJ0TVAQ=;
        b=jB8FwzVEJFFHZEvsi7RMqk1FdPTyl5Vs6Pxkv8R8mU0gzumsoq88bIbL9gbadp7GdV
         JbgnRWkJ8JFXvdPCVRQzRJ5PRSU43FUdMFHD3e+OaZ6ZJMCnm47Tyheb9Arej0l/rOQX
         elIjqj8u55sKs68hMzbW/r6L7PWfTzduUD25yhAexPcwcpSHK/7o1oIEmNQPVGmC4ugz
         cDGxQwLW3Gu9xRDfJc8Tp+QgZCqEn8mv3GcV7QfDGtS+GHjxfH1gQZ8YWmV5v/oCmogu
         qHprOWsRpCJ47ZaVe7tO7WeXDe4Xd5vl0CoVJI0+noPVT85K9alFoKdDzOnbLCPaAyWk
         yYjg==
X-Gm-Message-State: AOAM533OKc7pg4tvdv1F9qcT/Wu7ULhdE4mn10oEceJJwO4OWX5Q1kSL
        cjefvhqwfyg7FhHf9k9JNn2dEA==
X-Google-Smtp-Source: ABdhPJz2U/QCQjnf6xcDhjRQVT1vEpvT+JA4VaHSfojn8evQ89amD9+VbrzPbElpAGuFXmQZaPCDTA==
X-Received: by 2002:a92:c7d4:: with SMTP id g20mr10202927ilk.40.1598376392934;
        Tue, 25 Aug 2020 10:26:32 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id 132sm9666780ilb.36.2020.08.25.10.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 10:26:32 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kAciM-00EjKa-VS; Tue, 25 Aug 2020 14:26:30 -0300
Date:   Tue, 25 Aug 2020 14:26:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: Re another alternative to resolve hardened user copy warnings
Message-ID: <20200825172630.GJ24045@ziepe.ca>
References: <42b0da37-898f-2ca1-ffcb-444b65c9c48d@gmail.com>
 <20200825165307.GI24045@ziepe.ca>
 <a6ccc179-b23d-3dc4-cff7-57f39e912f13@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6ccc179-b23d-3dc4-cff7-57f39e912f13@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 12:12:18PM -0500, Bob Pearson wrote:
> On 8/25/20 11:53 AM, Jason Gunthorpe wrote:
> > On Tue, Aug 25, 2020 at 11:37:52AM -0500, Bob Pearson wrote:
> > 
> >> Currently only the rxe driver is exhibiting the issue of kernel
> >> warnings during qp create caused by recent kernel changes looking
> >> for potential information leaks to user space. The test which
> >> triggers this warning is very specific. It occurs when a portion of
> >> a kernel object stored in a slab cache is copied to user space and
> >> the copied area has not been 'whitelisted' by setting useroffset and
> >> usersize parameters for the kmem cache. As already discussed there
> >> are two ways to mitigate this
> > 
> > I think we should just add a uverbs_copy_to() for integers, much like
> > netlink does.
> > 
> > We already have various getters for integers..
> 
> Perhaps. But I think the proposed fix is good in any case. It gets
> rid of a bunch of code that doesn't add anything.  The info leak
> police will come after kmalloc too. It is just a harder problem so
> your suggestion will still be a good one.

Sure, if the caches are not so useful, then lets drop them.

Jason
