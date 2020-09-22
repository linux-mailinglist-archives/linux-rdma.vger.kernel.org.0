Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266C5273AEC
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 08:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgIVGc2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 02:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbgIVGc2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Sep 2020 02:32:28 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5A00239A1;
        Tue, 22 Sep 2020 06:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600756348;
        bh=sN7xC0zyd68lzwYrNnRcPOFgr9cqJbDFw9Q7tNAViRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q+RL/PVSQrYKfCvuIMs/o6qEHu5iS+xoENGQundsKMv68sqPvuB2LnQKIDerQAVt+
         79eu/4TwAKBCaKI1JbkiTh4+C59bLWBl5PLWDM2IsTvYt+32RhH18r9HdCrFno1pYg
         L8PI90lh/Opg+J4HSfVVkV7lYxXIqBveeOvc2ae0=
Date:   Tue, 22 Sep 2020 09:32:24 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 1/2] lib/scatterlist: Add support in dynamic
 allocation of SG table from pages
Message-ID: <20200922063224.GE1223944@unreal>
References: <20200916140726.839377-1-leon@kernel.org>
 <20200916140726.839377-2-leon@kernel.org>
 <20200921075725.GA19394@lst.de>
 <20200921091813.GA1223944@unreal>
 <20200922062452.GA30956@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922062452.GA30956@lst.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 22, 2020 at 08:24:52AM +0200, Christoph Hellwig wrote:
> On Mon, Sep 21, 2020 at 12:18:13PM +0300, Leon Romanovsky wrote:
> > On Mon, Sep 21, 2020 at 09:57:25AM +0200, Christoph Hellwig wrote:
> > > I'm still not really sold on the explosion of specific sgl APIs, so
> > > I ended up implementing my original suggestion to reuse
> > > __sg_alloc_table_from_pages and just pass two additional parameters.
> > > I also ended up moving the memset out of __sg_alloc_table into its
> > > two callers, and I think the result looks much better, what do you
> > > think?
> >
> > I think that the API call is really hard to grasp now with too many
> > arguments. Fun part will start when someone will decide to use this API
> > without some (expected for now) parameters.
>
> It has the same number of parameters as before, we just switch three
> more callers to the tons of arguments function instead of keeping the
> old one with two less arguments around.

No problem, we tested it overnight and I'll send v3 today.

Thanks
