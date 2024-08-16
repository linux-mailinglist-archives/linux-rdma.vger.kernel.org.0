Return-Path: <linux-rdma+bounces-4393-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22B9954B7F
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 15:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115DD1C2420C
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 13:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765F11BBBD2;
	Fri, 16 Aug 2024 13:57:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC161B8E92;
	Fri, 16 Aug 2024 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816635; cv=none; b=O37inelKE1L1ZiK64/aHy5vYyIzC5Cj15Ptx4pMUl/fNUbT8k5nObZyyKXimWWrT0mjpE6dr0cEAvaFBoiyweCZaFg8jX7KyRw7DusEThh1fhT4mEBgLVmZ+bSd9BvzWDhjFx/RVFTSlo8j2Vlf5vsVqnIlEMI7MJE5+oqNNTRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816635; c=relaxed/simple;
	bh=020hZGJIzLJWA99tUJoWCXT0j5vGBw0TAHhBZbKmTPE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Yu/TQaeZIDA3Wc6uqBUCf4LV1x/JlcKvciDrTUfwVWM8e217wk/fu8Xb9GRUiEXNBZYF1uydSjICYLicbEhJp6hS/MbzoN0ZCmdbOHwvSCNJ4qn2Khbvfqj9g23yHOZ+DMNBtn2/Nss18LQBh4Y8IGlLIcSx5qq52KqRyOt29wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id C985492009D; Fri, 16 Aug 2024 15:57:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id C3A4792009C;
	Fri, 16 Aug 2024 14:57:09 +0100 (BST)
Date: Fri, 16 Aug 2024 14:57:09 +0100 (BST)
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
In-Reply-To: <20240815194059.28798-1-mattc@purestorage.com>
Message-ID: <alpine.DEB.2.21.2408160312180.59022@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2408091356190.61955@angie.orcam.me.uk> <20240815194059.28798-1-mattc@purestorage.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 15 Aug 2024, Matthew W Carlis wrote:

> > Well, in principle in a setup with reliable links the LBMS bit may never 
> > be set, e.g. this system of mine has been in 24/7 operation since the last 
> > reboot 410 days ago and for the devices that support Link Active reporting 
> > it shows:
> > ...
> > so out of 11 devices 6 have the LBMS bit clear.  But then 5 have it set, 
> > perhaps worryingly, so of course you're right, that it will get set in the 
> > field, though it's not enough by itself for your problem to trigger.
> 
> The way I look at it is that its essentially a probability distribution with time,
> but I try to avoid learning too much about the physical layer because I would find
> myself debugging more hardware issues lol. I also don't think LBMS/LABS being set
> by itself is very interesting without knowing the rate at which it is being set.

 Agreed.  Ilpo's upcoming bandwidth controller will hopefully give us such 
data.

> FWIW I have seen some devices in the past going into recovery state many times a
> second & still never downtrain, but at the same time they were setting the
> LBMS/LABS bits which maybe not quite spec compliant.
> 
> I would like to help test these changes, but I would like to avoid having to test
> each mentioned change individually. Does anyone have any preferences in how I batch
> the patches for testing? Would it be ok if I just pulled them all together on one go?

 Certainly fine with me, especially as 3/4 and 4/4 aren't really related 
to your failure scenario, and then you need 1/4 and 2/4 both at a time to 
address both aspects of the issue you have reported.

  Maciej

