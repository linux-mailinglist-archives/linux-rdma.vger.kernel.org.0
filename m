Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233C035E69A
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 20:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhDMSm4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 14:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhDMSmv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Apr 2021 14:42:51 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97054C061756
        for <linux-rdma@vger.kernel.org>; Tue, 13 Apr 2021 11:42:29 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id c123so14070609qke.1
        for <linux-rdma@vger.kernel.org>; Tue, 13 Apr 2021 11:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PDb/r/yd8k47jZH0ixwImuuJ0d1dgyQx3AaOV9gqi7s=;
        b=PQgpLOXNrGpUkDKDJ9PPELt6r3aXzJvNG+KqdnkiWmcWlwcF6b/UXYVwWNQRGAmCxD
         caIei1YlCPuKo8SmI0Ey1HYvKP52swvxis2UnSXdrUO/wTVysnkBV9P30IsHZagvqYTG
         i86qG6M1f+ln5tA4sFMoZfL87ZTLklOG0PNGIpAzcnjqwukwC+CQmwplHzDEGFCi6uN5
         cipUIKcYndS5ptFljDP2ll0PMS1RQM2qDTawG+epvnTIm5ePglLc3vqOKVmT9k8bDzIY
         QvqUgizkvtKLL2vqkJzei0oDgzz3b9x0c7K1LpmBcjen8hmoax3S5H48Nv/nCQcrkuvN
         LvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PDb/r/yd8k47jZH0ixwImuuJ0d1dgyQx3AaOV9gqi7s=;
        b=eDuWSvkzAz4YWooqQRC6y8ySuchYmIYkwSvCSHQF2pX6H2mIQsamlHMuuJ0d9qjl4Z
         B2tBuxCAMKEdfG7wpMYpsUdRZh/Mr8m00JNlL024Qu1epPx0rxqA3UzHVyR/E1uSEGQD
         96dekYp/yfD9OfmtjOK9XlYcSI1VfHfYcSwPayMBAJ5CFx1d1ilFmEOb91Danfc6B8uC
         6pflYDu/nspzPgNOXhAnOdoYwjGw17qV2Bi6PKJj1DcLdlWEz+LLozvQlc3QwIvht1XK
         wnnJcyQmdiTqH8fF87ubpIl0FUYVDMYaFHnzdTNoTanf1QWQ/JLQXgI47nU5hr8BJaln
         /YSQ==
X-Gm-Message-State: AOAM531P34/gVQ7FDZ1BgOKUoPSO6qOwfjbkOIxObseDxyYraXqkWpuL
        bOk4beKR7xToLrJsPn0QiBlzRQ==
X-Google-Smtp-Source: ABdhPJzjar1kycP3DWeGMY3Rs400dFydtPRaRPVRTeiEGqGq9J38GrqHyHHJDsGygDAN8IZOVi6Cww==
X-Received: by 2002:a37:6188:: with SMTP id v130mr20913184qkb.483.1618339348891;
        Tue, 13 Apr 2021 11:42:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id e3sm10397378qtj.28.2021.04.13.11.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 11:42:28 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lWNzX-005cHG-NX; Tue, 13 Apr 2021 15:42:27 -0300
Date:   Tue, 13 Apr 2021 15:42:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Manjunath Patil <manjunath.b.patil@oracle.com>
Cc:     dledford@redhat.com, leon@kernel.org, valentinef@mellanox.com,
        gustavoars@kernel.org, haakon.bugge@oracle.com,
        rama.nichanamatlu@oracle.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2] IB/ipoib: improve latency in ipoib/cm connection
 formation
Message-ID: <20210413184227.GL227011@ziepe.ca>
References: <1618338965-16717-1-git-send-email-manjunath.b.patil@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618338965-16717-1-git-send-email-manjunath.b.patil@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 13, 2021 at 11:36:05AM -0700, Manjunath Patil wrote:
> Currently ipoib connected mode queries the device[HCA] to get pkey table
> entry during connection formation. This will increase the time taken to
> form the connection, especially when limited pkeys are in use.  This
> gets worse when multiple connection attempts are done in parallel.
> 
> Since ipoib interfaces are locked to a single pkey, use the pkey index
> that was determined at link up time instead of searching anything.
> 
> This improved the latency from 500ms to 1ms on an internal setup.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
> ---
> v2: v1 used the cached version[ib_find_cached_pkey()] to get the pkey table
> entry. Following the Jason's comments for v1, I switched to pkey index that was
> determined at link up time in v2.

Can you confirm that the pkey index does get updated if the SM changes
the pkey table? (and if so how is the locking done for reading the pkey_index?)

That is about the only reason to have had a dedicated query here

Jason
