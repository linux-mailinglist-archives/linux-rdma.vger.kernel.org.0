Return-Path: <linux-rdma+bounces-4230-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7415694A6DD
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 13:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56951C216FA
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 11:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DAB1E3CDC;
	Wed,  7 Aug 2024 11:21:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17711E2129;
	Wed,  7 Aug 2024 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723029714; cv=none; b=ZjPD9QFcof+m/ylFN308ZqR5iMkXCsPleSMCaejGHLKTzsLz9ux2iuvAEmhChJnJTIdJrLIM3ySEMc44Kpr3Qb5rgRn8uXF94L17rR803B3zLiPriLSKbACum6Rs5aiFxMu/OeV5OJHQqQR7vO7xWFchib2Sm9H9xLY6Zx1luXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723029714; c=relaxed/simple;
	bh=pIwToEXVW2gtmHl6Lvd1Tv/wLOcvr0zeK8oM18/v3aU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aHRpnbOrXJdsVp8zS/BaZJ9jawr8tQQ3gKiLGqiLOIt5n2NG4eOF/EeQmeO17Z0guJJiYsS0z+BITkYOAVfch2gVyMirpi3fGTkUq3bP+lx2v1KW8dShJ89nK5vTeVPL2BUnB41I3EgliOvXKZ5bP00ZOctaU/0y5dqWK0gHxJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id D4EE292009C; Wed,  7 Aug 2024 13:14:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id CEB8492009B;
	Wed,  7 Aug 2024 12:14:13 +0100 (BST)
Date: Wed, 7 Aug 2024 12:14:13 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Matthew W Carlis <mattc@purestorage.com>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: helgaas@kernel.org, alex.williamson@redhat.com, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    "David S. Miller" <davem@davemloft.net>, david.abdurachmanov@gmail.com, 
    edumazet@google.com, kuba@kernel.org, leon@kernel.org, 
    linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
    linux-rdma@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, lukas@wunner.de, 
    mahesh@linux.ibm.com, mika.westerberg@linux.intel.com, 
    netdev@vger.kernel.org, npiggin@gmail.com, oohall@gmail.com, 
    pabeni@redhat.com, pali@kernel.org, saeedm@nvidia.com, sr@denx.de, 
    Jim Wilson <wilson@tuliptree.org>
Subject: Re: PCI: Work around PCIe link training failures
In-Reply-To: <20240807084348.12304-1-mattc@purestorage.com>
Message-ID: <alpine.DEB.2.21.2408070956520.61955@angie.orcam.me.uk>
References: <20240806193622.GA74589@bhelgaas> <20240807084348.12304-1-mattc@purestorage.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 7 Aug 2024, Matthew W Carlis wrote:

> > it does seem like this series made wASMedia ASM2824 work better but
> > caused regressions elsewhere, so maybe we just need to accept that
> > ASM2824 is slightly broken and doesn't work as well as it should.
> 
> One of my colleagues challenged me to provide a more concrete example
> where the change will cause problems. One such configuration would be not
> implementing the Power Controller Control in the Slot Capabilities Register.
> Then, Powering off the slot via out-of-band interfaces would result in the
> kernel forcing the DSP to Gen1 100% of the time as far as I can tell. 
> The aspect of this force to Gen1 that is the most concerning to my team is
> that it isn't cleaned up even if we replaced the EP with some other EP.

 Why does that happen?

 For the quirk to trigger, the link has to be down and there has to be the 
LBMS Link Status bit set from link management events as per the PCIe spec 
while the link was previously up, and then both of that while rescanning 
the PCIe device in question, so there's a lot of conditions to meet.  Is 
it the case that in your setup there is no device at this point, but one 
gets plugged in later?

 One aspect to mention here is that when taking a device offline the LBMS 
Link Status bit really ought to be cleared by Linux in the corresponding 
downstream port of the parent device.  As I recall Ilpo was working on a 
broader link bandwidth management subsystem for Linux, which would do that 
among others.  He asked me to make experiments with my problematic machine 
to see if this would interfere, but unrelated issues with DRAM controller 
(now fixed by reducing the DDR clock rate) have prevented me from doing 
that.  I'll see if I can get back to that soon.

> I was curious about the PCIe devices mentioned in the commit because I
> look at crazy malfunctioning devices too often so I pasted the following:
> "Delock Riser Card PCI Expres 41433" into Google. 
> I'm not really a physical layer guy, but is it possible that the reported
> issue be due to signal integrity? I'm not sure if sending PCIe over a USB
> cable is "reliable".

 Well, it's a transmission line and as long as bandwidth and latency 
requirements are met it's as good as any.  My understanding has been one 
of the objectives of PCIe over conventional PCI was to make external links 
such as to expansion boxes easier to implement.

 Please note that it is a purpose-made cable too, rather than just an 
off-the-shelf USB cable.  Then I have solutions deployed with PCIe routed 
over DVI cables too.

 I doubt it could be a signal integrity issue, because once the link has 
negotiated the highest speed possible (Gen2) via this complicated dance it 
works with no issues for months.  I'm not sure what the highest uptime for 
the system in question exactly was, but it was in the range of half a 
year, and I have a network interface downstream which I regularly use for 
heavy NFS traffic in GNU tool chain regression verification, so any issue 
would have shown up pretty quickly.

 Given how switching between speed rates works with PCIe (by establishing 
a link at 2.5GT/s first and then exchanging rates available as data before 
choosing the highest supported by both endpoints) I suspect that it is a 
protocol issue: either or both devices have got it slightly wrong, which 
breaks it when they're combined together.  Otherwise why would retraining 
to 5GT/s by hand work while it doesn't if to be done by hardware itself?  
There is not much if any difference here between both scenarios really.

> I've never worked with an ASMedia switch and don't have a reliable way to
> reproduce anything like the interaction between the two device at hand. As
> much as I hate to make the request my thinking is that the patch should be
> reverted until there is a solution that doesn't leave the link forced to
> Gen1 forever for every EP thereafter.

 I'm working on such a change this week.

 It's just that my primary objectives for this maintenance visit at my lab 
were to fix a pair of broken PSUs (which I have now done) and upgrade the 
firmware of a console manager device to fix an issue with a remote serial 
BREAK feature affecting Magic SysRq (also completed), plus I have a day 
job too that is unrelated.

 I also bought a PCIe to dual M.2 M-Key option card with the ASM2824 
switch onboard to have a different setup to evaluate and determine if this 
issue is specific to the RISC-V board or not.  Unfortunately the ASM2824 
does not bring the downstream ports up if the card is placed in a slot 
that does not supply Vaux (which is a conforming arrangement according to 
the PCIe spec), apparently due to a quirk in the ASM2824 switch according 
to the option card manufacturer, and there is no software workaround 
possible.

 So I won't be able to use this alternative arrangement until I have 
modified the option card, which I won't be able to do before October the 
earliest.  

 I just can't help with that there is so many broken hardware designs out 
there and I have to strive to navigate through and do my job regardless.

  Maciej

