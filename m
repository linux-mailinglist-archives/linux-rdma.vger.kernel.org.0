Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44EF7257D3
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 20:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfEUSyp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 14:54:45 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39684 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbfEUSyp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 14:54:45 -0400
Received: by mail-qt1-f195.google.com with SMTP id y42so21798439qtk.6
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 11:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EY8XZr1fkZO07wgxJyVHnnlupUOqrKOPtZdwHP1/sUo=;
        b=PFU3pkv3NKB1ZIVwIKV5YVGysPEaz2O59DyuSAHnnjhN6ClZeLv/+ZFCda1PVfaDCF
         1OI0ZLcGjIVx9eSBOKrq+MX5jGtt/9naWLtXy98yhdR+3+Yc4KJ9I/v0azlzWD43psdX
         MEJn7U3QJPUn9yg/RTMcNZN2RsICWRrekN8boSlYL1/bTL3eQ2sUDfIAMrO/dbzdCbgQ
         mMyJw73riZwhvsp3Tok5xnRcdK+OtMcPHMWKHAJ5yCR7fmGvKwyaAaVZeGkGYcZxx0qy
         kDKpka7z07Th587y5sxUr9e4yv8Mge6sRMshqfJdbIMN6H6HB1xqBjttj6x5KmCW+cZq
         xy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EY8XZr1fkZO07wgxJyVHnnlupUOqrKOPtZdwHP1/sUo=;
        b=KJoKXrG7qLXG7I0wMtyupo0jhPaz6pfu2czl+pIqRvk+wmRUqQg/5BWIoKjbIAkUTV
         KyxqKfaJiaH1FvEmMv2Q/hHTKoqjqYLSRixSZxr6yaK9ygQXny0osw6aRDkJDWl9U1Dp
         l8Da3P7pi+QTgaiRznNk3XudDvGPAH3grYlGLyqPreA2Cg93nG1GGtliKIzcM3EGSmb9
         qbAPeAXgpBsfGaAUIb4dpzCFQNGtG6vXiQofTy2dBFQQKqIhe8vLl9EnYjxpCEKS01TY
         IbQZf/91yy6aXgwudLm+skcRTACjJK67+C2lmJrQ2N+Fko+KpohDJwNtWoz2C7KTRe54
         IuSA==
X-Gm-Message-State: APjAAAWKWFpUBmyC+S7LiaB3y2HJ1HPw7jdajgQ4LLDZwYG0qQCSQRgZ
        82cRKXb84u97BGSHsjNsklT9Lg==
X-Google-Smtp-Source: APXvYqwYSH3Cx4HD1Aa8yE0XQyXkf3xZWBcJLdh/nElVyy0Wg2kkcTlC8s7clt6dS2HGHzz2TBYQFg==
X-Received: by 2002:a0c:b155:: with SMTP id r21mr50252694qvc.73.1558464884234;
        Tue, 21 May 2019 11:54:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id a11sm9537113qtp.44.2019.05.21.11.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 11:54:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hT9uN-000757-Bh; Tue, 21 May 2019 15:54:43 -0300
Date:   Tue, 21 May 2019 15:54:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH rdma-next 00/15] Convert CQ allocations
Message-ID: <20190521185443.GA23445@ziepe.ca>
References: <20190520065433.8734-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520065433.8734-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 20, 2019 at 09:54:18AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> This is my next series of allocation conversion patches.
> 
> Thanks
> 
> Leon Romanovsky (15):
>   rds: Don't check return value from destroy CQ
>   RDMA/ipoib: Remove check of destroy CQ
>   RDMA/core: Make ib_destroy_cq() void
>   RDMA/nes: Remove useless NULL checks
>   RDMA/i40iw: Remove useless NULL checks
>   RDMA/nes: Remove second wait queue initialization call

These trivial ones all applied to for-rc, thanks

>   RDMA/efa: Remove check that prevents destroy of resources in error
>     flows
>   RDMA/nes: Avoid memory allocation during CQ destroy
>   RDMA: Clean destroy CQ in drivers do not return errors
>   RDMA/cxgb3: Use sizeof() notation instead of plain sizeof
>   RDMA/cxgb3: Don't expose DMA addresses
>   RDMA/cxgb3: Delete and properly mark unimplemented resize CQ function
>   RDMA/cxgb4: Use sizeof() notation
>   RDMA/cxgb4: Don't expose DMA addresses
>   RDMA: Convert CQ allocations to be under core responsibility

People should Review these ones please

Jason
