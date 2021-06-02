Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802F339892A
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 14:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhFBMSA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 08:18:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhFBMR6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Jun 2021 08:17:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95E6061168;
        Wed,  2 Jun 2021 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622636175;
        bh=V5ZVNSg6VrBxlRJfakhW8sRXrsgoOMu9QTiqmV0EpM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U5BQOKFTG5Gj3+Bo6Eoo68asasoK7acYLGLDysOhTY+8aHVw424AI8nFwHWCJLpPP
         kO4g5mMvwO+zu04/wOKP9Y+K+Cccmg2RFbn4p7UwXdnnzbK30IKgoqL/3g/8jm9L/j
         RvtOMHdQNgN/ebTQnPcfPvcK8ry3rTKdM5Zx3GjATpG2ISfoE5GceKUJxBHcFlRuNI
         VdcPU7at1QltZ8u+P9CKDuu47rPI1MzDhIsE1AX6FzM1zWyP2olrR5D+KPr6gp/890
         oJU1+t+BpjPjh7s+0bWInxFKeisMDRTOgIKnOTqXvrC+ACqnWAnUBxjuXJXYEgspZj
         j9YPOouTrJdrg==
Date:   Wed, 2 Jun 2021 15:16:11 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 2/2] RDMA/mlx5: Allow modifying Relaxed
 Ordering via fast registration
Message-ID: <YLd2i7LnWurwLWUs@unreal>
References: <cover.1621505111.git.leonro@nvidia.com>
 <9442b0de75f4ee029e7c306fce34b1f6f94a9e34.1621505111.git.leonro@nvidia.com>
 <20210526194906.GA3646419@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526194906.GA3646419@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 26, 2021 at 04:49:06PM -0300, Jason Gunthorpe wrote:
> On Thu, May 20, 2021 at 01:13:36PM +0300, Leon Romanovsky wrote:
> > From: Avihai Horon <avihaih@nvidia.com>
> > 
> > Relaxed Ordering is enabled by default for kernel ULPs, and is set
> > during MKey creation, yet it cannot be modified by them afterwards.
> > 
> > Allow modifying Relaxed Ordering via fast registration work request.
> > This is done by setting the relevant flags in the MKey context mask and
> > the Relaxed Ordering flags in the MKey context itself.
> > 
> > Only ConnectX-7 supports modifying Relaxed Ordering via fast
> > registration, and HCA capabilities indicate it. These capabilities are
> > checked, and if a fast registration work request tries to modify Relaxed
> > Ordering and the capabilities are not present, the work request will fail.
> 
>  
> > @@ -762,23 +786,33 @@ static void set_sig_mkey_segment(struct mlx5_mkey_seg *seg,
> >  	seg->len = cpu_to_be64(length);
> >  	seg->xlt_oct_size = cpu_to_be32(get_xlt_octo(size));
> >  	seg->bsfs_octo_size = cpu_to_be32(MLX5_MKEY_BSF_OCTO_SIZE);
> > +
> > +	if (!(access_flags & IB_ACCESS_DISABLE_RELAXED_ORDERING)) {
> > +		MLX5_SET(mkc, seg, relaxed_ordering_write,
> > +			 MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr));
> > +		MLX5_SET(mkc, seg, relaxed_ordering_read,
> > +			 MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr));
> > +	}
> >  }
> 
> I don't quite get this patch

This is premature optimization. We don't really need it.

Thanks
