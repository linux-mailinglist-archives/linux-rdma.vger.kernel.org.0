Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D48238889C
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 09:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243341AbhESHvr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 03:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243370AbhESHvp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 03:51:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA7376135B;
        Wed, 19 May 2021 07:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621410626;
        bh=cJyYNFSyYN5r62klP/f+ZfY2a5qEQmGVQUMfHjx7h+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fb384pLVEr92JBexh5zPTyfCSDi8DRNNvdXBekoUMPlus7X/hYbZQiyKHNeEabO41
         e4t8yqPtZnTQJ8aWknVBCmovBFPoQnrTfhLq2DJbZY1e5xYB6HrToHeNK4KHYx22wu
         yzZUiFB7rVJjj+t+sXaYiLmyowsIWHvwo19HcumXRSyVWTae1JwcLqyS26tgrd9yDV
         fv5eS9zK0GfzG4Q1Wd2vtGdm7fhxfoCRetZawnKdaUOK/4/iaJ7gZrWAgYESzSgVwK
         tsZ6MzdNncHfKcNKVWz0GN4o3mZ6lXmRgHUPQRdN/VmC+wU7IEryyycy0ZlXsj4iyQ
         D1qtbeyctZJWA==
Date:   Wed, 19 May 2021 10:50:22 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Message-ID: <YKTDPm6j29jziSxT@unreal>
References: <BYAPR01MB3816C9521A96A8BA773CF613F2529@BYAPR01MB3816.prod.exchangelabs.com>
 <YJvPDbV0VpFShidZ@unreal>
 <7e7c411b-572b-6080-e991-deb324e3d0e2@cornelisnetworks.com>
 <20210513191551.GT1002214@nvidia.com>
 <4237ab8a-a851-ecdf-ec41-4e798a2da156@cornelisnetworks.com>
 <20210514130247.GA1002214@nvidia.com>
 <47acc7ec-a37f-fa20-ea67-b546c6050279@cornelisnetworks.com>
 <20210514143516.GG1002214@nvidia.com>
 <CH0PR01MB71533DE9DBEEAEC7C250F8F8F2509@CH0PR01MB7153.prod.exchangelabs.com>
 <20210514150237.GJ1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514150237.GJ1002214@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 14, 2021 at 12:02:37PM -0300, Jason Gunthorpe wrote:
> On Fri, May 14, 2021 at 03:00:37PM +0000, Marciniszyn, Mike wrote:
> > > The core stuff in ib_qp is not performance sensitive and has no obvious node
> > > affinity since it relates primarily to simple control stuff.
> > > 
> > 
> > The current rvt_qp "inherits" from ib_qp, so the fields in the
> > "control" stuff are performance critical especially for receive
> > processing and have historically live in the same allocation.
> 
> This is why I said "core stuff in ib_qp" if drivers are adding
> performance stuff to their own structs then that is the driver's
> responsibility to handle.

Can I learn from this response that node aware allocation is not needed,
and this patch can go as is.

Thanks
