Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BCD1B2598
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2020 14:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDUMKA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Apr 2020 08:10:00 -0400
Received: from verein.lst.de ([213.95.11.211]:46318 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUMKA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Apr 2020 08:10:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6E6EE68C4E; Tue, 21 Apr 2020 14:09:57 +0200 (CEST)
Date:   Tue, 21 Apr 2020 14:09:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
        linux-rdma@vger.kernel.org, idanb@mellanox.com, axboe@kernel.dk,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
Subject: Re: [PATCH 04/17] nvme: introduce max_integrity_segments ctrl
 attribute
Message-ID: <20200421120957.GE26432@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com> <20200327171545.98970-6-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200327171545.98970-6-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 27, 2020 at 08:15:32PM +0300, Max Gurtovoy wrote:
> +	/*
> +	 * NVMe PCI driver doesn't support Extended LBA format and supports
> +	 * only a single integrity segment for a separate contiguous buffer
> +	 * of metadata.
> +	 */

That isn't strictly true, PCIe can also support SGLs for metadata.

I'd rather ѕay something like:

	/*
	 * We do not support an SGL for metadata (yet), so we are limited
	 * to a single integrity segment for the separate metadata pointer.
	 */

Except for that this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
