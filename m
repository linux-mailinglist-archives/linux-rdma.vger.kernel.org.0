Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC7A1E8724
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2020 21:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgE2TDf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 May 2020 15:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbgE2TDa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 May 2020 15:03:30 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7794C03E969
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 12:03:30 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f18so3271247qkh.1
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 12:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jtMShlx3MkZ93j5AGqNLIKb/56M9vrr1O9ZVnTAa0Co=;
        b=ANasFbbRuI7s6O9vGxXR18ZXMeX0zCQX6wIYM6W0yzT2yqBYhqtZ/JkMqbmONfO8gx
         CFRz2x3G3Ly0VsB/a0JrWmYewGjC6/NlwKKfatrkdyrEu14UQxwH5vKCetv1GQyTpRNj
         udOHia9Avpv/lTfO0oYy1nj8/+FNnyCZrxCJ7VVYZ2DeUlu+MZQ1DqzJFel5Be4JnAUZ
         S23N2UTpFrSxU19xBnQQo6yOtMh7klT6eZZpBrcBtZ4zDUXR8s3PaxJSMQElBH52u7fu
         poZw6/hkTgGIxzeNyOMbOi5m8dJjgEjjeFSiaBEWA9hgGeSzsarohN/IJa0Vk1mLeU5j
         cT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jtMShlx3MkZ93j5AGqNLIKb/56M9vrr1O9ZVnTAa0Co=;
        b=FlkwJh9d0fY0mp/OnOrjqOiCywZC9XhAc2PwJ+lah4DcdYsDngtKDHSAfrhWsje9Os
         XJfbeH3TPf4KybVLNEoa+v4WmuCfVXmuIrDecOaZPJHwHtmhaoownzmIV+AytzNIOirQ
         +ne1aGE7YylkEi9aQvax05cOuLmENWyq4Op9sN2RRDvuowBg1AKfNQPLHsyD/QQxVM9S
         ElJDDlp+J6XAvYinD3//jfp6b9+sRSyyv0DciBmPGUPW8Xj9VKcoOV6U1bYyKBYvQrKH
         QO8g8NAA0Y1UfVBQr0KfCLjZbghX3hubSNWLGcBxn5ZtJsMeX2BlS5Q200ww7jpurDDf
         p4/w==
X-Gm-Message-State: AOAM532MBWI5WKWrHC6ylIdD0BcE5RA7SbivaoIt8HaKTm655IO+H4Cs
        IeZsndgctfC6kHTGGpE5en1/grxv/50=
X-Google-Smtp-Source: ABdhPJz/c0mHMZYqfSWO0UIS1SuxC+DwH6j1UvfosOlTn6RJwR/Vl9n3C2F3yATngNbYgQZr8lOUcg==
X-Received: by 2002:a37:63c2:: with SMTP id x185mr9529852qkb.82.1590779010080;
        Fri, 29 May 2020 12:03:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d193sm3983305qke.124.2020.05.29.12.03.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 12:03:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jekHw-0000uL-W6; Fri, 29 May 2020 16:03:29 -0300
Date:   Fri, 29 May 2020 16:03:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yamin Friedman <yaminf@mellanox.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH V4 0/4] Introducing RDMA shared CQ pool
Message-ID: <20200529190328.GB2467@ziepe.ca>
References: <1590568495-101621-1-git-send-email-yaminf@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590568495-101621-1-git-send-email-yaminf@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 27, 2020 at 11:34:51AM +0300, Yamin Friedman wrote:
> This is the fourth re-incarnation of the CQ pool patches proposed
> by Sagi and Christoph. I have started with the patches that Sagi last
> submitted and built the CQ pool as a new API for acquiring shared CQs.
> 
> The main change from Sagi's last proposal is that I have simplified the
> method that ULP drivers interact with the CQ pool. Instead of calling 
> ib_alloc_cq they now call ib_cq_pool_get but use the CQ in the same manner
> that they did before. This allows for a much easier transition to using
> shared CQs by the ULP and makes it easier to deal with IB_POLL_DIRECT
> contexts. Certain types of actions on CQs have been prevented on shared
> CQs in order to prevent one user from harming another.
> 
> Our ULPs often want to make smart decisions on completion vector
> affinitization when using multiple completion queues spread on
> multiple cpu cores. We can see examples for this in iser, srp, nvme-rdma.
> 
> This patch set attempts to move this smartness to the rdma core by
> introducing per-device CQ pools that by definition spread
> across cpu cores. In addition, we completely make the completion
> queue allocation transparent to the ULP by adding affinity hints
> to create_qp which tells the rdma core to select (or allocate)
> a completion queue that has the needed affinity for it.
> 
> This API gives us a similar approach to whats used in the networking
> stack where the device completion queues are hidden from the application.
> With the affinitization hints, we also do not compromise performance
> as the completion queue will be affinitized correctly.
> 
> One thing that should be noticed is that now different ULPs using this
> API may share completion queues (given that they use the same polling context).
> However, even without this API they share interrupt vectors (and CPUs
> that are assigned to them). Thus aggregating consumers on less completion
> queues will result in better overall completion processing efficiency per
> completion event (or interrupt).
> 
> An advantage of this method of using the CQ pool is that changes in the ULP
> driver are minimal (around 14 altered lines of code).
> 
> The patch set converts nvme-rdma and nvmet-rdma to use the new API.
> 
> Test results can be found in patch-0002.
> 
> Comments and feedback are welcome.
> 
> Changes since v3
> 
> *Refactored ib_poll_ctx enum
> *Moved to correct use of unsigned types
> *Removed use of spin_lock_irqsave
> *Moved pool init and destroy function calls
> *Corrected function documentation
> 
> Changes since v2
> 
> *Minor code refactoring
> 
> Changes since v1
> 
> *Simplified cq pool shutdown process
> *Renamed cq pool functions to be like mr pool
> *Simplified process for finding cqs in pool
> *Removed unhelpful WARN prints
> *Removed one liner functions
> *Replaced cq_type with boolean shared
> *Updated test results to more properly show effect of patch
> *Minor bug fixes
> 
> Yamin Friedman (4):
>   RDMA/core: Add protection for shared CQs used by ULPs
>   RDMA/core: Introduce shared CQ pool API
>   nvme-rdma: use new shared CQ mechanism
>   nvmet-rdma: use new shared CQ mechanism
> 
>  drivers/infiniband/core/core_priv.h |   3 +
>  drivers/infiniband/core/cq.c        | 171 ++++++++++++++++++++++++++++++++++++
>  drivers/infiniband/core/device.c    |   2 +
>  drivers/infiniband/core/verbs.c     |   9 ++
>  drivers/nvme/host/rdma.c            |  75 ++++++++++------
>  drivers/nvme/target/rdma.c          |  14 +--
>  include/rdma/ib_verbs.h             |  21 ++++-
>  7 files changed, 261 insertions(+), 34 deletions(-)

Applied to for-next, thanks

Jason
