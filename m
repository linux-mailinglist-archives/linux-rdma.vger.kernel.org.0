Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDAD3A14EF
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 14:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhFIMyj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 08:54:39 -0400
Received: from verein.lst.de ([213.95.11.211]:56108 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231193AbhFIMyj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Jun 2021 08:54:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ACA4D6736F; Wed,  9 Jun 2021 14:52:41 +0200 (CEST)
Date:   Wed, 9 Jun 2021 14:52:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Tom Talpey <tom@talpey.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Honggang LI <honli@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v2 rdma-next] RDMA/mlx5: Enable Relaxed Ordering by
 default for kernel ULPs
Message-ID: <20210609125241.GA1347@lst.de>
References: <b7e820aab7402b8efa63605f4ea465831b3b1e5e.1623236426.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7e820aab7402b8efa63605f4ea465831b3b1e5e.1623236426.git.leonro@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 09, 2021 at 02:05:03PM +0300, Leon Romanovsky wrote:
> From: Avihai Horon <avihaih@nvidia.com>
> 
> Relaxed Ordering is a capability that can only benefit users that support
> it. All kernel ULPs should support Relaxed Ordering, as they are designed
> to read data only after observing the CQE and use the DMA API correctly.
> 
> Hence, implicitly enable Relaxed Ordering by default for kernel ULPs.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Changelog:
> v2:
>  * Dropped IB/core patch and set RO implicitly in mlx5 exactly like in
>    eth side of mlx5 driver.

This looks great in terms of code changes.  But can we please also add a
patch to document that PCIe relaxed ordering is fine for kernel ULP usage
somewhere?
