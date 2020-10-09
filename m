Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96664288F3F
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 18:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389899AbgJIQ4t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 12:56:49 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:35837 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389334AbgJIQ4t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 12:56:49 -0400
X-Greylist: delayed 994 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Oct 2020 12:56:49 EDT
Received: from localhost ([10.193.186.242])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 099Ge6QS030157;
        Fri, 9 Oct 2020 09:40:07 -0700
Date:   Fri, 9 Oct 2020 22:10:06 +0530
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH 01/11] RDMA/cxgb4: Remove MW support
Message-ID: <20201009164004.GA20779@chelsio.com>
References: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
 <1-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
 <20201005055652.GE9764@unreal>
 <20201005161726.GX816047@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005161726.GX816047@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Monday, October 10/05/20, 2020 at 21:47:26 +0530, Jason Gunthorpe wrote:
> On Mon, Oct 05, 2020 at 08:56:52AM +0300, Leon Romanovsky wrote:
> 
> > > -	mhp->rhp = rhp;
> > > -	mhp->attr.pdid = php->pdid;
> > > -	mhp->attr.type = FW_RI_STAG_MW;
> > 
> > 75% of "enum fw_ri_stag_type" can be removed too.
> 
> I think that is the code-gen'd HW API for this driver, I don't mind
> leaving it. It seems the HW supports MW, just nobody plumbed it
> through to rdma-core
> 
Hi Jason,
Agreed its dead code as is but Chelsio HW suports MW and we are yet to decide on
requirements, we may probably add userspace support for MW in future.

Thanks,
Bharat
