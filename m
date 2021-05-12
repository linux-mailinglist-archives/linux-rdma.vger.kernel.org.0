Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DA537BCD7
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 14:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhELMve (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 08:51:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhELMve (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 May 2021 08:51:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89EFE613CA;
        Wed, 12 May 2021 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823826;
        bh=uGZN093G8UznNDfSiUvQMW1X6K1u4U9norEFO5yfBeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qY3xt5DM9nNrf/qzNYHSoEht97NuI/NL/B7mp1RgXdwLN323h6lINp63PXOM1ESqF
         3MI7HBDlJ3q/OMgjDp2fOWSX4gkDShnedRWL1fkC7VSmfXfD3QYpGpiPuzYYB8Yl5P
         qybPIx2OIxF7CpqutOGTqnMk2zYiP+mEeeEC7jno7Sdk6TBuzjh5vPf+JKK/ud3niX
         B7+MXNsbwvtxLyqiuE1i2qTpxHdzFrgfMAoD/PtEdB3PKj0RFsx7UVfQ1cwOY6pXid
         Zxh2AC9uLPqYA3lJbB2DmYO9n3O/DbU8KypLraFHaoNsfe6O2Da47pmtXOD2z2ZDEA
         1GvKgH2V0PL3Q==
Date:   Wed, 12 May 2021 15:50:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
Cc:     "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Message-ID: <YJvPDbV0VpFShidZ@unreal>
References: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
 <f72bb31b-ea93-f3c9-607f-a696eac27344@cornelisnetworks.com>
 <YJp589JwbqGvljew@unreal>
 <BYAPR01MB3816C9521A96A8BA773CF613F2529@BYAPR01MB3816.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR01MB3816C9521A96A8BA773CF613F2529@BYAPR01MB3816.prod.exchangelabs.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 12, 2021 at 12:25:15PM +0000, Marciniszyn, Mike wrote:
> > > Thanks Leon, we'll get this put through our testing.
> > 
> > Thanks a lot.
> > 
> > >
> 
> The patch as is passed all our functional testing.

Thanks Mike,

Can I ask you to perform a performance comparison between this patch and
the following?

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 4522071fc220..d0e0f7cbe17a 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1134,7 +1134,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
                } else if (init_attr->cap.max_recv_sge > 1)
                        sg_list_sz = sizeof(*qp->r_sg_list) *
                                (init_attr->cap.max_recv_sge - 1);
-               qp = kzalloc(sizeof(*qp), GFP_KERNEL);
+               qp = kzalloc_node(sizeof(*qp), GFP_KERNEL, rdi->dparms.node);
                if (!qp)
                        goto bail_swq;
                qp->r_sg_list =


Thanks

> 
> Mike
