Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CA5367A1F
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 08:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhDVGrO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 02:47:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230232AbhDVGrN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Apr 2021 02:47:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8AE061403;
        Thu, 22 Apr 2021 06:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619073999;
        bh=dI56d7BwB9K8LGCgL4mhGUBc4TvQLo2AAQL4AOWK4Yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YRaxe6eexff4KGcI1VqJ028vaXHFxsRozgaSsn8hRyquePa9qRcAOb+ZYVQJ3t+zR
         llhIe3oiICtm0NH+5GhydjuU4NfybJCWnljw0IL1Tz1gkOhWaUli74EPDbvTCSluZC
         g/S1p5YXkHBxiNP1t5gFeUsihxic4q0/cJ1PDVjEjbFSFWoQ5HzhuPg0BcQOhbv8Nw
         1eGShJxw4G8Omcnrk5AZ/kcjNFMdGxmSWcN/OGKD7QvrYPR6YtWTcN/UDSI8WnYYWP
         fJUwh57SARfazNZgMzOmSxFq1NwO01YuW6W78BGe6XpaazfuOs21+Ij4paP/+MzIPe
         Wf1WrpaaGhBHw==
Date:   Thu, 22 Apr 2021 09:46:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Krishna Kumar <krkumar2@in.ibm.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Parav Pandit <parav@nvidia.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH rdma-next 0/3] CMA fixes
Message-ID: <YIEby1qCrM4nQ9d4@unreal>
References: <cover.1618753862.git.leonro@nvidia.com>
 <20210421235909.GA2329448@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421235909.GA2329448@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 21, 2021 at 08:59:09PM -0300, Jason Gunthorpe wrote:
> On Sun, Apr 18, 2021 at 04:55:51PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Another round of fixes to cma.c
> > 
> > Parav Pandit (1):
> >   RDMA/cma: Skip device which doesn't support CM
> > 
> > Shay Drory (2):
> >   RDMA/core: Add CM to restrack after successful attachment to a device
> 
> These two applied to for-next
> 
> >   RDMA/core: Fix check of device in rdma_listen()
> 
> Lets think about this one some more

Sure, thanks

> 
> Thanks,
> Jason
