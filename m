Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B67793B74F
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 16:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389356AbfFJO1i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 10:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388936AbfFJO1i (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 10:27:38 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63295207E0;
        Mon, 10 Jun 2019 14:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560176858;
        bh=ML2sBDgatuCk5b3xHipfCWj6HSR5+36n17ZxjlCjAlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zh0k4l1pEzLI1BegLrQuyZaZiBiaIZhB12G/4SRi0W0ccviUpyilt7nmMYMwRanmM
         k1FedGZr1EGVR+abXITXgfIR6px5oMlWxd55ZOOWMlKmxpMdLa9XPggRe3ZfII4hY4
         /MDa20TEax+NyfStKGqYfRZvexpiMUTDv8jrQbSE=
Date:   Mon, 10 Jun 2019 17:27:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 3/3] RDMA: Report available cdevs through
 RDMA_NLDEV_CMD_GET_CHARDEV
Message-ID: <20190610142734.GE6369@mtr-leonro.mtl.com>
References: <20190605183252.6687-1-jgg@ziepe.ca>
 <20190605183252.6687-4-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605183252.6687-4-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 05, 2019 at 03:32:52PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> Update the struct ib_client for all modules exporting cdevs related to the
> ibdevice to also implement RDMA_NLDEV_CMD_GET_CHARDEV. All cdevs are now
> autoloadable and discoverable by userspace over netlink instead of relying
> on sysfs.
>
> uverbs also exposes the DRIVER_ID for drivers that are able to support
> driver id binding in rdma-core.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/device.c             |  3 ++
>  drivers/infiniband/core/ucma.c               | 23 +++++++++
>  drivers/infiniband/core/user_mad.c           | 51 ++++++++++++++++++--
>  drivers/infiniband/core/uverbs_main.c        | 32 +++++++++++-
>  drivers/infiniband/hw/cxgb3/iwch_provider.c  |  1 +
>  drivers/infiniband/hw/hns/hns_roce_main.c    |  1 +
>  drivers/infiniband/hw/mthca/mthca_provider.c |  1 +
>  include/rdma/ib_verbs.h                      |  1 +
>  include/uapi/rdma/rdma_netlink.h             |  1 +
>  9 files changed, 109 insertions(+), 5 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
