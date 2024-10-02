Return-Path: <linux-rdma+bounces-5181-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F60798D3D3
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2024 14:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF241C217E6
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2024 12:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627B71D016C;
	Wed,  2 Oct 2024 12:58:20 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B950C1D0141;
	Wed,  2 Oct 2024 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873900; cv=none; b=pmWe/mnYU05rdxvgJgFVFpNoqZSZWBXSNJtN0L+ydGzZlSl5QYJKtCKkqOFzrF4bhB6/eowR/AEdzMOEpVVvRZ6d8z+3c1TWKfGIG+4CrTFyBOH7Ov9wpkC9pyCy5IRYdUYtRkC7f3M5P1V/57MF48N+rLCyTUwporlaf0cC4Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873900; c=relaxed/simple;
	bh=PCdA1+8AoRkwA3JGIgvQLhRzKofDdSbwqZuWbU1OdK4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QTMGexIgTDBJqo9rfRYDYe64JGf6pBPcIjPcUWYd24WPV3md/0ZiCVdIvRSpXNDxzr00xw2R0p9wiIzjSzBdJWmC04b6Dw1FD31S8XNELK8ywWMY22LvoUd3z8UEQeWtuUjEU2gWSzrwy5clAApcnZH63NmKOwNLmptTeaECi30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 85BA792009C; Wed,  2 Oct 2024 14:58:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 80B1792009B;
	Wed,  2 Oct 2024 13:58:15 +0100 (BST)
Date: Wed, 2 Oct 2024 13:58:15 +0100 (BST)
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
In-Reply-To: <20241001210446.14547-1-mattc@purestorage.com>
Message-ID: <alpine.DEB.2.21.2410021355540.45128@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2408160312180.59022@angie.orcam.me.uk> <20241001210446.14547-1-mattc@purestorage.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 1 Oct 2024, Matthew W Carlis wrote:

> I just wanted to follow up with our testing results for the mentioned
> patches. It took me a while to get them running in our test pool, but
> we just got it going yesterday and the initial results look really good.
> We will continue running them in our testing from now on & if any issues
> come up I'll try to report them, but otherwise I wanted to say thank you
> for entertaining the discussion & reacting so quickly with new patches.

 My pleasure.  I'm glad that the solution works for you.  Let me know if 
you need anything else.

  Maciej

