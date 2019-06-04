Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 917183405D
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2019 09:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfFDHgJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jun 2019 03:36:09 -0400
Received: from verein.lst.de ([213.95.11.211]:33879 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfFDHgI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jun 2019 03:36:08 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1008368B02; Tue,  4 Jun 2019 09:35:43 +0200 (CEST)
Date:   Tue, 4 Jun 2019 09:35:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     leonro@mellanox.com, linux-rdma@vger.kernel.org, jgg@mellanox.com,
        dledford@redhat.com, sagi@grimberg.me, hch@lst.de,
        bvanassche@acm.org, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: Re: [PATCH 04/20] RDMA/core: Introduce ib_map_mr_sg_pi to map
 data/protection sgl's
Message-ID: <20190604073542.GM15680@lst.de>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com> <1559222731-16715-5-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559222731-16715-5-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 30, 2019 at 04:25:15PM +0300, Max Gurtovoy wrote:
> This function will map the previously dma mapped SG lists for PI
> (protection information) and data to an appropriate memory region for
> future registration.
> The given MR must be allocated as IB_MR_TYPE_INTEGRITY.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Except for a similar nit as for the last patch:

Reviewed-by: Christoph Hellwig <hch@lst.de>
