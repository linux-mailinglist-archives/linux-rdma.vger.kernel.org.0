Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6EC515CA8E
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 19:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgBMSiw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Feb 2020 13:38:52 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36071 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMSiw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Feb 2020 13:38:52 -0500
Received: by mail-qk1-f196.google.com with SMTP id w25so6693865qki.3
        for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2020 10:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a17QWj1zniloH0REZJQUIegjN8HppvvQ+Ig6IzvF8do=;
        b=HS53ME2sfLQ5VWlmQANMJdrBmx0YnJNiUMA7+sYbLWdM67TxCv9cA5TwNEhoOEzy2N
         Xdhvd2tHSOTJgXuzlGMrSDjTEv5NMD9FID/8cLUU5H51lti55aEctLL4ZS4g4jLzuYVD
         G/pNRSioNCUxQyijxi3JTvu1W55/ZMVUChV0vU0ukefKNwYJU67rE7bN7zDYx1zdIpYk
         3wH+UITUQcYaCznD5H9e/aeqyRwH5ft2N3B353eOVZh6m2e9S+bcnlcthB5Xxfl6SkyN
         BIRJ0OLhITI6SevmBiyjqq4WZ/Ut7Ptph47R/7zGXnJ4NAlBZ+qS6d2mhRR84pE/SOO9
         c+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a17QWj1zniloH0REZJQUIegjN8HppvvQ+Ig6IzvF8do=;
        b=T1wkh0gtG5hnr9C0yjPEaQxnF+7W3jVd6vO1X8AuRvZBZs6ERQCm/bzrzuUT+ArK9f
         qoXPZZ9fQUM4qRa/A87mmVGpmbF00kxQYhjeu4Ahm5Xj9gflSFq243xWuPE1QteKTEiQ
         LiXhgiy45WIg9F2h/Cia9WN1fwQtMDcGlTUACwiblEfr1QcMdkOWpZxLGEdHPYi2oO6F
         udh85JGHQ9h87pqo4fD+TejfsgvQ9XIInqMUEToOr8cPhB2mKPjIVaYHktAyWf+yqODr
         WmPgZJlSl41iek8R0TKCooJ+rzqJDTzdcGxAVCqPqZ8sQ8Hi9Wfw150Tzgq3ta75LQxG
         BV+g==
X-Gm-Message-State: APjAAAVhrimb2OjPAhvb98k+HJhzy+KS0y5ypWTo+y25yKsInAZnxv0Y
        jmDz/MU0vuZ2hoa8z7CXiiQsaKD1eL85eA==
X-Google-Smtp-Source: APXvYqxICfpcsXGiYMyltui3Hcrstw2xAu4flS/uLpnLoszxAn48DbC69Blmv74LyCm9/sceySctrg==
X-Received: by 2002:a05:620a:b89:: with SMTP id k9mr16825057qkh.185.1581619131625;
        Thu, 13 Feb 2020 10:38:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id k15sm1665277qkk.103.2020.02.13.10.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 10:38:51 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2JNy-00029Y-KR; Thu, 13 Feb 2020 14:38:50 -0400
Date:   Thu, 13 Feb 2020 14:38:50 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/core: Replace zero-length array with flexible-array
 member
Message-ID: <20200213183850.GM31668@ziepe.ca>
References: <20200213183715.GA19636@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213183715.GA19636@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 13, 2020 at 12:37:15PM -0600, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/infiniband/core/cache.c     | 2 +-
>  drivers/infiniband/core/cm.c        | 4 ++--
>  drivers/infiniband/core/multicast.c | 2 +-
>  drivers/infiniband/core/sa_query.c  | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)

Any reason to skip these two?

drivers/infiniband/core/mad_priv.h:     u8 mad[0];
drivers/infiniband/core/mad_priv.h:     u8 data[0];

And may as well touch these in the subsystem headers too:

include/rdma/ib_fmr_pool.h:     u64                 page_list[0];
include/rdma/ib_verbs.h:        u8      real_sz[0];
include/rdma/ib_verbs.h:        u8      real_sz[0];
include/rdma/ib_verbs.h:        u8      real_sz[0];
include/rdma/ib_verbs.h:        u8      real_sz[0];
include/rdma/ib_verbs.h:        u8      real_sz[0];
include/rdma/ib_verbs.h:        u8      real_sz[0];
include/rdma/ib_verbs.h:        u8      real_sz[0];
include/rdma/ib_verbs.h:        u8      real_sz[0];
include/rdma/ib_verbs.h:        u8      real_sz[0];
include/rdma/opa_vnic.h:        char *dev_priv[0];
include/rdma/rdmavt_mr.h:       struct rvt_segarray *map[0];    /* the segments */
include/rdma/rdmavt_qp.h:       struct rvt_sge sg_list[0];

?

Jason
