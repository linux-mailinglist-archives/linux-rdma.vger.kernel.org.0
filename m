Return-Path: <linux-rdma+bounces-5186-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F04298E47A
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2024 22:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEF4AB20EC5
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2024 20:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECD9217326;
	Wed,  2 Oct 2024 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7noUOEm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F24A215F7B;
	Wed,  2 Oct 2024 20:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727902525; cv=none; b=Rk7CHKmg4oHRxVZmB8le/P9ngeWde+cUshAesEv2/2/VGUdNudkF5quJtJ9YAAzSVkdmJIzukSxu8dGr6CJ/qFM6VD6CzFhaDthNp15JpqZs+wU6FXTRvxFeb4oONV+d1TYiuBAI8dlPx8phNFeGPO/gBc2Tz0n8dgdLFHKoJVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727902525; c=relaxed/simple;
	bh=TuGJcLjFSc56+Q/eaA2wEGKI+ciNhNV4JQafPOI71fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ofTXs/Y3oF6PCNlKXuCPrdO2mNZpdNRlVLoKdAXxa8K2ftUrqNPVw/LCDPDzoFcodoALdJkdCnhV8iaP9Mbfxzd1mloSfRFaN07nZyUy9ZTnbUP4V0ZeIJF/m2VyJ89iVLvtbdrrIGlO9EQpKrYrusZNKleVWRAwlEdC3f3XgPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7noUOEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418ACC4CEC2;
	Wed,  2 Oct 2024 20:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727902524;
	bh=TuGJcLjFSc56+Q/eaA2wEGKI+ciNhNV4JQafPOI71fQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=c7noUOEm+BauPgS1f2MCN6MaaLa1cM46uUgxC8nE9HBAO3sEGV99HNNaLNWs047EH
	 /d05+dMftjH5oeauu7EFpU2NcDd38eZk6FhZWy/ioymRZnc0L1ZAvX9on430YyEB8Y
	 iBFl1FEhoMvylioKynPaIEIYY7rDMTAEkZwNaMXOM+jjIlon+eONfgCtZNqGgVs7rM
	 RiD8QFBdMI/B7A2blmSc1OrbchoSL9Yk1HfrzJbgilVzPzxGIcJaV/uCqDur2l1W69
	 dGXS0OcRwupnHwprVDyvloOyFlQbSD4HrG8zBiwiUt6cReD6Gc1/7QNPpgLHx3mRHy
	 HLwixwt62hcCA==
Date: Wed, 2 Oct 2024 15:55:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Matthew W Carlis <mattc@purestorage.com>, alex.williamson@redhat.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	david.abdurachmanov@gmail.com, edumazet@google.com, kuba@kernel.org,
	leon@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, lukas@wunner.de,
	mahesh@linux.ibm.com, mika.westerberg@linux.intel.com,
	netdev@vger.kernel.org, npiggin@gmail.com, oohall@gmail.com,
	pabeni@redhat.com, pali@kernel.org, saeedm@nvidia.com, sr@denx.de,
	Jim Wilson <wilson@tuliptree.org>
Subject: Re: PCI: Work around PCIe link training failures
Message-ID: <20241002205521.GA270435@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2410021355540.45128@angie.orcam.me.uk>

On Wed, Oct 02, 2024 at 01:58:15PM +0100, Maciej W. Rozycki wrote:
> On Tue, 1 Oct 2024, Matthew W Carlis wrote:
> 
> > I just wanted to follow up with our testing results for the mentioned
> > patches. It took me a while to get them running in our test pool, but
> > we just got it going yesterday and the initial results look really good.
> > We will continue running them in our testing from now on & if any issues
> > come up I'll try to report them, but otherwise I wanted to say thank you
> > for entertaining the discussion & reacting so quickly with new patches.
> 
>  My pleasure.  I'm glad that the solution works for you.  Let me know if 
> you need anything else.

If there's anything missing that still needs to be added to v6.13-rc1,
can somebody repost those?  I lost track of what's still outstanding.

Bjorn

