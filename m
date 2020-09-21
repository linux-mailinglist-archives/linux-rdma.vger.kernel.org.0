Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD00271EC1
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Sep 2020 11:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgIUJSS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Sep 2020 05:18:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgIUJSS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Sep 2020 05:18:18 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D755214F1;
        Mon, 21 Sep 2020 09:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600679897;
        bh=yfkG4KOujNgS1Z/HLK+DIjspFbrM8v9bHB0h0gzKIwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vn+vXza1DX8CTHI7yy0mspb8C8njPpEeYyB9LaA+4jckOQeaWbXFu758/DA4sDFi1
         b+j8aswIcM16TSnZg9JZ4afRUTUFQ3SU17um6Qbo30qVXiysnxzS9xUFizbFywvtHQ
         ZYCl59fovBCrzyjYGBdvdexVmRbPEcfyqFV+oqLg=
Date:   Mon, 21 Sep 2020 12:18:13 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 1/2] lib/scatterlist: Add support in dynamic
 allocation of SG table from pages
Message-ID: <20200921091813.GA1223944@unreal>
References: <20200916140726.839377-1-leon@kernel.org>
 <20200916140726.839377-2-leon@kernel.org>
 <20200921075725.GA19394@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921075725.GA19394@lst.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 21, 2020 at 09:57:25AM +0200, Christoph Hellwig wrote:
> I'm still not really sold on the explosion of specific sgl APIs, so
> I ended up implementing my original suggestion to reuse
> __sg_alloc_table_from_pages and just pass two additional parameters.
> I also ended up moving the memset out of __sg_alloc_table into its
> two callers, and I think the result looks much better, what do you
> think?

I think that the API call is really hard to grasp now with too many
arguments. Fun part will start when someone will decide to use this API
without some (expected for now) parameters.

I'm fond of more explicit interfaces.

Anyway, it is your area, we will retest it and resend.

Thanks
