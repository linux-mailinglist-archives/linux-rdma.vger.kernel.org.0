Return-Path: <linux-rdma+bounces-8746-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6CAA64FC8
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 13:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A658C1890FAC
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 12:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC47239595;
	Mon, 17 Mar 2025 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrZlAHa1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3091C861C;
	Mon, 17 Mar 2025 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215968; cv=none; b=bO5PYN77a4eeEfTC+hbLI3Yj/Dz49dKyy4eVjPIaHpTQQlov4dlIepesw+W8dnzu7PdeyHW+D8LctsC87vvMnePLVB6xmwKT0YQrRWWQ3lnNLEOACt8oXVz9se+wb50GM4KvjWs006fnCBSEHbNSrOYKF2LMn/mjv5+ZF1NOfO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215968; c=relaxed/simple;
	bh=KFYSRneptkjRCu9Vj5fQekt7blYDP9RXS5HicNdn/AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyajQ06TacGOwhI4xhTJFSRVALBvJ2KsdvQ+Nx4hHyVdT19IktoygHitnn2If+6opuc1Yq6yZS+nr5lE9+ePSIvV9vCwJjdhVZTjSG6wc7Vm8XpX8OEnYs3rABIQ6LXKDUCWRVBJOikAiTXtNEQMfQi1URiXSv34uu26sv7EMGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrZlAHa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825A6C4CEE3;
	Mon, 17 Mar 2025 12:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742215968;
	bh=KFYSRneptkjRCu9Vj5fQekt7blYDP9RXS5HicNdn/AE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QrZlAHa1z5iPyPJJCsafMVQtn/K0FUSwDTqmM5vaQ55LPF2PglgvqWg6xDOfwpnDt
	 KAqECxr241B+9qjlAtBhDmtQ4eOmP7H8tTkoLVq88tMceB8V+8i2CCU5NPRIdQ4v4I
	 2zIm3P1K99MrCFLXv1uYjEDcamTW/wgWUxNaN9HihDW4Gj00am51/gSn2Awopa3sJH
	 9gF+P/joAvRSWMqjU+m0XEruv95ixyXh9JelNR+z07aKBZxlDaqFI4Ov060RXJXgjX
	 fhupxbXDwuxh9+Gtx0/NYORQ/k6k4mckwJhgg6+Tky9Xb0A/+s5tcWEHLUWNImFhk2
	 51gN2A3x6wiPA==
Date: Mon, 17 Mar 2025 14:52:41 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bernard Metzler <BMT@zurich.ibm.com>
Cc: Nikolay Aleksandrov <nikolay@enfabrica.net>,
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
Message-ID: <20250317125241.GV1322339@unreal>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal>
 <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
 <20250312112921.GA1322339@unreal>
 <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>
 <20250312151037.GE1322339@unreal>
 <BN8PR15MB25133D6B2BC61C81408D6FE899D22@BN8PR15MB2513.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN8PR15MB25133D6B2BC61C81408D6FE899D22@BN8PR15MB2513.namprd15.prod.outlook.com>

On Fri, Mar 14, 2025 at 02:53:40PM +0000, Bernard Metzler wrote:
> 
> 
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Wednesday, March 12, 2025 4:11 PM
> > To: Nikolay Aleksandrov <nikolay@enfabrica.net>
> > Cc: netdev@vger.kernel.org; shrijeet@enfabrica.net;
> > alex.badea@keysight.com; eric.davis@broadcom.com; rip.sohan@amd.com;
> > dsahern@kernel.org; Bernard Metzler <BMT@zurich.ibm.com>;
> > roland@enfabrica.net; winston.liu@keysight.com;
> > dan.mihailescu@keysight.com; Kamal Heib <kheib@redhat.com>;
> > parth.v.parikh@keysight.com; Dave Miller <davem@redhat.com>;
> > ian.ziemba@hpe.com; andrew.tauferner@cornelisnetworks.com; welch@hpe.com;
> > rakhahari.bhunia@keysight.com; kingshuk.mandal@keysight.com; linux-
> > rdma@vger.kernel.org; kuba@kernel.org; Paolo Abeni <pabeni@redhat.com>;
> > Jason Gunthorpe <jgg@nvidia.com>
> > Subject: [EXTERNAL] Re: [RFC PATCH 00/13] Ultra Ethernet driver
> > introduction
> > 
> > On Wed, Mar 12, 2025 at 04:20:08PM +0200, Nikolay Aleksandrov wrote:
> > > On 3/12/25 1:29 PM, Leon Romanovsky wrote:
> > > > On Wed, Mar 12, 2025 at 11:40:05AM +0200, Nikolay Aleksandrov wrote:
> > > >> On 3/8/25 8:46 PM, Leon Romanovsky wrote:
> > > >>> On Fri, Mar 07, 2025 at 01:01:50AM +0200, Nikolay Aleksandrov wrote:
> > > [snip]
> > > >> Also we have the ephemeral PDC connections>> that come and go as
> > > needed. There more such objects coming with more
> > > >> state, configuration and lifecycle management. That is why we added a
> > > >> separate netlink family to cleanly manage them without trying to fit
> > > >> a square peg in a round hole so to speak.
> > > >
> > > > Yeah, I saw that you are planning to use netlink to manage objects,
> > > > which is very questionable. It is slow, unreliable, requires sockets,
> > > > needs more parsing logic e.t.c
> > > >
> > > > To avoid all this overhead, RDMA uses netlink-like ioctl calls, which
> > > > fits better for object configurations.
> > > >
> > > > Thanks
> > >
> > > We'd definitely like to keep using netlink for control path object
> > > management. Also please note we're talking about genetlink family. It is
> > > fast and reliable enough for us, very easily extensible,
> > > has a nice precise object definition with policies to enforce various
> > > limitations, has extensive tooling (e.g. ynl), communication can be
> > > monitored in realtime for debugging (e.g. nlmon), has a nice human
> > > readable error reporting, gives the ability to easily dump large object
> > > groups with filters applied, YAML family definitions and so on.
> > > Having sockets or parsing are not issues.
> > 
> > Of course it is issue as netlink relies on Netlink sockets, which means
> > that you constantly move your configuration data instead of doing
> > standard to whole linux kernel pattern of allocating configuration
> > structs in user-space and just providing pointer to that through ioctl
> > call.
> > 
> > However, this discussion is premature and as an intro it is worth to
> > read this cover letter for how object management is done in RDMA
> > subsystem.
> > 
> > https://lore.kernel.org/linux% 
> > 2Drdma_1501765627-2D104860-2D1-2Dgit-2Dsend-2Demail-2Dmatanb-
> > 40mellanox.com_&d=DwIBAg&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE4tY
> > SbqxyOwdSiLedP4yO55g&m=U78K-khiLd-
> > LLkbuNRzBStNppsXFTXdM7br052fwal1mzxpaOcOSQXCnguAK8t3g&s=U9dQl07fp-
> > e9380xjR94fW-UGixoMsoxr5HfXKYggLk&e=
> > 
> Nice old stuff. Often history teaches us something. 😉

Maybe, and this is what this submission is missing. An explanation what
was learnt, what needs to be changed, why it is impossible to fix and
everything needs to be started from the scratch.

> 
> I assume the correct way forward is to first clarify the
> structure of all user-visible objects that need to be
> created/controlled/destroyed, and to route them through
> this interface. 

Yes, the actual objects structure, their relation and exposure is
actually the interesting part.

Thanks

