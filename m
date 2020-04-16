Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14221ACF20
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 19:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgDPRy6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 13:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729436AbgDPRy5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Apr 2020 13:54:57 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1395C061A0C
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2020 10:54:56 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id y3so22243058qky.8
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2020 10:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DmIMzRRO6Xkyv3KWHd7Bvl9UdWxEtku1V0qZzWAQTh8=;
        b=YVzovpI/l1FoL+tR/+21lbmTsMBvHevsvxy/yL80E/dAZJKXpH71CfrlsO7pbdY2W7
         jV6kWTfTUufSFMbUD7HX+p5UbgLFHzGUiPSwUDecFpdLcHHYvPrAwDuuRJop1NSfrm6H
         IVu8ZHYVMa/clgxMElDHR9A+iWPXrZLpXWyUSj/Kase5pxP+Rb50qcB+QHm6dSk9Lamm
         qfoSG2h4I9UzbY5H84RiC8B3spAYnro106EOogHjj7OGgd6TMkfTUMBkUOcU/NtUlPcI
         GGDD7krJzOHUbP6zKIf3iO3tvkt0+aPihDM4yKZLXShc1LfVyAoOwmEbVJeWkw7vPQSR
         nz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DmIMzRRO6Xkyv3KWHd7Bvl9UdWxEtku1V0qZzWAQTh8=;
        b=oQsw4MynwpGqUd/UjW173hCU//L/IOIwbZ7y3oS8LbAtezwrGjwmN969tLTg4cuxho
         Af5kbkW8X0GVkeVru0YoYb1C3mjERsc1HDuS1/czlqd4pZqaTWJNyIm+bpO3pN424Okb
         71a+6maPHxuUgP4DDsetN3V//HYLKjkDJYF64SBq3rLb6iXDvnpnAyp3rY7l6S31/COs
         KEFPfYXfc8UDkiPcAJ6qBKBIzcHIebIf0ZYU5xD557rZqFCjhJCvDvdoRvZmbsq6W0Vn
         ipdHSZ5T0ugXEhn4Pwdj3Z/CoFoTTl6RRceloYxW86fU33+VUV9MvFrHSnubyVQqgsX2
         oaUA==
X-Gm-Message-State: AGi0PuaPHi639LGI8sQCLoV5rZYXtqX+XFlS8+1oOevWxL0puit2+f5l
        ciW2BuvmiaxBQsJ+xKY5bfE2Yw==
X-Google-Smtp-Source: APiQypLFCli0iNWOOcvhvUdW3mduWO5yysvV5teAcmREzldnxFXgBbu2Khb7W5XTbCxQ92sorhyCug==
X-Received: by 2002:a37:b786:: with SMTP id h128mr32332017qkf.92.1587059695875;
        Thu, 16 Apr 2020 10:54:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 205sm14461331qkj.1.2020.04.16.10.54.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Apr 2020 10:54:55 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jP8j0-00061Y-Je; Thu, 16 Apr 2020 14:54:54 -0300
Date:   Thu, 16 Apr 2020 14:54:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [RFC PATCH 0/3] RDMA: Add dma-buf support
Message-ID: <20200416175454.GT5100@ziepe.ca>
References: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 16, 2020 at 10:09:30AM -0700, Jianxin Xiong wrote:
> This patch set adds dma-buf importer role to the RDMA driver and thus
> provides a non-proprietary approach for supporting RDMA to/from buffers
> allocated from device local memory (e.g. GPU VRAM). 

How exactly does this allow access to GPU VRAM?

dma_buf_attach() cannot return non-struct page memory in the sgt, and
I'm not sure the API has enough information to do use the p2pdma stuff
to even establish a p2p mapping.

We've already been over this in another thread.. There is a way to
improve things to get there, but I don't understand how this patch
series is claming to be able to work with VRAM - if it is that means
there is a bug in a GPU driver that should be squashed.

Other than that, this seems broadly reasonable to me as a way to
access a DMA buf pointing at system memory, though it would be nice to
have a rational for why we should do this rather than rely on mmap'd
versions of a dma buf.

Jason
