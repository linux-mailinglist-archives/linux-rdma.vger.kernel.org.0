Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43404273AD1
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 08:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgIVGYz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 02:24:55 -0400
Received: from verein.lst.de ([213.95.11.211]:43283 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728136AbgIVGYz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Sep 2020 02:24:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CDF0A6736F; Tue, 22 Sep 2020 08:24:52 +0200 (CEST)
Date:   Tue, 22 Sep 2020 08:24:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 1/2] lib/scatterlist: Add support in
 dynamic allocation of SG table from pages
Message-ID: <20200922062452.GA30956@lst.de>
References: <20200916140726.839377-1-leon@kernel.org> <20200916140726.839377-2-leon@kernel.org> <20200921075725.GA19394@lst.de> <20200921091813.GA1223944@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921091813.GA1223944@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 21, 2020 at 12:18:13PM +0300, Leon Romanovsky wrote:
> On Mon, Sep 21, 2020 at 09:57:25AM +0200, Christoph Hellwig wrote:
> > I'm still not really sold on the explosion of specific sgl APIs, so
> > I ended up implementing my original suggestion to reuse
> > __sg_alloc_table_from_pages and just pass two additional parameters.
> > I also ended up moving the memset out of __sg_alloc_table into its
> > two callers, and I think the result looks much better, what do you
> > think?
> 
> I think that the API call is really hard to grasp now with too many
> arguments. Fun part will start when someone will decide to use this API
> without some (expected for now) parameters.

It has the same number of parameters as before, we just switch three
more callers to the tons of arguments function instead of keeping the
old one with two less arguments around.
