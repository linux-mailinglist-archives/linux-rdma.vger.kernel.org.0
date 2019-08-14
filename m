Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 459898D7AA
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2019 18:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfHNQHt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Aug 2019 12:07:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43093 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfHNQHt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Aug 2019 12:07:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id b11so10911678qtp.10
        for <linux-rdma@vger.kernel.org>; Wed, 14 Aug 2019 09:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uSze5gwW1/nHV7sdPnwR3jTf0rLBBMNUn/+CnX7OfxQ=;
        b=m4NbZWWvLvFaknX0xdkPpgAtWEaAV8BPlNsV0QPnc6RgrYDmgG7AIsCG9ZHupO1OhY
         MK5GQaw5bosgo81D9cY6GHmq179L4OqwHK3M6QUinKEJeDqx/XxsudgIdbj6JCJJ8Mx4
         OEfKzvMu4bctJ4ELd7APkdehLFO1/45kAPB31gtLMFMBegBd1BaTmuRtXRxfaqmbb9j/
         7gcKiA8oYZgHtUpbyJxdB8Pj0Jf2ZLMQcL7IdGdjMoAq6vEQba2nasxNHi3QIdWTLTQH
         d/4ioF5GVIgVwgwhmehLPTTzbIryOo6apF1QStiPEI+ww2ZIZ0Kt7coH71+5OeY3wmmM
         wQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uSze5gwW1/nHV7sdPnwR3jTf0rLBBMNUn/+CnX7OfxQ=;
        b=uRpHoSn8JLrznC6ozeIvBMwJzi+O0dKOk6EQTxxJFqIYTGG1oI7yqHdCB6BTpDjA5J
         3ilhcGAG6d7p2GLsUwPEk7+ITP1+JLYNnMvlivtqoK3sJaPVTJhJksus7n2PT6AB/MHB
         wns8+wDoFZnjP5cMH/sJkDyznDxLB797lrVVXdjGnJ7POTsFfVrTzXA4C30r/A2OQAbw
         Ub+AZm5JxmhA+HGRa5RFuGxHn1ZG71wPvN4enqiIaenl5ywIYEGFUwmCozh6qtOuKBwj
         XZIpYQytN/ZRzrBCTNP5sM0TU/7E/AH8m3zjdfOhcsH9W4hsZBsKf3hLWHjwx9SmIq/T
         7m5g==
X-Gm-Message-State: APjAAAUhe03U7gLKf5few2n8b1c8z5YGhjpTPiz8mj4KxbA3O2NGmC3M
        Kw4FSCkIvo+99ptj7d8U+WMqNQ==
X-Google-Smtp-Source: APXvYqyb9m87zjH3q35GhpgQm6CNCVSjTDXOgvHlJfjkQScATNdsG/TvzCk00mXmdZUVCVz5HTGwYA==
X-Received: by 2002:a0c:af33:: with SMTP id i48mr323000qvc.185.1565798867959;
        Wed, 14 Aug 2019 09:07:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h26sm52286qta.58.2019.08.14.09.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 09:07:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hxvoR-0001J4-0D; Wed, 14 Aug 2019 13:07:47 -0300
Date:   Wed, 14 Aug 2019 13:07:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 hmm 08/11] drm/radeon: use mmu_notifier_get/put for
 struct radeon_mn
Message-ID: <20190814160746.GA4926@ziepe.ca>
References: <20190806231548.25242-1-jgg@ziepe.ca>
 <20190806231548.25242-9-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806231548.25242-9-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 06, 2019 at 08:15:45PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> radeon is using a device global hash table to track what mmu_notifiers
> have been registered on struct mm. This is better served with the new
> get/put scheme instead.
> 
> radeon has a bug where it was not blocking notifier release() until all
> the BO's had been invalidated. This could result in a use after free of
> pages the BOs. This is tied into a second bug where radeon left the
> notifiers running endlessly even once the interval tree became
> empty. This could result in a use after free with module unload.
> 
> Both are fixed by changing the lifetime model, the BOs exist in the
> interval tree with their natural lifetimes independent of the mm_struct
> lifetime using the get/put scheme. The release runs synchronously and just
> does invalidate_start across the entire interval tree to create the
> required DMA fence.
> 
> Additions to the interval tree after release are already impossible as
> only current->mm is used during the add.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>  drivers/gpu/drm/radeon/radeon.h        |   3 -
>  drivers/gpu/drm/radeon/radeon_device.c |   2 -
>  drivers/gpu/drm/radeon/radeon_drv.c    |   2 +
>  drivers/gpu/drm/radeon/radeon_mn.c     | 157 ++++++-------------------
>  4 files changed, 38 insertions(+), 126 deletions(-)

AMD team: Are you OK with this patch?

Jason
