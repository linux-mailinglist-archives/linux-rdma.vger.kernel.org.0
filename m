Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213AE27C23B
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 12:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgI2KUt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 06:20:49 -0400
Received: from verein.lst.de ([213.95.11.211]:39117 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgI2KUt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Sep 2020 06:20:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 35FB667373; Tue, 29 Sep 2020 12:20:46 +0200 (CEST)
Date:   Tue, 29 Sep 2020 12:20:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blk-next 1/2] blk-mq-rdma: Delete not-used multi-queue
 RDMA map queue code
Message-ID: <20200929102046.GA14445@lst.de>
References: <20200929091358.421086-1-leon@kernel.org> <20200929091358.421086-2-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929091358.421086-2-leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 29, 2020 at 12:13:57PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The RDMA vector affinity code is not backed up by any driver and always
> returns NULL to every ib_get_vector_affinity() call.
> 
> This means that blk_mq_rdma_map_queues() always takes fallback path.
> 
> Fixes: 9afc97c29b03 ("mlx5: remove support for ib_get_vector_affinity")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

So you guys totally broken the nvme queue assignment without even
telling anyone?  Great job!
