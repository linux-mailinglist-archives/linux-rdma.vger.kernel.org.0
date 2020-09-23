Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3508427505F
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 07:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgIWFm4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 01:42:56 -0400
Received: from verein.lst.de ([213.95.11.211]:47245 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbgIWFmz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Sep 2020 01:42:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F67E67373; Wed, 23 Sep 2020 07:42:52 +0200 (CEST)
Date:   Wed, 23 Sep 2020 07:42:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>
Subject: Re: [PATCH rdma-next v3 1/2] lib/scatterlist: Add support in
 dynamic allocation of SG table from pages
Message-ID: <20200923054251.GA15249@lst.de>
References: <20200922083958.2150803-1-leon@kernel.org> <20200922083958.2150803-2-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922083958.2150803-2-leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 22, 2020 at 11:39:57AM +0300, Leon Romanovsky wrote:
> E.g. with the Infiniband driver that allocates a single page for hold
> the
> pages. For 1TB memory registration, the temporary buffer would consume
> only
> 4KB, instead of 2GB.

Formatting looks  little weird here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
