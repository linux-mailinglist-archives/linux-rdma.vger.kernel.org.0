Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08455261D9E
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Sep 2020 21:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbgIHTji (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Sep 2020 15:39:38 -0400
Received: from verein.lst.de ([213.95.11.211]:53199 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730929AbgIHPy7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Sep 2020 11:54:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6E65568BFE; Tue,  8 Sep 2020 17:54:09 +0200 (CEST)
Date:   Tue, 8 Sep 2020 17:54:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Maor Gottlieb <maorg@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 3/4] lib/scatterlist: Add support in dynamic
 allocation of SG table from pages
Message-ID: <20200908155409.GB13593@lst.de>
References: <20200903121853.1145976-1-leon@kernel.org> <20200903121853.1145976-4-leon@kernel.org> <20200907072921.GC19875@lst.de> <15552707-c9ae-b76b-f6ff-7fedd5b02aed@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15552707-c9ae-b76b-f6ff-7fedd5b02aed@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 07, 2020 at 03:44:08PM +0300, Maor Gottlieb wrote:
>>> +{
>>> +#ifdef CONFIG_ARCH_NO_SG_CHAIN
>>> +	if (append->left_pages)
>>> +		return ERR_PTR(-EOPNOTSUPP);
>>> +#endif
>> Which makes this API entirely useless for !CONFIG_ARCH_NO_SG_CHAIN,
>> doesn't it?  Wouldn't it make more sense to not provide it for that
>> case and add an explicitl dependency in the callers?
>
> Current implementation allow us to support small memory registration which 
> not require chaining. I am not aware which archs has the SG_CHAIN support 
> and I don't want to break it so I can't add it to as dependency to the 
> Kconfig. Another option is to do the logic in the caller, but it isn't 
> clean.

But does the caller handle the -EOPNOTSUPP properly?  I think right now
it will just fail the large registration that worked before this patchset.

Given that ARCH_NO_SG_CHAIN is only true for alpha, parisc and a few
arm subarchitectures I think just not supporting umem is probably
cleared.  And eventually we'll need to drop ARCH_NO_SG_CHAIN entirely.
