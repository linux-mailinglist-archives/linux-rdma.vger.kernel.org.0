Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10F01E136D
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 19:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388627AbgEYRgJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 13:36:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388480AbgEYRgJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 May 2020 13:36:09 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 701D22073B;
        Mon, 25 May 2020 17:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590428169;
        bh=JsdB7XyIFAekaqqpn8j6tQ0uJSuW0E/TApXadmXe36M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I985rAB4KbEyJPoDzf44/9Qz9EwQjZscxulroD3fQZd79CUKep19UkK9s5gf13kWu
         gwrk6/rQz8NqKqQT5GkanPZwrbgQnKO6JBRE7bOX7FkVbQ9B3Bpv7Xy+2jjvm9Q/v2
         wwHVyBwEoVL7FjWzTQuGESN5GC4LD4y28u/bOF7I=
Date:   Mon, 25 May 2020 20:36:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Weihang Li <liweihang@huawei.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/9] RDMA/hns: Cleanups for 5.8
Message-ID: <20200525173604.GG10591@unreal>
References: <1589982799-28728-1-git-send-email-liweihang@huawei.com>
 <20200525171116.GA17025@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525171116.GA17025@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 25, 2020 at 02:11:16PM -0300, Jason Gunthorpe wrote:
> On Wed, May 20, 2020 at 09:53:10PM +0800, Weihang Li wrote:
> > These are some cleanups, include removing dead code, modifying
> > varibles/fields types, and optimizing some functions.
> >
> > Lang Cheng (3):
> >   RDMA/hns: Let software PI/CI grow naturally
> >   RDMA/hns: Add CQ flag instead of independent enable flag
> >   RDMA/hns: Optimize post and poll process
> >
> > Weihang Li (2):
> >   RDMA/hns: Change all page_shift to unsigned
> >   RDMA/hns: Change variables representing quantity to unsigned
> >
> > Xi Wang (3):
> >   RDMA/hns: Rename QP buffer related function
> >   RDMA/hns: Refactor the QP context filling process related to WQE
> >     buffer configure
> >   RDMA/hns: Optimize the usage of MTR
> >
> > Yangyang Li (1):
> >   RDMA/hns: Remove unused code about assert
>
> I'm going to take these anyhow, the field macros could be improved
> someday if someone wanted. Applied to for-next
>
> I have to say the patches coming lately from hns have been following
> the kernel style and protocols much better. I'm also having a much
> easier time understanding the commit message and what the patch is
> trying to do. Keep it up!

+1, I have same feeling.

Thanks

>
> Thanks,
> Jason
