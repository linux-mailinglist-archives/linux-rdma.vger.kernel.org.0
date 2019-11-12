Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C383CF9AAB
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2019 21:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfKLU3b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Nov 2019 15:29:31 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36617 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfKLU3b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Nov 2019 15:29:31 -0500
Received: by mail-qk1-f195.google.com with SMTP id d13so15715567qko.3
        for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2019 12:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9/CN/xP6vJqOjvUwGr7WARnQnaIU03x9y+ycG42MQ4c=;
        b=mxqrCZSuJup/O7Tk9nbjCrAXv/I6y2Zo1A01a5hwNRvS5TKq103j4QuuhMx1TgbiKk
         TcToD98p3B/LkXcivRs143K922H29/EXiF4+WtML/koRgsoGaP9oNQstLSZZm1bD9exs
         1cHorb8PN0z2CV7n+aeUGymLfLZn+MuvJntXBJRGPUHsnS2WZXJ4z9mnbwdEDCFmPPUr
         zdAgEfZevh5Zr+vJwZHpWYsKmmW9YyHXXFRC0YlNVqSl54PMnxfnt5NDZO9d3P/oFw6v
         yMrA8ToPd5oCC0kTplCIvx8XTzt2MoQrQKuYRdLMH60olFuU80IXYkNA5X1z1QNM25zB
         l/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9/CN/xP6vJqOjvUwGr7WARnQnaIU03x9y+ycG42MQ4c=;
        b=jO2VvffRYaJ6cb02eSSW9S+D4JhilepYRwPdBm5DtVAWJ1+02KWRcOJ3ghm6NTkaKY
         zB5cmiRJGhiOTP4lkPQyN207vXyEFBZHkHH/ahlnvodDRgB3XHkQzo99dt6JNkBIW0II
         2x89iFXAoTL6BMUPrM78TBWTTQf4JvQk0qZNAXhgXcNrDeU3b+2wNeh4qGVklwruxUWi
         k+lHGCgcYlCtW/LeA+ECs22qql42CjR1JpH1cXhOpG2WcAGLIVvQScEHuy/jBTV6LlSR
         atmbAg3LSiohkpozOxN58SABs/EerwHy9fkF3fmV93Y6NQ4BvDwAzpRZE9JWVyxUlFHB
         Z8mQ==
X-Gm-Message-State: APjAAAXQVT9hAtN2xP6UFA+OdyRpqFurHvbQzCeU61RxxltUHimvSYN4
        Vq3ACQglzGoBG492c46TCFgP1Q==
X-Google-Smtp-Source: APXvYqybg5mSANeuBHPAwtpiQwrkuaJ3qSnOCohvuRuZIB0NupFTAxDLE6ppr/vcONzFQpVTRL7HrA==
X-Received: by 2002:a37:424a:: with SMTP id p71mr7621409qka.194.1573590568857;
        Tue, 12 Nov 2019 12:29:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id o3sm18630496qtf.84.2019.11.12.12.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 12:29:28 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iUcn1-0003pu-NI; Tue, 12 Nov 2019 16:29:27 -0400
Date:   Tue, 12 Nov 2019 16:29:27 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] IB/umem: use get_user_pages_fast() to pin DMA pages
Message-ID: <20191112202927.GC5584@ziepe.ca>
References: <20191109020434.389855-1-jhubbard@nvidia.com>
 <20191109020434.389855-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191109020434.389855-2-jhubbard@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 08, 2019 at 06:04:34PM -0800, John Hubbard wrote:
> And get rid of the mmap_sem calls, as part of that. Note
> that get_user_pages_fast() will, if necessary, fall back to
> __gup_longterm_unlocked(), which takes the mmap_sem as needed.
> 
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/infiniband/core/umem.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

This can go through Andrew's tree if he takes this larger series,
otherwise I'll grab it

Thanks,
Jason
