Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98476196623
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2020 13:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgC1MkF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Mar 2020 08:40:05 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:44306 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgC1MkF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 28 Mar 2020 08:40:05 -0400
Received: by mail-qv1-f68.google.com with SMTP id ef12so4323746qvb.11
        for <linux-rdma@vger.kernel.org>; Sat, 28 Mar 2020 05:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gyT8UFpGVb1UsWUbztnzGfKA/Wy/MFiEoclJbgrK4qI=;
        b=VVcMQGZgyOa+GvJ3OeqZlGQUg3Q5tO04sVFu6Z1wm1UW0Z3KTFMnpTLTI5Yy5fxUGX
         Mo6KvBsJ4j7n3e+qxKpB+lAQ2JJnVF1F1Aci4W+VEjVs5DUbLlyp6XUjVtTR2auSdjWb
         JcYKXfoSgAu0QAtPAVY7nV0yx5lM7ji5al5Bhj5E8wdXj42h4wz1G4kK4Jyn4bOCmLGq
         7w8KAqvI1Qnm1ATxOuH8uryM5EC1eU3ucnqpotpMXHf8YRgRwu/Re5Xkne8if+bT7ETQ
         kH6qYI2FNlXPT+IsKnnt8x9ZnTl2szm4c+v4mv8ad5L8GJRqCw+hyHhDqbm/PQN/1DH3
         rmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gyT8UFpGVb1UsWUbztnzGfKA/Wy/MFiEoclJbgrK4qI=;
        b=LDBc/1XGUGLSW7m1oMwe208XEjlGCqSN9L5qGgOug6fKG9EMQ0rtYRL52BPJ6zleju
         bvIn+ojiEC0OzT30vYhoNcS7c+4MSYhoh5pH3rWKZF4XZoyfWVaPpR6Ox2dtHElDikdK
         fMaPj9qbbEONLhgpZ1u3UXEu/JB/uKHfA8FKpsUcSiRaFpOXaahc6IeEGhUff3DGySS5
         P1GsXg14zBlwFKtNn4DIW1kyLtOQUojqXTu25C4BVY1TzkVnq3skniGWQZyyhdVBoO0I
         y0LY8zXhw8svZ0hCHRI97rl6hlxgK0IHxja+ksIKaq8L37SZ9Nd7xaXff6WGt811Vkjb
         cfGQ==
X-Gm-Message-State: ANhLgQ0DreA0Ovd4NvX1MZObf0PrbCWdfyL2t0V1I8dO9WtfAPlFBQZd
        QtQ8kaByDeZc740wRgupC3nV6Q==
X-Google-Smtp-Source: ADFU+vtVpk7Wds9Sr8Z/70SEBNVexp3x5QFsFGP/wcY3iBT0ao9r2FOjzqxZliOmgJfRU1Lqt734Sw==
X-Received: by 2002:a05:6214:70e:: with SMTP id b14mr3634409qvz.246.1585399204187;
        Sat, 28 Mar 2020 05:40:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o81sm5958528qke.24.2020.03.28.05.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Mar 2020 05:40:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jIAks-0006TL-S7; Sat, 28 Mar 2020 09:40:02 -0300
Date:   Sat, 28 Mar 2020 09:40:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     liweihang <liweihang@huawei.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        oulijun <oulijun@huawei.com>,
        "Huwei (Xavier)" <huwei87@hisilicon.com>,
        Doug Ledford <dledford@redhat.com>,
        "wangxi (M)" <wangxi11@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] RDMA/hns: Fix uninitialized variable bug
Message-ID: <20200328124002.GB20941@ziepe.ca>
References: <20200327193142.GA32547@embeddedor>
 <B82435381E3B2943AA4D2826ADEF0B3A022B739C@DGGEML502-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B82435381E3B2943AA4D2826ADEF0B3A022B739C@DGGEML502-MBS.china.huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 28, 2020 at 02:15:14AM +0000, liweihang wrote:
> On 2020/3/28 3:28, Gustavo A. R. Silva wrote:
> > There is a potential execution path in which variable *ret* is returned
> > without being properly initialized, previously.
> > 
> > Fix this by initializing variable *ret* to -ENODEV.
> > 
> > Addresses-Coverity-ID: 1491917 ("Uninitialized scalar variable")
> > Fixes: 2f49de21f3e9 ("RDMA/hns: Optimize mhop get flow for multi-hop addressing")
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >  drivers/infiniband/hw/hns/hns_roce_hem.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
> > index c96378718f88..3fd8100c2b56 100644
> > +++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
> > @@ -603,7 +603,7 @@ static int set_mhop_hem(struct hns_roce_dev *hr_dev,
> >  {
> >  	struct ib_device *ibdev = &hr_dev->ib_dev;
> >  	int step_idx;
> > -	int ret;
> > +	int ret = -ENODEV;
> >  
> >  	if (index->inited & HEM_INDEX_L0) {
> >  		ret = hr_dev->hw->set_hem(hr_dev, table, obj, 0);
> > 
> 
> Hi Gustavo,
> 
> Thanks for your modification. But I check the code and I think "ret"
> should be initialized to 0, which means no need to set hem and it is
> not an error.

Weihang, thank you for checking, I would have taken it without your remarks :)

Jason
