Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6B81A8A7A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2020 21:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504602AbgDNTCP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Apr 2020 15:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504599AbgDNTCN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Apr 2020 15:02:13 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81192C061A0E
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 12:02:13 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w29so10765248qtv.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 12:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YzNurIVAkA4jvr9JwIfo85IEn9Zw+h56w3Sd2PzkLjs=;
        b=kq8L7OtZXEWYxYz6h6w0mi8JQeSIMbo6QIlTDZ9JAHqkfX8Jty7Cn32BRwp1ePR0fB
         2foBW+NRr7W/TzadyKNOOEHortpa1y8CZ7xtgKWuDjR3n3lhVUsM/4XXq2SJyg0FsLou
         2ySz+HwaJ8tEfn8TTFiMU9i6LfD0u/u+ZcMA+xxmZZln0H3ZkgRUcllktsL528ZzXIqk
         wGZl6RGjE+lq7jWGgfsdN2krB3Lnj0OXTropOnQyjWKEbDbPWkc6o7wuJTaWAV++ToGn
         kJ1mHuqu7brf6zm8oHJcDtOprMUFecAvDo/zU67C/rUZN9W3a2EFUSmw1U7Om4VMbQUI
         2Yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YzNurIVAkA4jvr9JwIfo85IEn9Zw+h56w3Sd2PzkLjs=;
        b=D0exxmu32x6zzcdKwP12uBcq3BQHrFa8sMkRSvfRlLTDfUd8k9ITgKSR2sx6kHiK91
         5fouF5T0x5ZWRv10hBgiSImuA7qLI57J3bFXUA+j847/2Xpk1Ml2UHLvIWO787379Yio
         oohayzlAT5X3cXq4j4sPbHmp3cl8ir412/m9JJCDe5ho4SPO8EofmLyJozswB2EJmclo
         NAQNobSgHmzdz2WGyi002DXhI1kARlLPo7iH7zpf8roG/g+AR59Go7zwU7QoTaw2Rzxi
         RoZwukyPTyy4udIPZHs1CzntnipyeqrMVPE7ggwr2zMqq2xuwSzbmSWQ+bYSEXPZ0dQX
         DBdQ==
X-Gm-Message-State: AGi0PuZn7Pz65cpnzZqHEu6MHtWMrrz2EWFrB6f+OUHOAqOCJVwwtLv8
        /9OY9uX33UuIcKMsz4eoJBx8Zw==
X-Google-Smtp-Source: APiQypLU4njxISewbeTdGwEAqrIizC/SwzWOGIcnAkggwhqcfrcb3NI5iAhyrMMYVqLYy9DENvOK6w==
X-Received: by 2002:aed:2442:: with SMTP id s2mr17254378qtc.153.1586890932619;
        Tue, 14 Apr 2020 12:02:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n67sm10957048qke.88.2020.04.14.12.02.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 12:02:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOQp1-0003Ad-Jy; Tue, 14 Apr 2020 16:02:11 -0300
Date:   Tue, 14 Apr 2020 16:02:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Leon Romanovsky <leon@kernel.org>,
        Danit Goldberg <danitg@mellanox.com>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/cm: Fix an error check in cm_alloc_id_priv()
Message-ID: <20200414190211.GA12156@ziepe.ca>
References: <20200406145109.GQ20941@ziepe.ca>
 <20200407093714.GA80285@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407093714.GA80285@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 07, 2020 at 12:37:14PM +0300, Dan Carpenter wrote:
> The xa_alloc_cyclic_irq() function returns either 0 or 1 on success and
> negatives on error.  This code treats 1 as an error and returns
> ERR_PTR(1) which will cause an Oops in the caller.
> 
> Fixes: ae78ff3a0f0c ("RDMA/cm: Convert local_id_table to XArray")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> v2: Use the correct Fixes tag and add Matthew to the CC list.
> 
>  drivers/infiniband/core/cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
