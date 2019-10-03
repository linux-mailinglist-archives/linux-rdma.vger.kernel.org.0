Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23916C9E98
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 14:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfJCMdo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 08:33:44 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33432 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbfJCMdo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Oct 2019 08:33:44 -0400
Received: by mail-qt1-f196.google.com with SMTP id r5so3346249qtd.0
        for <linux-rdma@vger.kernel.org>; Thu, 03 Oct 2019 05:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AS/JS6py9PyuBTYp4eIvUqUx9NXrvOQhjnvc14Nd4gQ=;
        b=BsUli7zOZiXg2t8MzieXcDdoo9k0U6gbLPm1hxN7ckZkmxyXP2B5XIWGrCnBi+V9Up
         3VLVVhApqCr0g7KKVp+ApvGBx436Z7W3o8nqb1yxbLJK5ajPXQCsdLHr8rqj9vv+sYWO
         2eapmUT+I5VkQ+/qyXXOLs//DMKauE3/r51Kl9xfx2ViNoZCaavnK4rc634O51oZRjN2
         D9kRNc8BAhO0AqxwqrMVbHSJVeQLGtyFP5RXUAleLKub/i+kgwMb2Pk3XD5RVlpX8Akm
         NJAG2Qzs6TCrZVFkLLP0zG8UXjcFwSYRjC6Ptll/TnELosIjJAAU2XGL9D1oD2x8kRkq
         TEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AS/JS6py9PyuBTYp4eIvUqUx9NXrvOQhjnvc14Nd4gQ=;
        b=IgyWziYueN4V5PZcu6Z/rW3ghiXBuXHanvJa1AC3Hm8gQGycVwYnPOUHFXDU8pk8v7
         lIvsRS2iONSvlsNscG83KewRT46ktJ+oPSInRK7y3Rp/ihp+SROZe5RRECrA1cq6rR8u
         8qAs2j2hPtHEl8Lp7VoXMECo0bDaqN0O/v1/DfWx0oy/HRz1Mqhblca3lUswkUKM5njT
         GW7cSXRiAghujtbis35q7cXWQ7XeWY02L6dEX5Z3cs7Z6Bt9VxBDUA40tEB3T092s5Eh
         T2eROA8EotnCvTrLhBcEz0L1nA8yPQ9/1wtKzfPAwAXIRzwO0P5QmnsRauMFHFjlaV+I
         ZNyg==
X-Gm-Message-State: APjAAAVyicCVRheLeTPjfGXxqKMabEENk2WPnOUdj6rCwINtmbSh8DgU
        n5lOBQboef5ki07/ud6jM5Sknz1T7nA=
X-Google-Smtp-Source: APXvYqwnSfoUIOaQwgYznKf4fKXMPxnDRjoxhwHdahfDU4+ZcmOzEfdnYsT+ETUxO16bCmjn8kQtrQ==
X-Received: by 2002:ac8:2e58:: with SMTP id s24mr9880523qta.52.1570106023447;
        Thu, 03 Oct 2019 05:33:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id t32sm1709163qtb.64.2019.10.03.05.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Oct 2019 05:33:42 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iG0Ig-0006w6-7G; Thu, 03 Oct 2019 09:33:42 -0300
Date:   Thu, 3 Oct 2019 09:33:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Artemy Kovalyov <artemyko@mellanox.com>
Subject: Re: [PATCH 6/6] RDMA/mlx5: Add missing synchronize_srcu() for MW
 cases
Message-ID: <20191003123342.GA26135@ziepe.ca>
References: <20191001153821.23621-1-jgg@ziepe.ca>
 <20191001153821.23621-7-jgg@ziepe.ca>
 <20191003085449.GN5855@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003085449.GN5855@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 03, 2019 at 11:54:49AM +0300, Leon Romanovsky wrote:

> > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> > index 3a27bddfcf31f5..630599311586ec 100644
> > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > @@ -1962,14 +1962,25 @@ struct ib_mw *mlx5_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
> >
> >  int mlx5_ib_dealloc_mw(struct ib_mw *mw)
> >  {
> > +	struct mlx5_ib_dev *dev = to_mdev(mw->device);
> >  	struct mlx5_ib_mw *mmw = to_mmw(mw);
> >  	int err;
> >
> > -	err =  mlx5_core_destroy_mkey((to_mdev(mw->device))->mdev,
> > -				      &mmw->mmkey);
> > -	if (!err)
> > -		kfree(mmw);
> > -	return err;
> > +	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
> > +		xa_erase(&dev->mdev->priv.mkey_table,
> > +			 mlx5_base_mkey(mmw->mmkey.key));
> > +		/*
> > +		 * pagefault_single_data_segment() may be accessing mmw under
> > +		 * SRCU if the user bound an ODP MR to this MW.
> > +		 */
> > +		synchronize_srcu(&dev->mr_srcu);
> > +	}
> > +
> > +	err = mlx5_core_destroy_mkey(dev->mdev, &mmw->mmkey);
> > +	if (err)
> > +		return err;
> > +	kfree(mmw);
> 
> You are skipping kfree() in case of error returned by mlx5_core_destroy_mkey().
> IMHO, it is right for -ENOENT, but is not right for mlx5_cmd_exec() failures.

This is pre-existing behavior, it seems reasonable to always free.

Again, allow error on destroy is such an annoying anti-pattern..

But fixing this should be a followup patch

Jason
