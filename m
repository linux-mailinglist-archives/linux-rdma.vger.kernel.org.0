Return-Path: <linux-rdma+bounces-4286-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D2F94D150
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 15:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE151F21C55
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 13:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3120A194C82;
	Fri,  9 Aug 2024 13:34:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EDF18C93F;
	Fri,  9 Aug 2024 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210448; cv=none; b=AP7MrNlwi6kM4o39n/wCYVR9axs6hC7GLqOem5hy9+Y/YVm80ZjrzUL95KDZLkKZjhXr9iZODEplzTBAVlAk0a104hc6sNKTo6qpkSFlzI0wYwDVO1V3d2nDOgjsdWUUqciBJJeIhaJ/c3KjGGQyIxyLy7FJDUpeTH9+LkS2Ygw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210448; c=relaxed/simple;
	bh=wz4JRZZFRK+oxzUUfdGB2oAzGtjNrqJVDmx4j5Q5hho=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sGtVujlX4G7p/9dYRZ/yTao/hTvvWfskj+XvdvN/u13KrLDpb6AUnn6Yeh9A+c+p8khi72Iip0CD108hkM7pxynA9PIOrF6VYsX2ylK7MRZ+xcHRq1NCvS7mGrO4TnIiyGySqz0zzpBN+UImAYDwFaS1KVmL/DvwYhPkcOuq0fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9970092009C; Fri,  9 Aug 2024 15:34:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 92C6792009B;
	Fri,  9 Aug 2024 14:34:04 +0100 (BST)
Date: Fri, 9 Aug 2024 14:34:04 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Matthew W Carlis <mattc@purestorage.com>
cc: alex.williamson@redhat.com, Bjorn Helgaas <bhelgaas@google.com>, 
    "David S. Miller" <davem@davemloft.net>, david.abdurachmanov@gmail.com, 
    edumazet@google.com, helgaas@kernel.org, kuba@kernel.org, leon@kernel.org, 
    linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
    linux-rdma@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, lukas@wunner.de, 
    mahesh@linux.ibm.com, mika.westerberg@linux.intel.com, 
    netdev@vger.kernel.org, npiggin@gmail.com, oohall@gmail.com, 
    pabeni@redhat.com, pali@kernel.org, saeedm@nvidia.com, sr@denx.de, 
    Jim Wilson <wilson@tuliptree.org>
Subject: Re: PCI: Work around PCIe link training failures
In-Reply-To: <20240808020753.16282-1-mattc@purestorage.com>
Message-ID: <alpine.DEB.2.21.2408091356190.61955@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2408071241160.61955@angie.orcam.me.uk> <20240808020753.16282-1-mattc@purestorage.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 7 Aug 2024, Matthew W Carlis wrote:

> > For the quirk to trigger, the link has to be down and there has to be the
> > LBMS Link Status bit set from link management events as per the PCIe spec
> > while the link was previously up, and then both of that while rescanning
> > the PCIe device in question, so there's a lot of conditions to meet.
> 
> If there is nothing clearing the bit then why is there any expectation that
> it wouldn't be set? We have 20/30/40 endpoints in a host that can be hot-removed,
> hot-added at any point in time in any combination & its often the case that
> the system uptime be hundreds of days. Eventually the bit will just become set
> as a result of time and scale.

 Well, in principle in a setup with reliable links the LBMS bit may never 
be set, e.g. this system of mine has been in 24/7 operation since the last 
reboot 410 days ago and for the devices that support Link Active reporting 
it shows:

LnkSta:Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
LnkSta:Speed 5GT/s, Width x8, TrErr- Train- SlotClk- DLActive+ BWMgmt+ ABWMgmt+
LnkSta:Speed 5GT/s, Width x1, TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt+
LnkSta:Speed 5GT/s, Width x2, TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt+
LnkSta:Speed 5GT/s, Width x1, TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt+
LnkSta:Speed 8GT/s, Width x16, TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt+
LnkSta:Speed 8GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
LnkSta:Speed 8GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
LnkSta:Speed 8GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
LnkSta:Speed 8GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
LnkSta:Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-

so out of 11 devices 6 have the LBMS bit clear.  But then 5 have it set, 
perhaps worryingly, so of course you're right, that it will get set in the 
field, though it's not enough by itself for your problem to trigger.

 Then there is manual link retraining, which we do from time to time as 
well, which will set the bit too, which I overlooked.

 To cut the story short, it was an oversight of mine, especially as I 
don't really make any use myself of hot plug scenarios.

> > The reason for this is safety: it's better to have a link run at 2.5GT/s
> > than not at all, and from the nature of the issue there is no guarantee
> > that if you remove the speed clamp, then the link won't go back into the
> > infinite retraining loop that the workaround is supposed to break.
> 
> I guess I don't really understand why it wouldn't be safe for every device
> other than the ASMedia since they aren't the device that had the issue in the
> first place. The main problem in my mind is the system doesn't actually have to
> be retraining at all, it can occur the first time you replace a device or
> power cycle the device or the first time the device goes into DPC & comes back.
> If the quirk simply returned without doing anything when the ASMedia is not in the
> allow-list it would make me more at ease. I can also imagine some other implementations
> that would work well, but it doesn't seem correct that we could only give a single
> opportunity to a device before forcing it to live at Gen1. Perhaps it should be
> aware of the rate or a count or something...

 It's a complex matter.  For a starter please read the introduction at 
`pcie_failed_link_retrain'.

 When the problem triggers the link goes into an infinite link training 
loop, with the Link Training (LT) bit flipping on and off.  I've made a 
complementary workaround for U-Boot (since your bootstrap device can be 
downstream such a broken link), where a statistical probe is done for the 
LT bit flipping as discovered by polling the bit in a tight loop.  This is 
fine for a piece of firmware that has nothing better to do, but in an OS 
kernel we just can't do it.

 Also U-Boot does not remove the 2.5GT/s clamp because it does not have to 
set up the system in an optimal way, but just sufficiently to successfully 
boot.  An OS kernel can then adjust the configuration if it knows about 
the workaround, or leave it as it is.  In the latter case things will 
continue working across PCIe resets, because the TLS field is sticky.

 For Linux I went for just checking the DLLLA bit as it seems good enough 
for devices that support Link Active reporting.  And I admit that the 
workaround is quite aggressive, but this was a deliberate decision 
following the robustness principle: the end user may not be qualified 
enough to diagnose the problem and given its nature not even think it's 
something that can be made to work.  The downstream device does not show 
up in the PCIe hierarchy and just looks like it's broken.  It takes a lot 
of knowledge and experience to notice the LT bit flipping and even myself, 
quite a seasoned Linux kernel developer, only noticed it by chance.

 It was discussed to death with the original submission, the rationale is 
given in the introductory comment and I'd prefer that it stays as it is.  
The ASM2824 switch works just fine with other downstream devices and so 
does the PI7C9X2G304 switch with other upstream devices.  Both vendors 
refused to help narrow it down and declined to comment (a person from 
Diodes née Pericom replied, but they learnt it's about a PCIe switch they 
told me they were from another department and couldn't help), which would 
have helped (I now just recommend staying away from both manufacturers).  
Therefore my assumption is this can potentially trigger with any pair of 
devices.

 I have now posted a patch series to address this problem of yours and a 
previous issue reported by Ilpo.  See: 
<https://patchwork.kernel.org/project/linux-pci/list/?series=878216>, and 
I've included you in the list of direct recipients too.

 I will appreciate if you give it a try, and again, apologies for the 
trouble caused, but such things happen in engineering.

  Maciej

