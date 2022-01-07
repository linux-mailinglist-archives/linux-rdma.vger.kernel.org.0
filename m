Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792CF4878E4
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 15:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbiAGOYU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 09:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiAGOYU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jan 2022 09:24:20 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E369EC061574
        for <linux-rdma@vger.kernel.org>; Fri,  7 Jan 2022 06:24:19 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id o17so5694663qtk.1
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jan 2022 06:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u1NhgUuudxS7oVCnaKfCZ88Iiq6OudY9uly1gke8U40=;
        b=LIgRErhtLqgxFqWnGRLG0vmdw3E1he4FFOWCo6i6Z1wNwkeoLsFPPaipnPOhPm50kP
         3RHwqjLljlk/gZVf/8nlLJ4y/69bJKZImvMKhMkEWm6xL/mFDnDwwUPvYL70+qh/XiCD
         oWQNQs0TGW7PdJ18He64/M9n9g3tHbOeYGZ/o6VXJ/nNNTmS19fTpGjUX0vRhRmjRkAO
         xM7SVue9slvxZb+WfjqWcPgg6iI/coRFKH0xsC+ahOIhQOD2IyPO+HGUwxGpmBAha3Kc
         zHjsUg9qoT8qRy8+UU7WRm3mxUEwnnirIVGOKZZCTD9ldr/6Z7iS3lBt//DldPqiz4Ht
         38qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u1NhgUuudxS7oVCnaKfCZ88Iiq6OudY9uly1gke8U40=;
        b=DhBx0yOLB4U5r2Ulsml2SG1d1bB2xZsXOmSDMP4Vxmp+sey7G4EFux+GETm95nHnzs
         PX3j4fVmkkc23oUTPF8DXZ6XpM7aJw6CY1y2EzUc0b9UdxoL0hBOUOzPrk8lTPyKIdhi
         8noa58hc8GZecY6YLWu0BwQlp7i8LG57jjAlqq3ojkpcAx9A1k0tFjhQ294e2O423P8L
         /ZFHLXWeOmhYqiSJWjVeACbPBBmT5hpHcWF3F9N+G+6eyDkmBg0fkRekAG7wWbG+7L++
         XVc9Yo/vDn/DMLii9mZKDqt9DPqkH1RJY6wK+NbL9tGgfAY4FqGcO15deJpvfnIKB8BQ
         5RFw==
X-Gm-Message-State: AOAM533pUrHVkIh237B6fVBvVvt7V/TwzG3H0JTmogQxhkYQ34tjI3wz
        +4Qrn8BCMmAr0pkMpIqNaNLKy0sDGn5s0w==
X-Google-Smtp-Source: ABdhPJw/Eaqt0jDD9Z8BshW5MJrfPj0xc1gGkfqJs7OiBYa7hlPZpWjr7gkTIbvZKgJUsgAtX4yHDg==
X-Received: by 2002:a05:622a:1389:: with SMTP id o9mr56793650qtk.109.1641565459072;
        Fri, 07 Jan 2022 06:24:19 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id c8sm3490318qkp.8.2022.01.07.06.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 06:24:18 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n5qAD-00CvUl-Jp; Fri, 07 Jan 2022 10:24:17 -0400
Date:   Fri, 7 Jan 2022 10:24:17 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     Leon Romanovsky <leon@kernel.org>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com,
        tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-next 00/11] Elastic RDMA Adapter (ERDMA) driver
Message-ID: <20220107142417.GW6467@ziepe.ca>
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

It really doesn't match our driver binding model to rely on MAC
addreses.

Our standard model would expect that the virtio-net driver would
detect it has RDMA capability and spawn an aux device to link the two
things together.

Using net notifiers to try to link the lifecycles together has been a
mess so far.

Jason
