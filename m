Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A1BC116D
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Sep 2019 18:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbfI1QyV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Sep 2019 12:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfI1QyV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 28 Sep 2019 12:54:21 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C99D2086A;
        Sat, 28 Sep 2019 16:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569689660;
        bh=9GrMgzKfCHLo3Tl0vfD/0Ausr7N4/G5ecaxmF8GpSQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MzAvcTZiMJBdGrVZIcZEB3F62ZLoI4r1v2umY/M6tvtKEWipKJxD7iD2MGjYFwyg8
         KLprZ3kKGkIdJotXl6evUniHKXoDyGCRLFbPwU5U6VANGN/O0HkDqaog8eWycSf1kX
         Nig3+8eT0TWhx+enp+H9SS+pU/McreKHohOmNGXo=
Date:   Sat, 28 Sep 2019 19:54:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jonathan Toppins <jtoppins@redhat.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core] kernel-boot: Tighten check if device is virtual
Message-ID: <20190928165416.GL14368@unreal>
References: <20190926094253.31145-1-leon@kernel.org>
 <20190926123427.GD19509@mellanox.com>
 <9c582ae3-8214-f9b8-d403-cf443b70284e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c582ae3-8214-f9b8-d403-cf443b70284e@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 26, 2019 at 01:58:38PM -0400, Jonathan Toppins wrote:
> On 09/26/2019 08:34 AM, Jason Gunthorpe wrote:
> > On Thu, Sep 26, 2019 at 12:42:53PM +0300, Leon Romanovsky wrote:
> >> From: Leon Romanovsky <leonro@mellanox.com>
> >>
> >> Virtual devices like SIW or RXE don't set FW version because
> >> they don't have one, use that fact to rely on having empty
> >> fw_ver file to sense such virtual devices.
> >
> > Have you checked that every physical device does set fw version?
> >
> > Seems hacky
>
> agreed, how are tuntap devices handled, is there a similar handling that
> can be applied here?

Unfortunately, we can't do the same, RDMA doesn't have notion of stacked devices.

1.
TUN devices are initialized with ARPHRD_NONE type.
https://elixir.bootlin.com/linux/latest/source/drivers/net/tun.c#L1396

It causes for systemd-udev to skip their rename.
https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-net_id.c#L781

2.
TAP devices are skipped due to the fact that iflink != ifindex on such devices.
https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-net_id.c#L810

So, yes hacky, but the solution is tailored to RDMA subsystem where ALL
devices have FW and we can ensure that ALL future devices will report any
sort of string through fw_ver file.

Thanks

>
