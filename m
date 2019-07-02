Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 953215DA83
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 03:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfGCBO2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jul 2019 21:14:28 -0400
Received: from verein.lst.de ([213.95.11.211]:46851 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfGCBOZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Jul 2019 21:14:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CAAB368BFE; Wed,  3 Jul 2019 00:49:12 +0200 (CEST)
Date:   Wed, 3 Jul 2019 00:49:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [RFC] mm/hmm: pass mmu_notifier_range to
 sync_cpu_device_pagetables
Message-ID: <20190702224912.GA24043@lst.de>
References: <20190608001452.7922-1-rcampbell@nvidia.com> <20190702195317.GT31718@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702195317.GT31718@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 02, 2019 at 07:53:23PM +0000, Jason Gunthorpe wrote:
> > I'm sending this out now since we are updating many of the HMM APIs
> > and I think it will be useful.
> 
> This make so much sense, I'd like to apply this in hmm.git, is there
> any objection?

As this creates a somewhat hairy conflict for amdgpu, wouldn't it be
a better idea to wait a bit and apply it first thing for next merge
window?
