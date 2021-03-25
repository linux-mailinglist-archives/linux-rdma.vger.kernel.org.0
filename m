Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FD8348BBA
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 09:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbhCYIlA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 04:41:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229581AbhCYIkz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Mar 2021 04:40:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADD52619FC;
        Thu, 25 Mar 2021 08:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616661655;
        bh=W6ZybFOAgQAJmx9FjbEhu0V7ccfgvQNRbHmgV5J/52o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0LOs2ClUHIw3DtX25d5fy9K84eTd/an6Tf8SnGiyB+znSW1lzhXOCs5YNp9FcizJ
         yMngpaLZYhSMqayc+8Dcg7DddKwESntxsOarssmO6/s7TfSIJwn98UIlGs7RC3pN4j
         b9J378MGNBxwUnp5djS2UFKZrfWhZk9Y+gaRU5XGCxF5ENwfvmttwCBDMV80TKZZhw
         h8bK1bZYODRVnEvPkGyV5CfH89J7YYHs2QCE61dOiD4w79o/AT0L91ISO5vTKzK7dC
         Rm6BwJPb41Q9QB+g6lWPigQpDcYxw55EyBGJFUjQWzzEesJSeojZn9x7V6bw42LINF
         dOFk5Y9v3S8pA==
Date:   Thu, 25 Mar 2021 10:40:51 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: Re: [PATCH rdma-next] bnxt_re: Rely on Kconfig to keep module
 dependency
Message-ID: <YFxMkxtpOMLY3/d3@unreal>
References: <20210324142524.1135319-1-leon@kernel.org>
 <20210324150759.GH2356281@nvidia.com>
 <YFtXw+w7MZFynam0@unreal>
 <CANjDDBjKbDkbwnWV=kk8m2J_NdwjOir0Uoj2xahwEMVDfu-5CQ@mail.gmail.com>
 <20210324165648.GL2356281@nvidia.com>
 <CANjDDBh_H1jqQxBJFgu-uO2AmWe4-3Qiuos93vxMPxHOx8md+w@mail.gmail.com>
 <20210324173556.GO2356281@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324173556.GO2356281@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 24, 2021 at 02:35:56PM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 24, 2021 at 10:54:58PM +0530, Devesh Sharma wrote:
> > On Wed, Mar 24, 2021 at 10:26 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Wed, Mar 24, 2021 at 10:00:05PM +0530, Devesh Sharma wrote:
> > >
> > > > > > > -static void bnxt_re_dev_unprobe(struct net_device *netdev,
> > > > > > > -                           struct bnxt_en_dev *en_dev)
> > > > > > > -{
> > > > > > > -   dev_put(netdev);
> > > > > > > -   module_put(en_dev->pdev->driver->driver.owner);
> > > > > > > -}
> > > > > >
> > > > > > And you are right to be wondering WTF is this
> > > >
> > > > Still trying to understand but what's the big idea here may be I can help.
> > >
> > > A driver should not have module put things like the above
> > >
> > > It should not be accessing ->driver without holding the device_lock()
> > >
> > > Basically it is all nonsense coding, Leon suggests to delete it and he
> > > is probably right.
> > >
> > > Can you explain what it thinks it is doing?
> > That F'ed up  code is trying to prevent a situation where someone
> > tries to remove the bnxt_en driver while bnxt_re driver is using it.
> > All because bnxt_re driver is at the mercy of bnxt_en drive and there
> > is not symbole dependence, Do you suggest anything to prevent that
> > unload of bnxt_en other than doing this jargon.
> 
> Well, the module put says nothing about the validity of the 'struct
> bnxt' and related it extracted from the netdev - you should have a
> mechanism that prevents that from going invalid which in turn will
> ensure the function pointers you want to touch are still valid
> too. (as the struct containing function pointers must become invalid
> before the module unloads)
> 
> Probably the netdev refcount does that already but I always forget the
> exact point during unregister that it waits on that...
> 
> As far as strict module dependencies go, replace the pointless
> brp->ulp_probe function pointer with an actual call to
> bnxt_ulp_probe() and you get the same effect as the module_get.

Yeah, I'll update it.

Thanks

> 
> Jason
