Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1162288C70
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 17:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388727AbgJIPUS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 11:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387664AbgJIPUS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 11:20:18 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E8AC0613D2
        for <linux-rdma@vger.kernel.org>; Fri,  9 Oct 2020 08:20:17 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id a23so10863436qkg.13
        for <linux-rdma@vger.kernel.org>; Fri, 09 Oct 2020 08:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/h9bX8xOtJ6TbncXbEw+pgu5RSps9IS7zBsfxpmTevA=;
        b=cXDzYoZ1mGj9Ctmvfo5onw5R+rcg380UISbegAlO8ZUZYs07bmx1+kNKz+ghALbGyN
         HQyKbF5IIUuybVkbycxfDejJ6ovB16eeTtu4d+YsYKZyzn/2GFIxiWsN4Lekb/BBdWvA
         +9w+OdPDSLzXCxiqoxQA8Cm8wO+I7jZqJdv6FTeYhTGdYl9JNhMBKj4i6OlQJs7qVJxU
         jilwiUZzhCE2ByLMIuu37ebckFNSbTYauq4KsrXSLgbkF3Cbf/SmB2uSpguLS2JP/O3g
         +KTH26sfhUh6+mylCxHDhQkLg/qyFVlFSQvr3c4NT5JvbbuydyiEIEFefifMnJb1zqWG
         qSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/h9bX8xOtJ6TbncXbEw+pgu5RSps9IS7zBsfxpmTevA=;
        b=kZXXtFWDm+qamyAl74IqO9f7e3Fb3JB/e5G2V2csohz4GPBr/EfdkTFTNWQO8m76KH
         NQe06SV5njsHkwG1W99op8U211NBfSAr2UBbbPQfxIlGfQOFrUCiVQQ6A7X9+s2UjL3w
         Rcju5iu+IABW9G8+OSP8Ur4+6Y4n2982Hjp8QEE/oCBpoGP1sPBKJUsg8Nb7vT4iZio6
         cM8zWmteBzsWPU22G30NGXqEW6NN6z5qT8FkclZ8jORPi3sgkjQoIPYpbbOfIuPFuPzZ
         dem5TnEKNwp7ZxQHjcUVRGfIrk37476gkRIfFbVFkchLRXzrYP8OsW8LKf3HCyu6ZX1G
         1LlA==
X-Gm-Message-State: AOAM530KMyp6Td7ZUDUzJopktaDXKsH6CBsYV68bWpnQ/P0Wm/tWJk14
        /ugfgnISrs8kqD0RSvRBLDyDxxVeDE2CexDn
X-Google-Smtp-Source: ABdhPJz9V78zXLR42MLprZb3EiKjRKcVUkHfhRQ6afOw8BboajBFIMf0hlDSmBfZ0MA0N1gI++TnCg==
X-Received: by 2002:ae9:f104:: with SMTP id k4mr13903427qkg.10.1602256816936;
        Fri, 09 Oct 2020 08:20:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id j9sm6578497qtk.89.2020.10.09.08.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 08:20:16 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQuBr-0020dr-NE; Fri, 09 Oct 2020 12:20:15 -0300
Date:   Fri, 9 Oct 2020 12:20:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joe Perches <joe@perches.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 3/4] RDMA: manual changes for sysfs_emit and neatening
Message-ID: <20201009152015.GY5177@ziepe.ca>
References: <cover.1602122879.git.joe@perches.com>
 <f5c9e4c9d8dafca1b7b70bd597ee7f8f219c31c8.1602122880.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5c9e4c9d8dafca1b7b70bd597ee7f8f219c31c8.1602122880.git.joe@perches.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 07, 2020 at 07:36:26PM -0700, Joe Perches wrote:
> Make changes to use sysfs_emit in the RDMA code as cocci scripts can not
> be written to handle _all_ the possible variants of various sprintf family
> uses in sysfs show functions.
> 
> While there, make the code more legible and update its style to be more
> like the typical kernel styles.
> 
> Miscellanea:
> 
> o Use intermediate pointers for dereferences
> o Add and use string lookup functions
> o return early when any intermediate call fails so normal return is
>   at the bottom of the function
> o mlx4/mcg.c:sysfs_show_group: use scnprintf to format intermediate strings
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/infiniband/core/sysfs.c              | 60 +++++++-------
>  drivers/infiniband/hw/cxgb4/provider.c       |  5 +-
>  drivers/infiniband/hw/hfi1/sysfs.c           | 38 ++++-----
>  drivers/infiniband/hw/mlx4/main.c            |  5 +-
>  drivers/infiniband/hw/mlx4/mcg.c             | 82 +++++++++++---------
>  drivers/infiniband/hw/mlx4/sysfs.c           | 47 ++++++-----
>  drivers/infiniband/hw/mlx5/main.c            |  4 +-
>  drivers/infiniband/hw/mthca/mthca_provider.c | 29 ++++---
>  drivers/infiniband/hw/qib/qib_sysfs.c        | 45 +++++------
>  drivers/infiniband/hw/usnic/usnic_ib_sysfs.c | 66 +++++++---------
>  drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 21 +++--
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 13 ++--
>  drivers/infiniband/ulp/srp/ib_srp.c          |  4 +
>  13 files changed, 206 insertions(+), 213 deletions(-)

Some of thee are a bit exciting, so usnic, hfi1, qib and mlx4 folks
should check their bits over the next two weeks

Thanks,
Jason
