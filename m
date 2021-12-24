Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4873F47F093
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Dec 2021 19:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344205AbhLXS0z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Dec 2021 13:26:55 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58382 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343993AbhLXS0y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Dec 2021 13:26:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BDA9620DF
        for <linux-rdma@vger.kernel.org>; Fri, 24 Dec 2021 18:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073DAC36AE5;
        Fri, 24 Dec 2021 18:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640370413;
        bh=UO5pk6v03d+13u/myxZbkYK5XkJPpIB++WayjkNPE3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sUHgNB50gVJWdzua57dMjjavPOlGpA9BHmtU+1NK0thJOC3knFBtzzqaTTjU86eaL
         Wf+qsTg/SbQoCYavO/24Va9ZmOtXt2m0dKAVKlK1Pv5ifLVjMsfc6bD2G9gVMialFu
         OY4X9UH6+SA+wLj5OE6Gv6EPpwqAE2sVQaIzbVM99xxbMn4W6Z/RSISNw2nJg/O+Vw
         rBqvGpjrKJGFqVhB8z34fyDDL2aCtX10p1fZad9se+7j2/srZBovpBKPYP+tw4P9Yn
         Z46QKNfrtyp02XwklNIw11iffKlQ8k4+7PEY6ukHBnfp4+0F/KBcLNn11doKklsWNk
         7y+6YqJ8bmDeA==
Date:   Fri, 24 Dec 2021 20:26:49 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-next 00/11] Elastic RDMA Adapter (ERDMA) driver
Message-ID: <YcYQ6WvZuh3hlVKN@unreal>
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
 <YcHSBnKHmR9sb6KR@unreal>
 <b45d0472-06d2-0541-13a2-c64ef6f189f0@linux.alibaba.com>
 <YcROKB5N7Kr1XhaN@unreal>
 <9496ca18-760c-f90e-8735-f7fb2982e7a4@linux.alibaba.com>
 <YcR9PVDS2jFsrJ4N@unreal>
 <bab9e1f4-21d5-efcc-f6b6-360f80725561@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bab9e1f4-21d5-efcc-f6b6-360f80725561@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 24, 2021 at 03:07:57PM +0800, Cheng Xu wrote:
> 
> 
> On 12/23/21 9:44 PM, Leon Romanovsky wrote:
> > On Thu, Dec 23, 2021 at 08:59:14PM +0800, Cheng Xu wrote:
> > > 
> > > 
> > > On 12/23/21 6:23 PM, Leon Romanovsky wrote:
> > > > On Wed, Dec 22, 2021 at 11:35:44AM +0800, Cheng Xu wrote:
> > > > > 
> > > > 
> > > > <...>
> > > > 
> > > > > > > 
> > > > > > > For the ECS instance with RDMA enabled, there are two kinds of devices
> > > > > > > allocated, one for ERDMA, and one for the original netdev (virtio-net).
> > > > > > > They are different PCI deivces. ERDMA driver can get the information about
> > > > > > > which netdev attached to in its PCIe barspace (by MAC address matching).
> > > > > > 
> > > > > > This is very questionable. The netdev part should be kept in the
> > > > > > drivers/ethernet/... part of the kernel.
> > > > > > 
> > > > > > Thanks
> > > > > 
> > > > > The net device used in Alibaba ECS instance is virtio-net device, driven
> > > > > by virtio-pci/virtio-net drivers. ERDMA device does not need its own net
> > > > > device, and will be attached to an existed virtio-net device. The
> > > > > relationship between ibdev and netdev in erdma is similar to siw/rxe.
> > > > 
> > > > siw/rxe binds through RDMA_NLDEV_CMD_NEWLINK netlink command and not
> > > > through MAC's matching.
> > > > 
> > > > Thanks
> > > 
> > > Both siw/rxe/erdma don't need to implement netdev part, this is what I
> > > wanted to express when I said 'similar'.
> > > What you mentioned (the bind mechanism) is one major difference between
> > > erdma and siw/rxe. For siw/rxe, user can attach ibdev to every netdev if
> > > he/she wants, but it is not true for erdma. When user buys the erdma
> > > service, he/she must specify which ENI (elastic network interface) to be
> > > binded, it means that the attached erdma device can only be binded to
> > > the specific netdev. Due to the uniqueness of MAC address in our ECS
> > > instance, we use the MAC address as the identification, then the driver
> > > knows which netdev should be binded to.
> > 
> > Nothing prohibits from you to implement this MAC check in RDMA_NLDEV_CMD_NEWLINK.
> > I personally don't like the idea that bind logic is performed "magically".
> > 
> 
> OK, I agree with you that using RDMA_NLDEV_CMD_NEWLINK is better. But it
> means that erdma can not be ready to use like other RDMA HCAs, until
> user configure the link manually. This way may be not friendly to them.
> I'm not sure that our current method is acceptable or not. If you
> strongly recommend us to use RDMA_NLDEV_CMD_NEWLINK, we will change to
> it.

Before you are rushing to change that logic, could you please explain
the security model of this binding?

I'm as an owner of VM can replace kernel code with any code I want and
remove your MAC matching (or replace to something different). How will
you protect from such flow?

If you don't trust VM, you should perform binding in hypervisor and
this erdma driver will work out-of-the-box in the VM.

Thanks

> 
> Thanks,
> Cheng Xu
> 
> > BTW,
> > 1. No module parameters
> > 2. No driver versions
> > 
> 
> Will fix them.
> 
> > Thanks
> > 
> > > 
> > > Thanks,
> > > Cheng Xu
