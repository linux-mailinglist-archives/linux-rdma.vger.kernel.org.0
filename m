Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFC01C7901
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 20:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbgEFSJj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 14:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbgEFSJi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 May 2020 14:09:38 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5B5C061A0F
        for <linux-rdma@vger.kernel.org>; Wed,  6 May 2020 11:09:38 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id c4so1248570qvi.6
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2020 11:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DhKhDLraYY5zVvOG+kB1t3NrhQcRWpwlxSgmSFeMJaw=;
        b=ddFOus8/OGoZT7TCpUdCcC7FFcsJSDg1cGhGwmMV09PHC4rgfa9bRg8GCvNyqNDtnh
         2Hj+jxusSrgnQuhUC4OqKOE6jkdpo0Cm4ZDM1dUOjLN/UTu6xdsomSIvzU30GrIrFGEH
         k+WAbDwXWHzcvgVkhvo9O01SdXMPswSWu4bGI/ps4vzGbui7jw3CvE3tvJGwYwPmJrAZ
         xiHk1C9WK6i+2Di63QiB3YWrGakel+o742BoJxUUybQYHv7Vb27hTVAnoL0gnp6i6pPW
         mnwF5na/OayrXJPvB2o+7gMpDcB7GGXiXTSu2Efrbzk/EfmsfNQwxHxR1TsFd39rvwj8
         8bxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DhKhDLraYY5zVvOG+kB1t3NrhQcRWpwlxSgmSFeMJaw=;
        b=dHf+fnYgPCDB1JdfAxDh1nal4F32SFEoym63N1L/53Dh9I4K4A1occLCQSKuxGTwbc
         LZb+Z+D50D1C0Qok0sFdoCuLSq3PXnbgDq4xFNeL+LLL3+px3fJ9fa7M5RsEhe6xh+d7
         s1s0cYJ8coFJC1oQRK7SnDlEbmQQ0pjvs2toONTi1V+sK/WAm22+Cilet9KbBIcWv493
         xyUqHtnqcjd+HLqr+EIcfihYRJatpwG1Am9l8TNgmWUizaUt7YdH2D5BBYMgxxALU53m
         M0tJ8P+UE2uXr2RaorlYfnQcEEDHRw0Cp8Z0kFRV7UJQm2sVR+58+4xEH3xXGIlNCR6n
         LPig==
X-Gm-Message-State: AGi0PuZHrpUM3EnBRnlZA3FCDV17K06iiupxPkMygHgctTj1Zs3KCOpd
        5kbUwP+1CFRh3OL0/N7P/aCRvA==
X-Google-Smtp-Source: APiQypJjUh8UT3SvaYjekrpnh0OmlZp58hWjDO1YxNEF/VSuNsWjJ8lsHXrF0gBw/u9CLlAx8VyahQ==
X-Received: by 2002:a05:6214:bc6:: with SMTP id ff6mr9643264qvb.43.1588788577468;
        Wed, 06 May 2020 11:09:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id u35sm2024087qtd.88.2020.05.06.11.09.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 May 2020 11:09:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jWOUC-0004rH-Bs; Wed, 06 May 2020 15:09:36 -0300
Date:   Wed, 6 May 2020 15:09:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc v1] IB/core: Fix potential NULL pointer
 dereference in pkey cache
Message-ID: <20200506180936.GI26002@ziepe.ca>
References: <20200506053213.566264-1-leon@kernel.org>
 <20200506144344.GA8875@ziepe.ca>
 <20200506165608.GA4600@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506165608.GA4600@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 06, 2020 at 07:56:08PM +0300, Leon Romanovsky wrote:
> On Wed, May 06, 2020 at 11:43:44AM -0300, Jason Gunthorpe wrote:
> > On Wed, May 06, 2020 at 08:32:13AM +0300, Leon Romanovsky wrote:
> > > From: Jack Morgenstein <jackm@dev.mellanox.co.il>
> > >
> > > The IB core pkey cache is populated by procedure ib_cache_update().
> > > Initially, the pkey cache pointer is NULL. ib_cache_update allocates
> > > a buffer and populates it with the device's pkeys, via repeated calls
> > > to procedure ib_query_pkey().
> > >
> > > If there is a failure in populating the pkey buffer via ib_query_pkey(),
> > > ib_cache_update does not replace the old pkey buffer cache with the
> > > updated one -- it leaves the old cache as is.
> > >
> > > Since initially the pkey buffer cache is NULL, when calling
> > > ib_cache_update the first time, a failure in ib_query_pkey() will cause
> > > the pkey buffer cache pointer to remain NULL.
> > >
> > > In this situation, any calls subsequent to ib_get_cached_pkey(),
> > > ib_find_cached_pkey(), or ib_find_cached_pkey_exact() will try to
> > > dereference the NULL pkey cache pointer, causing a kernel panic.
> > >
> > > Fix this by checking the ib_cache_update() return value.
> > >
> > > Fixes: 8faea9fd4a39 ("RDMA/cache: Move the cache per-port data into the main ib_port_data")
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
> > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > Changelog:
> > > v1: I rewrote the patch to take care of ib_cache_update() return value.
> > > v0: https://lore.kernel.org/linux-rdma/20200426075811.129814-1-leon@kernel.org
> > >  drivers/infiniband/core/cache.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >
> > >
> > > diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> > > index 717b798cddad..1cbebfa374a5 100644
> > > +++ b/drivers/infiniband/core/cache.c
> > > @@ -1553,10 +1553,17 @@ int ib_cache_setup_one(struct ib_device *device)
> > >  	if (err)
> > >  		return err;
> > >
> > > -	rdma_for_each_port (device, p)
> > > -		ib_cache_update(device, p, true);
> > > +	rdma_for_each_port (device, p) {
> > > +		err = ib_cache_update(device, p, true);
> > > +		if (err)
> > > +			goto out;
> > > +	}
> > >
> > >  	return 0;
> > > +
> > > +out:
> > > +	ib_cache_release_one(device);
> > > +	return err;
> >
> > ib_cache_release_once can be called only once, and it is always called
> > by ib_device_release(), it should not be called here
> 
> It doesn't sound right if we rely on ib_device_release() to unwind error
> in ib_cache_setup_one(). I don't think that we need to return from
> ib_cache_setup_one() without cleaning it.

We do as ib_cache_release_one() cannot be called multiple times

The general design of all this pre-registration stuff is that the
release function does the clean up and the individual functions should
not error unwind cleanup done in the unconditional release.

Other schemes were too complicated

Jason
