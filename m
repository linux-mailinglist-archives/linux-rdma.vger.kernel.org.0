Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81D91E182F
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 01:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgEYXVb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 19:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgEYXVb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 19:21:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA5BC061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 16:21:30 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u188so1517344wmu.1
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 16:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4IkvcZK53cLFIR1R0tvHhGF7OIPJ0Oyo42pp68Rb0o0=;
        b=CiaB+aqrL5DdmOc2bnxZnQgtrrrczsW8HUZnAmYRXGi86+AdKZi/weSGgzUKp6gG/d
         CRUHbuM6E+ff7DPeIv0FAHm+Vs/0eCHY7R31X8B8t4mh4YXB6S28UcshqW+4pOs08FgE
         hXRtuViPOcvNySgRrVLi/1oK8wb8g0LuPb2hYa7vYpbSwWzjzrktQ7X8UbjnYiBCtS2a
         ZKHqU1xSqVuqj+kwnfZmz4fq77QvtLt7sG3Sr38kdkbfZ6rD0l03pV5PHU/lyo/dbNYS
         BNDeqsuVlxJumt/3lljGqZpcqZe2htgfLavWt96ETAqKk2+KJLZcnzck44Icme5zeE0J
         Y8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4IkvcZK53cLFIR1R0tvHhGF7OIPJ0Oyo42pp68Rb0o0=;
        b=pRo1Y4kacfh+oX+1mQSPIapIH1SA86+qTeWK6h7EHUWnJYXZHn6GtZjHkvXu6W0XTM
         x34bl6f5XLl3Xnw4hX2qoCtx2Iq4Ux4KRI2FCD+HAMGuXeqYdfL97ovunwGLvmQBW2fb
         hZkxEwi6VwG8jl7lqp3ZAPkn2qZcXW86E4NoVESHGIMrTk5ttWblMY3dtejmUHBrA5kC
         /thBiVIjOpigx7XLO/z3komioCcGiNdDhLx2EsfxFGih2pHM2OL/j20MlVL9gVkl96UB
         TB1LM06GNhcvC1iyV/k9WdKWCo72uhJYD3Nq82BxGxXEhc1K1w+mENkrU+SdQPdU4BBV
         iG8Q==
X-Gm-Message-State: AOAM531+ZFgGRJRLV5Nwy0lBKeca3K4hVB85e0G88agYzSNFz55+dcG6
        ry6CYMMCzTzx7bwO4I5c1gs=
X-Google-Smtp-Source: ABdhPJzb5gP5d+TaUJOiEyrShGovJ8aD6StOBab4F1kIMiPbyGovL0SJqPR9MKFoKPbt4uJcyR7UqA==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr29073585wmh.31.1590448889213;
        Mon, 25 May 2020 16:21:29 -0700 (PDT)
Received: from kheib-workstation ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id t7sm13674776wrq.41.2020.05.25.16.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 16:21:28 -0700 (PDT)
Date:   Tue, 26 May 2020 02:21:25 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 04/14] RDMA/core: Allow to override device op
Message-ID: <20200525232125.GA177080@kheib-workstation>
References: <20200513095034.208385-1-leon@kernel.org>
 <20200513095034.208385-5-leon@kernel.org>
 <20200525142641.GA20978@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525142641.GA20978@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 25, 2020 at 11:26:41AM -0300, Jason Gunthorpe wrote:
> On Wed, May 13, 2020 at 12:50:24PM +0300, Leon Romanovsky wrote:
> > From: Maor Gottlieb <maorg@mellanox.com>
> > 
> > Current device ops implementation allows only two stages "set"/"not set"
> > and requires caller to check if function pointer exists before
> > calling it.
> > 
> > In order to simplify this repetitive task, let's give an option to
> > overwrite those pointers. This will allow us to set dummy functions
> > for the specific function pointers.
> > 
> > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/core/device.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > index d9f565a779df..9486e60b42cc 100644
> > --- a/drivers/infiniband/core/device.c
> > +++ b/drivers/infiniband/core/device.c
> > @@ -2542,11 +2542,10 @@ EXPORT_SYMBOL(ib_get_net_dev_by_params);
> >  void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
> >  {
> >  	struct ib_device_ops *dev_ops = &dev->ops;
> > -#define SET_DEVICE_OP(ptr, name)                                               \
> > -	do {                                                                   \
> > -		if (ops->name)                                                 \
> > -			if (!((ptr)->name))				       \
> > -				(ptr)->name = ops->name;                       \
> > +#define SET_DEVICE_OP(ptr, name)					\
> > +	do {								\
> > +		if (ops->name)						\
> > +			(ptr)->name = ops->name;			\
> >  	} while (0)
> 
> Did you carefully check every driver to be sure it is OK with this?
> 
> Maybe Kamal remembers why it was like this?
> 
> Jason

The idea was to set a specific op only once by the provider when there
is a valid function for the op, this was done to make sure that if
the op isn't supported by the provider then it will be set to NULL.

I think it will be more cleaner from the provider point of view to
see which ops are supported or not supported in the provider code. by
overriding the ops in the core this will make things more confusing.

Thanks,
Kamal
