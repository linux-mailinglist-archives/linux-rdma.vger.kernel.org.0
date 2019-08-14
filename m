Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C11128DD81
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2019 20:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfHNSrz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Aug 2019 14:47:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbfHNSrz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:55 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B077A21852;
        Wed, 14 Aug 2019 18:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808474;
        bh=qT6C41zyIpgCeeEJQ0UMfQkqKkaO2CBC1pNR9obRCl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vBb7fk+O4s+qgQeVXg7UaHoVJaN7y/oiI8OvsIPshLYBA8hcxz+BzTUpQ2UxIVtAd
         d4GSePj62gxiNv0eTFaoq0UykMzrrUtAjK8aq2SrUW4CrGmfLauH421zwkvOXYxdlr
         1ucQ7TXmGElxL1546YAB3nkko7nK3KPiau7nbhu4=
Date:   Wed, 14 Aug 2019 21:47:37 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Yangyang Li <liyangyang20@huawei.com>,
        Lijun Ou <oulijun@huawei.com>, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 3/9] RDMA/hns: Completely release qp resources
 when hw err
Message-ID: <20190814184737.GB5893@mtr-leonro.mtl.com>
References: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
 <1565343666-73193-4-git-send-email-oulijun@huawei.com>
 <f49c56933205d90d82ffd3fa55a951843e22cda1.camel@redhat.com>
 <0d325f78-a929-f088-cc29-e2c7af98fd40@huawei.com>
 <f1609a31d9b0d1cdc3b2db38dda1543126755007.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1609a31d9b0d1cdc3b2db38dda1543126755007.camel@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 14, 2019 at 11:05:04AM -0400, Doug Ledford wrote:
> On Wed, 2019-08-14 at 14:02 +0800, Yangyang Li wrote:
> > > I don't know your hardware, but this patch sounds wrong/dangerous to
> > > me.
> > > As long as the resources this card might access are allocated by the
> > > kernel, you can't get random data corruption by the card writing to
> > > memory used elsewhere in the kernel.  So if your card is not
> > > responding
> > > to your requests to free the resources, it would seem safer to leak
> > > those resources permanently than to free them and risk the card
> > > coming
> > > back to life long enough to corrupt memory reallocated to some other
> > > task.
> > >
> > > Only if you can guarantee me that there is no way your commands to
> > > the
> > > card will fail and then the card start working again later would I
> > > consider this patch safe.  And if it's possible for the card to hang
> > > like this, should that be triggering a reset of the device?
> > >
> >
> > Thanks for your suggestion, I agree with you, it would seem safer to
> > leak
> > those resources permanently than to free them. I will abandon this
> > change
> > and consider cleaning up these leaked resources during uninstallation
> > or reset.
>
> Ok, patch dropped from patchworks, thanks.

Sorry for being late, but I don't like the idea of having leaked memory.

All my allocation patches are actually trying to avoid such situation
by ensuring that no driver does crazy stuff like this. It means that
once I'll have time to work on QP allocations, I'll ensure that memory
is freed, so it is better to free such memory now.

Thanks

>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD


