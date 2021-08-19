Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304853F2379
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 01:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbhHSXBk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 19:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhHSXBk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Aug 2021 19:01:40 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7B9C061575
        for <linux-rdma@vger.kernel.org>; Thu, 19 Aug 2021 16:01:03 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id b1so6056000qtx.0
        for <linux-rdma@vger.kernel.org>; Thu, 19 Aug 2021 16:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pIxdUSgmjz7GOcg4GJSov0w9zK5nIJguojkPihAZQ88=;
        b=oEG59CP+BxfIAAgFPXl108I+vNpbCsX/os9W6BjRAe/R9eEHUiwjpaUo1rtHy253Wv
         aYZpxABNN2LBpfnjPL6n5B3k4gauKztLln8tceyTQMWFQ8ohi12YOTzwl91fSG4JloVp
         OwUHo0ZnpDM4UlGw2tZudgDTC2FacO09/GyybLs9Dt+gH9kZuhhDTJBhHNRX+EIO/WHB
         ocwTCJPIxPEXC0PoUmobemBsXjuBCUVeQL3+1jXjI3kpetQKkYJea7g6ciLzXDd+1622
         sdjoXy58x3Hd2SFvbSEoBJRFMUMzIvDVnaCWpTQHpF9ILLUwUw5rwwuQ0FUVgfxX/x2e
         xAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pIxdUSgmjz7GOcg4GJSov0w9zK5nIJguojkPihAZQ88=;
        b=R9GwuH9iAIId6h4Y01blJ2uG/n03/lkZHhvDDyf5NLh8qIHgRXBZQOwX/TlRpOBDpx
         d1mqtfV2Xx/ZQ5q4gRnSYIxPwhVSxhCuoA7U84wm+s/LJSGt2Qry+7W3UyctlG8rAM55
         xdBlenE3dDCh5/pwBVH8NA80j32BYucHKxM4IJgx+pTe2n0oOza4zOvPMp3A6q+6WWPH
         p4lsDjK4h5VgWjGIAc7yLTkfPVVzeGbNVmc2Ie289iu6OVmIMU02rOmszxZyrpBI6px0
         d8HRaOOUKFkcDknFwmWclHE0A3jWFr4FOUq6a17/GlucM2b43eCi/HNI/UxV5AwvFOEZ
         P0IQ==
X-Gm-Message-State: AOAM531+/+dps/H6WAnI4ty/K+u9i6btSEau6ZOO9IHjbJ83U8rGUOEw
        QkTcM372AxLchDfQTh3JhzPsEA==
X-Google-Smtp-Source: ABdhPJxV9mLuypofNyVuZ7qdJKKHtibwE7K7DEYtTd/SBIKpbTxaaldgfTdGk0nshD+C4l+fBUBHdQ==
X-Received: by 2002:a05:622a:1350:: with SMTP id w16mr14841566qtk.295.1629414062639;
        Thu, 19 Aug 2021 16:01:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id q72sm2318425qka.104.2021.08.19.16.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 16:01:02 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mGr1x-001dJn-9Q; Thu, 19 Aug 2021 20:01:01 -0300
Date:   Thu, 19 Aug 2021 20:01:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Linux RDMA <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>, kaike.wan@intel.com
Subject: Re: [RFC] bulk zero copy transport
Message-ID: <20210819230101.GT543798@ziepe.ca>
References: <04bdb0a7-4161-6ace-26d0-c3498327d28c@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04bdb0a7-4161-6ace-26d0-c3498327d28c@cornelisnetworks.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 19, 2021 at 03:09:02PM -0400, Dennis Dalessandro wrote:
> Just wanted to float an idea we are thinking about. It builds on the basic idea
> of what Intel submitted as their RV module [1]. This however does things a bit
> differently and is really all about bulk zero-copy using the kernel. It is a new
> ULP.
> 
> The major differences are that there will be no new cdev needed. We will make
> use of the existing HFI1 cdev where an FD is needed. We also propose to make use
> of IO-Uring (hence needing FD) to get requests into the kernel. The idea will be
> to not share Uverbs objects with the kernel. The kernel will maintain
> ownership of the qp, pd, mr, cq, etc.

I feel a lot of reluctance to see the API surface of the HFI1 cdev
expanded, especially to encompass an entire ULP

As you know I think that cdev is very much the wrong way to design
driver interfaces, and since all the work is now completed to do it
through verbs I'm not keen on any expansion.

But I'm confused how you are calling something a ULP but then talking
about the HFI (or uverbs even) cdev? That isn't a ULP.

A ULP is something like RDS that spawns its own cdevs and interworks
with the common RDMA stack.

I suppose I don't get what you are trying to sketch. Maybe you could
share the uAPI you envision in more detail?

Jason
