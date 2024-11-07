Return-Path: <linux-rdma+bounces-5836-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A51429C0569
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 13:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB3E1F2259A
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 12:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6E220F5A3;
	Thu,  7 Nov 2024 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0TLjSo+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFB41EF0A2;
	Thu,  7 Nov 2024 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981595; cv=none; b=HW850hWDEcO0542RYWuoS34mDktNXeBIW0EALFAq9VCy1Pp/7W456Sln8f6HngWG+Bb5pt4Vi/85/VprURjaQNnC9fyW79JRNSJDxWMX95HlW8i7xJ9SPlZB6ZbsUR2hv/WG60urBaf3J56DtEZk3nNE3/fG9vxYGjJJvt+WHm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981595; c=relaxed/simple;
	bh=wA6HaF5jWhqC7PHRHi/nW4wj5K9TmEPJwgmIrA6Ht2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvv8YG/RL815FFlbymguZ2HGoSqXm2dbuYUN7Im66ARrWBq+cH7QG4ENp6+Bo6JDVOxeNTztDQ92WYbmNgIRc+bxYZ2iWLZAQuMb1vfxEaRFOc2VkSJPXKR3nOR0tN6IKXW40uhd/MrhKPSLqmsEmqKE8UB+rGAlpV2RP5xycUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0TLjSo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFDDC4CECC;
	Thu,  7 Nov 2024 12:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730981594;
	bh=wA6HaF5jWhqC7PHRHi/nW4wj5K9TmEPJwgmIrA6Ht2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I0TLjSo+i59L8NKIbuMoYlUM/IhFCjq6dim4A6lnqJQ+86SbWy7/920OCxxG5828a
	 eGFm8YGTVAkJ65mW/hL7d5ykmag5DOUQyK76Vv5zwkShDHC4k/1bbLpfn2xiKjhdEE
	 AhwdGOpDpA3zwdbQ/NWAZLybgcXSECc9iwoqysidkD8OLDlT9bbFxIfmLcXSRzFr3G
	 6mvWH0AWkuHgClh/cFDSqQz9ZTtFU8AnOybjF0kt7rpIDmE9qAAMeGx5rYmHJFmvdL
	 tm/44D1xtPxEh3tSn15ZFfy8mjAGJ3Kp+PUmVN2MzwnJy3EuhC86c5YAQP2HtDXTns
	 cX9idrzvy4S1Q==
Date: Thu, 7 Nov 2024 14:13:07 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Nils Hoppmann <niho@linux.ibm.com>,
	Niklas Schnell <schnelle@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>, Aswin K <aswin@linux.ibm.com>,
	linux-cifs@vger.kernel.org
Subject: Re: [PATCH net] net/smc: Fix lookup of netdev by using
 ib_device_get_netdev()
Message-ID: <20241107121307.GN5006@unreal>
References: <20241025072356.56093-1-wenjia@linux.ibm.com>
 <20241027201857.GA1615717@unreal>
 <8d17b403-aefa-4f36-a913-7ace41cf2551@linux.ibm.com>
 <20241105112313.GE311159@unreal>
 <20241106102439.4ca5effc.pasic@linux.ibm.com>
 <20241106135910.GF5006@unreal>
 <20241107125643.04f97394.pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107125643.04f97394.pasic@linux.ibm.com>

On Thu, Nov 07, 2024 at 12:56:43PM +0100, Halil Pasic wrote:
> On Wed, 6 Nov 2024 15:59:10 +0200
> Leon Romanovsky <leon@kernel.org> wrote:
> 
> > > Does  fs/smb/server/transport_rdma.c qualify as inside of RDMA core code?  
> > 
> > RDMA core code is drivers/infiniband/core/*.
> 
> Understood. So this is a violation of the no direct access to the
> callbacks rule.

It is not rule, but more common sense. Callbacks don't provide any
module reference counting, module autoload e.t.c

It is very rare situation where you call device callbacks from one subsystem
in another. I'm not familiar with such situations.

> 
> > 
> > > I would guess it is not, and I would not actually mind sending a patch
> > > but I have trouble figuring out the logic behind  commit ecce70cf17d9
> > > ("ksmbd: fix missing RDMA-capable flag for IPoIB device in
> > > ksmbd_rdma_capable_netdev()").  
> > 
> > It is strange version of RDMA-CM. All other ULPs use RDMA-CM to avoid
> > GID, netdev and fabric complexity.
> 
> I'm not familiar enough with either of the subsystems. Based on your
> answer my guess is that it ain't outright bugous but still a layering 
> violation. Copying linux-cifs@vger.kernel.org so that 
> the smb are aware.
> 
> Thank you very much for all the explanations!
> 
> Regards,
> Halil 

