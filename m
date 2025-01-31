Return-Path: <linux-rdma+bounces-7345-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A076CA23901
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jan 2025 03:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1002C168E0C
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jan 2025 02:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421A745BEC;
	Fri, 31 Jan 2025 02:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lY57fmAw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF052322E;
	Fri, 31 Jan 2025 02:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738291364; cv=none; b=jC53KxUGY+doM30hLbCp5389xMfE33Redk78mb4le38O6g8+kyaMyg//Qcy0MWDciBh0Aur1uQ0HLnd/1UF8ydsTfkmGmoZDRDAx9e9csA7F+Yd7dijIq6zPj6q2XCl2bOguZBquAbSSo38K0mDJrYjuA2umEWbRm2KkgcYfT1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738291364; c=relaxed/simple;
	bh=J4HtwjCENVIAFWioYRKWDuFBJptAfdaYD93a5v9M3sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCSacLmeA0jKMLlEaKrRFi3vysqSnLnkp1HWZgAMqZmtEOWhnSMa4Tgvv5YnvlHLUaePzXxRjAz/MdefD8RBwSt8AU51ftoLkvFhQ/fHT+5b8oPkqwChKmeFzaRDB675pCl4uGZMRWiDRgOVI3jdVzvaPWvkD8ZMluMnUQTk80U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lY57fmAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172DAC4CED2;
	Fri, 31 Jan 2025 02:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738291363;
	bh=J4HtwjCENVIAFWioYRKWDuFBJptAfdaYD93a5v9M3sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lY57fmAwMwLF8S/tJaVlm9trCYbbtYpSCgt5POCRRJgcXWK8BFOGH4XJAXU8p56A6
	 LyzVYMIR3kD2OKUqRoGC1XhksyqOJAw2zxLjmx7IsAbDpEvNHIZq2YCtIp98t1dbKu
	 HlhI2UwliLrs5w4u46uHgTer3r4ckmw4+bjQxjfAToPHGUIVsZjLsu7DQ0C99UVGYQ
	 kdJ0WDOaI0So+1kwMS1ildpO2cMHyXcysIT3aTISif3BHWnbOZVWbcAerioS4f88yb
	 4GCe1TtwSGZ02akKFOhWJYbKkhQ9kJZCTekU2ko9YkGi0TLgzupl8395bOJ7LGSgWy
	 WNk+Yl5iD8huA==
Date: Thu, 30 Jan 2025 18:42:41 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: linux-rdma@vger.kernel.org, Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Bernard Metzler <bmt@zurich.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] RDMA/rxe: consolidate code for calculating ICRC of
 packets
Message-ID: <20250131024241.GA1237@sol.localdomain>
References: <20250127223840.67280-1-ebiggers@kernel.org>
 <20250127223840.67280-3-ebiggers@kernel.org>
 <048daa22-fdc6-4f5f-9fa3-e023dc421aab@linux.dev>
 <20250130021526.GD66821@sol.localdomain>
 <0043edb8-8bba-4675-b0b6-fdb70fb2e091@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0043edb8-8bba-4675-b0b6-fdb70fb2e091@linux.dev>

On Thu, Jan 30, 2025 at 08:24:59AM +0100, Zhu Yanjun wrote:
> 在 2025/1/30 3:15, Eric Biggers 写道:
> > On Wed, Jan 29, 2025 at 07:11:35PM +0100, Zhu Yanjun wrote:
> > > 在 2025/1/27 23:38, Eric Biggers 写道:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > Since rxe_icrc_hdr() is always immediately followed by updating the CRC
> > > > with the packet's payload, just rename it to rxe_icrc() and make it
> > > > include the payload in the CRC, so it now handles the entire packet.
> > > > 
> > > > This is a refactor with no change in behavior.
> > > 
> > > In this commit, currently the entire packet are checked while the header is
> > > checked in the original source code.
> > > 
> > > Now it can work between RXE <----> RXE.
> > > I am not sure whether RXE <---> MLX can work or not.
> > > 
> > > If it can work well, I am fine with this patch.
> > > 
> > > Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > 
> > 
> > Both the header and payload are checksummed both before and after this patch.
> > Can you elaborate on why you think this patch changed any behavior?
> 
> From the source code, it seems that only the header is checked. And RXE can
> connect to MLX RDMA NIC. That is, the CRC of the header can be verified both
> in RXE and MLX RDMA NIC.
> 
> Now in your commit, the header and payload are checked. Thus, the CRC value
> in RDMA header may be different from the CRC of the header(that CRC can be
> verified in RXE and MLX RDMA NIC). Finally the CRC of the header and payload
> will not be verified in MLX RDMA NIC?
> 
> IMO, after your patchset is applied, if RXE can connect to MLX RDMA NIC, I
> am fine with it.
> 
> In the function rxe_rcv as below,
> "
> ...
>     err = rxe_icrc_check(skb, pkt);
>     if (unlikely(err))
>         goto drop;
> ...
> "
> rxe_icrc_check is called to check the RDMA packet. In your commit, the icrc
> is changed. I am not sure whether this icrc can also be verified correctly
> in MLX RDMA NIC or not.
> 
> Because RXE can connect to MLX RDMA NIC, after your patchset is applied,
> hope that RXE can also connect to MLX RDMA NIC successfully.
> 
> Thanks,
> Zhu Yanjun

Again, the payload was checksummed before too.  Please read the whole patch and
not just part of it.  In particular, note that as the commit message points out,
both of the calls to rxe_icrc_hdr() were immediately followed by updating the
CRC with the packet's payload.

Anyway, I might just reduce the scope of this patchset to just the bare minimum
changes needed to replace shash with the CRC library anyway, as it seems hard to
get anything else fixed in this subsystem.

- Eric

