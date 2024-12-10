Return-Path: <linux-rdma+bounces-6396-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB849EB9DC
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 20:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64B5167601
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 19:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EB3214208;
	Tue, 10 Dec 2024 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgnGjdJY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C021BDAA2
	for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 19:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857988; cv=none; b=D3ldn3ZwrKEpnVF9iLZiOjHlXtUTue/p06BYuRq0cBwRFYOUiKWX3l3nC59ZW++jjLTJJJZrs0wkkUnN4Nz5IOMa+7U43mKCQYPKh77pscT12BR2C3Z7mFb47fN4PnIeuWC+A5Bkx+IFQT9LzV4caYKvPjX7ni+A225MfYWwtyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857988; c=relaxed/simple;
	bh=hiMsX3xjPcbj//Bqo1RHDwstsq2AXitccUsguzoEzQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7k1YKZ+sRmnpOr7Mv0SMk5NoDTIEzyUcxF9lpJQqaXL1um91qoQvVnoFCGGXT5U2xPRvO7dc8801lnoCPn0zMxZ6i411Z4vtzXyRYHrBTHznOBfPrz3zqlB/EH9/Iah3+Ls1VkHA4bN7KgDSLt1HVVGz8ZiGWJvK5z4XvlHOJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgnGjdJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F3CC4CED6;
	Tue, 10 Dec 2024 19:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733857987;
	bh=hiMsX3xjPcbj//Bqo1RHDwstsq2AXitccUsguzoEzQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PgnGjdJYsx8+TArFn4viSXppJSSsV9QFCb/u8Ubp6WZoDuyrQtV9xxkalaA4N92yy
	 3Rwur8XYd8yfZjo2AIKJi2GKTmsOCAVtNzfFi7p2Hf2sTc0SqFmrh1Sj9omQrQKt7U
	 S9BUQCu28UWHsowR9sCq670Wzf3E4STybiWq238zcFd5b5LTvVjVHM6JgchrYNMTid
	 GVOVi1LywKR6ZTBe1radmP3UOnRQo/oYWsaW2EDn6KfQmeJLURVDzzGNS7l2M/wqUf
	 EgNakO7oIBK+Z6UikhMACxaC4nds0eZap9kwR3OA29DghKmFLD2evTqDZD2XY6o7dk
	 lIKyEs2aopaYg==
Date: Tue, 10 Dec 2024 21:13:03 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bernard Metzler <BMT@zurich.ibm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/siw: Remove direct link to net_device
Message-ID: <20241210191303.GF1245331@unreal>
References: <20241210130351.406603-1-bmt@zurich.ibm.com>
 <20241210145627.GH1888283@ziepe.ca>
 <BN8PR15MB2513CA1868B484175CB61E88993D2@BN8PR15MB2513.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR15MB2513CA1868B484175CB61E88993D2@BN8PR15MB2513.namprd15.prod.outlook.com>

On Tue, Dec 10, 2024 at 05:08:51PM +0000, Bernard Metzler wrote:
> 
> 
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Tuesday, December 10, 2024 3:56 PM
> > To: Bernard Metzler <BMT@zurich.ibm.com>
> > Cc: linux-rdma@vger.kernel.org; leon@kernel.org; linux-
> > kernel@vger.kernel.org; netdev@vger.kernel.org; syzkaller-
> > bugs@googlegroups.com; zyjzyj2000@gmail.com;
> > syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
> > Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Remove direct link to net_device
> > 
> > On Tue, Dec 10, 2024 at 02:03:51PM +0100, Bernard Metzler wrote:
> > > diff --git a/drivers/infiniband/sw/siw/siw.h
> > b/drivers/infiniband/sw/siw/siw.h
> > > index 86d4d6a2170e..c8f75527b513 100644
> > > --- a/drivers/infiniband/sw/siw/siw.h
> > > +++ b/drivers/infiniband/sw/siw/siw.h
> > > @@ -69,16 +69,19 @@ struct siw_pd {
> > >
> > >  struct siw_device {
> > >  	struct ib_device base_dev;
> > > -	struct net_device *netdev;
> > >  	struct siw_dev_cap attrs;
> > >
> > >  	u32 vendor_part_id;
> > > +	struct {
> > > +		int ifindex;
> > 
> > ifindex is only stable so long as you are holding a reference on the
> > netdev..
> > > --- a/drivers/infiniband/sw/siw/siw_main.c
> > > +++ b/drivers/infiniband/sw/siw/siw_main.c
> > > @@ -287,7 +287,6 @@ static struct siw_device *siw_device_create(struct
> > net_device *netdev)
> > >  		return NULL;
> > >
> > >  	base_dev = &sdev->base_dev;
> > > -	sdev->netdev = netdev;
> > 
> > Like here needed to grab a reference before storing the pointer in the
> > sdev struct.
> > 
> 
> This patch was supposed to remove siw's link to netdev. So no
> reference to netdev would be needed. I did it under the
> assumption siw can locally keep all needed information up to
> date via netdev_event().
> But it seems the netdev itself can change during the lifetime of
> a siw device? With that ifindex would become wrong.
> 
> If the netdev can change without the siw driver being informed,
> holding a netdev pointer or reference seems useless.
>  
> So it would be best to always use ib_device_get_netdev() to get
> a valid netdev pointer, if current netdev info is needed by the
> driver?

Or call to dev_hold(netdev) in siw_device_create(). It will make sure
that netdev is stable.

Thanks

BTW, Need to check, maybe IB/core layer already called to dev_hold.

> 
> I just wanted to avoid the costly ib_device_get_netdev() call
> during query_qp(), query_port() and listen().
> 
> Thank you!
> Bernard.
> 

