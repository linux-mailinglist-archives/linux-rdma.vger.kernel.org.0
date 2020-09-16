Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3AB26BDCE
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 09:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIPHT4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 03:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgIPHT4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Sep 2020 03:19:56 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02DDF2076C;
        Wed, 16 Sep 2020 07:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600240795;
        bh=1cO8EafAQxQunyA9UiqbTCmb83XT1maBwoQrVcurDH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v11iDr4MbBKq2VXWUTA25KH22HIPIvMLCVzVBvObQqIjnidcXSj0mgJ99pieAaf7a
         ReqDuTCRMhjDLmqQNi0wQ8t4WjjfrppY/ze/Kfn9UbgQjdk+LgVWq8zhEY2gnXhYeZ
         gCIUwejqk8QEVZcRWEiGtQwOkrKXaruVZ9PPSnvc=
Date:   Wed, 16 Sep 2020 10:19:51 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 3/4] lib/scatterlist: Add support in dynamic
 allocation of SG table from pages
Message-ID: <20200916071951.GE486552@unreal>
References: <20200910134259.1304543-1-leon@kernel.org>
 <20200910134259.1304543-4-leon@kernel.org>
 <20200915162339.GC24320@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915162339.GC24320@lst.de>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 15, 2020 at 06:23:39PM +0200, Christoph Hellwig wrote:
> > +#ifndef CONFIG_ARCH_NO_SG_CHAIN
> > +struct scatterlist *sg_alloc_table_append(
> > +	struct sg_table *sgt, struct page **pages, unsigned int n_pages,
> > +	unsigned int offset, unsigned long size, unsigned int max_segment,
> > +	gfp_t gfp_mask, struct scatterlist *prv, unsigned int left_pages);
> > +#endif
>
> Odd indentation here, we either do two tabs (my preference) or aligned
> to the opening brace (what you seem to be doing elsewhere in the series).

All indentation came from clang-formatter, we will change.

Thanks
