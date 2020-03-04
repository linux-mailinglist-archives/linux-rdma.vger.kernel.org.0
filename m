Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E1117952D
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 17:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388379AbgCDQ1z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 11:27:55 -0500
Received: from verein.lst.de ([213.95.11.211]:55360 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387497AbgCDQ1z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 4 Mar 2020 11:27:55 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 19CA268C4E; Wed,  4 Mar 2020 17:27:53 +0100 (CET)
Date:   Wed, 4 Mar 2020 17:27:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH v2] nouveau/hmm: map pages after migration
Message-ID: <20200304162752.GB11616@lst.de>
References: <20200303010023.2983-1-rcampbell@nvidia.com> <20200303124229.GH26318@mellanox.com> <1f27ac9e-7ddf-6e4f-25ea-063ef6c78761@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f27ac9e-7ddf-6e4f-25ea-063ef6c78761@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 03, 2020 at 01:15:21PM -0800, Ralph Campbell wrote:
>>> +static inline struct nouveau_pfnmap_args *
>>> +nouveau_pfns_to_args(void *pfns)
>>
>> don't use static inline inside C files
>
> OK.
>
>>> +{
>>> +	struct nvif_vmm_pfnmap_v0 *p =
>>> +		container_of(pfns, struct nvif_vmm_pfnmap_v0, phys);
>>> +
>>> +	return container_of(p, struct nouveau_pfnmap_args, p);
>>
>> And this should just be
>>
>>     return container_of(pfns, struct nouveau_pfnmap_args, p.phys);
>
> Much simpler, thanks.

Btw, for the case where we just have an container_of wrapper I strongly
disagree with avoiding the inline - not inlining this would be stupid,
but unfortunately compilers often behave stupidly.  It also is a very
clear marker.

