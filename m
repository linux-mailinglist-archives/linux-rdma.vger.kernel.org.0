Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE362F67E6
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jan 2021 18:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbhANRho (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jan 2021 12:37:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbhANRho (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Jan 2021 12:37:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D80FE23B40;
        Thu, 14 Jan 2021 17:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610645823;
        bh=BPWuYd+SE+x3vFVizmZN5aSKVhnP0BCCFuXjgdtDn9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f9KNLSXFbUD0bvYhkC05k4Su+D5SCDsx4dyrLgzXqRajVIh++zba34PxQY3Vm1LXr
         SaixOYAGJZuzHfO8LM5PUW1Rppdo6LRxZBlMG3xJpNYbiIFk/7z7Y0oaItZ8in7Qrd
         0olkbY63z1GY2KSXSaPAEvPNa9J8DBTdXmewbWy78LulmOkmnG2O40rLzPRhHJklLG
         Yhq4gKwHVr7FGCDG+hr5UgpQ4VJsfYwsHbDssFoSgID4vQsN/GOtWcWdBhOFha7J8m
         ybyLk6iwZruho2gkbHsS5sVSQJg8NE4ZwMwDFzScC1FxNV5xsG3bmIuHvxKPbILLBU
         eP1EDTe/wf4/Q==
Date:   Thu, 14 Jan 2021 19:36:59 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Mark Bloch <mbloch@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH rdma-next 0/5] Set of fixes
Message-ID: <20210114173659.GF944463@unreal>
References: <20210113121703.559778-1-leon@kernel.org>
 <20210114170411.GA316809@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114170411.GA316809@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 14, 2021 at 01:04:11PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 13, 2021 at 02:16:58PM +0200, Leon Romanovsky wrote:
>
> >   RDMA/umem: Avoid undefined behavior of rounddown_pow_of_two
> >   RDMA/mlx5: Fix wrong free of blue flame register on error
> >   IB/mlx5: Fix error unwinding when set_has_smi_cap fails
>
> I took these ones to for-rc

It is your call, personally, I'm sending two types of patches to -rc:
crashes and "new bugs".

Thanks

>
> Thanks,
> Jason
