Return-Path: <linux-rdma+bounces-3829-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB89A92EB7B
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 17:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814092834B3
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 15:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8711E16B751;
	Thu, 11 Jul 2024 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="V6kGLkj5";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="I6jIY0vt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A70323D;
	Thu, 11 Jul 2024 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720711021; cv=none; b=Lb3edopO3Mej+M+jFro41GZWcEF6zlFU2T5rShcpmcc7pSMGE2KwSYslOFG/1B7Loih1HLBEctMIuSKlizsZkB+kb+dfuPwaLHAdhAAYnEE4dVPJyGkH5uCXB+R/1B46SoFQb8MfxrOSau1ZrAvmuZl6ik8D1mhlzrlWt6RnVIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720711021; c=relaxed/simple;
	bh=+4/Ed8e5LpNGHu6fjmM6KG9TewhrzuoHvHSpE1FxXC8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bJZHg8Idu4Ikqhr7ubere3CR/sDnNOBfqPEHxolk+t2+5FWa7pux2VGSBqzD+/YciaUgwGUWcfK562s9Z8UcbBiOkMyzIxraTJy7DOsRT/C+lxAC/zAJkGiYbK4B1kKB9InyeJzEyDNfgMPrV/g9Bnlw3cCIRVrpvsZgvsNku3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=V6kGLkj5; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=I6jIY0vt; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1720711018;
	bh=+4/Ed8e5LpNGHu6fjmM6KG9TewhrzuoHvHSpE1FxXC8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=V6kGLkj53izvMyRJqdIRmQqcaJXLkAULYOTmUxFRoz2HTVYdYarWTTixz4tWvcyqE
	 H/g9Fj7IJmgrfXjUASqF9vWCqj/VOlsAB59sYiZ/m/Mmi+uIEPJCEr7vOHacERWqvi
	 z31714kWRoEldezato4yyZ6hRGU7gCRhJAwQIHEA=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 352C312860F0;
	Thu, 11 Jul 2024 11:16:58 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id kFLXZY8IdDPn; Thu, 11 Jul 2024 11:16:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1720711017;
	bh=+4/Ed8e5LpNGHu6fjmM6KG9TewhrzuoHvHSpE1FxXC8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=I6jIY0vtQKlms1zpDA6KWeWhoijYFO4Lf7Ts/A5OvewqqQ5PS1VLoNdiVX7TbiLrc
	 vkQPX0ZKXfRKD38uAPsYFmMWew3mFrsrdmWEjn/B/zdHP9vK4cv7ARsOL1Hyisz/5y
	 dRzETE/mHfNOz2cccubSvCy0JGy0T7bIqulrjRjs=
Received: from [172.20.11.192] (unknown [74.85.233.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A7AC21285DF9;
	Thu, 11 Jul 2024 11:16:57 -0400 (EDT)
Message-ID: <3ea7076089590e1d2bed139c256dbc077ecd6984.camel@HansenPartnership.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev, 
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
Date: Thu, 11 Jul 2024 08:16:55 -0700
In-Reply-To: <20240711135030.GD1482543@nvidia.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
	 <3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
	 <20240711135030.GD1482543@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-07-11 at 10:50 -0300, Jason Gunthorpe wrote:
> On Tue, Jul 09, 2024 at 09:02:25AM -0700, James Bottomley wrote:
> 
> > For NVMe and net we do have SPDK and DPDK.  What I find is that
> > people tend to use them for niche use cases (like the NVMe KV
> > command set) or obscure network routers.  Even though the claim
> > they both make is to get the kernel out of the way and do stuff
> > "way faster" the difficulty they create by bypassing everything is
> > quite a high burden.
> 
> [..]
>  
> > What all of the prior pass through's taught us is that if the use
> > case is big enough it will get pulled into the kernel and the
> > kernel will usually manage it better (DB users).  If it remains a
> > niche use case it will likely remain out of the kernel, but we
> > won't be hurt by it (NVME KV protocol) and sometimes it doesn't
> > really matter and the device manufacturers will sort it out on
> > their own (USB tokens).
> 
> I don't see it as being linked to big enough use case at all.

'it' being fwctl?  I'm happy to take a wait and see approach with that.
I'm in the camp that doesn't squash a novel proposal because the kernel
should be controlling it.  I'm confident that if the use case becomes
big enough the kernel will likely do it in the end.

> The kernel gets involved if there are good technical reasons to do
> so. Databases running over real filesystems with O_DIRECT is really
> technically better than raw block devices.

Exactly for a whole host of performance and more particularly
management reasons.

> While DPDK shows the opposite, userspace is the technically better
> option. This is now shown at scale. DPDK is not some niche. A big
> chunk of internet traffic is going through DPDKs, especially for
> mobile. Many ORAN solutions include DPDK on Linux.

ORAN being Open Radio Access Network?  But that's a case in point: the
kernel doesn't have a LTE stack or APN handling for networking.  RAN
hardware is not very widespread outside of cell providers, meaning it
doesn't get a lot of widespread exposure.  However, I believe Osmocom
is trying to change this (giving linux a native stack instead of DPDK)
and they're on record as referring to DPDK as the "Rabbit Hole".

To look at a counter example: how many linux based router boxes (i.e.
hardware based not cloud based) actually use DPDK?  I have a huge list
of cloud projects that overran and got cancelled because they decided
to use DPDK to replace a function the kernel was already doing (because
faster) and then found that if you replace function X in the kernel
generally the rest of the alphabet needs replacing as well, which blows
your project deadlines.

That's not to say there aren't a whole host of uses for DPDK: novel
protocols, traffic classification experiments, etc.  It's just that
it's like this honeytrap for the unwary and any project that comes
along with DPDK somewhere in its spec immediately gets extra scrutiny
(it's not that we don't do them, just that we make sure there's a
genuine use case that isn't reinventing what the kernel already does).

> What has been improved kernel-side is the intergation. DPDK
> deployments now often use RDMA raw queue pairs instead of VFIO, which
> laregly eliminates the "high burden".
> 
> There are many other cases, like DPDK, where the right answer is to
> reduce the kernel involvement. It is not so simple that things always
> get pulled into the kernel.

I don't disagree: there are many novel protocols and other use cases
that will never make it into the kernel simply because they won't get
the adoption; they're all ideal candidates for DPDK.  However, I do
take issue with "reduce kernel involvement" that's what gives rise to
projects that start by rewriting a piece of kernel networking in DPDK
and get sucked down the Rabbit Hole and never come out the other side.

James


