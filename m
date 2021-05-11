Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4A337A6CF
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 14:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhEKMgL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 08:36:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231633AbhEKMgK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 08:36:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CED2061628;
        Tue, 11 May 2021 12:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620736503;
        bh=42NHG5ZV5WD36khbUkUkpaEMxMuvPi6Ex8nEUKHZbpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EwdgI1JJgIRrBWfqQYYWaAFzM3riRLH1/n8syhNu5zkv2k69OdKwOq6WRX0x3AHjs
         EVQQPvohYkQO7wnpIDUFhSXmPQ9rf+wadiL6yz1trNP8/ZfHFPZlGBkbjbvsRDsEg4
         EIAsj1AQLE0GKC+IfEM+gZBORODGVubWxE5ySIP6w3DWc1HyuSqjy9UPgr0GmUfY8R
         xAkTihct4xNkqXErqt7IrgxGv9iWBr1YfPE02LauwAyXXK7IQheiFgcgGeKRDPsGcn
         B0oGCqDvhOPxAoS0oCnLKtdUcox4/OohKAmAfsxUZaDzKe1ODiAQMUs4r7KHO3HM2E
         W2PJ9NTaudTEg==
Date:   Tue, 11 May 2021 15:34:59 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Message-ID: <YJp589JwbqGvljew@unreal>
References: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
 <f72bb31b-ea93-f3c9-607f-a696eac27344@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f72bb31b-ea93-f3c9-607f-a696eac27344@cornelisnetworks.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 11, 2021 at 08:26:43AM -0400, Dennis Dalessandro wrote:
> On 5/11/21 6:36 AM, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > The rdmavt QP has fields that are both needed for the control and data
> > path. Such mixed declaration caused to the very specific allocation flow
> > with kzalloc_node and SGE list embedded into the struct rvt_qp.
> > 
> > This patch separates QP creation to two: regular memory allocation for
> > the control path and specific code for the SGE list, while the access to
> > the later is performed through derefenced pointer.
> > 
> > Such pointer and its context are expected to be in the cache, so
> > performance difference is expected to be negligible, if any exists.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> > Hi,
> > 
> > This change is needed to convert QP to core allocation scheme. In that
> > scheme QP is allocated outside of the driver and size of such allocation
> > is constant and can be calculated at the compile time.
> 
> Thanks Leon, we'll get this put through our testing.

Thanks a lot.

> 
> -Denny
