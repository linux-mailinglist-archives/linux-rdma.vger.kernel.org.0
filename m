Return-Path: <linux-rdma+bounces-3527-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A2C9185E5
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 17:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93EE9283136
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 15:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED9418A952;
	Wed, 26 Jun 2024 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCd5xkqA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A42DA92F;
	Wed, 26 Jun 2024 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719416039; cv=none; b=ELaq4xoP8PDtYGAMNXa9HFToaEFLVIXGLWFE8oEEqunV2tqudy2nozO+KdbH3IcQ71ixMww0b1MjloKD43SeRxX1yIZb5Ahc3v4Wm/B7wMUoz3lqTBJJlOjzWF6uGMgioqcMYECpGPUvUb2Oqs3I+6+d2EtedOpb7bg1n2Sztwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719416039; c=relaxed/simple;
	bh=mMuyQahSghnJD/XM5yr+zewXeOuKJRoKV18OW9IbbyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjZupxl+VhWFmzaZF9IorhmbNBHIQuNYIxhPfJRlrbMz5IMoDw/s7aN9xkzjqkA9Tuj5XssDiwmtm59Cl8IiPv6n+V1cCRODq9K8sXVkR1Wp5uox4HmDMECjoU/pzrNLBTVNsLNxsNQP6cSrbOSPoBxgFdSVHEqYrs9wRDcyfdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCd5xkqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85345C116B1;
	Wed, 26 Jun 2024 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719416039;
	bh=mMuyQahSghnJD/XM5yr+zewXeOuKJRoKV18OW9IbbyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gCd5xkqAb8IzORmGTtkndisxrnIWbEKk15FL5s9SwSQKVXulquVZs3X+kSMZjkYtT
	 7QEfRXFyXb3TFaU441puvh6i01bPc9dZKlofEKA0MkbQqvEda3lqt1Va6BIoIJ9yBN
	 1o6JQZVsAYZkeZmwMkClRolUjElZ/y7eVT8M5nww39865UmU+cCifJa2dsHo5NeT1f
	 gENkS7AwhMBA6dcVo33Gx60TJlvwZSQ7M/0oW5x2mTrNGDmebtfmPpb5Qr2+B3xj18
	 vXZN6sgCpw3iEucyJmsBH8Z3/Cdt0XFFHHdjTbp0MJysPKza1WuAeXYeEv0qvPC5O2
	 J1KA3zcRd4Bhw==
Date: Wed, 26 Jun 2024 18:33:54 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Konstantin Taranov <kotaranov@microsoft.com>,
	Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Wei Hu <weh@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Message-ID: <20240626153354.GQ29266@unreal>
References: <1719311307-7920-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240626054748.GN29266@unreal>
 <PAXPR83MB0559F4678E73B0091A8ADFBBB4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240626121118.GP29266@unreal>
 <20240626082731.70d064bb@hermes.local>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626082731.70d064bb@hermes.local>

On Wed, Jun 26, 2024 at 08:27:31AM -0700, Stephen Hemminger wrote:
> On Wed, 26 Jun 2024 15:11:18 +0300
> Leon Romanovsky <leon@kernel.org> wrote:
> 
> > On Wed, Jun 26, 2024 at 09:05:05AM +0000, Konstantin Taranov wrote:
> > > > > When mc->ports[0] is not slave, use it in the set_netdev.
> > > > > When mana is used in netvsc, the stored net devices in mana are slaves
> > > > > and GIDs should be taken from their master devices.
> > > > > In the baremetal case, the mc->ports devices will not be slaves.  
> > > > 
> > > > I wonder, why do you have "... | IFF_SLAVE" in __netvsc_vf_setup() in a first
> > > > place? Isn't IFF_SLAVE is supposed to be set by bond driver?
> > > >   
> > > 
> > > I guess it is just a valid use of the IFF_SLAVE bit. In the bond case it is also set
> > > as a BOND netdev. The IFF_SLAVE helps to show users that another master
> > > netdev should be used for networking. But I am not an expert in netvsc.  
> > 
> > The thing is that netvsc is virtual device like many others, but it is
> > the only one who uses IFF_SLAVE bit. The comment around that bit says
> > "slave of a load balancer.", which is not the case according to the
> > Hyper-V documentation.
> > https://learn.microsoft.com/en-us/windows-hardware/drivers/network/overview-of-hyper-v
> > 
> > You will need to get Ack from netdev maintainers to rely on IFF_SLAVE
> > bit in the way you are relying on it now.
> 
> This is used to tell userspace tools to not interact directly with the device.
> For example, it is used when VF is connected to netvsc device.
> It prevents things like IPv6 local address, and Network Manager won't modify device.

You described how hyper-v uses it, but I'm interested to get acknowledgment
that it is a valid use case for IFF_SLAVE, despite sentence written in the comment.

Thanks

