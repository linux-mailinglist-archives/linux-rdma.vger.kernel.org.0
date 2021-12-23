Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09F347E15E
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Dec 2021 11:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347674AbhLWKXo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Dec 2021 05:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347664AbhLWKXm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Dec 2021 05:23:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C7FC061401
        for <linux-rdma@vger.kernel.org>; Thu, 23 Dec 2021 02:23:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53D6AB81FC1
        for <linux-rdma@vger.kernel.org>; Thu, 23 Dec 2021 10:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8B1C36AE5;
        Thu, 23 Dec 2021 10:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640255020;
        bh=rL9cHOFuy65DIi2qgW8V+oCjkpTL0m1CNqifZnNPpwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R928ONRsPKBkGJ2kXYnSzIVdNtpIDYnqJQJU4VheADW/BnoZTLYdnhuxebBNyKXZM
         HYnQKIgtnX2CcTIo0wAep7VH8pnZCT+xK9U17IcAK148XFSrWFAjiYWaHyp7dLijBp
         /mnvkcq/dCrxkUZVZA3KsNIM0Lp3H72OyQgWNPYHVTBT2Z7XeitJKAG66W1hg1JWmu
         VY6X4fc681lSz/Le98Gcq3dPqPGVLJeKK/UlL1DrqUoLHYDYBiHi9nSFS+W6Oemx1E
         XcARt0bmDK+ivxHE/6lESDzNALt5OJSb3friB2+nOHHw4NtwsyY6xgAwcErQ/MbhtG
         PpityZZmLwElw==
Date:   Thu, 23 Dec 2021 12:23:36 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-next 00/11] Elastic RDMA Adapter (ERDMA) driver
Message-ID: <YcROKB5N7Kr1XhaN@unreal>
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
 <YcHSBnKHmR9sb6KR@unreal>
 <b45d0472-06d2-0541-13a2-c64ef6f189f0@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b45d0472-06d2-0541-13a2-c64ef6f189f0@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 22, 2021 at 11:35:44AM +0800, Cheng Xu wrote:
> 

<...>

> > > 
> > > For the ECS instance with RDMA enabled, there are two kinds of devices
> > > allocated, one for ERDMA, and one for the original netdev (virtio-net).
> > > They are different PCI deivces. ERDMA driver can get the information about
> > > which netdev attached to in its PCIe barspace (by MAC address matching).
> > 
> > This is very questionable. The netdev part should be kept in the
> > drivers/ethernet/... part of the kernel.
> > 
> > Thanks
> 
> The net device used in Alibaba ECS instance is virtio-net device, driven
> by virtio-pci/virtio-net drivers. ERDMA device does not need its own net
> device, and will be attached to an existed virtio-net device. The
> relationship between ibdev and netdev in erdma is similar to siw/rxe.

siw/rxe binds through RDMA_NLDEV_CMD_NEWLINK netlink command and not
through MAC's matching.

Thanks
