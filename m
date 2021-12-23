Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC6F47E433
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Dec 2021 14:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbhLWNoh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Dec 2021 08:44:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60364 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348682AbhLWNoh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Dec 2021 08:44:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFA09B820E0
        for <linux-rdma@vger.kernel.org>; Thu, 23 Dec 2021 13:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F078C36AE9;
        Thu, 23 Dec 2021 13:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640267074;
        bh=WSLag79565Lc+mj7l8Gd9zh99O5VQNLLyKv+efNo0G8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bR4mGf0rXOB4o4jUbjAfnvwFWU3AlhSTBriw6KYS7TISOc6QEaF+LLLZYd7a2KmdU
         UTJMrDcZ15Yu01hMoaa/fqRgtBLQS/Vx7kF2HtXTgSCruXuo+dxQyF4+LsQXsmHOLa
         jGX+lbMM9WYPOFj8fM/VctiE2VVl/9Wq5Bwb9mwFiXzyNLfkP00xxSBLwdIgctrr3A
         /Lsj9vhShr08DtcLg5vXMHWb5B+MMqjtQT6R+whMQWSx2xOVe6xLjTkSR2viGLaypF
         5hZdnOSuCyaE6skUTomRpMHxZiaVDJXDxixkbZru0ufoBV9+d7vGnyW55xPyoYBgQg
         PQcJyOevfuwgw==
Date:   Thu, 23 Dec 2021 15:44:29 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-next 00/11] Elastic RDMA Adapter (ERDMA) driver
Message-ID: <YcR9PVDS2jFsrJ4N@unreal>
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
 <YcHSBnKHmR9sb6KR@unreal>
 <b45d0472-06d2-0541-13a2-c64ef6f189f0@linux.alibaba.com>
 <YcROKB5N7Kr1XhaN@unreal>
 <9496ca18-760c-f90e-8735-f7fb2982e7a4@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9496ca18-760c-f90e-8735-f7fb2982e7a4@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 23, 2021 at 08:59:14PM +0800, Cheng Xu wrote:
> 
> 
> On 12/23/21 6:23 PM, Leon Romanovsky wrote:
> > On Wed, Dec 22, 2021 at 11:35:44AM +0800, Cheng Xu wrote:
> > > 
> > 
> > <...>
> > 
> > > > > 
> > > > > For the ECS instance with RDMA enabled, there are two kinds of devices
> > > > > allocated, one for ERDMA, and one for the original netdev (virtio-net).
> > > > > They are different PCI deivces. ERDMA driver can get the information about
> > > > > which netdev attached to in its PCIe barspace (by MAC address matching).
> > > > 
> > > > This is very questionable. The netdev part should be kept in the
> > > > drivers/ethernet/... part of the kernel.
> > > > 
> > > > Thanks
> > > 
> > > The net device used in Alibaba ECS instance is virtio-net device, driven
> > > by virtio-pci/virtio-net drivers. ERDMA device does not need its own net
> > > device, and will be attached to an existed virtio-net device. The
> > > relationship between ibdev and netdev in erdma is similar to siw/rxe.
> > 
> > siw/rxe binds through RDMA_NLDEV_CMD_NEWLINK netlink command and not
> > through MAC's matching.
> > 
> > Thanks
> 
> Both siw/rxe/erdma don't need to implement netdev part, this is what I
> wanted to express when I said 'similar'.
> What you mentioned (the bind mechanism) is one major difference between
> erdma and siw/rxe. For siw/rxe, user can attach ibdev to every netdev if
> he/she wants, but it is not true for erdma. When user buys the erdma
> service, he/she must specify which ENI (elastic network interface) to be
> binded, it means that the attached erdma device can only be binded to
> the specific netdev. Due to the uniqueness of MAC address in our ECS
> instance, we use the MAC address as the identification, then the driver
> knows which netdev should be binded to.

Nothing prohibits from you to implement this MAC check in RDMA_NLDEV_CMD_NEWLINK.
I personally don't like the idea that bind logic is performed "magically".

BTW,
1. No module parameters
2. No driver versions

Thanks

> 
> Thanks,
> Cheng Xu
