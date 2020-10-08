Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99572286EF1
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 09:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgJHHCz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 03:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgJHHCz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Oct 2020 03:02:55 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5094D217BA;
        Thu,  8 Oct 2020 07:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602140575;
        bh=90eHIIizkxdX1x4dde+tKCctVxWb1ysxQGsCoDqGFEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EG1DURmPoDW3HqTOWlEO++tVoLmuM8qyuJz/px4S7rDO2kr2GRpw7lQCbGKN/sn+l
         GFxZs+GvgNxgKHmSbkM3s3iejknBR12hsJHHQyi8X7lAa05SN5br4DA6vz6NGL/2Ci
         lDE+twm3JI31a50k0QXgrkoFb0Y9X9PAvH8fQazA=
Date:   Thu, 8 Oct 2020 10:02:51 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH-next 0/4] RDMA: sprintf to sysfs_emit conversions
Message-ID: <20201008070251.GH13580@unreal>
References: <cover.1602122879.git.joe@perches.com>
 <20201008054128.GD13580@unreal>
 <2279bdda913b31bdea68c23a9889e056c3947201.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2279bdda913b31bdea68c23a9889e056c3947201.camel@perches.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 07, 2020 at 10:52:15PM -0700, Joe Perches wrote:
> On Thu, 2020-10-08 at 08:41 +0300, Leon Romanovsky wrote:
> > On Wed, Oct 07, 2020 at 07:36:23PM -0700, Joe Perches wrote:
> > > A recent commit added a sysfs_emit and sysfs_emit_at to allow various
> > > sysfs show functions to ensure that the PAGE_SIZE buffer argument is
> > > never overrun and always NUL terminated.
> >
> > Unfortunately but the sysfs_emit commit is not in rdma-next tree yet.
>
> Likely it'll still apply fairly well when the sysfs_emit commit is...

Of course, we just can't take it yet and test it in automatic way like
we are doing now.

Thanks

>
>
