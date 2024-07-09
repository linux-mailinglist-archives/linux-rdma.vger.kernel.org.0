Return-Path: <linux-rdma+bounces-3773-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D8292BF04
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 18:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63251C22386
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 16:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57DE19D06E;
	Tue,  9 Jul 2024 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="LhE8j7NR";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="iYeSMbOA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA568181D0D;
	Tue,  9 Jul 2024 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720540950; cv=none; b=Dlxqrryag/i3WazcYNiuFN/GIojluk6T0Xw3l+ZvjO22hv6vIvlvteXHJy4b/kW38I5rrsxRxeB2h3AhvlvxMbP7jZL6Kvxefu37FstBUDkunCwC6gAjG4ZcrGUUe52cO4M+TV34eKSfvoT9CkZPpuZAqj2Ho9rKiDjVAd31aRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720540950; c=relaxed/simple;
	bh=XJ/Jh5SnuG3rN/OavcSI+CyZ++lBTUQ2aTx68YCTme0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=krbIr9lKF/P/hES0cZN6VUNxPIi9++J7e1diz4bJeHsnsd+QjE33iNuSP8Ja+Qb8tMp54QO27nAqmEkfNO/9ufDwJcidxOagXKye2PKWXB4rSgYbofSIdYOW3TDfA/IswpNnodHR9MVntF8olDh4cMwc3uDFl01qlASi4GkQknU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=LhE8j7NR; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=iYeSMbOA; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1720540947;
	bh=XJ/Jh5SnuG3rN/OavcSI+CyZ++lBTUQ2aTx68YCTme0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=LhE8j7NR9Or3JdM8y+ZTcypR4EK+IG/fCQDEKhvjVxXMLLJGslRjbR/K4vr6l9loF
	 wvHxImU4K3rhnWrMv0DnhwuAf1cHulVMn8rxP0XxEoV1AeIIprDKh9pdKq6KFursgh
	 AL4sjWi+jC7AlEdW5V6I0czTMuhvRuT18Qr6LQxQ=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 831F41281049;
	Tue, 09 Jul 2024 12:02:27 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id MstJzd94AWbf; Tue,  9 Jul 2024 12:02:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1720540946;
	bh=XJ/Jh5SnuG3rN/OavcSI+CyZ++lBTUQ2aTx68YCTme0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=iYeSMbOAD71KMRWonx4RGxhLw83wQPNCXkT/yAbxrzIk50O/DbL+gFDuhA4a2Ec39
	 lI2P/ws+2QqOsCP/ZIhvFybuHu/dKOMEQFqcHE5k9MP6R7v9cDdwvdNCpfTojp4JpH
	 +Z6wwBpOT7i7A9Z5AN3LESXPRh2JXShvd+HKAbuk=
