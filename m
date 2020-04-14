Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D731A8ACF
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2020 21:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504825AbgDNTbj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Apr 2020 15:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504813AbgDNTbN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Apr 2020 15:31:13 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202B9C061A10
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 12:31:05 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id bu9so462203qvb.13
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 12:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6YlWT5Ndlu99/nfI1r0vp1Am52RgddR5Ti+E5WGoNo0=;
        b=ljIrLTynTkIBD68n8xb6wy21V4GQVDiKAE5ZdmaKD4d9PeuzMXV9H3YUy2AKcG4BaT
         NXjLMScOKxa70oh2YJ30YeHreDnGSfaoTK/IG6WxtUFEY1iOJCLQlQi4+EYhuSjGQqsb
         3iHsgUR4A8h4PBHnhF+gvPyV7Ku66t/srCMMAqwp4um4XtzDTApSlYnnaD73muy45Myp
         72s75p3sfeTSE1XrJf/rY+hJuX7Gt3Tembb5CK/Je0ipto4mIsHszj5mjquWVQ99hzKd
         xYeO7qEP3797jjoPE+18CHgBLhCJO/SJMXbK8oPb/izjkghCA4eSUSsxJ1zlJwuZagqj
         gAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6YlWT5Ndlu99/nfI1r0vp1Am52RgddR5Ti+E5WGoNo0=;
        b=UM2iFdvnibY+Sb4zVWAw33Ft3SA1prWRdTYpg0S3eqJU2crt7OGrNYXKwuYcFxjKGG
         XR8i9C5m1eUo6PEWirP5IH6hISvMaB+9Zb7P+E+4gVIj2EujbjrzepA+wqPEfnsy4OWc
         CvAYLkP2K1bTaVrAJ/pKCO19swqwIdXGh9758PTThX2LA8bDSwSjWqYWAXTK2JIVJJgS
         cVmqgSnCtbYkRj+Jlc1qULfTZ4mvaXOB8spfgKvAdllGBdgGroIFhqSAP0s3puCjrXlZ
         d2BUOkpNCXKAtQCRkCCFBE/85jrBT2T36cEsvLcf7F/yfYHYWoB/a7FQBho95ixnwobA
         7BLg==
X-Gm-Message-State: AGi0PuZXnbTxP+03N/cXuueGVDuQVnuMKV+p4k+2CALoZHMdflmfqvIm
        o0f8Oqo8upcW3Ouzrb4pTCXEB9nkpNuHxw==
X-Google-Smtp-Source: APiQypJOHm+O3bYeEua08/BnPle1J4JK+2fgLV/jRnjdjbhKmcnsGwSqXjX8AiSxNB58xaPPyTo7sg==
X-Received: by 2002:a0c:fdc3:: with SMTP id g3mr1650783qvs.184.1586892664078;
        Tue, 14 Apr 2020 12:31:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id l9sm11537814qth.60.2020.04.14.12.31.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 12:31:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jORGx-0005Mt-3l; Tue, 14 Apr 2020 16:31:03 -0300
Date:   Tue, 14 Apr 2020 16:31:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>
Subject: Re: [PATCH] RDMA: Remove a few extra calls to ib_get_client_data()
Message-ID: <20200414193103.GA20597@ziepe.ca>
References: <0-v1-fae83f600b4a+68-less_get_client_data%jgg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-fae83f600b4a+68-less_get_client_data%jgg@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 07, 2020 at 08:20:09PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> These four places already have easy access to the client data, just use
> that instead.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Acked-by: Ursula Braun <ubraun@linux.ibm.com>
> ---
>  drivers/infiniband/core/sa_query.c    | 15 ++++++---------
>  drivers/infiniband/core/user_mad.c    |  3 +--
>  drivers/infiniband/ulp/srpt/ib_srpt.c |  7 ++-----
>  net/smc/smc_ib.c                      |  3 +--
>  4 files changed, 10 insertions(+), 18 deletions(-)

Applied to rdma for-next

Jason
