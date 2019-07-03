Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3739D5D940
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 02:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfGCAjZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jul 2019 20:39:25 -0400
Received: from verein.lst.de ([213.95.11.211]:46641 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfGCAjZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Jul 2019 20:39:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1A7B468CEC; Wed,  3 Jul 2019 02:03:34 +0200 (CEST)
Date:   Wed, 3 Jul 2019 02:03:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Ralph Campbell <rcampbell@nvidia.com>,
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
Message-ID: <20190703000333.GA29316@lst.de>
References: <20190608001452.7922-1-rcampbell@nvidia.com> <20190702195317.GT31718@mellanox.com> <20190702224912.GA24043@lst.de> <20190702225911.GA11833@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702225911.GA11833@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 02, 2019 at 10:59:16PM +0000, Jason Gunthorpe wrote:
> > As this creates a somewhat hairy conflict for amdgpu, wouldn't it be
> > a better idea to wait a bit and apply it first thing for next merge
> > window?
> 
> My thinking is that AMD GPU already has a monster conflict from this:
> 
>  int hmm_range_register(struct hmm_range *range,
> -                      struct mm_struct *mm,
> +                      struct hmm_mirror *mirror,
>                        unsigned long start,
>                        unsigned long end,
>                        unsigned page_shift);

Well, that seems like a relatively easy to fix conflict, at least as
long as you have the mirror easily available.  The notifier change
on the other hand basically requires rewriting about two dozen lines
of code entirely.