Received: from [172.20.11.192] (unknown [74.85.233.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 88E661280BA5;
	Tue, 09 Jul 2024 12:02:26 -0400 (EDT)
Message-ID: <3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev
Cc: linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, jgg@nvidia.com
Date: Tue, 09 Jul 2024 09:02:25 -0700
In-Reply-To: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-07-08 at 15:26 -0700, Dan Williams wrote:
> Early in my Linux career there was palpable concern around Linux
> being locked out of future computing platforms by hardware vendors
> who did not provide open drivers, or even documentation for their
> hardware. For the hardware vendors that did participate upstream,
> maintainers used code acceptance to influence them towards common
> Linux commands and cross-vendor cooperation.

Firstly could I say "passthrough" seems to be the wrong word here. 
When I see it I think of device pass through from host to VM (SRIOV and
the like), which is becoming the bedrock of the virtualization world. 
However, this proposal seems to be more about user space device drivers
and fat firmware cards.

> The internalized lesson from those days was: "Be wary of vendors
> pushing 'do anything you want and get away with it' passthrough
> tunnels. Demand open documentation of all interfaces."
> 
> Present day realities and discussions merit revisiting that lesson:
> 
> 1/ The truth of the matter is that until the Kernel Lockdown facility
>    arrived, device vendors *had* an unfettered passthrough tunnel via
>    userspace driver mechanisms like /dev/mem and pci-sysfs. The
> presence of
>    those facilities did not appear to injure the ascension of Linux.
> 
> 2/ Device passthrough, kernel passing opaque payloads, is already
> taken
>    for granted in many subsystems. USB and HID have "raw" interfaces,
> EFI
>    variables provide platform-specific configuration, and the oft-
> cited
>    examples of SCSI and NVME that provide facilities to marshal any
> command
>    payload whether mainline maintainers think the functionality is a
> good
>    idea or not. In the case of NVME, the specification continues to
> evolve
>    despite this Linux bypass.

Time was decades ago Oracle demanded raw access to the SCSI device
because they claimed it was easier for customers and faster for them if
they just talked to devices in their native protocol and got all of the
annoying kernel filesystems and page cache out of the way.  Fast
fowards to today and database vendors largely use filesystems thanks to
the evolution of interfaces (direct I/O) that support what they want to
do and the huge annoyance for customers of having to manage huge
numbers of unidentifiable raw devices.

For NVMe and net we do have SPDK and DPDK.  What I find is that people
tend to use them for niche use cases (like the NVMe KV command set) or
obscure network routers.  Even though the claim they both make is to
get the kernel out of the way and do stuff "way faster" the difficulty
they create by bypassing everything is quite a high burden.

For USB security tokens in the early days we had the huge problem of
everyone inventing their own interface, then they realised this was
unsustainable and came up with CTAP, but it's just a unified way for
user space applications to talk to FIDO tokens over raw USB ... is this
a problem?

> 
> 3/ The practice of requiring Linux commands to wrap all device
> commands
>    does not appear to have accelerated upstream participation in the
> CXL
>    subsystem. I.e. CXL, in contrast to NVME, relegates passthrough to
> a
>    build-time debug option. Some vendors are even shipping vendor
>    specific firmware update facilities even though mainline has
> support for
>    the CXL standard firmware update mechanism.
> 
>    With the impending arrival of CXL switch devices wanting to share
>    mailbox handling code with the CXL core, the prohibition of
>    device-specific commands is going to generate significant upstream
> work
>    to wrap all that in Linux commands with little perceivable long
> term
>    benefit to the subsystem.
> 
> CXL and RDMA are also foreshadowing conflicts across subsystems. It
> is not difficult to imagine a future CXL or RDMA device that supports
> mem, block, net, and drm/accel functionality. Which subsystem's
> device-command policy applies to such a thing?

We already have that today: pretty much every device protocol looks a
bit network like and has an Over Ethernet or Over RDMA equivalent.

What all of the prior pass through's taught us is that if the use case
is big enough it will get pulled into the kernel and the kernel will
usually manage it better (DB users).  If it remains a niche use case it
will likely remain out of the kernel, but we won't be hurt by it (NVME
KV protocol) and sometimes it doesn't really matter and the device
manufacturers will sort it out on their own (USB tokens).

> Enter the fwctl proposal [1]. From the CXL subsystem perspective it
> looks like a long-term solution to the problem of managing
> expectations between hardware vendors and mainline subsystems. It
> disclaims support for the fast-path (data-plane) and is targeted at
> the long tail of slow-path (config/debug plane) device-specific
> operations that are often uninteresting to mainline. It sets
> expectations that the device must advertise the effect of all
> commands so that the kernel can deploy reasonable Kernel Lockdown
> policy, or otherwise require CAP_SYS_RAWIO for commands that may
> affect user-data. It sets common expectations for device designers,
> distribution maintainers, and kernel developers. It is complimentary
> to the Linux-command path for operations that need
> deeper kernel coordination.

This proposal does look to me more like a tool for configuring highly
malleable fat firmware (or really mini-os) offload type devices (like
intelligent network cards) to interact correctly and be easier to
debug.  Every cloud vendor effectively has their own one of these, so I
think the problem isn't going away, so trying to bring some order to it
looks like a potentially good idea.

> The upstream discussion has yielded the full spectrum of positions on
> device specific functionality, and it is a topic that needs cross-
> kernel consensus as hardware increasingly spans cross-subsystem
> concerns. Please consider it for a Maintainers Summit discussion.

I'm with Greg on this ... can you point to some of the contrary
positions?

Regards,

James


