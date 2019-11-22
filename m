Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF6611066A2
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2019 07:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfKVGxG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Nov 2019 01:53:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbfKVGxG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 22 Nov 2019 01:53:06 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 857192070A;
        Fri, 22 Nov 2019 06:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574405586;
        bh=dXDJjy7W4XEdvH5XAIzxJtf5kv3bcDRtjU4yreyOKj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1GkL4cf/YLjkDmnBi8EMjwkasAE5e13Y005vcMtSgkfmTOMYZyDn3VTg36Irg/wk
         ShJ9UfJakZOF1J6w66P9J4imADXChMWtg6l/dPfn5hZA5sSS3Dc/sqr8oevRCVKpJa
         AjgLTmV0+ZpkSPOIEuIh6gW2aEE+UvNxPtoO7YPA=
Date:   Fri, 22 Nov 2019 08:53:03 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next v1 03/48] RDMA/ucma: Mask QPN to be 24 bits
 according to IBTA
Message-ID: <20191122065303.GB136476@unreal>
References: <20191121181313.129430-1-leon@kernel.org>
 <20191121181313.129430-4-leon@kernel.org>
 <20191121213824.GA13840@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121213824.GA13840@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 21, 2019 at 01:38:24PM -0800, Ira Weiny wrote:
> > diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> > index 0274e9b704be..57e68491a2fd 100644
> > --- a/drivers/infiniband/core/ucma.c
> > +++ b/drivers/infiniband/core/ucma.c
> > @@ -1045,7 +1045,7 @@ static void ucma_copy_conn_param(struct rdma_cm_id *id,
> >  	dst->retry_count = src->retry_count;
> >  	dst->rnr_retry_count = src->rnr_retry_count;
> >  	dst->srq = src->srq;
> > -	dst->qp_num = src->qp_num;
> > +	dst->qp_num = src->qp_num & 0xFFFFFF;
>
> Isn't src->qp_num coming from userspace?  Why not return -EINVAL in such a
> case?

I afraid that it will break userspace application, we had similar case
in uverbs, where we added WARN_ON() while masked PSN and got endless
amount of bug reports from our enterprise colleagues who didn't clear
memory above those 24bits and saw kernel splats.

Thanks

>
> Ira
>
