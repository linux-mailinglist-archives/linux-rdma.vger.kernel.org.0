Return-Path: <linux-rdma+bounces-5194-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDF098ED22
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 12:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4021D1C21635
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 10:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EA914D456;
	Thu,  3 Oct 2024 10:39:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC29136338;
	Thu,  3 Oct 2024 10:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727951993; cv=none; b=vFL9FcDHHbufW+mlR6q1fALPgJzm1B+rH7SQwe53azEJYMJwOPnT6gFBzHlyKPmRxUwyFTJm5Z/Q/NcDVGiayUIm/Z2jbnOwaPfYdWEVKIf+9nzN/7yW5DHNZVk5wH4vVMJ3qtLQ47YGadsG5vR00dNZaKl2U2VO4fomVziL61Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727951993; c=relaxed/simple;
	bh=nl2eDUTuCWjr2kdFbKwdbdLYHfKwbYUpVrAorrA5A2s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AU/UvVe/SJUfUooDH2m8iZzZBJN9nepfaIixlyBbAc7jdYXjHYpv6vrRgXPQz/KsXD7Hx6i0BTIm+ImUlHMPGJcqBbcaQ/0KYD8ulYNiuvpi9BYkMEOhh3rAuxOTiJhx6YawL5qsTcZPP3a/TmXx96kwg1MgEb9uuPsWSfR0b1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 3464A92009C; Thu,  3 Oct 2024 12:39:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 27C8E92009B;
	Thu,  3 Oct 2024 11:39:48 +0100 (BST)
Date: Thu, 3 Oct 2024 11:39:48 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Matthew W Carlis <mattc@purestorage.com>, alex.williamson@redhat.com, 
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
In-Reply-To: <20241002205521.GA270435@bhelgaas>
Message-ID: <alpine.DEB.2.21.2410031135250.45128@angie.orcam.me.uk>
References: <20241002205521.GA270435@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 2 Oct 2024, Bjorn Helgaas wrote:

> If there's anything missing that still needs to be added to v6.13-rc1,
> can somebody repost those?  I lost track of what's still outstanding.

 I have nothing outstanding to add right away.  Thank you for asking.

  Maciej

