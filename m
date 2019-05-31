Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12B1830D5F
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2019 13:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfEaLdf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 May 2019 07:33:35 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36370 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaLdf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 May 2019 07:33:35 -0400
Received: by mail-qk1-f193.google.com with SMTP id g18so6024379qkl.3
        for <linux-rdma@vger.kernel.org>; Fri, 31 May 2019 04:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=md6oLgyDrJqQv7Bfgdi3DmmHEdkpqq0rTU6E5OKcNwA=;
        b=YdJqlrd/CP5sn/ffjVLx3lqMyIJhvd0PYG/XucgdP3SVAX4NT4fUc7f9zeo+ZqaG+C
         ikcaHfNzKosBJKwn7i2cPCbiadcSNvoxXPO5dL3vnwdppwzZyWiyPAIAX9nUGzgV1s6o
         tbDCXmu4v1sfS7mU++quYV3ziWPuzw53TPw6p8H0R07lcf+eiSVvEp2DZLt4c6+rrwMX
         7CGv/NyxLCKBqqa8vlbkAqx7gRWmI7joWiBSVrO7NLOFzy1N3GZpbEx+TcvJLmquKTGT
         9cCVXpwNbMwix/0QSMwEqJWVYGZgbi/+TEfM/ZAW094AVJPNr2CaQEl/UviP4QUXn7xT
         OJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=md6oLgyDrJqQv7Bfgdi3DmmHEdkpqq0rTU6E5OKcNwA=;
        b=F60l++I2udMzim32ByO4iNxgTCZ7T9pC5kaQSbmX/bUxaEwq63fkqdKhQYB8M3aBDo
         BKdDQlKOexKdNWixU/G7+kTpdGrqd1BCV3uClvfen4GsgNGKoW9tlgXQwbne8rCvzArf
         LAXwUIByUD0iaWUqQE8gFi8Sjb5SNHYuqNTlKT2lCkf+U85NVky00UfJjGr4mxGLa7Ad
         wKOf2L7bIDCit0x17Xv0A8ff8kBzmzbZceZHi0rL47UMU12MCIMMpF+pTocjIe6yBqfM
         FdA+t/R2IcDx9gTBGB+ZiqjtwtpRZxxkxGlO6Ji9DXdMIPNVYXqFHq8HJ3vjFJBM7ZBG
         Ookg==
X-Gm-Message-State: APjAAAVzDUWxw/1K6VGQmrmWuVex0jZOngskvwJw5/PKjMPFWIWsagKi
        uxacMjBBFGm9peWooVdd6fQlNw==
X-Google-Smtp-Source: APXvYqw9YsEvWmVr6WuBWNz7E/Pcewi694FcC2uODBKBfRT4Fu16vP4afTdHlKLRRZYfjQFVQxjFqA==
X-Received: by 2002:a37:7783:: with SMTP id s125mr7727353qkc.267.1559302414587;
        Fri, 31 May 2019 04:33:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id p1sm2627998qtq.84.2019.05.31.04.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 04:33:33 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hWfmv-0002CK-ES; Fri, 31 May 2019 08:33:33 -0300
Date:   Fri, 31 May 2019 08:33:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Lijun Ou <oulijun@huawei.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH V2 for-next] RDMA/hns: Bugfix for posting multiple srq
 work request
Message-ID: <20190531113333.GA8258@ziepe.ca>
References: <1559231753-81837-1-git-send-email-oulijun@huawei.com>
 <20190530184919.GA5454@ziepe.ca>
 <20190530193117.GD5768@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530193117.GD5768@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 30, 2019 at 10:31:17PM +0300, Leon Romanovsky wrote:
> On Thu, May 30, 2019 at 03:49:19PM -0300, Jason Gunthorpe wrote:
> > On Thu, May 30, 2019 at 11:55:53PM +0800, Lijun Ou wrote:
> > > When the user submits more than 32 work request to a srq queue
> > > at a time, it needs to find the corresponding number of entries
> > > in the bitmap in the idx queue. However, the original lookup
> > > function named ffs only processes 32 bits of the array element,
> > > When the number of srq wqe issued exceeds 32, the ffs will only
> > > process the lower 32 bits of the elements, it will not be able
> > > to get the correct wqe index for srq wqe.
> > >
> > > Signed-off-by: Xi Wang <wangxi11@huawei.com>
> > > Signed-off-by: Lijun Ou <oulijun@huawei.com>
> > > V1->V2:
> > > 1. Use bitmap function instead of __ffs64()
> > >  drivers/infiniband/hw/hns/hns_roce_device.h |  2 +-
> > >  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 29 +++++++++++++----------------
> > >  drivers/infiniband/hw/hns/hns_roce_srq.c    | 15 +++------------
> > >  3 files changed, 17 insertions(+), 29 deletions(-)
> >
> > Applied to for-next, thanks
> 
> Jason,
> 
> I don't want to be a party buster, but it is hard to believe that
> this part of their patch is correct.
> 
> +       if (unlikely(bitmap_full(idx_que->bitmap, size)))
> +               bitmap_zero(idx_que->bitmap, size);
> 
> They simply "dropping" all indexes.

It is what the logic did before.. No idea what this algorithm is
supposed to be

Jason
