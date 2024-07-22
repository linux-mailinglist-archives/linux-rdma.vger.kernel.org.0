Return-Path: <linux-rdma+bounces-3936-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061C09394DA
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 22:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6019281FE6
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 20:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448C339FEF;
	Mon, 22 Jul 2024 20:40:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77C02C879;
	Mon, 22 Jul 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721680835; cv=none; b=bs1+RObjDqYDTmvZpkt8NE43aDXcqHiv39rr+0OkwEmaaCpbLcwdroqjuIG1CgQykDt45jhxemFHvbVaKPw+3WqktfAW1Z7E1PrQnObLpBsdZO33u1gDJYufMREeiMJMN1QVyfZ0DhQRakY+XaVDYm8UoAsRsQ8ek/P4ACLq7l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721680835; c=relaxed/simple;
	bh=zMq1COTfxr28zTUf4ikrErgLDnhXEQIb4HQURyhtF7M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gRPGefbVrH+lKXSrzaxPSc5NRjPcFSHpqsV6gCEdEXieZnaN9L3k6vcxM4oEvTWdX8K1fX4jPIN5L5D577sDRP7GRqb7txdXzzvJw+fD8vgLYyJxQ3d9lttW220zOZje8uHdbp3oVJaH2NTLzKniKP4hGIqrLJ92Q+GI1yJtdgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 3F9AC92009C; Mon, 22 Jul 2024 22:40:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 38AC992009B;
	Mon, 22 Jul 2024 21:40:29 +0100 (BST)
Date: Mon, 22 Jul 2024 21:40:29 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Matthew W Carlis <mattc@purestorage.com>
cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    alex.williamson@redhat.com, Bjorn Helgaas <bhelgaas@google.com>, 
    christophe.leroy@csgroup.eu, "David S. Miller" <davem@davemloft.net>, 
    david.abdurachmanov@gmail.com, edumazet@google.com, kuba@kernel.org, 
    leon@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
    linux-rdma@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, lukas@wunner.de, 
    mahesh@linux.ibm.com, mika.westerberg@linux.intel.com, mpe@ellerman.id.au, 
    netdev@vger.kernel.org, npiggin@gmail.com, oohall@gmail.com, 
    pabeni@redhat.com, pali@kernel.org, saeedm@nvidia.com, sr@denx.de, 
    Jim Wilson <wilson@tuliptree.org>
Subject: Re: PCI: Work around PCIe link training failures
In-Reply-To: <20240722193407.23255-1-mattc@purestorage.com>
Message-ID: <alpine.DEB.2.21.2407222117300.51207@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2306111619570.64925@angie.orcam.me.uk> <20240722193407.23255-1-mattc@purestorage.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

[+cc Ilpo for his previous involvement here]

On Mon, 22 Jul 2024, Matthew W Carlis wrote:

> Sorry to resurrect this one, but I was wondering why the
> PCI device ID in drivers/pci/quirks.c for the ASMedia ASM2824
> isn't checked before forcing the link down to Gen1... We have
> had to revert this patch during our kernel migration due to it
> interacting poorly with at least one older Gen3 PLX PCIe switch
> vendor/generation while using DPC. In another context we have
> found similar issues during system bringup without DPC while
> using a more legacy hot-plug model (BIOS defaults for us..).
> In both contexts our devices are stuck at Gen1 after physical
> hot-plug/insert, power-cycle.

 Sorry to hear about your problems.  However the workaround is supposed to 
only trigger if the link has already failed negotiation.  Could you please 
be more specific as to the actual scenario where it triggers?

 A scenario was mentioned earlier on, where a downstream device has been 
removed from a slot and left behind the LBMS bit set in the corresponding 
downstream port of the upstream device.  It then triggered the workaround 
where the port was rescanned with the slot still empty, which then left 
the link capped at 2.5GT/s for a device subsequently inserted.  Is it what 
happens for you?

 As I recall Ilpo has been working on changes that among others should 
make sure no stale LBMS bit has been left set, but I'm not sure what the 
state of affairs has been here.  Myself I've been too swamped in the 
recent months and consequently didn't look into any improvements in this 
area (and unrelated issues involving the system in question in my remote 
lab have further impeded me).

> Tried reading through the patch history/review but it was still
> a little bit unclear to me. Can we add the device ID check as a
> precondition to forcing link to Gen1?

 The main reason is it is believed that it is the downstream device 
causing the issue, and obviously you can't fetch its ID if you can't 
negotiate link so as to talk to it in the first place.

  Maciej

