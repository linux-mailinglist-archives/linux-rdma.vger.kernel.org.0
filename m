Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76733373FB9
	for <lists+linux-rdma@lfdr.de>; Wed,  5 May 2021 18:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbhEEQ1Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 May 2021 12:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234044AbhEEQ1W (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 May 2021 12:27:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3A146121F;
        Wed,  5 May 2021 16:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620231986;
        bh=+XVmn+qQ0hZ/pDYHrA4fm3voToW9efhwPKJClQ2Ns7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OT9gM4ATRF7EKC10IJ4fI+H7Hqsj1wvNtM7A7lBUYC/s8V341V0eUabPn2xPEMNRA
         drpNeXq16PcBGH+kQLUd4WwVtWlG4M5jviIBP6Je28TSOZM10RWhPUHstVOt/E9O8I
         f5Cgti962c5HE7yDC44oA4xy6LmGunCM/OWjN2Dg=
Date:   Wed, 5 May 2021 18:26:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@nvidia.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: CFI violation in drivers/infiniband/core/sysfs.c
Message-ID: <YJLHMLq9qd5R0CiQ@kroah.com>
References: <20210402195241.gahc5w25gezluw7p@archlinux-ax161>
 <202104021555.08B883C7@keescook>
 <20210403065559.5vebyyx2p5uej5nw@archlinux-ax161>
 <20210504202222.GB2047089@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504202222.GB2047089@ziepe.ca>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 04, 2021 at 05:22:22PM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 02, 2021 at 11:55:59PM -0700, Nathan Chancellor wrote:
> > > So, I think, the solution is below. This hasn't been runtime tested. It
> > > basically removes the ib_port callback prototype and leaves everything
> > > as kobject/attr. The callbacks then do their own container_of() calls.
> > 
> > Well that appear to be okay from a runtime perspective.
> 
> This giant thing should fix it, and some of the other stuff Greg observed:
> 
> https://github.com/jgunthorpe/linux/commits/rmda_sysfs_cleanup
> 
> It needs some testing before it gets posted

When you post it, can you cc: me?

thanks,

greg k-h
