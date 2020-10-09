Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E8C288C8C
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 17:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389251AbgJIP1V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 11:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389039AbgJIP1U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 11:27:20 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCB3C0613D2
        for <linux-rdma@vger.kernel.org>; Fri,  9 Oct 2020 08:27:20 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b69so10933701qkg.8
        for <linux-rdma@vger.kernel.org>; Fri, 09 Oct 2020 08:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HvPR/2161MZ4QZ7tllZ9KkNkBA7IMOHJGZ2RgEgNyDE=;
        b=hpsEuVajXhh1WeEQBiF2+xZszxMFxl6lpuq6+qdwjFamLbsrCYZZXGi/4YarM5dTxP
         WZVPFyURz6/oN6gR7KRcrI13ciSmQTX+9pSXwU3CInuezUO9xDIGy0PHeG0Lz1J1stFt
         suvwe6E9VDevDtYAokBcGVW6u5wJuY7VkCW0yX3HYUAAASaWnu9CACyQGDwwRcaK59QG
         B3Kphzm1RMao4xYxGPPDkjmRI9I0xe7xqSF1pWyEauiW3hd9Le6o7GUgkxABI0lKG/6L
         jSMXrwqf/M3VEni34hf8lJZpQPQiTfafZWueoL/i2YgrgK0T94o0uu0voJoGZ81jNLBH
         srXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HvPR/2161MZ4QZ7tllZ9KkNkBA7IMOHJGZ2RgEgNyDE=;
        b=euxaRgcRhMweRx/EV8Rb2BueEGLY3iimaNSId4kbY28Uz4B/Dft+NamybwqqBP/Ux+
         bIbAMcNdjHuuxffETf+nUrwaUB/thNYkJDG0rhU7759903g+OzUytgr8TjyZrwMZzUMm
         c9kUMT1HK9VUCj+KiwN192C4MIhN5aOxmxx/cC18zHDSBaeFKZQvEE6sR1b1Z0bXjE4g
         8nB0m/O3uQYQlkLHof3746q61cOu87AJsyrfLLCUheKSI6gN63TeDDkWHX4DUs1G9AYR
         576ftPXutQKis3f4IswKavVrhA93B79OVm6MpwFKR3Z5OuG7REsv+6qMxdmrJEdEdiGN
         uYMQ==
X-Gm-Message-State: AOAM531p0oTvibMZTaw9sqYomuwsgL2x5ix8ElQCwuVwsy1rPUsdSh4H
        wvRyM5nKOQBe8zv9QiJNBSrQBw==
X-Google-Smtp-Source: ABdhPJzr04YGUU48WnZvAMayUmPukFoqGRyi7gqREZ5XZTQVvR0ocEir0zO32tkE0lGlw9qfTkgUpg==
X-Received: by 2002:ae9:e20f:: with SMTP id c15mr10604643qkc.76.1602257239994;
        Fri, 09 Oct 2020 08:27:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id m25sm6397735qki.105.2020.10.09.08.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 08:27:19 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQuIg-0020jY-M7; Fri, 09 Oct 2020 12:27:18 -0300
Date:   Fri, 9 Oct 2020 12:27:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joe Perches <joe@perches.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 4/4] RDMA: Convert various random sprintf sysfs _show
 uses to sysfs_emit
Message-ID: <20201009152718.GZ5177@ziepe.ca>
References: <cover.1602122879.git.joe@perches.com>
 <ecde7791467cddb570c6f6d2c908ffbab9145cac.1602122880.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecde7791467cddb570c6f6d2c908ffbab9145cac.1602122880.git.joe@perches.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 07, 2020 at 07:36:27PM -0700, Joe Perches wrote:
> Manual changes for sysfs_emit as cocci scripts can't easily convert them.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/infiniband/core/cm.c                 |  4 +-
>  drivers/infiniband/core/cma_configfs.c       |  4 +-
>  drivers/infiniband/core/sysfs.c              | 98 +++++++++++---------
>  drivers/infiniband/core/user_mad.c           |  2 +-
>  drivers/infiniband/hw/hfi1/sysfs.c           | 10 +-
>  drivers/infiniband/hw/mlx4/sysfs.c           | 19 ++--
>  drivers/infiniband/hw/qib/qib_sysfs.c        | 30 +++---
>  drivers/infiniband/hw/usnic/usnic_ib_sysfs.c | 34 +++----
>  drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 14 +--
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  7 +-
>  drivers/infiniband/ulp/srp/ib_srp.c          |  4 +-
>  drivers/infiniband/ulp/srpt/ib_srpt.c        | 14 +--
>  12 files changed, 119 insertions(+), 121 deletions(-)

Didn't see anything profound

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
