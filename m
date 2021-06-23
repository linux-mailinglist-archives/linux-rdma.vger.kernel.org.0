Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96E03B1352
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 07:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhFWFqJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 01:46:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhFWFqJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Jun 2021 01:46:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A911B60249;
        Wed, 23 Jun 2021 05:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624427032;
        bh=H86L4FqvypLHylh0ieRPnijSg97s3Un/DXQiGKX0ctA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ULRPRpaU4hKKPdHVb6J8WRCM+lLcOFAgzLeQyjXddks+ybMyKqHg8heiZz+JPYNFN
         36ojXBnQ1V/jtIFJRmjFUcQ0ozc3N51I6qaYzw63/xlXQkaMoeENsnbKSLQASwTVnf
         +lnhhH9S5rUEOK6NXG6XzzxGtLX5SVfV6T+LB1siKKHN7C+xgWU47hO0rB1CVchO0t
         6LEbIwLJWqDjqPthClYopo0laiYXSOHoeFMMXlGzzJT/g0LQTiU//TQHfaQm8CheBn
         g/9owqeLpY80kosTtbG5ZjD30rZYOvO9O3YxbfLnOvnUsp9L0VfFmetGLmCWBshZ8P
         RN0i205wPD45Q==
Date:   Wed, 23 Jun 2021 08:43:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2] RDMA/cma: Remove unnecessary INIT->INIT
 transition
Message-ID: <YNLKE6lJ6Qxf+hHj@unreal>
References: <1623996475-23986-1-git-send-email-haakon.bugge@oracle.com>
 <YNLHixlGokuQOjmW@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNLHixlGokuQOjmW@unreal>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 23, 2021 at 08:32:59AM +0300, Leon Romanovsky wrote:
> On Fri, Jun 18, 2021 at 08:07:55AM +0200, Håkon Bugge wrote:
> > In rdma_create_qp(), a connected QP will be transitioned to the INIT
> > state.
> > 
> > Afterwards, the QP will be transitioned to the RTR state by the
> > cma_modify_qp_rtr() function. But this function starts by performing
> > an ib_modify_qp() to the INIT state again, before another
> > ib_modify_qp() is performed to transition the QP to the RTR state.
> > 
> > Hence, there is no need to transition the QP to the INIT state in
> > rdma_create_qp().
> > 
> > Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> > 
> > ---
> > 
> > 	v1 -> v2:
> > 	   * Fixed uninitialized ret variable as:
> > 	     Reported-by: kernel test robot <lkp@intel.com>
> > ---
> >  drivers/infiniband/core/cma.c | 17 +----------------
> >  1 file changed, 1 insertion(+), 16 deletions(-)
> > 
> 
> I reviewed v1, let's add this tag to v2 too.
> 
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

Ahh, you sent this patch as part of other series with same version :(.

Thanks
