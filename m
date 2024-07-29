Return-Path: <linux-rdma+bounces-4071-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A28A93F8BB
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 16:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620F21C210FB
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 14:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5192155751;
	Mon, 29 Jul 2024 14:51:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD933146580;
	Mon, 29 Jul 2024 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264709; cv=none; b=QIrL70LHYU6lcAlRh17y07WfhGbM3+AbLsFHJlSjkqxI6dIp8CzxrKlUH+kZ9cMwBreLUnS2JgR1hQvgEenXbZxg2JiPX+zxYeYw0L9z0wnppRO651JqzfhEEWOnlyB40QuOQvBU/6O2+qYzsREWzmiIcd2ics4ZY9Q93Q4Vb8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264709; c=relaxed/simple;
	bh=JwxZkruffVOFu0w1m6bzqfxuk0TYMxYEJc4mNatpIX0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VC+qxv6W7Q/TZCcRZ5N1XoHFJIRFwB7usivcB2ToB0TpNaczUjPwtvwIOPR0kxftU/p/BqVv8cHDLsSWkUyh6ziSFSUllFm6zg61IqPldlkBSVnnWemlOzWHnvIGFm7IQyPxXygYBrXQASnuc99f/eRHaqgpLCGBnwCwl8kSe5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 3FC4D92009C; Mon, 29 Jul 2024 16:51:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 3971892009B;
	Mon, 29 Jul 2024 15:51:37 +0100 (BST)
Date: Mon, 29 Jul 2024 15:51:37 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Matthew W Carlis <mattc@purestorage.com>, alex.williamson@redhat.com, 
    Bjorn Helgaas <bhelgaas@google.com>, christophe.leroy@csgroup.eu, 
    "David S. Miller" <davem@davemloft.net>, david.abdurachmanov@gmail.com, 
    edumazet@google.com, kuba@kernel.org, leon@kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, 
    linux-rdma@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
    Lukas Wunner <lukas@wunner.de>, mahesh@linux.ibm.com, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, mpe@ellerman.id.au, 
    Netdev <netdev@vger.kernel.org>, npiggin@gmail.com, oohall@gmail.com, 
    pabeni@redhat.com, pali@kernel.org, saeedm@nvidia.com, sr@denx.de, 
    Jim Wilson <wilson@tuliptree.org>
Subject: Re: PCI: Work around PCIe link training failures
In-Reply-To: <914b7d34-9ed5-cd99-cb76-f6f8eccb842e@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2407291540120.48387@angie.orcam.me.uk>
References: <20240724191830.4807-1-mattc@purestorage.com> <20240726080446.12375-1-mattc@purestorage.com> <914b7d34-9ed5-cd99-cb76-f6f8eccb842e@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 29 Jul 2024, Ilpo Järvinen wrote:

> > > The main reason is it is believed that it is the downstream device
> > > causing the issue, and obviously you can't fetch its ID if you can't
> > > negotiate link so as to talk to it in the first place.
> > 
> > Have had some more time to look into this issue. So, I think the problem
> > with this change is that it is quite strict in its assumptions about what
> > it means when a device fails to train, but in an environment where hot-plug
> > is exercised frequently you are essentially bound have something interrupt
> > the link training. In the first case where we caught this problem our test
> > automation was doing some power cycle tortures on our endpoints. If you catch
> > the right timing the link will be forced down to Gen1 forever without some other
> > automation to recover you unless your device is the one single device in the
> > allowlist which had the hardware bug in the first place.
> > 
> > I wonder if we can come up with some kind of alternative.
> 
> The most obvious solution is to not leave the speed at Gen1 on failure in 
> Target Speed quirk but to restore the original Target Speed value. The 
> downside with that is if the current retraining interface (function) is 
> used, it adds delay. But the retraining functions could be reworked such 
> that the retraining is only triggered in case the Target Speed quirk 
> fails but we don't wait for its result (which will very likely fail 
> anyway).

 This is what I have also been thinking of.

 After these many years it took from the inception of this change until it 
landed upstream I'm not sure anymore what my original idea was behind 
leaving the link clamped on a retrain failure, but I think it was either 
not to fiddle with the setting beyond the absolute necessity at hand 
(which the scenarios such as Matthew's prove wrong) or to leave the 
setting in a hope that training will eventually have succeeded (but it 
seems to make little sense as there'll be nothing there to actually 
observe the success unless the bus gets rescanned for another reason).

 I'll be at my lab towards the end of the week with a maintenance visit, 
so I'll allocate some time to fiddle with this issue on that occasion and 
implement such an update.

  Maciej

