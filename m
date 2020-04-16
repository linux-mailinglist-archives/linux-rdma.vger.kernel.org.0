Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B361ACFB2
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 20:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgDPSai (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 14:30:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbgDPSah (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Apr 2020 14:30:37 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6267B206D5;
        Thu, 16 Apr 2020 18:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587061837;
        bh=Lt/pr9RUNCAhA4FWaQWoD76BQNIpHIliCCImnMJ+tNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=15OkUaHDH7FNWi9y+07XY+2iySWVC9dsUZ9r/2m3qRE17oG3C7gjRZJBD9LpW2OO6
         NCWhnCE5v4o4S9aov08Epy/tmxI2wYm22cvjJY3UuyijtXe/36VYjvDfztO83S0Zr7
         pMo/fGqiR8+eyndZgWbRhYH6XIAjO4JJUdTc0/+A=
Date:   Thu, 16 Apr 2020 21:30:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [RFC PATCH 1/3] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20200416183033.GI1309273@unreal>
References: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
 <1587056973-101760-2-git-send-email-jianxin.xiong@intel.com>
 <20200416180201.GH1309273@unreal>
 <20200416180407.GV5100@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416180407.GV5100@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 16, 2020 at 03:04:07PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 16, 2020 at 09:02:01PM +0300, Leon Romanovsky wrote:
>
> > > diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
> > > index ade8638..1dcfc59 100644
> > > +++ b/drivers/infiniband/Kconfig
> > > @@ -63,6 +63,16 @@ config INFINIBAND_ON_DEMAND_PAGING
> > >  	  memory regions without pinning their pages, fetching the
> > >  	  pages on demand instead.
> > >
> > > +config INFINIBAND_DMABUF
> >
> > There is no need to add extra config, it is not different from any
> > other verbs feature which is handled by some sort of mask.
>
> That works too, but then it infiniband_user_mem needs the
>  depends on DMABUF || !DMABUF construct

IS_REACHABLE() ? :)

>
> > > +	if (access & IB_ACCESS_ON_DEMAND)
> > > +		return ERR_PTR(-EOPNOTSUPP);
> >
> > Does dma-buf really need to prohibit ODP?
>
> ODP fundamentally can only be applied to a mm_struct

Right, I forgot about it, thanks.

>
> Jason
