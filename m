Return-Path: <linux-rdma+bounces-4231-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9B194A72C
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 13:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468021F23DB7
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 11:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73DC1E486A;
	Wed,  7 Aug 2024 11:49:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4794C171E69;
	Wed,  7 Aug 2024 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031353; cv=none; b=EMaLJZ1r+K5PUMULdDkOBlEenrmsQhkR169Qnp+reQ3Blsg4pprYu0m9VSIGBjDldWrsHJUa0jDiJ8/O7okmrZNs4LENOenr5j91p4DrYK5OtyA24e0kEH4+bK2x6IYFgyBqIBLMGKMDIi1DZvvaDT7nuPIal2O2j4aRpY7Uxms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031353; c=relaxed/simple;
	bh=Eby7UOvWLe0/fR1Xt49v8ubVQikmeZ2nB5JBF/5S5h8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=duvKJm9ASSWu0uEnlbkQHu2q+EM1SbxFgBLyD4F5p+8wqKOLL9BWykXh5MSfsltX1ELQ0ooa6BVizmatRoH5TFXXFswDnjYdZfEeVHRxgQVkgaOVL5YXImz0j84Ykw/2DYLNv5MlWbBkc0bFYtv22cRS0eOCEXYE1UmnUokFouQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 60AD292009C; Wed,  7 Aug 2024 13:49:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 5A9F492009B;
	Wed,  7 Aug 2024 12:49:09 +0100 (BST)
Date: Wed, 7 Aug 2024 12:49:09 +0100 (BST)
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
In-Reply-To: <20240806000659.30859-1-mattc@purestorage.com>
Message-ID: <alpine.DEB.2.21.2408071241160.61955@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2306201040200.14084@angie.orcam.me.uk> <20240806000659.30859-1-mattc@purestorage.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 5 Aug 2024, Matthew W Carlis wrote:

> The most common place where we see our systems getting stuck at Gen1 is with
> device power cycling. If a device is powered on and then off quickly then the
> link will of course fail to train & the consequence here is that the port is
> forced to Gen1 forever. Does anybody know why the patch will only remove the
> forced Gen1 speed from the ASMedia device?

 I know, as the author of the change.

 The reason for this is safety: it's better to have a link run at 2.5GT/s 
than not at all, and from the nature of the issue there is no guarantee 
that if you remove the speed clamp, then the link won't go back into the 
infinite retraining loop that the workaround is supposed to break.

 I was only able to verify that the speed clamp is safe to lift with this 
particular device, but if you hit the actual issue with any other device 
and find that it is safe to remove the clamp as well, then you're welcome 
to add it to the list too.

  Maciej

