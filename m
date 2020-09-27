Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A36F27A124
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Sep 2020 15:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgI0NEQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Sep 2020 09:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0NEQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 27 Sep 2020 09:04:16 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AB7C0613CE
        for <linux-rdma@vger.kernel.org>; Sun, 27 Sep 2020 06:04:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so3862194wmj.5
        for <linux-rdma@vger.kernel.org>; Sun, 27 Sep 2020 06:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jn2cBA9epYTiLkjqdj5b4EuJh5MIj1Q0kbsDGSRsL/4=;
        b=XnYqkiLaFeSxgZMonkhhu5gWQUVxAXflEIXMle6FvBofdcJ0//e7MGwK4mx/+c17Rq
         P0Ya/WkqEZARW2vW+m14NBXFDN3KA9R7I9YJs1rXz8zqN3Q1WHs8PMiugfmoO5chbzou
         jPmQTV9qbUO7d1wEZQx8gQ+ymbp9wJZOhUWABp1hw+b4nIMr8yHqRBJ+AwV7827G2Cn0
         5UXw19qmUZkwSJFcAKg9wajvIBNTMK1SZbexxGQUBmaPiEYuPiels8Kw9nUhf/2kEwxF
         aevzMTqKuUilBgRUDsKm75CYbjYbNdmecZWSKmGaf0vhIjAnakVYne63l/yrocRXHdsH
         iqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jn2cBA9epYTiLkjqdj5b4EuJh5MIj1Q0kbsDGSRsL/4=;
        b=fdoP/S/BWcQGSxePKkpFkjS36HBXYRXLPbGEHzMmCYnqYx2Txs0rEmMlyBy3L15HbS
         J0oo6NfWS4oh55X8RvdL10e1LG2uc3BpyJi99MD3ZINdLypbYttxubft0W9aAVkGa2ty
         K6onTQpQD+W0zn4DZXxZndBtAGTXDQQU7sz2trz3TTmfZDwsTwC4sNiX5TmDuA1BMclg
         VdFcsEb6gltKONl9yNknJDwUuO9I4zmlWLZeEUbYCZD85oZ3B6EFdkO88U9PuIwNt9Oa
         /d3S3LbGxI5oSoM8ed8mnXl5MbNI6NbYwYIMYDpRDW4nn066v8ww6pytbpGd4IJO/ASS
         yd5A==
X-Gm-Message-State: AOAM530xDnlMlormJXB6+8mYY8ZORkav2uRgjeaL57m9dslUrG9UIQQ7
        J8jsEATdB4RJEGfwJirSqFU1y5D/Fw8=
X-Google-Smtp-Source: ABdhPJyURGtHjK7BT8V7DRNyTSMyQeAeQloWMBIFrOn4WOZv9ZY36G99R9ri950NS61DXVIw4U4Qow==
X-Received: by 2002:a1c:9a10:: with SMTP id c16mr6518728wme.96.1601211853771;
        Sun, 27 Sep 2020 06:04:13 -0700 (PDT)
Received: from kheib-workstation ([2a00:a040:19b:e02f:5cc2:9fa6:fc6d:771d])
        by smtp.gmail.com with ESMTPSA id m13sm9566786wrr.74.2020.09.27.06.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 06:04:13 -0700 (PDT)
Date:   Sun, 27 Sep 2020 16:04:10 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH for-rc] RDMA/mlx4: Fix return value when QP type isn't
 supported
Message-ID: <20200927130410.GA22150@kheib-workstation>
References: <20200922134429.130255-1-kamalheib1@gmail.com>
 <20200922233003.GA809877@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922233003.GA809877@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 22, 2020 at 08:30:03PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 22, 2020 at 04:44:29PM +0300, Kamal Heib wrote:
> > The proper return code is "-EOPNOTSUPP" when trying to modify a raw
> > packet QP over an IB port.
> > 
> > Fixes: 3987a2d3193c ("IB/mlx4: Add raw packet QP support")
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > ---
> >  drivers/infiniband/hw/mlx4/qp.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Is it? Why? EOPNOTSUPP should be used by the uverbs layer to indicate
> that the operation is not implemented in the driver
> 
> Calling modify_qp against a RAW_QP when it is not supported by spec is
> EINVAL?
> 
> Jason

Please drop this patch...

The idea behind it was to avoid the pyverbs test_qp.py failure when trying
to create a RAW QP over an mlx4 IB port, this was fixed using the
following change in the test_qp.py:

https://github.com/linux-rdma/rdma-core/pull/833

Thanks,
Kamal
