Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6A637BC55
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 14:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhELMOY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 08:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230357AbhELMOY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 May 2021 08:14:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A824D61370;
        Wed, 12 May 2021 12:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620821596;
        bh=CNvjw7v8rjpcXWdSZ4Lsgcr/y2sXPEjKb5c0PWs8Axg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CcY1AA9pn9Td0t+4RiKgd+c1vOg0shyOteuVyJtZF9W3SPHgYgUQo+GwmJOOms5JR
         WhKBISYoTuj5qH3bCnIAPX0hODuTnfvwV+SqzPKs4+VzKm0rc7bA3JFhb3FJDAJMeF
         WJLtL+gyXta2TmCOI7+0bH412kPDcdRWC0UwucHwh32S0OsgLHn2lQJ0atty5Fs4oF
         7Z2tNlU67UCwLIjwdefvYUrT+myXZ75BdUD/y3RdiMGz5sNxtehb+ehBHjVScJKlVl
         ysUjI4IjOith8sHlLNbFRv6paqOrPB7eQOSNASg5MgvsqNpQOOFxgy2QIYuXvvdMRB
         fZLX+DiavAqTw==
Date:   Wed, 12 May 2021 15:13:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Message-ID: <YJvGWPimIFbptgdC@unreal>
References: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
 <F62CF3D3-E605-4CBA-B171-5BB98594C658@oracle.com>
 <YJp50nw6JD3ptVDp@unreal>
 <BYAPR01MB3816D1F9DC81BBB1FA5DF293F2539@BYAPR01MB3816.prod.exchangelabs.com>
 <YJrasoIGHQCq7QBD@unreal>
 <6e45f8ca-59d3-354c-bddc-ad7ff449b58c@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e45f8ca-59d3-354c-bddc-ad7ff449b58c@cornelisnetworks.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 12, 2021 at 12:08:59AM -0400, Dennis Dalessandro wrote:
> 
> On 5/11/21 3:27 PM, Leon Romanovsky wrote:
> > On Tue, May 11, 2021 at 07:15:09PM +0000, Marciniszyn, Mike wrote:
> > > > > 
> > > > > Why not kzalloc_node() here?
> > > 
> > > I agree here.
> > > 
> > > Other allocations that have been promoted to the core have lost the node attribute in the allocation.
> > 
> > Did you notice any performance degradation?
> > 
> 
> So what's the motivation to change it from the way it was originally
> designed? It seems to me if the original implementation went to the trouble
> to allocate the memory on the local node, refactoring the code should
> respect that.

I have no problem to make rdma_zalloc_*() node aware, but would like to get
real performance justification. My assumption is that rdmavt use kzalloc_node
for the control plane based on some internal performance testing and we finally
can see the difference between kzalloc and kzalloc_node, am I right?

Is the claim of performance degradation backed by data?

The main reason (maybe I'm wrong here) is to avoid _node() allocators
because they increase chances of memory allocation failure due to not
doing fallback in case node memory is depleted.

Again, I'm suggesting to do plain kzalloc() for control part of QP.

Thanks

> 
> -Denny
