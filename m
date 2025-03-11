Return-Path: <linux-rdma+bounces-8584-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99471A5C449
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 15:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E511735BC
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 14:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1D325D8FD;
	Tue, 11 Mar 2025 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZk9g+6D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD54625C6FE;
	Tue, 11 Mar 2025 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704963; cv=none; b=NQVgSZyCZwj4mNGkTGzWki3BHQT7ewL6TNziJnRUrqMaG2QQQlV7Zt7MYgnSkGrz380Geg7oHBiP1ZzhtmmNmh/E/JDkyLu7UFNc0pKJuYMrG4ckMkqJlWjNmIxTarpHY+xBqFkFiDJ8qgKJt7StK659Ar1X3iq7KMNDA1MDDFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704963; c=relaxed/simple;
	bh=SC3CQyPzKXglN8Xig/IH7CP07I5r155f+JqiCZcqvTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7emdP4ngCA6VmPtJWedlGyYCOQrF/Ozg58OvkSkIJ6s7W1Ea9JCgLCmG+/NzbXfP/0WaSXZz9V69UuEg9sihw+h7ab5AayAJFfXGL3XwlFCrTBBujQCUpU4sXxoXkO2y0KKHX2lcUFyPXc/12UXpoWENOC4l36nII2jpNF0Jfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZk9g+6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4256DC4CEEA;
	Tue, 11 Mar 2025 14:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741704963;
	bh=SC3CQyPzKXglN8Xig/IH7CP07I5r155f+JqiCZcqvTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZk9g+6D2d830IJFgWRtIkCtZJP+YN6QaBDZKqlIcgP0oF+HYNcXY0TAHg9vIE4lz
	 u3Aa9thhyew8orECzx4oz/Ee4hKpOUeoHgyKrC2acmS+6Sx0gTfHPbvc5RIcD5Fg+k
	 os2tAj2Abt95cNeey7AJmil59GDz/JKbue8b9+7N7vVV2YSqSVLJTsNmphLajStHnQ
	 CVKFOUOymM8EWDRBPNcKqIgUndexiPydlPCOGPml36W86Xee/RRQM8tyLW2oERoJXk
	 WKasM6WwRhHw6eXt5cfvMiObM8uSJ0sz2UUmim+OoxubHkl6s0hIsQFy3qSmJ5FEp5
	 Y3I8nO8CR1bsw==
Date: Tue, 11 Mar 2025 16:55:57 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bernard Metzler <BMT@zurich.ibm.com>
Cc: Parav Pandit <parav@nvidia.com>,
	Nikolay Aleksandrov <nikolay@enfabrica.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"shrijeet@enfabrica.net" <shrijeet@enfabrica.net>,
	"alex.badea@keysight.com" <alex.badea@keysight.com>,
	"eric.davis@broadcom.com" <eric.davis@broadcom.com>,
	"rip.sohan@amd.com" <rip.sohan@amd.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"roland@enfabrica.net" <roland@enfabrica.net>,
	"winston.liu@keysight.com" <winston.liu@keysight.com>,
	"dan.mihailescu@keysight.com" <dan.mihailescu@keysight.com>,
	Kamal Heib <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>,
	Dave Miller <davem@redhat.com>,
	"ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
	"andrew.tauferner@cornelisnetworks.com" <andrew.tauferner@cornelisnetworks.com>,
	"welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Message-ID: <20250311145557.GG7027@unreal>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal>
 <CY8PR12MB7195F4D67BE6D9A970044572DCD72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <BN8PR15MB25136EC9F3DE1FBEF9B2429199D12@BN8PR15MB2513.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <BN8PR15MB25136EC9F3DE1FBEF9B2429199D12@BN8PR15MB2513.namprd15.prod.outlook.com>

On Tue, Mar 11, 2025 at 02:20:07PM +0000, Bernard Metzler wrote:
>=20
>=20
> > -----Original Message-----
> > From: Parav Pandit <parav@nvidia.com>
> > Sent: Sunday, March 9, 2025 4:22 AM
> > To: Leon Romanovsky <leon@kernel.org>; Nikolay Aleksandrov
> > <nikolay@enfabrica.net>
> > Cc: netdev@vger.kernel.org; shrijeet@enfabrica.net;
> > alex.badea@keysight.com; eric.davis@broadcom.com; rip.sohan@amd.com;
> > dsahern@kernel.org; Bernard Metzler <BMT@zurich.ibm.com>;
> > roland@enfabrica.net; winston.liu@keysight.com;
> > dan.mihailescu@keysight.com; Kamal Heib <kheib@redhat.com>;
> > parth.v.parikh@keysight.com; Dave Miller <davem@redhat.com>;
> > ian.ziemba@hpe.com; andrew.tauferner@cornelisnetworks.com;
> > welch@hpe.com; rakhahari.bhunia@keysight.com;
> > kingshuk.mandal@keysight.com; linux-rdma@vger.kernel.org;
> > kuba@kernel.org; Paolo Abeni <pabeni@redhat.com>; Jason Gunthorpe
> > <jgg@nvidia.com>
> > Subject: [EXTERNAL] RE: [RFC PATCH 00/13] Ultra Ethernet driver
> > introduction
> >=20
> >=20
> >=20
> > > From: Leon Romanovsky <leon@kernel.org>
> > > Sent: Sunday, March 9, 2025 12:17 AM
> > >
> > > On Fri, Mar 07, 2025 at 01:01:50AM +0200, Nikolay Aleksandrov wrote:
> > > > Hi all,
> > >
> > > <...>
> > >
> > > > Ultra Ethernet is a new RDMA transport.
> > >
> > > Awesome, and now please explain why new subsystem is needed when
> > > drivers/infiniband already supports at least 5 different RDMA
> > transports
> > > (OmniPath, iWARP, Infiniband, RoCE v1 and RoCE v2).
> > >
> > 6th transport is drivers/infiniband/hw/efa (srd).
> >=20
> > > Maybe after this discussion it will be very clear that new subsystem
> > is needed,
> > > but at least it needs to be stated clearly.
>=20
> I am not sure if a new subsystem is what this RFC calls
> for, but rather a discussion about the proper integration of
> a new RDMA transport into the Linux kernel.

<...>

> The different API semantics of UET may further call
> for either extending verbs to cover it as well, or exposing a
> new non-verbs API (libfabrics), or both.

So you should start from there (UAPI) by presenting the device model and
how the verbs API needs to be extended, so it will be possible to evaluate
how to fit that model into existing Linux kernel codebase.

RDNA subsystem provides multiple type of QPs and operational models, some o=
f them
are indeed follow IB style, but not all of them (SRD, DC e.t.c).

Thanks

>=20
> Thanks,
> Bernard.
>=20
>=20
> > >
> > > An please CC RDMA maintainers to any Ultra Ethernet related
> > discussions as it
> > > is more RDMA than Ethernet.
> > >
> > > Thanks
>=20

