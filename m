Return-Path: <linux-rdma+bounces-1586-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E32788CFD0
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 22:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138C01F649F4
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 21:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E05C13D63B;
	Tue, 26 Mar 2024 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLVThY5Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7EE1E884;
	Tue, 26 Mar 2024 21:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711487673; cv=none; b=TK8eihENos9bIj3hsSIXMhKelu50tKVirjaVCwkFMaVUXKQAxafRLk9y4cvfxrecICHZjwagtAqaPMXzMGW1g5+df4yxruCqfeyfuu1GwvrYl5Gr9WFh28f730QqXxAS2G737elH3YrDIX4ApUvjkeMQ8t+VdBfIBCZTWmhwz6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711487673; c=relaxed/simple;
	bh=cxfzcpVl6iw0nLD4z59WnZub1zdzpHD3Ab/gARw6LCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WXjygm7jGJyJxeZdCwGhQSgc9luOnhCIwF/ghWQB1IWDnHkpP6TyCWxXPIkMN+YYrgmq4g66WtMGlm6WcUV5bk/nvaoucHfN98EXvO8D9lMwbz0lq63t1bJuHA5n5kJmdcdkKgmhik32+ktM9FH1GyxTpC986Jn5CIC9wtmy9+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLVThY5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5738BC433F1;
	Tue, 26 Mar 2024 21:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711487672;
	bh=cxfzcpVl6iw0nLD4z59WnZub1zdzpHD3Ab/gARw6LCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NLVThY5Yh2SzMHj4gx9UytpQfFJgRigfFFXt+bm6Vuu3F1XJQiMr6mpQ5ZiPngd1n
	 Y3oah6WxB6w8vOtameV4wbrxrY5wofrUOI9g31Io5EdLc/j+KK8tfXH3xtt0JxGB2N
	 41zLFvHWmMYUpsRk36/3btrCOrPAtRy6KTbcAmYOIBNVugRcJC8xbhUFT667lR/66s
	 K8/Ub7VERzydJeXZrf3U8gIU/jnq6GIZoo3e1f50o0x4S+IefKUpldWak2O8Z9945C
	 M/N49IG+6Cnb/a1N5y474X7v3YHt+/i2pidMu6YhpMQK8dJegtAohGlEJNPNCUpTS8
	 8oqh9BxzR+lAw==
Date: Tue, 26 Mar 2024 16:14:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org, ntb@lists.linux.dev,
	Lee Jones <lee@kernel.org>, David Airlie <airlied@gmail.com>,
	amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/28] mfd: intel-lpss-pci: Use PCI_IRQ_INTX
Message-ID: <20240326211430.GA1497386@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325210444.GA1449676@bhelgaas>

On Mon, Mar 25, 2024 at 04:04:44PM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 25, 2024 at 09:39:38PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 25, 2024 at 04:09:20PM +0900, Damien Le Moal wrote:
> > > Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
> > > macro.
> > 
> > Not needed anymore. MFD subsystem has a patch moving this to MSI support.
> > But you need to coordinate with Lee how to proceed (in case of conflicts MFD
> > version should be taken).
> 
> Thanks!  It looks like your patch [1] has been applied already and
> makes this one obsolete, so I dropped this one from the series.

I put this patch back in to prevent an ordering requirement between
MFD and PCI.  There will be a trivial merge conflict as Andy
mentioned.

> [1] https://lore.kernel.org/all/20240312165905.1764507-1-andriy.shevchenko@linux.intel.com/

