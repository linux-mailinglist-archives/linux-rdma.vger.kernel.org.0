Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C13D634CF
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 13:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfGILRk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 07:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfGILRk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 9 Jul 2019 07:17:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFBE22082A;
        Tue,  9 Jul 2019 11:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562671059;
        bh=DJ74fwGLtV8C8xuECfnoLYhmXuGJU8f3DjdzbcHXtS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/RfQ6JA9EZ5R4LqZu+FJVmuVqCz+wzEngnKU4+qrUM6r5bP01NTL51juRovdwizE
         +sL01SAUJ1g915qT1RK2/9WPcNL2+vrh22o9o6O3GerhsEGd1j18XosAfAeVjOYtD9
         caeDNdG/WtqiF2yTsW+xAWD0jcyaLI/2Wl2KRTns=
Date:   Tue, 9 Jul 2019 13:17:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, axboe@kernel.dk,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>, bvanassche@acm.org,
        jgg@mellanox.com, dledford@redhat.com,
        Roman Pen <r.peniaev@gmail.com>
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
Message-ID: <20190709111737.GB6719@kroah.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <20190709110036.GQ7034@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709110036.GQ7034@mtr-leonro.mtl.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 09, 2019 at 02:00:36PM +0300, Leon Romanovsky wrote:
> On Tue, Jul 09, 2019 at 11:55:03AM +0200, Danil Kipnis wrote:
> > Hallo Doug, Hallo Jason, Hallo Jens, Hallo Greg,
> >
> > Could you please provide some feedback to the IBNBD driver and the
> > IBTRS library?
> > So far we addressed all the requests provided by the community and
> > continue to maintain our code up-to-date with the upstream kernel
> > while having an extra compatibility layer for older kernels in our
> > out-of-tree repository.
> > I understand that SRP and NVMEoF which are in the kernel already do
> > provide equivalent functionality for the majority of the use cases.
> > IBNBD on the other hand is showing higher performance and more
> > importantly includes the IBTRS - a general purpose library to
> > establish connections and transport BIO-like read/write sg-lists over
> > RDMA, while SRP is targeting SCSI and NVMEoF is addressing NVME. While
> > I believe IBNBD does meet the kernel coding standards, it doesn't have
> > a lot of users, while SRP and NVMEoF are widely accepted. Do you think
> > it would make sense for us to rework our patchset and try pushing it
> > for staging tree first, so that we can proof IBNBD is well maintained,
> > beneficial for the eco-system, find a proper location for it within
> > block/rdma subsystems? This would make it easier for people to try it
> > out and would also be a huge step for us in terms of maintenance
> > effort.
> > The names IBNBD and IBTRS are in fact misleading. IBTRS sits on top of
> > RDMA and is not bound to IB (We will evaluate IBTRS with ROCE in the
> > near future). Do you think it would make sense to rename the driver to
> > RNBD/RTRS?
> 
> It is better to avoid "staging" tree, because it will lack attention of
> relevant people and your efforts will be lost once you will try to move
> out of staging. We are all remembering Lustre and don't want to see it
> again.

That's up to the developers, that had nothing to do with the fact that
the code was in the staging tree.  If the Lustre developers had actually
done the requested work, it would have moved out of the staging tree.

So if these developers are willing to do the work to get something out
of staging, and into the "real" part of the kernel, I will gladly take
it.

But I will note that it is almost always easier to just do the work
ahead of time, and merge it in "correctly" than to go from staging into
the real part of the kernel.  But it's up to the developers what they
want to do.

thanks,

greg k-h
