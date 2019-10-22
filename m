Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34B0FE0B45
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 20:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbfJVSQC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 14:16:02 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43281 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730305AbfJVSQC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 14:16:02 -0400
Received: by mail-qt1-f193.google.com with SMTP id t20so28161615qtr.10
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2019 11:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dOTCnpOBKLPF2V4OlpYtclGlstLVYnfZi+r1UyVuM3E=;
        b=nqNgeCL2ZwPtWX8a++1uuIGzk1ny4ngtfTgZ+7hbFP/fFbRvxjYrThvWTnwGg3xMlV
         SSfiQ2vLxy7nMkcamEZUzqIL3v4dfp14p1lZLQZMgoG6BIzphT9ykmgfQihZ6wkQvtAk
         7pN8m+wnhuXjGX0UUrBqYH3Wy9Ru8r9s8POf3Z25RZS+/IB+YnoWXwpvilP62gLhZtDs
         +/wgX66ktPvGiF0FP0DgbKcOoSPY+munPpPGDxoZRMNMl0XauXKnhjU7ScUjQgpRiRX8
         Z64/fo1rlBAlaaN6R9MODK1PuQgwRPz2OKvfjVhR/+44m3seolnYlMUMnVvt9CogyRus
         ztUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dOTCnpOBKLPF2V4OlpYtclGlstLVYnfZi+r1UyVuM3E=;
        b=DAjcHPPfjLVDRczHIlxmgfEOcf+cZHLpV5/BUJLtA2t5MnEXbSeNyn2ROAQaBb84p+
         3K/EI2ItF9/cC1YOGIw3iXdj24XONjQrutcGujtn1loOX9wOSoEaVVS2COwPgXW5AUO6
         EfCvk/JaIcs5tdlSzwg1JfC+D8OTZdKcZ5wx6vt4J56xHetj1Cef9BeNerZHuUrFocUk
         TLjisYzKkC2Ce3ECRZN0HGfd7klaaK2FEighRcCflpaVZWrAJ34pVMeDRFKVfNf280Sc
         Rn1fkP3vxf7iK5kiYGdY8wQLTz8GwGcJXpWpY2Rk4471FELmU4NBFOn/q4CXuUplt88E
         mBpA==
X-Gm-Message-State: APjAAAWH7NL0HdQLaLYGZzp4y4p5rcvaLSFY7vv1T0ee7Zy0R1Qi7/oD
        mC/Xljoe4QbzCPQZ9l/SSijR7Q==
X-Google-Smtp-Source: APXvYqxPQJXeYQyQb0fvGOlySkIsmhvPOWVD6JaQIoUYsUaO2R+NZ/RFVSWWPWlllQGUvn5VXq4xRQ==
X-Received: by 2002:ac8:7447:: with SMTP id h7mr4766890qtr.11.1571768160011;
        Tue, 22 Oct 2019 11:16:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id o195sm1410409qke.35.2019.10.22.11.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 11:15:59 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMyhK-0004io-V4; Tue, 22 Oct 2019 15:15:58 -0300
Date:   Tue, 22 Oct 2019 15:15:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Matan Barak <matanb@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] uverbs: prevent potential underflow
Message-ID: <20191022181558.GA18115@ziepe.ca>
References: <20191008194425.GA28067@ziepe.ca>
 <20191011133419.GA22905@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011133419.GA22905@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 11, 2019 at 04:34:19PM +0300, Dan Carpenter wrote:
> The issue is in drivers/infiniband/core/uverbs_std_types_cq.c in the
> UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE) function.  We check that:
> 
>         if (attr.comp_vector >= attrs->ufile->device->num_comp_vectors) {
> 
> But we don't check that "attr.comp_vector" whether negative.  It
> could potentially lead to an array underflow.  My concern would be where
> cq->vector is used in the create_cq() function from the cxgb4 driver.
> 
> And really "attr.comp_vector" is appears as a u32 to user space so that's
> the right type to use.
> 
> Fixes: 9ee79fce3642 ("IB/core: Add completion queue (cq) object actions")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: Change both types to u32
> 
>  drivers/infiniband/core/uverbs.h | 2 +-
>  include/rdma/ib_verbs.h          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
