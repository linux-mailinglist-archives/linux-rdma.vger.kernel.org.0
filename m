Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3D016BB67
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2020 08:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgBYH6z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Feb 2020 02:58:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbgBYH6z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Feb 2020 02:58:55 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AF7D2082F;
        Tue, 25 Feb 2020 07:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582617534;
        bh=OmKHkYl8C/llMLJQsB6JfIdXFvStS9diXGI030bPh5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yrSRDGxVsVzEC11nLCpJ+A/UnBGYXefwRVTFk5D/r8Kb23YTerDMJxAubPVszlt0P
         V7cY2Q5mdZy6uI86iK4+VmH5UPRXOWGJEPzj+WuXVEF0J6lmXz4YQKEM849D92n/zp
         QelWnRaQrhRaTUrI3DR/355daOLvMXJ+JI4V+nn4=
Date:   Tue, 25 Feb 2020 09:58:51 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Parav Pandit <parav@mellanox.com>,
        Weihang Li <liweihang@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: Is anyone working on implementing LAG in ib core?
Message-ID: <20200225075851.GD5347@unreal>
References: <280d87d0-fbc0-0566-794b-f66cb4fadb63@huawei.com>
 <20200222234026.GO31668@ziepe.ca>
 <98482e8a-f2eb-5406-b679-0ceb946ac618@mellanox.com>
 <20200223094928.GB422704@unreal>
 <5db0d4f8-1893-33c2-fb25-e6012e0fc6d6@mellanox.com>
 <20200224105206.GA468372@unreal>
 <20200224182902.GS31668@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224182902.GS31668@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 24, 2020 at 02:29:02PM -0400, Jason Gunthorpe wrote:
> On Mon, Feb 24, 2020 at 12:52:06PM +0200, Leon Romanovsky wrote:
> > > Are you asking why bonding should be implemented as dedicated
> > > ulp/driver, and not as an extension by the vendor driver?
> >
> > No, I meant something different. You are proposing to combine IB
> > devices, while keeping netdev devices separated. I'm asking if it is
> > possible to combine netdev devices with already existing bond driver
> > and simply create new ib device with bond netdev as an underlying
> > provider.
>
> Isn't that basically what we do now in mlx5?

Yes, logically the same, the implementation of course should be
different by involving IB/core more than it is now.

>
> Logically the ib_device is attached to the bond, it uses the bond for
> IP addressing, etc.

Yes.

Thanks
