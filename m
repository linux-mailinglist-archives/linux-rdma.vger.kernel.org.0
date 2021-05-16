Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5E5381E58
	for <lists+linux-rdma@lfdr.de>; Sun, 16 May 2021 12:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhEPK50 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 May 2021 06:57:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhEPK5Y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 16 May 2021 06:57:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBE4561155;
        Sun, 16 May 2021 10:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621162569;
        bh=wC3jQS1/zOk1SUF4jEt3dAvnBTJLZq7qkh/znkIllKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uhCK5snKjXI4YP+UQhl3Y7tO99RPBw72YaIYE1QEuDN5nOnhekdxvRBZ2JRiOouwg
         9NPxiB/WLPjkm+XJNFITTqRZ7TAczYoLZUbxgCEBwK/muAaMxLHgqFqs6Qhrp1rOTD
         us/KRL8HEzLn1/cTp8JPt+uhWwLy8N6zTS64UXSlX48gCi6dgmSaoOaaKa+D9WEc2W
         O0o9R3wF1XeOGI6PQwW/kotbTOWQeC6o3r/O/lozCLLj0tOcLFPnBVk7Bb/VEcptBi
         GSoRq906SK1RsmL08LEu5WjZkE5+yAIPJ4LF3mAZru6r/+0AwPwXlzXx3oUGTHHNm5
         4ASqYjcyKjB7Q==
Date:   Sun, 16 May 2021 13:56:05 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Message-ID: <YKD6ReulqPQNGScG@unreal>
References: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
 <f72bb31b-ea93-f3c9-607f-a696eac27344@cornelisnetworks.com>
 <YJp589JwbqGvljew@unreal>
 <BYAPR01MB3816C9521A96A8BA773CF613F2529@BYAPR01MB3816.prod.exchangelabs.com>
 <YJvPDbV0VpFShidZ@unreal>
 <7e7c411b-572b-6080-e991-deb324e3d0e2@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e7c411b-572b-6080-e991-deb324e3d0e2@cornelisnetworks.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 13, 2021 at 03:03:43PM -0400, Dennis Dalessandro wrote:
> On 5/12/21 8:50 AM, Leon Romanovsky wrote:
> > On Wed, May 12, 2021 at 12:25:15PM +0000, Marciniszyn, Mike wrote:
> > > > > Thanks Leon, we'll get this put through our testing.
> > > > 
> > > > Thanks a lot.
> > > > 
> > > > > 
> > > 
> > > The patch as is passed all our functional testing.
> > 
> > Thanks Mike,
> > 
> > Can I ask you to perform a performance comparison between this patch and
> > the following?
> 
> We have years of performance data with the code the way it is. Please
> maintain the original functionality of the code when moving things into the
> core unless there is a compelling reason to change. That is not the case
> here.

Sorry for not being responsive.

In addition to already said in parallel thread, this change keeps the
functionality except static node. I'm curious to finally see the difference
between these two allocations and it is very unlilkely we will see any.

For example, this QP can be associated with application that runs on
different node than rdi->dparms.node. Will we see performance degradation?

Thanks
