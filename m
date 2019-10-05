Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79B7ACC85D
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Oct 2019 08:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbfJEGMS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 5 Oct 2019 02:12:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfJEGMS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 5 Oct 2019 02:12:18 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20FEF2133F;
        Sat,  5 Oct 2019 06:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570255937;
        bh=erD3DfWkZOzxmjP8CSruNZOprvNRMOuOtplsGA1nLsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CzqptSJFMP3UAcnyqIqf5XjLlMPZOV/G/QKsK8chyGzxV9fC87J6jiaxzIDZF4ED2
         2EWdaRMjiHXtY1gerFcDWWH5gIfIeCki+8X//+GJ0qfjhUlirltz1+LogzAA9e+hTH
         FUJFrEQVxfXmVUPlVlKgJ8aGk9xelYWI2lGMGtvI=
Date:   Sat, 5 Oct 2019 09:12:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jonathan Toppins <jtoppins@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core] kernel-boot: Tighten check if device is virtual
Message-ID: <20191005061212.GO5855@unreal>
References: <20190926094253.31145-1-leon@kernel.org>
 <20190926123427.GD19509@mellanox.com>
 <9c582ae3-8214-f9b8-d403-cf443b70284e@redhat.com>
 <20190928165416.GL14368@unreal>
 <20191003163127.GE26151@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003163127.GE26151@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 03, 2019 at 04:31:32PM +0000, Jason Gunthorpe wrote:
> On Sat, Sep 28, 2019 at 07:54:16PM +0300, Leon Romanovsky wrote:
> > On Thu, Sep 26, 2019 at 01:58:38PM -0400, Jonathan Toppins wrote:
> > > On 09/26/2019 08:34 AM, Jason Gunthorpe wrote:
> > > > On Thu, Sep 26, 2019 at 12:42:53PM +0300, Leon Romanovsky wrote:
> > > >> From: Leon Romanovsky <leonro@mellanox.com>
> > > >>
> > > >> Virtual devices like SIW or RXE don't set FW version because
> > > >> they don't have one, use that fact to rely on having empty
> > > >> fw_ver file to sense such virtual devices.
> > > >
> > > > Have you checked that every physical device does set fw version?
> > > >
> > > > Seems hacky
> > >
> > > agreed, how are tuntap devices handled, is there a similar handling that
> > > can be applied here?
> >
> > Unfortunately, we can't do the same, RDMA doesn't have notion of stacked devices.
> >
> > 1.
> > TUN devices are initialized with ARPHRD_NONE type.
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/tun.c#L1396
> >
> > It causes for systemd-udev to skip their rename.
> > https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-net_id.c#L781
> >
> > 2.
> > TAP devices are skipped due to the fact that iflink != ifindex on such devices.
> > https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-net_id.c#L810
> >
> > So, yes hacky, but the solution is tailored to RDMA subsystem where ALL
> > devices have FW and we can ensure that ALL future devices will report any
> > sort of string through fw_ver file.
>
> It still seems really hacky, why not add some device flag or something
> instead? Is this better because it works with old kernels?

Yes, I'm trying to find a way to do such discovery without changing
kernel, because we have only two virtual devices and I don't expect
to see any new ones in forth coming future.

However, this patch is wrong because there are at least two drivers (hns
and EFA) didn't implement .get_dev_fw_str() and they will have empty
fw_ver.

 805 void ib_get_device_fw_str(struct ib_device *dev, char *str)
 806 {
 807         if (dev->ops.get_dev_fw_str)
 808                 dev->ops.get_dev_fw_str(dev, str);
 809         else
 810                 str[0] = '\0';
 811 }
 812 EXPORT_SYMBOL(ib_get_device_fw_str);

Special flag seems too much for me, what about writing special string to
fw_ver to indicate virtual device? For example "virtual".

Thanks

>
> Jason
