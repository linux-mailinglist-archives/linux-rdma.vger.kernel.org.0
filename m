Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13381B25AC
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2020 14:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgDUMNA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Apr 2020 08:13:00 -0400
Received: from verein.lst.de ([213.95.11.211]:46363 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgDUMNA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Apr 2020 08:13:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 666CE68C4E; Tue, 21 Apr 2020 14:12:57 +0200 (CEST)
Date:   Tue, 21 Apr 2020 14:12:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
        linux-rdma@vger.kernel.org, idanb@mellanox.com, axboe@kernel.dk,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
Subject: Re: [PATCH 06/17] nvme: introduce NVME_INLINE_MD_SG_CNT
Message-ID: <20200421121257.GG26432@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com> <20200327171545.98970-8-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327171545.98970-8-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 27, 2020 at 08:15:34PM +0300, Max Gurtovoy wrote:
> From: Israel Rukshin <israelr@mellanox.com>
> 
> SGL size of metadata is usually small. Thus, 1 inline sg should cover
> most cases. The macro will be used for pre-allocate a single SGL entry
> for metadata. The preallocation of small inline SGLs depends on SG_CHAIN
> capability so if the ARCH doesn't support SG_CHAIN, use the runtime
> allocation for the SGL. This patch is a preparation for adding metadata
> (T10-PI) over fabric support.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
