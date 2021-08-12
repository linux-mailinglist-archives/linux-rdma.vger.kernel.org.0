Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A283EA09B
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Aug 2021 10:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhHLIgQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Aug 2021 04:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhHLIgQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Aug 2021 04:36:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1F4661058;
        Thu, 12 Aug 2021 08:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628757351;
        bh=KJBnCMhNWj16RkzvEacOBMzFhcX6qc3pIrv9OtZjPxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ChLvPcwdR/doAaCmmv6AbO7pfzgosGQYvyZVhHcsMZK+/iGrZqCFGgtoUTwQVwhFx
         XYDhm3tQ3OolRNJqCLl/7sFRQMiJVhKlpspQ0TcTJZsr/klAoBz/r9F7X/tA+TOvcy
         nRJ+A177iudvo+sl8nrIRWfWLPSVpoJHSrOFg4OONLIOD20ejBlOW390bWBqBBe97w
         0yb6vrLWZC1zVQ7ljpEtZUaTnqXbHybUIbkOpMoirlGw6z8jBoszWN1PZOuE5NzKUg
         JYAO2zr5WpKImsOXIYzViAJ1kJ2+JmBMTzocbN6n6nz2cxeByzivEWNleK35IqLIh3
         zIFvP2zwqMsLw==
Date:   Thu, 12 Aug 2021 11:35:46 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next v2] RDMA/core/sa_query: Remove unused function
Message-ID: <YRTdYp7mKiVMmRgH@unreal>
References: <1628702736-12651-1-git-send-email-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1628702736-12651-1-git-send-email-haakon.bugge@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 11, 2021 at 07:25:36PM +0200, Håkon Bugge wrote:
> ib_sa_service_rec_query() was introduced in kernel v2.6.13 by commit
> cbae32c56314 ("[PATCH] IB: Add Service Record support to SA client")
> in 2005. It was not used then and have never been used since.
> 
> Removing it and related functions/structs.
> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/core/sa_query.c | 177 -------------------------------------
>  include/rdma/ib_sa.h               |  24 -----
>  2 files changed, 201 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
